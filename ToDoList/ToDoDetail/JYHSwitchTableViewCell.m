//
//  JYHSwitchTableViewCell.m
//  ToDoList
//
//  Created by Kaka on 8/28/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import "JYHSwitchTableViewCell.h"

@implementation JYHSwitchTableViewCell
@synthesize iNameLabel;
@synthesize iSwitch;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

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
    [iSwitch release];
    [super dealloc];
}
@end
