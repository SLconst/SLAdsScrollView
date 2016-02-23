//
//  ViewController.m
//  广告图片展示
//
//  Created by 倪申雷 on 16/2/22.
//  Copyright © 2016年 nishenlei. All rights reserved.
//

#import "ViewController.h"
#import "SLAdsSliderView.h"
@interface ViewController ()<SLAdsSliderViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建广告滚动的控件
    SLAdsSliderView *adsSliderView = [[SLAdsSliderView alloc] init];
    adsSliderView.frame = CGRectMake(0, 0, 375 , 200);
    adsSliderView.images = @[
                             [UIImage imageNamed:@"image0"],
                             [UIImage imageNamed:@"image1"],
                             [UIImage imageNamed:@"image2"],
                             [UIImage imageNamed:@"image3"],
                             [UIImage imageNamed:@"image4"]
                             ];
    [self.view addSubview:adsSliderView];
    
    // 设置代理（可以用代理方法监听图片的点击）
    adsSliderView.delegate = self;
    // 设置图片的滚动方向（默认是水平方向滚动）
    adsSliderView.direction = SLAdsSliderViewDirectionVertical;
    // 可以设置pageControl的一些状态
    //adsSliderView.pageControl.hidden = YES;
    
    
}

// adsSliderView的代理方法，监听是点击了哪一张图片
-(void)adsSliderView:(SLAdsSliderView *)adsSliderView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
}



@end
