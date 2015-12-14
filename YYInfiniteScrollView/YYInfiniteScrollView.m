

#import "YYInfiniteScrollView.h"

#define ScrollViewContentSpacing 10

@interface YYInfiniteScrollView (){
    UIScrollView *_innerScrollView;
    NSMutableArray *_pageViews;
    CGFloat _previousScrollViewOffsetX;
}
@end


@implementation YYInfiniteScrollView


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (nil == _innerScrollView) {
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        CGRect bounds = CGRectZero;
        bounds.size = frame.size;
        _innerScrollView = [[UIScrollView alloc] initWithFrame:bounds];
        _innerScrollView.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
        _innerScrollView.delegate = self;
        _innerScrollView.backgroundColor = [UIColor clearColor];
        _innerScrollView.clipsToBounds = NO;
        _innerScrollView.pagingEnabled = YES;
        _innerScrollView.scrollEnabled = YES;
        _innerScrollView.showsHorizontalScrollIndicator = NO;
        _innerScrollView.showsVerticalScrollIndicator = NO;
        _innerScrollView.scrollsToTop = NO;
        _innerScrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_innerScrollView];
        UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(handleSingleFingerEvent:)];
        singleFingerOne.numberOfTouchesRequired = 1;
        singleFingerOne.numberOfTapsRequired = 1;
        singleFingerOne.delegate = self;
        [self addGestureRecognizer:singleFingerOne];
//        self.pageSize = frame.size;
    }
}

- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)tapRecognizer{
    int clickIndex = 0;
    CGPoint touchPoint = [tapRecognizer locationInView: self];
    NSArray *subViews = _innerScrollView.subviews;
    if (touchPoint.x < ([UIScreen mainScreen].bounds.size.width - self.pageSize.width)/2.0) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(infiniteScrollView:didClickIndex:)]){
            for (UIView *page in subViews) {
                if ([page isKindOfClass:[UIView class]]) {
                    if (page.center.x == (0) * (_innerScrollView.frame.size.width) + (_innerScrollView.frame.size.width / 2)) {
                        clickIndex = (int)page.tag;
                        [self.delegate infiniteScrollView:self didClickIndex:clickIndex];
                        return;
                    }
                }
            }
        }
    }else if (touchPoint.x > ([UIScreen mainScreen].bounds.size.width - self.pageSize.width)/2.0 + self.pageSize.width){
        if(self.delegate && [self.delegate respondsToSelector:@selector(infiniteScrollView:didClickIndex:)]){
            for (UIView *page in subViews) {
                if ([page isKindOfClass:[UIView class]]) {
                    if (page.center.x == (2) * (_innerScrollView.frame.size.width) + (_innerScrollView.frame.size.width / 2)) {
                        clickIndex = (int)page.tag;
                        [self.delegate infiniteScrollView:self didClickIndex:clickIndex];
                        return;
                    }
                }
            }
        }
    }else{
        if(self.delegate && [self.delegate respondsToSelector:@selector(infiniteScrollView:didClickIndex:)]){
            for (UIView *page in subViews) {
                if ([page isKindOfClass:[UIView class]]) {
                    if (page.center.x == (1) * (_innerScrollView.frame.size.width) + (_innerScrollView.frame.size.width / 2)) {
                        clickIndex = (int)page.tag;
                        [self.delegate infiniteScrollView:self didClickIndex:clickIndex];
                        return;
                    }
                }
            }
        }
    }
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
    _innerScrollView.delegate = nil;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (nil != hitView) {
        return _innerScrollView;
    }
    return nil;
}

#pragma mark - Public methods

- (void)addPageViews:(NSArray *)pageViews{
    for (int i = 0; i < pageViews.count; i++) {
        UIView *view = [pageViews objectAtIndex:i];
        view.tag = i;
    }
    if (nil == _pageViews) {
        _pageViews = [NSMutableArray array];
    }
    [_pageViews removeAllObjects];
    NSArray *scrollViewSubViews = [_innerScrollView subviews];
    [scrollViewSubViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_pageViews addObjectsFromArray:pageViews];
    
    for (int i = 0; i < 3; i ++) {
        UIView *rightView = [_pageViews lastObject];
        [_pageViews removeLastObject];
        [_pageViews insertObject:rightView atIndex:0];
    }
    [self layoutPages];
}

