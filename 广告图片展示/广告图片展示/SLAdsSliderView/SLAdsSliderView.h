//
//  SLAdsScrollView.h
//  广告图片展示
//
//  Created by 倪申雷 on 16/2/22.
//  Copyright © 2016年 nishenlei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SLAdsSliderView;
typedef enum{
    /** 水平滚动（左右滚动） */
    SLAdsSliderViewDirectionHorizontal = 0,
    /** 垂直滚动（上下滚动）*/
    SLAdsSliderViewDirectionVertical
    
}SLAdsSliderViewDirection;

// 协议
@protocol SLAdsSliderViewDelegate <NSObject>
@optional
-(void)adsSliderView:(SLAdsSliderView *)adsSliderView didSelectItemAtIndex:(NSInteger)index;
@end


@interface SLAdsSliderView : UIView
/** 图片数据(里面存放UIImage对象) */
@property(nonatomic,strong)NSArray *images;
/** 滚动方向 */
@property(nonatomic,assign)SLAdsSliderViewDirection direction;
/** pageControl属性 */
@property(nonatomic,weak,readonly)UIPageControl *pageControl;
/** 代理 */
@property(nonatomic,weak)id<SLAdsSliderViewDelegate> delegate;
@end



