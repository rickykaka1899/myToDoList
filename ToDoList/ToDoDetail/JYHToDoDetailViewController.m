//
//  JYHToDoDetailViewController.m
//  ToDoList
//
//  Created by Kaka on 8/26/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import "JYHToDoDetailViewController.h"

@interface JYHToDoDetailViewController ()

@end

@implementation JYHToDoDetailViewController
@synthesize iDetailCtrl;
@synthesize iDetailVO;
@synthesize iTableview;
@synthesize iNavbar;
@synthesize iDetailBlock;

- (void)dealloc
{
  [iDetailVO release];
  [iDetailCtrl release];
  [iNavbar release];
  [iTableview release];
  [iRightBtn release];
  [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
      iDetailCtrl = [[JYHToDoDetailController alloc] init];
      iDetailCtrl.iDetailVC = self;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withBlock:(TJYHDetailBlock)aBlock;
{
  self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self)
  {
    iDetailBlock = Block_copy(aBlock);
  }
  return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  iTableview.delegate = iDetailCtrl;
  iTableview.dataSource = iDetailCtrl;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneAction:(id)sender
{
  iDetailBlock(iDetailVO);
  [self dismissViewControllerAnimated:YES completion:nil];
}
@end
