  //
  //  JYHToDoController.m
  //  ToDoList
  //
  //  Created by Kaka on 8/20/14.
  //  Copyright (c) 2014 yonyou. All rights reserved.
  //

#import "JYHToDoController.h"
#import "JYHToDoViewController.h"
#import "JYHSaveToCache.h"
#import "JYHToDoThingVO.h"
#import "JYHToDoDetailViewController.h"
#import "JYHListNormalTableViewCell.h"
#define WA_PLACESALEORDER_FONT_KAKU_W3_16 [UIFont fontWithName:@"HiraKakuProN-W3" size:16.0]
#define WA_PLACESALEORDER_FONT_HT_W3_16 [UIFont fontWithName:@"STHeitiSC-Medium" size:16.0]

@interface JYHToDoController()
{
//  UITextView *iTextView;
}
//@property (nonatomic,retain) UITextView *iTextView;

@end

@implementation JYHToDoController
@synthesize iToDoList;
@synthesize iToDoString;
@synthesize iTextField;
@synthesize iToDoVC;
@synthesize iCacheList;
//@synthesize iTextView;

- (void) setDefaultList
{
  iCacheList = [JYHSaveToCache readFromFile];
  NSString *listid = iToDoVC.iFirstVO.iId;
  if ([iCacheList count] == 0)
  {
    iCacheList = [[NSMutableArray alloc] initWithCapacity:1];
    iToDoList = [[NSMutableArray alloc] initWithCapacity:1];
  }
  else
  {
      //全部
    if ([listid isEqualToString:@"1"])
    {
      iToDoList = [NSMutableArray arrayWithArray:iCacheList];
    }
    
    else
    {
      iToDoList = [[NSMutableArray alloc] initWithCapacity:1];
        //已完成
      if([listid isEqualToString:@"3"])
      {
        for ( JYHToDoThingVO *strvo in iCacheList)
        {
          if ([strvo.isFinished isEqualToString:@"1"])
          {
            [iToDoList addObject:strvo];
          }
        }
      }
        //未完成
      else
      {
        for ( JYHToDoThingVO *strvo in iCacheList)
        {
          if ([strvo.isFinished isEqualToString:@"0" ])
          {
            [iToDoList addObject:strvo];
          }
        }
      }
    }
    
  }
  [iCacheList retain];
  [iToDoList retain];
}

- (void)dealloc
{
  [iToDoList release];
  [iToDoString release];
  [iTextField release];
  [iCacheList release];
//  [iTextView release];
  [super dealloc];
}

