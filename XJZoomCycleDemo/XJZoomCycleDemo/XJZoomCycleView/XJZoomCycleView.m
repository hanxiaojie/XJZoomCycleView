//
//  WWRecommendInvestView.m
//  WYWD
//
//  Created by 韩晓杰 on 2018/5/12.
//  Copyright © 2018年 ios programer. All rights reserved.
//


#import "XJZoomCycleView.h"
#import "WWRecommendInvestItemView.h"
#import "Masonry.h"

@interface XJZoomCycleView () <UIScrollViewDelegate>{
    CGFloat _marginT; //距离上边的距离
    CGFloat _itemMaxW;
    CGFloat _len; //边上漏出的长度
    CGFloat _scale; //缩放系数
    CGFloat _space; //间距
    
    CGFloat _offset_max; //左右内容的最大偏移量
}

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)NSMutableArray<WWRecommendInvestItemView* > *itemViewArray;

@property (strong,nonatomic) UIImageView *backImageView;
@property (strong,nonatomic) WWRecommendInvestItemView *leftItemView;
@property (strong,nonatomic) WWRecommendInvestItemView *middleItemView;
@property (strong,nonatomic) WWRecommendInvestItemView *rightItemView;


@property (strong, nonatomic)UIView *leftLineView;
@property (strong, nonatomic)UIView *rightLineView;
@property (nonatomic, assign) NSUInteger previousItemIndex;
@property (nonatomic, assign) NSUInteger currentItemIndex;
@property (nonatomic, assign) NSUInteger nextItemIndex;

@property (nonatomic, copy)NSArray *models;

//手动造成的偏移量
@property (assign,nonatomic) CGFloat offsetX;

@property (strong,nonatomic) NSTimer *timer;
//属于计时器方法动画持续时间 ？
@property (assign,nonatomic) BOOL timerAnimation;

@end

@implementation XJZoomCycleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _marginT  = 10;
        _space = 20;
        _len = 7;
        _itemMaxW = ScreenWidth - 2*_space - _len* 2;
        _scale = 0.8;
        _offset_max = _itemMaxW * _scale *(1 + (1-_scale)/2.0) + _space;
        [self loadSubViews];
        [self constraintSubView];
        
        [self.scrollView setContentOffset:CGPointMake(_offset_max, 0)];
    }
    return self;
}

- (void)dealloc{
    if( [self.timer isValid] ){
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)updateViewWithModels:(NSArray *)models{
    _models = models;
    [self loadItemViewContent];
}

#pragma mark - 私有方法
-(void)loadItemViewContent{
    [self refreshView:self.middleItemView index:self.previousItemIndex];
    [self refreshView:self.leftItemView index:self.currentItemIndex];
    [self refreshView:self.rightItemView index:self.nextItemIndex];
    // 循环滚懂banner计时器
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        //[self.timer invalidate];
    }
    [self.scrollView setContentOffset:CGPointMake(_offset_max, 0) animated:NO];
    self.leftItemView.layer.transform = CATransform3DIdentity;
    self.middleItemView.layer.transform = CATransform3DIdentity;
    self.rightItemView.layer.transform = CATransform3DIdentity;
}

//刷新view
-(void)refreshView:(WWRecommendInvestItemView*)itemView index:(NSUInteger)index{
    if (self.models.count!=0) {
        [itemView updateViewWithModel:self.models[index]];
    }
}

#pragma mark - init
- (void)loadSubViews{
    [self addSubview:self.backImageView];
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.leftItemView];
    [self.scrollView addSubview:self.middleItemView];
    [self.scrollView addSubview:self.rightItemView];
    [self.scrollView addSubview:self.leftLineView];
    [self.scrollView addSubview:self.rightLineView];
}

- (void)constraintSubView{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(self);
    }];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.with.mas_equalTo(self);
    }];
    
    [self.leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.middleItemView).multipliedBy(_scale);
        make.width.mas_equalTo(_len+3);
        make.centerY.mas_equalTo(_scrollView);
        make.left.mas_equalTo(self.scrollView.mas_left).offset(-3);
    }];

    [self.rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.leftLineView);
        make.centerY.mas_equalTo(_scrollView);
        make.left.mas_equalTo(self.scrollView.mas_right).offset(-_len);
        make.left.mas_equalTo(self.scrollView.mas_left).offset(ScreenWidth + 2*_offset_max - _len);
    }];
    
    [self.leftItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.middleItemView).multipliedBy(_scale);
        make.width.mas_equalTo(_itemMaxW*_scale);
        make.centerY.mas_equalTo(_scrollView);
        make.right.mas_equalTo(_middleItemView.mas_left).offset(-_space);
    }];
    [self.middleItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self).offset(-_marginT*2);
        make.width.mas_equalTo(_itemMaxW);
        make.centerY.mas_equalTo(_scrollView);
        make.left.mas_equalTo(_scrollView).offset(_offset_max+_space + _len);
    }];
    [self.rightItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(_leftItemView);
        make.centerY.mas_equalTo(_scrollView);
        make.left.mas_equalTo(_middleItemView.mas_right).offset(_space);
    }];
    
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth + 2 *_offset_max, 0);
}


