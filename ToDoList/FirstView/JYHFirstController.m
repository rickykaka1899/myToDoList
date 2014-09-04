  //
  //  JYHFirstController.m
  //  ToDoList
  //
  //  Created by Kaka on 8/20/14.
  //  Copyright (c) 2014 yonyou. All rights reserved.
  //

#import "JYHFirstController.h"
#import "JYHFirstListVO.h"
#import "JYHToDoViewController.h"
#import "JYHFirstViewController.h"

@implementation JYHFirstController
@synthesize iArray;
@synthesize iFirstVC;

-(void) dealloc
{
  [iArray release];
  [super dealloc];
}

- (void)setData
{
  JYHFirstListVO *iList1 = [[JYHFirstListVO alloc] init];
  iList1.iId = @"1";
  iList1.iName = @"全部";
  JYHFirstListVO *iList2 = [[JYHFirstListVO alloc] init];
  iList2.iId = @"3";
  iList2.iName = @"已完成";
  JYHFirstListVO *iList3 = [[JYHFirstListVO alloc] init];
  iList3.iId = @"2";
  iList3.iName = @"待完成";
  iArray = [NSArray arrayWithObjects:iList1,iList2,iList3 ,nil];
  [iArray retain];
  [iList1 release];
  [iList2 release];
  [iList3 release];
  
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return UITableViewCellEditingStyleInsert | UITableViewCellEditingStyleDelete;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [iArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier = @"firstidentifier";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier]; ;
  if (cell == nil)
  {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
  }
  cell.textLabel.text = ((JYHFirstListVO *)[iArray objectAtIndex:indexPath.row]).iName;;
  return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  JYHFirstListVO *listVO = [iArray objectAtIndex:indexPath.row];
  JYHToDoViewController *iToDoVC = [[JYHToDoViewController alloc] initWithNibName:@"JYHToDoViewController"
                                                                           bundle:nil];
  iToDoVC.iFirstVO = listVO;
  [iFirstVC presentViewController:iToDoVC animated:YES completion:nil];
  [iToDoVC release];
}

@end
