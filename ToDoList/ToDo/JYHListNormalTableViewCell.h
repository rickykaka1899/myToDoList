//
//  JYHListNormalTableViewCell.h
//  ToDoList
//
//  Created by Kaka on 8/29/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYHListNormalTableViewCell : UITableViewCell
{
  IBOutlet UILabel *iNameLabel;
  IBOutlet UIButton *iDetailBtn;
}
@property (retain, nonatomic) IBOutlet UILabel *iNameLabel;
@property (retain, nonatomic) IBOutlet UIButton *iDetailBtn;

@end
