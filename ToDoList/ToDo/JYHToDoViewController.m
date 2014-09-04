  //
  //  JYHToDoViewController.m
  //  ToDoList
  //
  //  Created by Kaka on 8/20/14.
  //  Copyright (c) 2014 yonyou. All rights reserved.
  //

#import "JYHToDoViewController.h"

@interface JYHToDoViewController ()

@end


@implementation JYHToDoViewController
@synthesize iNavBar;
@synthesize iTableView;
@synthesize iBackBtn;
@synthesize iRightBtn;
@synthesize iFirstVO;
@synthesize iToDoCtrl;
@synthesize isEditing;

- (void)dealloc
{
  [iNavBar release];
  [iTableView release];
  [iBackBtn release];
  [iRightBtn release];
  [iFirstVO release];
  [iToDoCtrl release];
  [iRightBtn release];
  [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
      // Custom initialization
    iToDoCtrl = [[JYHToDoController alloc] init];
    iToDoCtrl.iToDoVC = self;
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
    //注册键盘通知
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:iToDoCtrl];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:iToDoCtrl];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  iNavBar.topItem.title = iFirstVO.iName;
  [iToDoCtrl setDefaultList];
  iTableView.delegate = iToDoCtrl;
  iTableView.dataSource = iToDoCtrl;
  [iBackBtn setTitle:@"返回" forState:UIControlStateNormal];
  [iTableView setEditing:YES animated:YES];
  if (!isEditing)
  {
    [iRightBtn setTitle:@"编辑" forState:UIControlStateNormal];
  }
  else
  {
    [iRightBtn setTitle:@"完成" forState:UIControlStateNormal];
  }
  
}
- (void)viewDidDisappear:(BOOL)animated
{
    //注销键盘通知
  [[NSNotificationCenter defaultCenter]removeObserver:iToDoCtrl name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter]removeObserver:iToDoCtrl name:UIKeyboardWillHideNotification object:nil];
  [super viewDidDisappear:animated];
}


- (IBAction)backAction:(id)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)reloadViewaccording
{
  if (isEditing)
  {
    [iRightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    isEditing = NO;
//    [iTableView setEditing:NO animated:YES];
  }
  else
  {
    [iRightBtn setTitle:@"完成" forState:UIControlStateNormal];
//    [iTableView setEditing:YES animated:YES];
    isEditing = YES;
  }
}

- (IBAction)editAction:(id)sender
{
  [self reloadViewaccording];
  [iTableView reloadData];
}


@end
