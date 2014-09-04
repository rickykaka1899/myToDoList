//
//  JYHToDoDetailController.m
//  ToDoList
//
//  Created by Kaka on 8/26/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import "JYHToDoDetailController.h"
#import "JYHToDoDetailViewController.h"
#import "JYHSwitchTableViewCell.h"

@implementation JYHToDoDetailController
@synthesize iDetailVC;
@synthesize iDate;


#pragma mark tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellidentifier = @"tododetailidentifier";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
  if (cell == nil)
  {
    cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier]autorelease];
  }
  if (indexPath.section == 0)
  {
    cell.textLabel.text = iDetailVC.iDetailVO.iTodoStr;
  }
    //switch
  else if(indexPath.section == 1)
  {
    cell = [[[NSBundle mainBundle] loadNibNamed:@"JYHSwitchTableViewCell" owner:nil options:nil] lastObject];

    UISwitch *switchButton = ((JYHSwitchTableViewCell *)cell).iSwitch;
    UILabel *label = ((JYHSwitchTableViewCell *)cell).iNameLabel;
    label.text = @"设置提醒";
    if (iDetailVC.iDetailVO.iSwitch != nil && [iDetailVC.iDetailVO.iSwitch isEqualToString:@"1"])
    {
      [switchButton setOn:YES];
    }
    else
    {
      [switchButton setOn:NO];
    }
    [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [cell addSubview:switchButton];
  }
    //datepicker
  else if(indexPath.section == 2)
  {
    NSString *dateStr = nil;
      //获得系统时间
    if (iDetailVC.iDetailVO.iRemindDate != nil  )
    {
      dateStr = iDetailVC.iDetailVO.iRemindDate;
    }
    else
    {
      dateStr = [self systemDate];
    }
    
    cell.textLabel.text = dateStr;
    if (iDetailVC.iDetailVO.iSwitch != nil && [iDetailVC.iDetailVO.iSwitch isEqualToString:@"1"])
    {
      cell.textLabel.textColor = [UIColor blackColor];
      cell.userInteractionEnabled = YES;
    }
    else
    {
      cell.textLabel.textColor = [UIColor grayColor];
      cell.userInteractionEnabled = NO;
    }
  }
    //label
  else
  {
    cell.textLabel.text = @"test";
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //弹出datepicker
  if (indexPath.section == 2)
  {
    UIDatePicker *datepicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 300, 320, 216)];
    datepicker.datePickerMode = UIDatePickerModeDate;
    datepicker.backgroundColor = [UIColor greenColor];
    [datepicker addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventValueChanged];
    [iDetailVC.view addSubview:datepicker];
    [datepicker release];
  }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 4;
}

#pragma mark switch
- (void)switchAction:(id)sender
{
  UISwitch *tempSwitch = (UISwitch *)sender;
  if (tempSwitch.on)
  {
    iDetailVC.iDetailVO.iSwitch = @"1";
  }
  else
  {
    iDetailVC.iDetailVO.iSwitch = @"0";
  }
  [iDetailVC.iTableview reloadData];
}

- (void)datePickerAction:(id)sender
{
  UIDatePicker * control = (UIDatePicker*)sender;
  self.iDate = control.date;
  iDetailVC.iDetailVO.iRemindDate = [self systemDate];
  [iDetailVC.iTableview reloadData];
}

- (NSString *)systemDate
{
  if (self.iDate == nil)
  {
    self.iDate = [NSDate date];
  }
  NSCalendar  * cal=[NSCalendar  currentCalendar];
  NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
  NSDateComponents * conponent= [cal components:unitFlags fromDate:self.iDate];
  NSInteger year=[conponent year];
  NSInteger month=[conponent month];
  NSInteger day=[conponent day];
  NSString *nsDateString= [NSString  stringWithFormat:@"%4d年%2d月%2d日",year,month,day];
  return nsDateString;
}


@end
