//
//  WWInvestItemView.h
//  WYWD
//
//  Created by 韩晓杰 on 2018/5/12.
//  Copyright © 2018年 ios programer. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define ScreenBounds [[UIScreen mainScreen]bounds]
#define ScreenWidth  CGRectGetWidth(ScreenBounds)
#define MainColor  RGB(45, 174, 252)

@protocol WWRecommendInvestItemViewDelegate;

@interface WWRecommendInvestItemView : UIView

@property (nonatomic, strong)UIImageView *bgImage;
@property (nonatomic, weak)id <WWRecommendInvestItemViewDelegate> delegate;
@property (nonatomic, strong)id model;
@property (nonatomic, assign)CGFloat scale;

- (WWRecommendInvestItemView *)initWithScale:(CGFloat)scale;

- (void)updateViewWithModel:(id)mdoel;

@end


@protocol WWRecommendInvestItemViewDelegate <NSObject>

- (void)investItemViewJoinBtnTouched;

@end
