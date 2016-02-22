//
//  ViewController.m
//  广告图片展示
//
//  Created by 倪申雷 on 16/2/22.
//  Copyright © 2016年 nishenlei. All rights reserved.
//

#import "ViewController.h"
#import "SLAdsSliderView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SLAdsSliderView *adsSliderView = [[SLAdsSliderView alloc] init];
    adsSliderView.frame = CGRectMake(0, 0, 375 , 200);
    adsSliderView.images = @[
                             [UIImage imageNamed:@"image0"],
                             [UIImage imageNamed:@"image1"],
                             [UIImage imageNamed:@"image2"],
                             [UIImage imageNamed:@"image3"],
                             ];
    
    
    
    [self.view addSubview:adsSliderView];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
