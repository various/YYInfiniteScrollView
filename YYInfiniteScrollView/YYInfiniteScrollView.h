//
//  YYInfiniteScrollView.h
//  YYInfiniteScrollView
//
//  Created by various on 15/12/14.
//

/*
 The MIT License (MIT)
 
 Copyright (c) 2015 various
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */



#import <UIKit/UIKit.h>


@class YYInfiniteScrollView;

/*!
 @protocol YYInfiniteScrollViewDelegate
 */
@protocol YYInfiniteScrollViewDelegate <NSObject>
@optional
- (void)infiniteScrollView:(YYInfiniteScrollView *)infiniteScrollView willBeginDragging:(UIScrollView *)scrollView;
- (void)infiniteScrollView:(YYInfiniteScrollView *)infiniteScrollView didScroll:(UIScrollView *)scrollView;
- (void)infiniteScrollView:(YYInfiniteScrollView *)infiniteScrollView didEndDragging:(UIScrollView *)scrollView;
- (void)infiniteScrollView:(YYInfiniteScrollView *)infiniteScrollView willBeginDecelerating:(UIScrollView *)scrollView;
- (void)infiniteScrollView:(YYInfiniteScrollView *)infiniteScrollView didEndDecelerating:(UIScrollView *)scrollView atPageIndex:(NSInteger)pageIndex;
- (void)infiniteScrollView:(YYInfiniteScrollView *)infiniteScrollView didClickIndex:(int)index;
@end

/*!
 * @class YYInfiniteScrollView
 * endlessly scrollable view.
 */
@interface YYInfiniteScrollView : UIView <UIScrollViewDelegate,UIGestureRecognizerDelegate>

/*!
 @var CGFloat width of inner page.
 */
@property (nonatomic, assign) CGSize pageSize;



/*!
 @var YYInfiniteScrollViewDelegate
 */
@property (nonatomic, assign) id<YYInfiniteScrollViewDelegate> delegate;

- (void)setPageSize:(CGSize)pageSize;

- (id)initWithFrame:(CGRect)frame  contentSpacing:(float)contentSpacing;

- (void)addPageViews:(NSArray *)pageView;

/*!
 Scroll to previous page.
 @method scrollToPrevious
 */
- (void)scrollToPreviousPage;

/*!
 Scroll to next page.
 @method scrollToPrevious
 */
- (void)scrollToNextPage;

@end
