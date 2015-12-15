YYInfiniteScrollView
=====================

Overview
--------
YYInfiniteScrollView is a subclass of UIView. It contains an endlessly scrollable UIScrollView, and you can click the subview on the scrollview. Some of the function get inspiration from https://github.com/caesarcat/InfinitePagingView.


Features
--------
- Endlessly scrollable to horizontal direction and show the previous and next subview.
- Each page view contents are available to a UIView based custom view.
- Implements paging scroll and click delegate protocol.
- Page scroll action methods.
- Page click action methods.
 

Requirements
------------
- iOS 7.0+
- Xcode 5 (Use ARC)

Screenshots
-----------
![Screenshot0](https://github.com/various/YYInfiniteScrollView/blob/master/sample1.png)
![Screenshot0](https://github.com/various/YYInfiniteScrollView/blob/master/sample2.png)


How to use
----------

```Objective-C
#import "YYInfiniteScrollView.h"
...
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YYInfiniteScrollView";
    self.infiniteScrollView = [[YYInfiniteScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 260) contentSpacing:10];
    self.infiniteScrollView.delegate = self;
    self.infiniteScrollView.pageSize = CGSizeMake(535, 260);
    NSMutableArray *imageViews = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 6; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"page%d.jpg", i]];
        UIImageView *page = [[UIImageView alloc] initWithImage:image];
        page.frame = CGRectMake(0.f, 0.f, 535, 260);
        page.contentMode = UIViewContentModeScaleAspectFill;
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"%d",i];
        label.frame = CGRectMake(0, 0, 100, 100);
        label.font = [UIFont fontWithName:@"Helvetica" size:100];
        label.textAlignment = NSTextAlignmentCenter;
        [label setTextColor:[UIColor whiteColor]];
        label.center = page.center;
        [page addSubview:label];
        [imageViews addObject:page];
    }
    [self.infiniteScrollView addPageViews:imageViews];
    [self.view addSubview:self.infiniteScrollView];
}
```

Build and run the project files. Enjoy more examples!

Public methods
--------

```Objective-C
- (void)addPageViews:(NSArray *)pageView;
```
Adds views to the inner scrollview's subviews.

-

```Objective-C
- (void)scrollToPreviousPage;
```
Scroll to the previous page.

-

```Objective-C
- (void)scrollToNextPage;
```
Scroll to the next page.



YYInfiniteScrollViewDelegate Protocols
-

```Objective-C
- (void)infiniteScrollView:(YYInfiniteScrollView *)infiniteScrollView willBeginDragging:(UIScrollView *)scrollView;
```
Tells the delegate when the scrollview view is about to start scrolling the content.



```Objective-C
- (void)infiniteScrollView:(YYInfiniteScrollView *)infiniteScrollView didClickIndex:(int)index;
```
Tells the delegate which subview the user click on content view within the receiver.
-

```Objective-C
- (void)infiniteScrollView:(YYInfiniteScrollView *)infiniteScrollView didScroll:(UIScrollView *)scrollView;
```
Tells the delegate when the user scrolls the content view within the receiver.

-

```Objective-C
- (void)infiniteScrollView:(YYInfiniteScrollView *)infiniteScrollView didEndDragging:(UIScrollView *)scrollView;
```
Tells the delegate when dragging ended in the paging view.


-

```Objective-C
- (void)infiniteScrollView:(YYInfiniteScrollView *)infiniteScrollView willBeginDecelerating:(UIScrollView *)scrollView;
```

Tells the delegate that the paging view is starting to decelerate the scrolling movement.

-

```Objective-C
- (void)infiniteScrollView:(YYInfiniteScrollView *)infiniteScrollView didEndDecelerating:(UIScrollView *)scrollView ;
```
Tells the delegate that the scroll view has ended decelerating the scrolling movement.



License
-------
This software is released under the MIT License, see LICENSE.txt.

