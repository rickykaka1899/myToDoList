//
//  JYHToDoDetailController.h
//  ToDoList
//
//  Created by Kaka on 8/26/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYHToDoThingVO.h"

@class JYHToDoDetailViewController;


@interface JYHToDoDetailController : NSObject<UITableViewDataSource,UITableViewDelegate>
{
  JYHToDoDetailViewController *iDetailVC;
  NSDate *iDate;
}
@property (nonatomic,assign) JYHToDoDetailViewController *iDetailVC;
@property (nonatomic,retain) NSDate *iDate;
@end