- (void)scrollToPreviousPage
{
    [self scrollToDirection:1 animated:YES];
    [self performSelector:@selector(scrollViewDidEndDecelerating:) withObject:_innerScrollView afterDelay:0.5f]; // delay until scroll animation end.
}

- (void)scrollToNextPage
{
    [self scrollToDirection:-1 animated:YES];
    [self performSelector:@selector(scrollViewDidEndDecelerating:) withObject:_innerScrollView afterDelay:0.5f]; // delay until scroll animation end.
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutPages];
}

- (void)setPageSize:(CGSize)pageSize{
    _pageSize = CGSizeMake(pageSize.width + ScrollViewContentSpacing, pageSize.height);
}

#pragma mark - Private methods
- (void)layoutPages
{
    CGFloat left_margin = (self.frame.size.width - _pageSize.width) / 2;
    _innerScrollView.frame = CGRectMake(left_margin, 0.f, _pageSize.width , self.frame.size.height);
    _innerScrollView.contentSize = CGSizeMake(_pageViews.count * _innerScrollView.frame.size.width + (_pageViews.count - 1) * ScrollViewContentSpacing, self.frame.size.height);
    for (int idx = 0; idx < _pageViews.count  ; idx++) {
        UIView *pageView  = [_pageViews objectAtIndex:idx];
        pageView.center = CGPointMake((idx - 2) * (_innerScrollView.frame.size.width) + (_innerScrollView.frame.size.width / 2) , _innerScrollView.center.y);
        [_innerScrollView addSubview:pageView];
    }
    _innerScrollView.contentOffset = CGPointMake(_pageSize.width , 0.f);
}

- (void)scrollToDirection:(NSInteger)moveDirection animated:(BOOL)animated
{
    CGRect adjustScrollRect;
    if (0 != fmodf(_innerScrollView.contentOffset.x, _pageSize.width)) return ;
    adjustScrollRect = CGRectMake(_innerScrollView.contentOffset.x - _innerScrollView.frame.size.width * moveDirection,
                                  _innerScrollView.contentOffset.y,
                                  _innerScrollView.frame.size.width, _innerScrollView.frame.size.height);
    [_innerScrollView scrollRectToVisible:adjustScrollRect animated:animated];
}

#pragma mark - UIScrollViewDelegate methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _previousScrollViewOffsetX = scrollView.contentOffset.x;
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(infiniteScrollView:willBeginDragging:)]) {
        [self.delegate infiniteScrollView:self willBeginDragging:_innerScrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(infiniteScrollView:didScroll:)]) {
        [self.delegate infiniteScrollView:self didScroll:_innerScrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(infiniteScrollView:didEndDragging:)]) {
        [self.delegate infiniteScrollView:self didEndDragging:_innerScrollView];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(infiniteScrollView:willBeginDecelerating:)]) {
        [self.delegate infiniteScrollView:self willBeginDecelerating:_innerScrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == 0) {
        //move to right
        UIView *rightView = [_pageViews lastObject];
        [_pageViews removeLastObject];
        [_pageViews insertObject:rightView atIndex:0];
        
    }else if(scrollView.contentOffset.x == _pageSize.width * 2 ){
        UIView *leftView = [_pageViews objectAtIndex:0];
        [_pageViews removeObjectAtIndex:0];
        [_pageViews insertObject:leftView atIndex:_pageViews.count];
    }
    for(int idx = 0;idx < _pageViews.count; idx++){
        UIView *pageView = [_pageViews objectAtIndex:idx];
        pageView.center = CGPointMake((idx - 2 ) * _innerScrollView.frame.size.width + _innerScrollView.frame.size.width / 2  , _innerScrollView.center.y);
    }
    _innerScrollView.contentOffset = CGPointMake(_pageSize.width , 0.f);
}

@end
