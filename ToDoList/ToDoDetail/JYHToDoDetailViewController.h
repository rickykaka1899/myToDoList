//
//  JYHToDoDetailViewController.h
//  ToDoList
//
//  Created by Kaka on 8/26/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYHToDoThingVO.h"
#import "JYHToDoDetailController.h"

typedef void (^TJYHDetailBlock) (JYHToDoThingVO *vo);

@interface JYHToDoDetailViewController : UIViewController
{
  JYHToDoThingVO *iDetailVO;
  JYHToDoDetailController *iDetailCtrl;
  IBOutlet UINavigationBar *iNavbar;
  IBOutlet UIButton *iRightBtn;
  IBOutlet UITableView *iTableview;
  TJYHDetailBlock iDetailBlock;
}
@property (nonatomic,retain) JYHToDoThingVO *iDetailVO;
@property (nonatomic,retain) JYHToDoDetailController *iDetailCtrl;
@property (nonatomic,assign) TJYHDetailBlock iDetailBlock;

@property (nonatomic,retain) IBOutlet UINavigationBar *iNavbar;
@property (nonatomic,retain) IBOutlet UITableView *iTableview;

- (IBAction)doneAction:(id)sender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withBlock:(TJYHDetailBlock)aBlock;


@end
