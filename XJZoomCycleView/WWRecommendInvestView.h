//
//  WWRecommendInvestView.h
//  WYWD
//
//  Created by 韩晓杰 on 2018/5/12.
//  Copyright © 2018年 ios programer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WWRecommendInvestViewDelegate <NSObject>


@end

@interface WWRecommendInvestView : UIView

@property (nonatomic, weak)id <WWRecommendInvestViewDelegate>delegate;

- (void)updateViewWithModels:(NSArray *)models;

@end
