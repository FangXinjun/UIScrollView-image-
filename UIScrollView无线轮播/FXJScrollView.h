//
//  FXJScrollView.h
//  UIScrollView无线轮播
//
//  Created by myApplePro01 on 16/6/16.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXJScrollView : UIScrollView<UIScrollViewDelegate>

@property (retain,nonatomic,readonly) UIPageControl * pageControl;
@property (retain,nonatomic,readwrite) NSArray * imageNameArray;


@end
