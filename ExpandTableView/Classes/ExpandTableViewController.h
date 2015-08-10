//
//  ExpandTableViewController.h
//  ExpandTableView
//
//  Created by long on 15/7/14.
//  Copyright (c) 2015年 long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupDataModel : NSObject

@property (nonatomic, copy) NSString *groupTitle;
@property (nonatomic, copy) NSArray *groupData;

@end

@interface ExpandTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray *arrayData;

@end
