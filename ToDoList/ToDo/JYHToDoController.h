//
//  JYHToDoController.h
//  ToDoList
//
//  Created by Kaka on 8/20/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACEExpandableTextCell.h"

@class JYHToDoViewController;
@interface JYHToDoController : NSObject <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ACEExpandableTableViewDelegate>
{
  NSMutableArray *iToDoList;
  NSMutableArray *iCacheList;
  NSString *iToDoString;
  UITextField *iTextField;
  JYHToDoViewController *iToDoVC;
    //每行高度
  CGFloat cellHeight[1000];
}
/*!
 	@property
 	@abstract	iToDoList	用于展示的数组
 */
@property (nonatomic, retain) NSMutableArray *iToDoList;

@property (nonatomic, retain) NSString *iToDoString;
@property (nonatomic, retain) UITextField *iTextField;
@property (nonatomic, retain) JYHToDoViewController *iToDoVC;

/*!
 	@property
 	@abstract	iCacheList	与缓存交互的数组
 */
@property (nonatomic, retain) NSMutableArray *iCacheList;


- (void)keyboardShow:(NSNotificationCenter *)notification;
- (void)keyboardHide:(NSNotificationCenter *)notification;

- (void) setDefaultList;

@end
