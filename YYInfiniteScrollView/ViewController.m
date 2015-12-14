//
//  ViewController.m
//  YYInfiniteScrollView
//
//  Created by various on 15/12/14.
//  Copyright © 2015年 Baozou. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YYInfiniteScrollView";
    self.infiniteScrollView = [[YYInfiniteScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 260)];
    self.infiniteScrollView.backgroundColor = [UIColor whiteColor];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark YYInfiniteScrollViewDelegate
- (void)infiniteScrollView:(YYInfiniteScrollView *)infiniteScrollView didClickIndex:(int)index{
    DetailViewController *detail = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    detail.imageName = [NSString stringWithFormat:@"page%d.jpg", index];
    [self.navigationController pushViewController:detail animated:YES];
}



@end
