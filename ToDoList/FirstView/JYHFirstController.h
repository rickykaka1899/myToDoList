//
//  JYHFirstController.h
//  ToDoList
//
//  Created by Kaka on 8/20/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JYHFirstViewController;

@interface JYHFirstController : NSObject<UITableViewDataSource,UITableViewDelegate>
{
  NSArray *iArray;
  JYHFirstViewController *iFirstVC;
}
@property (nonatomic, retain) NSArray *iArray;
@property (nonatomic, assign) JYHFirstViewController *iFirstVC;

- (void)setData;

@end
