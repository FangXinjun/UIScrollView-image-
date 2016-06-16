//
//  FXJScrollView.m
//  UIScrollView无线轮播
//
//  Created by myApplePro01 on 16/6/16.
//  Copyright © 2016年 LSH. All rights reserved.
//

#import "FXJScrollView.h"

#define UISCREENWIDTH  self.bounds.size.width
#define UISCREENHEIGHT  self.bounds.size.height

#define HIGHT self.bounds.origin.y

static CGFloat const chageImageTime = 3.0;
static NSUInteger currentImage = 1;//记录中间图片的下标,开始总是为1
@interface FXJScrollView ()
{
    UIImageView * _leftImageView;
    UIImageView * _centerImageView;
    UIImageView * _rightImageView;
    NSTimer * _moveTime;
    //YES,则为系统滚动,NO则为客户滚动
    BOOL _isTimeUp;
}

@property (retain,nonatomic,readonly) UIImageView * leftImageView;
@property (retain,nonatomic,readonly) UIImageView * centerImageView;
@property (retain,nonatomic,readonly) UIImageView * rightImageView;

@end

@implementation FXJScrollView

#pragma mark - 自由指定广告所占的frame
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = NO;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
        self.contentSize = CGSizeMake(UISCREENWIDTH * 3, UISCREENHEIGHT);
        self.delegate = self;
        
        
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:_leftImageView];
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:_centerImageView];
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH*2, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:_rightImageView];
            _pageControl = [[UIPageControl alloc]init];
        
        _moveTime = [NSTimer scheduledTimerWithTimeInterval:chageImageTime target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
        _isTimeUp = NO;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _pageControl.frame = CGRectMake(0, self.bounds.size.height - 10, UISCREENWIDTH, 20);

}
#pragma mark - 设置广告所使用的图片(名字)
- (void)setImageNameArray:(NSArray *)imageNameArray
{
    _imageNameArray = imageNameArray;
    
    _leftImageView.image = [UIImage imageNamed:_imageNameArray[0]];
    _centerImageView.image = [UIImage imageNamed:_imageNameArray[1]];
    _rightImageView.image = [UIImage imageNamed:_imageNameArray[2]];
    
    _pageControl.numberOfPages = 3;
    _pageControl.currentPage = 0;

}

#pragma mark - 计时器到时,系统滚动图片
- (void)animalMoveImage
{
    
    [self setContentOffset:CGPointMake(UISCREENWIDTH * 2, 0) animated:YES];
    _isTimeUp = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

#pragma mark - 图片停止时,调用该函数使得滚动视图复用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.contentOffset.x == 0)
    {
        currentImage = (currentImage-1)%_imageNameArray.count;
//        _pageControl.currentPage = (_pageControl.currentPage - 1)%_imageNameArray.count;
        _pageControl.currentPage = _imageNameArray.count - 1;

    }
    else if(self.contentOffset.x == UISCREENWIDTH * 2)
    {
        
        currentImage = (currentImage+1)%_imageNameArray.count;
        _pageControl.currentPage = (_pageControl.currentPage + 1)%_imageNameArray.count;
    }
    else
    {
        return;
    }
    
    _leftImageView.image = [UIImage imageNamed:_imageNameArray[(currentImage-1)%_imageNameArray.count]];
    
    
    _centerImageView.image = [UIImage imageNamed:_imageNameArray[currentImage%_imageNameArray.count]];
    
    
    _rightImageView.image = [UIImage imageNamed:_imageNameArray[(currentImage+1)%_imageNameArray.count]];
    
    
    self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
    
    //手动控制图片滚动应该取消那个三秒的计时器
    if (!_isTimeUp) {
        [_moveTime setFireDate:[NSDate dateWithTimeIntervalSinceNow:chageImageTime]];
    }
    _isTimeUp = NO;
}

@end

