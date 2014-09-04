//
//  JYHSwitchTableViewCell.h
//  ToDoList
//
//  Created by Kaka on 8/28/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYHSwitchTableViewCell : UITableViewCell
{
  IBOutlet UILabel *iNameLabel;
  IBOutlet UISwitch *iSwitch;
}
@property (retain, nonatomic) IBOutlet UILabel *iNameLabel;
@property (retain, nonatomic) IBOutlet UISwitch *iSwitch;

@end
