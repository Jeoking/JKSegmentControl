//
//  ViewController.m
//  JKSegmentControlDemo
//
//  Created by JayKing on 17/7/29.
//  Copyright © 2017年 jeoking. All rights reserved.
//

#import "ViewController.h"
#import "JKSegmentControl.h"

@interface ViewController ()

@property (strong, nonatomic) JKSegmentControl *dataSegmentControl;

@property (strong, nonatomic) UILabel *titleLabel;

@property (copy, nonatomic) NSArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.title = @"选择器";
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:self.dataSegmentControl];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 18)];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.titleLabel.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    self.titleLabel.text = self.datas[0];
    self.titleLabel.textColor = [UIColor darkGrayColor];
    self.titleLabel.font = [UIFont systemFontOfSize:30 weight:UIFontWeightBlack];
    [self.view addSubview:self.titleLabel];
    
}

- (JKSegmentControl *)dataSegmentControl {
    if(!_dataSegmentControl) {
        __weak typeof(self) weak_self = self;
        self.datas = @[@"精选", @"推荐", @"日用品", @"衣服", @"美食", @"化妆品", @"办公用品", @"运动用品"];
        _dataSegmentControl = [[JKSegmentControl alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 40.0) items:self.datas segmentScrollType:JKContentMatchTextType selectBlock:^(NSInteger selectIndex) {
            weak_self.titleLabel.text = self.datas[selectIndex];
        }];
    }
    return _dataSegmentControl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
