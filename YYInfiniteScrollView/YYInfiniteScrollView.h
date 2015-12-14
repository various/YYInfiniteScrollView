


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

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) BOOL needAutoScroll;


/*!
 @var YYInfiniteScrollViewDelegate
 */
@property (nonatomic, assign) id<YYInfiniteScrollViewDelegate> delegate;

- (void)setPageSize:(CGSize)pageSize;

- (void)setContentViewSpacing:(float)contentViewSpacing;

/*!
 Add a view object to inner scrollView view.
 @method addPageView:
 @param UIView *pageView
 */
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
