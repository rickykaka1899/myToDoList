//
//  JYHFirstViewController.m
//  ToDoList
//
//  Created by Kaka on 8/20/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import "JYHFirstViewController.h"


@interface JYHFirstViewController ()

@end

@implementation JYHFirstViewController
@synthesize iNavBar;
@synthesize iTableView;
@synthesize iFirstCtrl;

//@synthesize iArray;
//@synthesize iMutArray;
//@synthesize firstelement;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      iFirstCtrl = [[JYHFirstController alloc] init];
      iFirstCtrl.iFirstVC = self;
//      iMutArray = [[NSMutableArray alloc] initWithCapacity:1];
//      iMutArray = [NSMutableArray arrayWithObjects:@"abc",@"str", nil];
//      firstelement = iMutArray[0];
//      self.iArray = iMutArray;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

//  CWAPullingRefreshTableView *pulltableview = [[CWAPullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 504)style:UITableViewStylePlain];
//  iTableView = pulltableview;
//  [pulltableview release];
  iTableView.delegate = iFirstCtrl;
  iTableView.dataSource = iFirstCtrl;
  [iFirstCtrl setData];
//  NSString *str = @"str";
//  [iMutArray addObject:str];
//  iMutArray[0] = @"feafe";
//  [iArray addObject:str];
//  firstelement = [NSString stringWithFormat:@"%@%@",firstelement,@"afe"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
  [iNavBar release];
  [iTableView release];
  [iFirstCtrl release];
  [super dealloc];
}
@end