#pragma mark tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  if (indexPath.row == [iToDoList count])
  {
    return MAX(48.0, cellHeight[indexPath.row]);
  }
  else
  {
    UITextView *iTextView = [[UITextView alloc] initWithFrame:CGRectMake(8, 0, 240, 24)];
//    iTextView.frame = CGRectMake(16, 0, 240, 24);
    iTextView.text = ((JYHToDoThingVO *)[iToDoList objectAtIndex:indexPath.row]).iTodoStr;
    return [self expandCellTextViewAttributes:iTextView].size.height;
  }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == [iToDoList count])
  {
    return UITableViewCellEditingStyleNone;
  }
  else
  {
    if (iToDoVC.isEditing)
    {
      return UITableViewCellEditingStyleDelete;
    }
    else
    {
      return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    }
  }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if ([iToDoVC.iFirstVO.iId isEqualToString:@"3"])
  {
    return [iToDoList count];
  }
  else
  {
    return [iToDoList count] + 1;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellidentifier = @"todocellidentifier";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
  
  
  if (cell == nil)
  {
    cell = [[[ACEExpandableTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier]autorelease];
  }
  cell = (ACEExpandableTextCell *)[tableView expandableTextCellWithId:@"cellId"];
  if (indexPath.row == [iToDoList count])
  {
    ((ACEExpandableTextCell *)cell).textView.placeholder = @"text";
  }
  else
  {
    
    UITextView *iTextView= ((ACEExpandableTextCell *)cell).textView;
    iTextView.text = ((JYHToDoThingVO *)[iToDoList objectAtIndex:indexPath.row]).iTodoStr;
    iTextView.frame = CGRectMake(8, 0, 240, 24);
    iTextView.frame = [self expandCellTextViewAttributes:iTextView];
    UIButton *detailBtn = [[UIButton alloc] initWithFrame:CGRectMake(270, 6, 32, 32)];
    detailBtn.tag = indexPath.row;
    detailBtn.backgroundColor = [UIColor redColor];
    [detailBtn addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:detailBtn];
    [detailBtn release];
    if (!iToDoVC.isEditing)
    {
      NSString *fini = ((JYHToDoThingVO *)[iToDoList objectAtIndex:indexPath.row]).isFinished;
      if([fini isEqualToString:@"1"])
      {
        cell.selected = YES;
      }
      else
      {
        cell.selected = NO;
      }
    }
    
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //  cell.selected = YES;
  JYHToDoThingVO *thingVO = [iToDoList objectAtIndex:indexPath.row];
  if ([thingVO.isFinished isEqualToString:@"0"])
  {
    thingVO.isFinished = @"1";
  }
  else
  {
    thingVO.isFinished = @"0";
  }
  [iToDoList replaceObjectAtIndex:indexPath.row withObject:thingVO];
  [self changeStatusOfVO:thingVO withStatus:thingVO.isFinished];
  [iToDoVC.iTableView reloadData];
}

#pragma mark expandcell delegate
- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath
{
  cellHeight[indexPath.row] = height;
}

- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath
{
  JYHToDoThingVO *todoVO = [[JYHToDoThingVO alloc] init];
  todoVO.isFinished = @"0";
  todoVO.iTodoStr = text;
  todoVO.iTimeStamp = [self getterTimeStamp];
    //新增的
  if (indexPath.row == [iToDoList count])
  {
    [iToDoList addObject:todoVO];
    [iCacheList addObject:todoVO];
  }
    //修改的
  else
  {
    [iCacheList replaceObjectAtIndex:indexPath.row withObject:todoVO];
    [iToDoList replaceObjectAtIndex:indexPath.row withObject:todoVO];
  }
  [todoVO release];
    //保存到缓存
  [JYHSaveToCache writeToFile:iCacheList];
  [iToDoVC.iTableView reloadData];
}

/*
 - (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 //  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
 //  cell.selected = NO;
 JYHToDoThingVO *thingVO = [iToDoList objectAtIndex:indexPath.row];
 thingVO.isFinished = @"0";
 [iToDoList replaceObjectAtIndex:indexPath.row withObject:thingVO];
 [self changeStatusOfVO:thingVO withStatus:thingVO.isFinished];
 [iToDoVC.iTableView reloadData];
 }
 */

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == [iToDoList count])
  {
    return NO;
  }
  else
  {
    return YES;
  }
}


  //修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete)
  {
    JYHToDoThingVO *deleteVO = [iToDoList objectAtIndex:indexPath.row];
    [iToDoList removeObject:deleteVO];
      //    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    for (JYHToDoThingVO *vo in iCacheList)
    {
        //单条删除没问题
      if (deleteVO.iTimeStamp == vo.iTimeStamp) {
        [iCacheList removeObject:vo];
        break;
      }
    }
    [JYHSaveToCache writeToFile:iCacheList];
    [iToDoVC.iTableView reloadData];
  }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  NSInteger listcount = [iToDoList count];
  NSString *str = [NSString stringWithFormat:@"合计：%d",listcount];
  return str;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
  
}

#pragma mark textfield delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
  return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
  
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
  return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
  JYHToDoThingVO *todoVO = [[JYHToDoThingVO alloc] init];
  todoVO.isFinished = @"0";
  todoVO.iTodoStr = textField.text;
  todoVO.iTimeStamp = [self getterTimeStamp];
  [iCacheList addObject:todoVO];
  [iToDoList addObject:todoVO];
  [todoVO release];
    //保存到缓存
  [JYHSaveToCache writeToFile:iCacheList];
  [iTextField removeFromSuperview];
  [iToDoVC.iTableView reloadData];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //键盘收回
  [iTextField resignFirstResponder];
  
  return YES;
}

#pragma mark keyboard
- (void) keyboardShow:(NSNotification *)notification{
    //动态获取当前键盘高度
  NSDictionary *userInfo = [notification userInfo];
  NSValue *value = [userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
  CGFloat keyBoardEndY = value.CGRectValue.size.height;
    //动画
  NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
  NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
  
  [UIView animateWithDuration:duration.doubleValue animations:^{
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:[curve intValue]];
      //决定界面滑动
    [self slideToNewPositionwithKeyboradHeight: keyBoardEndY];
  }];
}