#pragma mark ---------- timer --------
- (void)timerAction {
    self.offsetX = 2 * _offset_max;
    self.timerAnimation = YES;
    [UIView animateWithDuration:0.8 animations:^{
        [self.scrollView setContentOffset:CGPointMake(self.offsetX, 0)];
        self.rightItemView.transform =  CGAffineTransformScale(CGAffineTransformIdentity, 1/_scale, 1/_scale);
        self.middleItemView.transform =  CGAffineTransformScale(CGAffineTransformIdentity, _scale, _scale);
    } completion:^(BOOL finished) {
        self.timerAnimation = NO;
        [self loadItemViewContent];
        self.rightItemView.transform =CGAffineTransformIdentity;
        self.middleItemView.transform = CGAffineTransformIdentity;
    }];
}


#pragma mark ------------ UIScrollViewDelegate --------

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.scrollView) {
        if (self.timerAnimation) {
            return;
        }
        CGFloat offScale = scrollView.contentOffset.x - _offset_max;
        CGFloat scale = fabs(offScale)/_offset_max;
        if (offScale < 0) {
            //右滑
            CGFloat lscale = 1 +(1/_scale - 1)*scale;
            CGFloat mScale = 1 - (1 - _scale)* scale;
            self.leftItemView.transform = CGAffineTransformScale(CGAffineTransformIdentity, lscale, lscale);
            self.middleItemView.transform = CGAffineTransformScale(CGAffineTransformIdentity, mScale, mScale);
        } else {
            //左滑
            CGFloat rscale = 1 +(1/_scale - 1) * scale;
            CGFloat mScale = 1 - (1 - _scale) * scale;
            self.rightItemView.transform = CGAffineTransformScale(CGAffineTransformIdentity, rscale, rscale);
            self.middleItemView.transform = CGAffineTransformScale(CGAffineTransformIdentity, mScale, mScale);
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGPoint offset = scrollView.contentOffset;
    self.offsetX = offset.x;
    
    if ((fabs(self.offsetX-_offset_max) >= _offset_max*0.5)) {
        if (!decelerate) {
            //替换图片
            [self loadItemViewContent];
        }
    } else {
        //回弹复位
        [scrollView setContentOffset:CGPointMake(_offset_max, 0) animated:YES];
        self.leftItemView.layer.transform = CATransform3DIdentity;
        self.middleItemView.layer.transform = CATransform3DIdentity;
        self.rightItemView.layer.transform = CATransform3DIdentity;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //替换图片
    //[self exchangeImage];
    NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
    if (index==0) {
        self.currentItemIndex = self.previousItemIndex;
    }else if(index==2){
        self.currentItemIndex = self.nextItemIndex;
    }

    [self loadItemViewContent];
 }

#pragma mark - setter && getter
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"bg_home"];
    }
    return _backImageView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        //_scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIView *)leftLineView{
    if (!_leftLineView) {
        _leftLineView = [[UIView alloc] init];
        _leftLineView.backgroundColor = MainColor;
        _leftLineView.layer.cornerRadius = 3;
        _leftLineView.layer.masksToBounds = YES;
    }
    return _leftLineView;
}

- (UIView *)rightLineView{
    if (!_rightLineView) {
        _rightLineView = [[UIView alloc] init];
        _rightLineView.backgroundColor = MainColor;
        _rightLineView.layer.cornerRadius = 3;
        _rightLineView.layer.masksToBounds = YES;
    }
    return _rightLineView;
}

-(NSUInteger)previousItemIndex{
    if (self.currentItemIndex==0) {
        return self.models.count-1;
    }
    return self.currentItemIndex-1;
}


-(NSUInteger)nextItemIndex{
    if(self.currentItemIndex < (self.models.count-1)) {
        return self.currentItemIndex+1;
    }
    return 0;
}

- (WWRecommendInvestItemView *)leftItemView{
    if (!_leftItemView) {
        _leftItemView = [[WWRecommendInvestItemView alloc] initWithScale:_scale];
    }
    return _leftItemView;
}

- (WWRecommendInvestItemView *)middleItemView{
    if (!_middleItemView) {
        _middleItemView = [[WWRecommendInvestItemView alloc] initWithScale:1];
    }
    return _middleItemView;
}

- (WWRecommendInvestItemView *)rightItemView{
    if (!_rightItemView) {
        _rightItemView = [[WWRecommendInvestItemView alloc] initWithScale:_scale];
    }
    return _rightItemView;
}



@end
