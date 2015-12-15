//
//  ViewController.h
//  YYInfiniteScrollView
//
//  Created by various on 15/12/14.
//  Copyright © 2015年 Baozou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYInfiniteScrollView.h"

@interface ViewController : UIViewController<YYInfiniteScrollViewDelegate>

@property  (nonatomic, strong) YYInfiniteScrollView *infiniteScrollView;

@property (nonatomic, strong) NSTimer *timer;


@end

