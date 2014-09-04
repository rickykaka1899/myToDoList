//
//  JYHToDoThingVO.h
//  ToDoList
//
//  Created by Kaka on 8/21/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYHToDoThingVO : NSObject<NSCoding>
{
  NSString *isFinished;
  NSString *iTodoStr;
  NSString *iTimeStamp;
  NSString *iSwitch;
  NSString *iRemindDate;
  NSString *iNote;
}

@property (nonatomic,retain) NSString *isFinished;
@property (nonatomic,retain) NSString *iTodoStr;
@property (nonatomic,retain) NSString *iTimeStamp;
@property (nonatomic,retain) NSString *iSwitch;
@property (nonatomic,retain) NSString *iRemindDate;
@property (nonatomic,retain) NSString *iNote;


@end
