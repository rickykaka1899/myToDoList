//
//  JYHToDoViewController.h
//  ToDoList
//
//  Created by Kaka on 8/20/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYHFirstListVO.h"
#import "JYHToDoController.h"


@interface JYHToDoViewController : UIViewController
{
  
  IBOutlet UINavigationBar *iNavBar;
  IBOutlet UITableView *iTableView;
  IBOutlet UIButton *iBackBtn;
  IBOutlet UIButton *iRightBtn;
  JYHFirstListVO *iFirstVO;
  JYHToDoController *iToDoCtrl;
  BOOL isEditing;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *iNavBar;
@property (nonatomic, retain) IBOutlet UITableView *iTableView;
@property (nonatomic, retain) IBOutlet UIButton *iBackBtn;
@property (nonatomic, retain) IBOutlet UIButton *iRightBtn;
@property (nonatomic, retain) JYHFirstListVO *iFirstVO;
@property (nonatomic, retain) JYHToDoController *iToDoCtrl;
@property (nonatomic, assign) BOOL isEditing;


- (IBAction)backAction:(id)sender;
- (IBAction)editAction:(id)sender;

@end
