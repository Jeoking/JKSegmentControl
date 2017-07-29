# JKSegmentControl
自定义简单的横条选项栏，仿网易新闻首页单选栏

__weak typeof(self) weak_self = self;

self.datas = @[@"精选", @"推荐", @"日用品", @"衣服", @"美食", @"化妆品", @"办公用品", @"运动用品"];

_dataSegmentControl = [[JKSegmentControl alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 40.0) items:self.datas segmentScrollType:JKContentMatchTextType selectBlock:^(NSInteger selectIndex) {

      weak_self.titleLabel.text = self.datas[selectIndex];

}];

