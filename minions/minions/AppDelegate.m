//
//  AppDelegate.m
//  minions
//
//  Created by Yao Guai on 16/9/10.
//  Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//


#import <AFNetworking/AFHTTPSessionManager.h>
#import "AppDelegate.h"
#import "YGHttpTest.h"
#import "MNTest.h"
#import "MNLoginViewController.h"
#import "MNMainTabBarViewController.h"
#import "YGNSStreamTest.h"
#import "JegarnCFSocketTransport.h"
#import "MNBaseChatViewModel.h"
#import "MNHttpsSessionManager.h"
#import "JegarnCFSslSocketTransport.h"
#import "YGHttpManager.h"
#import "JegarnCFSslSecurityPolicy.h"
#import "JegarnCFSslSocketTransport.h"
#import "JegarnSslConvert.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window.backgroundColor = [UIColor whiteColor];
    [self presentLoginViewController];
    [self initHttpManager];
    //[self testJegarnCore];
    [self testSslJegarnCore];

    // _streamTest = [[YGNSStreamTest alloc] init];
    // [_streamTest initNetworkCommunication];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) initHttpManager
{
    YGHttpsSessionManager *manager = [[MNHttpsSessionManager alloc] init];
    [YGHttpManager setDefaultManager:manager];
}

- (void) presentMainTabBarViewController
{
    MNMainTabBarViewController *tabBarViewController = [[MNMainTabBarViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabBarViewController];
    _window.rootViewController = navigationController;
}

- (void) presentLoginViewController
{
    MNLoginViewController * loginViewController = [[MNLoginViewController alloc] init];
    _window.rootViewController = loginViewController;
}

- (void) testJegarn
{
    NSThread* myThread = [[NSThread alloc] initWithTarget:self
                                                 selector:@selector(testJegarnCore)
                                                   object:nil];
    [myThread start];
}

- (void)testJegarnCore
{
    _transport = [[JegarnCFSocketTransport alloc] init];
    _transport.host = @"127.0.0.1";
    _transport.port = 8883;
    [_transport open];
    //[_transport close];
};

- (void) testSslJegarnCore
{
    JegarnCFSslSecurityPolicy *securityPolicy = [JegarnCFSslSecurityPolicy policyWithPinningMode:JegarnSSLPinningModeCertificate];
    NSString *certificate = [[NSBundle bundleForClass:[self class]] pathForResource:@"server" ofType:@"cer"];
    securityPolicy.pinnedCertificates = @[[NSData dataWithContentsOfFile:certificate]];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesCertificateChain = NO;

    NSString *p12File = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"];
    NSString *p12Password = @"111111";
    NSArray * certificates = [JegarnSslConvert clientCertsFromP12:p12File passphrase:p12Password];

    _sslTransport = [[JegarnCFSslSocketTransport alloc] init];
    _sslTransport.securityPolicy = securityPolicy;
    _sslTransport.tls = true;
    _sslTransport.certificates = certificates;
    _sslTransport.host = @"jegarn.com";
    //_sslTransport.host = @"123.56.79.160";
    _sslTransport.port = 7773;
    [_sslTransport open];
}


@end