- (void) keyboardHide:(NSNotification *)notification
{
    //当前tableview的contentoffsize
  CGPoint tableContentoffSize = iToDoVC.iTableView.contentOffset;
    //tableview整体全部的size
  CGSize tableContentSize = iToDoVC.iTableView.contentSize;
    //tableview的frame，即在界面上可展示的区域frame
  CGRect tableFrame = iToDoVC.iTableView.frame;
    //计算tableview的contentoffsize，table滑到最下的偏移值
  CGFloat position = tableContentSize.height - tableFrame.size.height;
    //如果 整体-当前的contentoffsize < tableframe && tableframe < table整体大小，table要回弹
  if (tableFrame.size.height > tableContentSize.height - tableContentoffSize.y && tableContentSize.height >tableFrame.size.height)
  {
    [self slideFrame:NO withPosition:position];
  }
  
}

  //self.iCellTextView 是在tableview加载上textview上之后，将当前的属性self.iCellTextView指向加载的textview，
  //这可以作为下一个优化点
- (void)slideToNewPositionwithKeyboradHeight: (CGFloat) keyheight
{
  CGPoint tableContentoffSize = iToDoVC.iTableView.contentOffset;
    //获取当前textfield在table中的相对位置
  CGPoint textFieldOriginInTableView = [self.iTextField convertPoint:self.iTextField.frame.origin toView:iToDoVC.iTableView];
    //在可显示的tableview中的y坐标
  CGFloat textFrameY = textFieldOriginInTableView.y - tableContentoffSize.y;
    //到屏幕底部的绝对距离
  CGFloat y = [UIScreen mainScreen].bounds.size.height - iToDoVC.iTableView.frame.origin.y - textFrameY;
    //计算需要滑动的距离，如果需要滑动，距离是键盘－（距离底部距离 - 自身的高度 ）＋ 当前tableview已有的contentsize
  CGFloat position = keyheight - y + self.iTextField.frame.size.height + tableContentoffSize.y;
  if (y < keyheight + self.iTextField.frame.size.height)
  {
      //修改tableview当前的contentoffsize
    [self slideFrame:YES withPosition:position];
    
  }
}

- (void)slideFrame:(BOOL)boollen withPosition: (CGFloat)y
{
  iToDoVC.iTableView.contentOffset = CGPointMake(0, y);
}

#pragma mark timestack
- (NSString *)getterTimeStamp
{
  NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
  NSTimeInterval a=[dat timeIntervalSince1970]*1000;
  NSString *timeString = [NSString stringWithFormat:@"%f", a];
  return timeString;
}

#pragma mark changestatus
- (void)changeStatusOfVO:(JYHToDoThingVO*)thingVO withStatus:(NSString *)status
{
  for (JYHToDoThingVO *vo in iCacheList)
  {
    if (thingVO.iTimeStamp == vo.iTimeStamp)
    {
      vo.isFinished = status;
    }
  }
  [JYHSaveToCache writeToFile:iCacheList];
}

#pragma mark textview动态变化高度
- (CGRect)expandCellTextViewAttributes:(UITextView *)textview
{
  CGRect textviewFrame = textview.frame;
    //  textview.frame = textviewFrame;
  textview.font = WA_PLACESALEORDER_FONT_KAKU_W3_16;
    //计算固定高度，需要的frame，主要关注与宽度
    //  CGRect textFrame = [textview.text boundingRectWithSize:textviewFrame.size
    //                                                options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
    //                                             attributes:textAttri
    //                                                context:nil];
  CGSize textSize = [textview sizeThatFits:CGSizeMake(textviewFrame.size.width, FLT_MAX)];
    //新的高度翻倍
  textviewFrame.size.height = textSize.height;
  return textviewFrame;
}

#pragma mark 详情按钮动作
- (void)detailAction:(id)sender
{
  UIButton *btn = ((UIButton *)sender);
  JYHToDoDetailViewController *detailVC =
  [[JYHToDoDetailViewController alloc] initWithNibName:@"JYHToDoDetailViewController"
                                                bundle:nil
                                             withBlock:^(JYHToDoThingVO *vo)
   {
     iToDoList[btn.tag] = vo;
   }];
  detailVC.iDetailVO = [iToDoList objectAtIndex:btn.tag];
  [self.iToDoVC presentViewController:detailVC animated:YES completion:nil];
  [detailVC release];
}

@end
