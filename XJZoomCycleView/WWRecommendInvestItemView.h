//
//  WWInvestItemView.h
//  WYWD
//
//  Created by 韩晓杰 on 2018/5/12.
//  Copyright © 2018年 ios programer. All rights reserved.
//

#import <UIKit/UIKit.h>

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
