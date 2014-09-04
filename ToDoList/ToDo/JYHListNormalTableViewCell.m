//
//  JYHListNormalTableViewCell.m
//  ToDoList
//
//  Created by Kaka on 8/29/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import "JYHListNormalTableViewCell.h"

@implementation JYHListNormalTableViewCell
@synthesize iNameLabel;
@synthesize iDetailBtn;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [iNameLabel release];
    [iDetailBtn release];
    [super dealloc];
}
@end
