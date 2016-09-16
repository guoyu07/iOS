//
// Created by Yao Guai on 16/9/15.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "MNLoginViewController.h"
#import "YGCommonMicro.h"


@implementation MNLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    const CGFloat commonMarginLeft = 60;
    const CGFloat commonWidth = YGViewWidth(self.view) - 2 * commonMarginLeft;
    UIColor * commonColor = [UIColor colorWithRed:155 / 255.0 green:155 / 255.0 blue:155 / 255.0 alpha:1];
    UIColor * commonHighlightColor = [UIColor colorWithRed:155 / 255.0 green:155 / 255.0 blue:155 / 255.0 alpha:0.44];

    _signLabel = [[UILabel alloc] initWithFrame:CGRectMake(commonMarginLeft, 70, commonWidth, 100)];
    _signLabel.text = @"SIGN\nIN";
    _signLabel.numberOfLines = 0;
    _signLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _signLabel.textColor = commonColor;
    [_signLabel setFont:[UIFont systemFontOfSize:40]];
    [_signLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_signLabel];

    const CGFloat usernameMarginTop = 200;
    _usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(commonMarginLeft, usernameMarginTop, commonWidth, 20)];
    _usernameLabel.text = @"USERNAME";
    _usernameLabel.textColor = [UIColor colorWithRed:161 / 255.0 green:161 / 255.0 blue:164 / 255.0 alpha:1];
    _usernameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:_usernameLabel];

    _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(commonMarginLeft, usernameMarginTop + 32, commonWidth, 32)];
    _usernameTextField.keyboardType = UIKeyboardTypeAlphabet;
    [_usernameTextField becomeFirstResponder];
    [_usernameTextField setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:_usernameTextField];

    _usernameLineView = [[UIView alloc] initWithFrame:CGRectMake(commonMarginLeft, usernameMarginTop + 70, commonWidth, 1)];
    _usernameLineView.backgroundColor = [UIColor colorWithRed:36 / 255.0 green:37 / 255.0 blue:42 / 255.0 alpha:1];
    [self.view addSubview:_usernameLineView];

    const CGFloat passwordMarginTop = usernameMarginTop + 110;
    _passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(commonMarginLeft, passwordMarginTop, commonWidth, 20)];
    _passwordLabel.text = @"PASSWORD";
    _passwordLabel.textColor = [UIColor colorWithRed:161 / 255.0 green:161 / 255.0 blue:164 / 255.0 alpha:1];
    _passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:_passwordLabel];

    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(commonMarginLeft, passwordMarginTop + 32, commonWidth, 32)];
    _passwordTextField.keyboardType = UIKeyboardTypeAlphabet;
    [_passwordTextField setFont:[UIFont systemFontOfSize:18]];
    [_passwordTextField setSecureTextEntry:YES];
    [self.view addSubview:_passwordTextField];

    _passwordLineView = [[UIView alloc] initWithFrame:CGRectMake(commonMarginLeft, passwordMarginTop + 70, commonWidth, 1)];
    _passwordLineView.backgroundColor = [UIColor colorWithRed:36 / 255.0 green:37 / 255.0 blue:42 / 255.0 alpha:1];
    [self.view addSubview:_passwordLineView];

    _loginButton = [[UIButton alloc] initWithFrame:CGRectMake((YGViewWidth(self.view) - 140)/2, passwordMarginTop + 140, 140, 40)];
    [_loginButton setTitle:@"Sign In" forState:UIControlStateNormal];
    [_loginButton setTitleColor:commonColor forState:UIControlStateNormal];
    [_loginButton setTitleColor:commonHighlightColor forState:UIControlStateHighlighted];
    [_loginButton setTitleColor:commonHighlightColor forState:UIControlStateSelected];
    _loginButton.layer.borderColor = commonColor.CGColor;
    _loginButton.layer.borderWidth = 2.0;
    _loginButton.layer.cornerRadius = 10.0;
    [self.view addSubview:_loginButton];
}


@end