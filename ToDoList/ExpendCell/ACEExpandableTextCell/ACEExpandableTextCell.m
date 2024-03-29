//  ACEExpandableTextCell.m
//
// Copyright (c) 2014 Stefano Acerbetti
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "ACEExpandableTextCell.h"

#define kPadding 5

@interface ACEExpandableTextCell ()<UITextViewDelegate>
@property (nonatomic, retain) SZTextView *textView;
@end

#pragma mark -

@implementation ACEExpandableTextCell
@synthesize textView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.textView];
    }
    return self;
}

- (SZTextView *)textView
{
    if (textView == nil) {
        CGRect cellFrame = self.contentView.bounds;
        cellFrame.origin.y += kPadding;
        cellFrame.size.height -= kPadding;
        
        textView = [[SZTextView alloc] initWithFrame:cellFrame];
        textView.delegate = self;
        
        textView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        textView.backgroundColor = [UIColor clearColor];
        textView.font = [UIFont systemFontOfSize:18.0f];
        
        textView.scrollEnabled = NO;
        textView.showsVerticalScrollIndicator = NO;
        textView.showsHorizontalScrollIndicator = NO;
      textView.placeholder = @"neibuss";
        // textView.contentInset = UIEdgeInsetsZero;
    }
    return textView;
}

- (void)setText:(NSString *)text
{
    _text = text;
    
    // update the UI
    self.textView.text = text;
}

- (CGFloat)cellHeight
{
    return [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, FLT_MAX)].height + kPadding * 2;
}


#pragma mark - Text View Delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    // make sure the cell is at the top
    [self.expandableTableView scrollToRowAtIndexPath:[self.expandableTableView indexPathForCell:self]
                                    atScrollPosition:UITableViewScrollPositionTop
                                            animated:YES];
    
    return YES;
}

  //内容发生改变时修改高度
- (void)textViewDidChange:(UITextView *)theTextView
{
  if ([self.expandableTableView.delegate conformsToProtocol:@protocol(ACEExpandableTableViewDelegate)]) {
    
    id<ACEExpandableTableViewDelegate> delegate = (id<ACEExpandableTableViewDelegate>)self.expandableTableView.delegate;
    NSIndexPath *indexPath = [self.expandableTableView indexPathForCell:self];
    
    CGFloat newHeight = [self cellHeight];
    CGFloat oldHeight = [delegate tableView:self.expandableTableView heightForRowAtIndexPath:indexPath];
    if (fabs(newHeight - oldHeight) > 0.01) {
      
        // update the height
      if ([delegate respondsToSelector:@selector(tableView:updatedHeight:atIndexPath:)]) {
        [delegate tableView:self.expandableTableView
              updatedHeight:newHeight
                atIndexPath:indexPath];
      }
      
        // refresh the table without closing the keyboard
      [self.expandableTableView beginUpdates];
      [self.expandableTableView endUpdates];
    }
  }
}

  //结束输入，修改内容
- (void)textViewDidEndEditing:(UITextView *)textView
{
  if ([self.expandableTableView.delegate conformsToProtocol:@protocol(ACEExpandableTableViewDelegate)])
  {
    id<ACEExpandableTableViewDelegate> delegate = (id<ACEExpandableTableViewDelegate>)self.expandableTableView.delegate;
    NSIndexPath *indexPath = [self.expandableTableView indexPathForCell:self];
      // update the text
    _text = self.textView.text;
    
    [delegate tableView:self.expandableTableView
            updatedText:_text
            atIndexPath:indexPath];
  }
}

@end

#pragma mark -

@implementation UITableView (ACEExpandableTextCell)

- (ACEExpandableTextCell *)expandableTextCellWithId:(NSString *)cellId
{
    ACEExpandableTextCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ACEExpandableTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.expandableTableView = self;
    }
    return cell;
}

@end

