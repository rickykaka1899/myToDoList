//
//  JYHFirstViewController.h
//  ToDoList
//
//  Created by Kaka on 8/20/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYHFirstController.h"

@interface JYHFirstViewController : UIViewController
{
  IBOutlet UINavigationBar *iNavBar;
  IBOutlet UITableView *iTableView;
  JYHFirstController *iFirstCtrl;
//  NSMutableArray *iArray;
//  NSMutableArray *iMutArray;
//  NSMutableString *firstelement;
}
@property (retain, nonatomic) IBOutlet UINavigationBar *iNavBar;
@property (retain, nonatomic) IBOutlet UITableView *iTableView;
@property (retain, nonatomic) JYHFirstController *iFirstCtrl;

//@property (nonatomic, retain) NSMutableArray *iArray;
//@property (nonatomic, retain) NSMutableArray *iMutArray;
//@property (nonatomic,assign) NSMutableString *firstelement;

@end
