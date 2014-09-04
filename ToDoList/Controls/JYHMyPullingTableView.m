//
//  JYHMyPullingTableView.m
//  ToDoList
//
//  Created by Kaka on 8/28/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import "JYHMyPullingTableView.h"

@implementation JYHMyPullingTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
  CGRect framec = CGRectMake(0, 0-frame.size.height, frame.size.width, frame.size.height);
  self = [super initWithFrame:framec style:style];
  if (self)
  {
    [self addSubviewToTableView];
  }
  return self;
}

- (void)addSubviewToTableView
{
  UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, -34, 192, 24)];
  label.text = @"test";
  label.backgroundColor = [UIColor redColor];
  [self addSubview:label];
  [label release];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
