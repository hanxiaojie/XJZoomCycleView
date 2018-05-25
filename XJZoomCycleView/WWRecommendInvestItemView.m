//
//  WWInvestItemView.m
//  WYWD
//
//  Created by 韩晓杰 on 2018/5/12.
//  Copyright © 2018年 ios programer. All rights reserved.
//

#import "WWRecommendInvestItemView.h"

#define WWAutoScale(a) self.scale * a

@interface WWRecommendInvestItemView ()

@property (nonatomic, strong)UIButton *typeBtn;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *gainNumberLabel;
@property (nonatomic, strong)UILabel *tipsLabel;
@property (nonatomic, strong)UILabel *investTimeLabel;
@property (nonatomic, strong)UILabel *remainAmountLabel;
@property (nonatomic, strong)UILabel *processLabel;

@property (nonatomic, strong)UIButton *joinCoverBtn;
@property (nonatomic, strong)UILabel *joinTitleLabel;
@property (nonatomic, strong)UILabel *joinDetailLabel;

@end

@implementation WWRecommendInvestItemView

- (instancetype)initWithScale:(CGFloat)scale{
    self = [super init];
    if (self) {
        _scale = scale==0?1:scale;
        [self loadSubViews];
        [self constrainSubViews];
        self.layer.cornerRadius = 3;
        self.backgroundColor = BackGroundColor;
    }
    return self;
}

#pragma mark - 外部方法
- (void)updateViewWithModel:(id)mdoel{
    
}

#pragma mark - Action
- (void)joinBtnTouched{
    if (self.delegate && [self.delegate respondsToSelector:@selector(investItemViewJoinBtnTouched)]) {
        [self.delegate investItemViewJoinBtnTouched];
    }
}

#pragma mark - init
- (void)loadSubViews{
    [self addSubview:self.bgImage];
    //[self addSubview:self.typeBtn];
    [self addSubview:self.titleLabel];
    [self addSubview:self.gainNumberLabel];
    [self addSubview:self.tipsLabel];
    [self addSubview:self.investTimeLabel];
    [self addSubview:self.remainAmountLabel];
    [self addSubview:self.processLabel];
    
    [self addSubview:self.joinCoverBtn];
    [self addSubview:self.joinTitleLabel];
    [self addSubview:self.joinDetailLabel];
}

- (void)constrainSubViews{
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(WWAutoScale(30));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.left.mas_equalTo(self.mas_left).offset(30);
        make.right.mas_equalTo(self.mas_right).offset(-30);
    }];
    
    [self.gainNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(WWAutoScale(40));
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.gainNumberLabel.mas_bottom).offset(WWAutoScale(10));
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    [self.investTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(self.tipsLabel.mas_bottom).offset(WWAutoScale(40));
    }];
    
    [self.remainAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.investTimeLabel.mas_right);
        make.centerY.mas_equalTo(self.investTimeLabel);
        make.width.mas_equalTo(self.investTimeLabel);
        make.height.mas_equalTo(self.investTimeLabel);
    }];
    
    [self.processLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.remainAmountLabel.mas_right);
        make.right.mas_equalTo(self.mas_right);
        make.centerY.mas_equalTo(self.remainAmountLabel);
        make.width.mas_equalTo(self.investTimeLabel);
        make.height.mas_equalTo(self.investTimeLabel);
    }];
    
    [self.joinCoverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.remainAmountLabel.mas_bottom).offset(WWAutoScale(15));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(WWAutoScale(50));
        make.left.mas_equalTo(self.mas_left).offset(20);
    }];
    
    [self.joinTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.joinCoverBtn.mas_top).offset(WWAutoScale(6));
        make.centerX.mas_equalTo(self.joinCoverBtn.mas_centerX);
    }];
    
    [self.joinDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.joinTitleLabel.mas_bottom).offset(WWAutoScale(2));
        make.centerX.mas_equalTo(self.joinTitleLabel.mas_centerX);
    }];
    
}

#pragma mark - setter && getter
- (UIButton *)typeBtn{
    if (!_typeBtn) {
        _typeBtn = [[UIButton alloc] init];
    }
    return _typeBtn;
}

- (UIButton *)joinCoverBtn{
    if (!_joinCoverBtn) {
        _joinCoverBtn = [[UIButton alloc] init];
        [_joinCoverBtn addTarget:self action:@selector(joinBtnTouched) forControlEvents:UIControlEventTouchUpInside];
        [_joinCoverBtn setBackgroundColor:MainColor];
        _joinCoverBtn.layer.cornerRadius = WWAutoScale(25);
        _joinCoverBtn.layer.masksToBounds = YES;
    }
    return _joinCoverBtn;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:WWAutoScale(20)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"标题-代码";
        
    }
    return _titleLabel;
}

- (UILabel *)gainNumberLabel{
    if (!_gainNumberLabel) {
        _gainNumberLabel = [[UILabel alloc] init];
        _gainNumberLabel.font = [UIFont systemFontOfSize:WWAutoScale(30) weight:20];
        _gainNumberLabel.text = @"0.0%%";
        _gainNumberLabel.textColor = MainColor;
    }
   return _gainNumberLabel;
}

- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.textColor = WWColorI;
        _tipsLabel.font = [UIFont systemFontOfSize:WWAutoScale(17)];
        _tipsLabel.text = @"预期年化收益";
    }
    return _tipsLabel;
}

- (UILabel *)investTimeLabel{
    if (!_investTimeLabel) {
        _investTimeLabel = [[UILabel alloc] init];
        _investTimeLabel.font = [UIFont systemFontOfSize:WWAutoScale(17)];
        _investTimeLabel.textColor = WWColorB;
         _investTimeLabel.text = @"月";
        _investTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _investTimeLabel;
}

- (UILabel *)remainAmountLabel{
    if (!_remainAmountLabel) {
        _remainAmountLabel = [[UILabel alloc] init];
        _remainAmountLabel.font = [UIFont systemFontOfSize:WWAutoScale(17)];
        _remainAmountLabel.textColor = WWColorB;
         _remainAmountLabel.text = @"剩余";
        _remainAmountLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _remainAmountLabel;
}

- (UILabel *)processLabel{
    if (!_processLabel) {
        _processLabel = [[UILabel alloc] init];
        _processLabel.font = [UIFont systemFontOfSize:WWAutoScale(17)];
        _processLabel.textColor = WWColorB;
        _processLabel.text = @"进度";
        _processLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _processLabel;
}

- (UILabel *)joinTitleLabel{
    if (!_joinTitleLabel) {
        _joinTitleLabel = [[UILabel alloc] init];
        _joinTitleLabel.text = @"立即抢购";
        _joinTitleLabel.textColor = WWColorF;
        _joinTitleLabel.font = [UIFont systemFontOfSize:WWAutoScale(17)];
    }
    return  _joinTitleLabel;
}

- (UILabel *)joinDetailLabel{
    if (!_joinDetailLabel) {
        _joinDetailLabel = [[UILabel alloc] init];
        _joinDetailLabel.text = @"已加入9人";
        _joinDetailLabel.textColor = WWColorF;
        _joinDetailLabel.font = [UIFont systemFontOfSize:WWAutoScale(14)];
    }
    return  _joinDetailLabel;
}

@end
