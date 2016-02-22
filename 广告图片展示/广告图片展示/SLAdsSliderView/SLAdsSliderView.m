//
//  SLAdsScrollView.m
//  广告图片展示
//
//  Created by 倪申雷 on 16/2/22.
//  Copyright © 2016年 nishenlei. All rights reserved.
//

#import "SLAdsSliderView.h"
@interface SLAdsSliderView()<UIScrollViewDelegate>

@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,weak)UIPageControl *pageControl;
@end

@implementation SLAdsSliderView

-(void)setImages:(NSArray *)images
{
    _images = images;
    // 设置总页数
    self.pageControl.numberOfPages = images.count;
}


// 添加子控件
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 1.创建ScrollerView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.ScrollerView添加三个imageView
        for (int i = 0; i < 3 ; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            NSString *imageName = [NSString stringWithFormat:@"image%d",i];
            imageView.image = [UIImage imageNamed:imageName];
            [scrollView addSubview:imageView];
        }
        
        
        // 3.添加pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.pageIndicatorTintColor = [UIColor redColor];
        //pageControl.backgroundColor = [UIColor grayColor];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
    }
    return self;
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
    self.scrollView.contentSize = CGSizeMake(3 * self.frame.size.width , self.frame.size.height);
    // 2.布局3个imageview的位置
    for (NSInteger i = 0; i < 3; i++ ) {
        UIImageView *imageView = self.scrollView.subviews[i];
        imageView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
    }
    
    // 3.布局pageControl的位置
    CGFloat pageControlW = scrollViewW / 3.6;
    CGFloat pageControlH = scrollViewW / 8;
    self.pageControl.frame = CGRectMake(scrollViewW - pageControlW, scrollViewH - pageControlH, pageControlW, pageControlH);
    

}


#pragma mark - scrollView的代理方法
// 只要scrollview滚动了就会调用这个方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    NSLog(@"点击");
}


@end
