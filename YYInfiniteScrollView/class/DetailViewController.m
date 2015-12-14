//
//  DetailViewController.m
//  YYInfiniteScrollView
//
//  Created by various on 15/12/14.
//  Copyright © 2015年 Baozou. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:self.imageName];
    self.detailImageView.image = image;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
