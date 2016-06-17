//
//  ViewController.m
//  UIScrollView无线轮播
//
//  Created by myApplePro01 on 16/4/28.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import "ViewController.h"
#import "FXJScrollView.h"

#define UISCREENHEIGHT  self.view.bounds.size.height
#define UISCREENWIDTH  self.view.bounds.size.width

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView*       scrollView;
@property (nonatomic, strong) NSArray            *imageArray;

@end

@implementation ViewController

- (NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray = @[@"001.jpg",@"002.jpg",@"003.jpg",@"002.jpg"];
    }
    return _imageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initScrollView];
}

#pragma mark -private Methods-
- (void)initScrollView
{
     FXJScrollView* scrollView = [[FXJScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 150)];
    scrollView.imageNameArray = self.imageArray;
    scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    [self.view addSubview:scrollView];
    [self.view addSubview:scrollView.pageControl];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
