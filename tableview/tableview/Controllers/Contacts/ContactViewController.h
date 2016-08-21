//
// Created by 刘勇 on 16/8/21.
// Copyright (c) 2016 tableview.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ContactViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) NSMutableArray * contacts;
@property (strong, nonatomic) NSIndexPath * selectedIndexPath;

@end