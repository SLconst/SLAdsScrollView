//
//  SLAdsScrollView.m
//  广告图片展示
//
//  Created by 倪申雷 on 16/2/22.
//  Copyright © 2016年 nishenlei. All rights reserved.
//

#import "SLAdsSliderView.h"
@interface SLAdsSliderView()<UIScrollViewDelegate>
/** 显示具体内容 */
@property(nonatomic,weak)UIScrollView *scrollView;
/** 页码显示 */
@property(nonatomic,weak)UIPageControl *pageControl;
/** 定时器 */
@property(nonatomic,weak)NSTimer *timer;

@end

@implementation SLAdsSliderView

// 添加子控件
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 1.创建ScrollerView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.ScrollerView添加三个imageView
        for (int i = 0; i < 3 ; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)]];
            [scrollView addSubview:imageView];
        }
        
        
        // 3.添加pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
        // 4.开启定时器
        [self startTimer];
    }
    return self;
}


-(void)setImages:(NSArray *)images
{
    _images = images;
    // 设置总页数
    self.pageControl.numberOfPages = images.count;
}


// 布局子控件的位置
-(void)layoutSubviews
{
    [super layoutSubviews];
    // 整体尺寸
    CGFloat scrollViewW = self.bounds.size.width;
    CGFloat scrollViewH = self.bounds.size.height;
    
    // 1.布局scrollView的位置
    self.scrollView.frame = self.bounds;
    if (self.direction == SLAdsSliderViewDirectionHorizontal) {
        self.scrollView.contentSize = CGSizeMake(3 * self.frame.size.width , self.frame.size.height);
    }else {
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width , 3 *self.frame.size.height);
    }
    
    // 2.布局3个imageview的位置
    for (NSInteger i = 0; i < 3; i++ ) {
        UIImageView *imageView = self.scrollView.subviews[i];
        if (self.direction == SLAdsSliderViewDirectionHorizontal) {
            imageView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
        }else {
            imageView.frame = CGRectMake(0, i * scrollViewH, scrollViewW, scrollViewH);
        }

        
    }
    
    // 3.布局pageControl的位置
    CGFloat pageControlW = scrollViewW / 3.6;
    CGFloat pageControlH = scrollViewW / 8;
    self.pageControl.frame = CGRectMake(scrollViewW - pageControlW, scrollViewH - pageControlH, pageControlW, pageControlH);
    
    // 4.更新内容
    [self updateContent];

}
#pragma mark - 监听手势的点击
-(void)imageClick:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(adsSliderView:didSelectItemAtIndex:)]) {
        [self.delegate adsSliderView:self didSelectItemAtIndex:tap.view.tag];
    }
}

#pragma mark - 定时器
-(void)startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}


-(void)nextPage
{
    if (self.direction == SLAdsSliderViewDirectionHorizontal) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + self.scrollView.frame.size.width, 0) animated:YES];
    }else{
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentOffset.y + self.scrollView.frame.size.height) animated:YES];

    }
}



#pragma mark - 其他
/**
 *  更新所有UIImageView的内容，并且重置scrollView.contentOffset.x == 1倍宽度
 */
-(void)updateContent
{
    
    // 当前页码
    NSInteger page = self.pageControl.currentPage;

    // 更新所有UIImageView的内容
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        
        // 图片索引
        NSInteger index = 0;
        if (i == 0) { // 左边的imageView
            index = page - 1;
        } else if (i == 1) { // 中间的imageView
            index = page;
        } else { // 右边的imageView
            index = page + 1;
        }
        // 处理特殊情况
        if (index == -1) { // 变成最后一张
            index = self.images.count - 1;
        } else if (index == self.images.count) { // 变为最前面一张
            index = 0;
        }
        imageView.image = self.images[index];
        // 设置index为tag
        imageView.tag = index;
    }
    
    // 重置scrollView.contentOffset.x == 1倍宽度
    if (self.direction == SLAdsSliderViewDirectionHorizontal) {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }else {
        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.frame.size.height);
    }
    

}



#pragma mark - scrollView的代理方法
// 只要scrollview滚动了就会调用这个方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 求出显示在最中间的imageView
    UIImageView *destImageView = nil;
    CGFloat minDelta = MAXFLOAT;
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        CGFloat delta = 0;
        if (self.direction == SLAdsSliderViewDirectionHorizontal) {
            delta = ABS(self.scrollView.contentOffset.x - imageView.frame.origin.x);
        } else {
            delta = ABS(self.scrollView.contentOffset.y - imageView.frame.origin.y);
        }

        if (delta < minDelta) {
            minDelta = delta;
            destImageView = imageView;
        }
    }
    
    // imageView的tag就是显示在最中间的图片索引
    self.pageControl.currentPage = destImageView.tag;
}

// 当scrollview减速结束的时候调用该方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 更新内容
    [self updateContent];
    
    [self startTimer];
}
// 将要拖拽scrollView的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
// 有动画的结束滚动就会调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updateContent];
}

@end
