//
//  ViewController.m
//  XJZoomCycleDemo
//
//  Created by EvanTan on 2018/5/25.
//  Copyright © 2018年 顺丰科技. All rights reserved.
//

#import "ViewController.h"
#import "XJZoomCycleView.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadSubView];
}

- (void)loadSubView{
    XJZoomCycleView *cycleView = [[XJZoomCycleView alloc] init];
    [self.view addSubview:cycleView];
    
    [cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(100);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(350);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
