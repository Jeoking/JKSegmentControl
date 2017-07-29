//
//  JKSegmentControl.m
//  ZY-Houserkeeper
//
//  Created by JayKing on 17/7/17.
//  Copyright © 2017年 zallsoon-zf. All rights reserved.
//

#import "JKSegmentControl.h"

@implementation JKSegmentControl {
    NSMutableArray *_tabBtns;
    NSInteger _preIndex;
    UIView *_indexView;
    JKSegmentType _segmentScrollType;
    SelectItemBlock _itemSelectBlock;
}

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray <NSString *>*)items segmentScrollType:(JKSegmentType)segmentScrollType selectBlock:(SelectItemBlock)block {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        self.bounces = NO;
        _segmentScrollType = segmentScrollType;
        _titleDefaultSize = _titleSelectSize = 13;
        _itemSelectBlock = block;
        _titleDefaultColor = [UIColor darkGrayColor];
        _titleSelectColor = [UIColor colorWithRed:250/255.0 green:100/255.0 blue:0/255.0 alpha:1.0];
        _indexViewColor = [UIColor colorWithRed:250/255.0 green:100/255.0 blue:0/255.0 alpha:1.0];
        _indexViewHeight = 2;
        
        if (!items || items.count == 0) {
            return self;
        }
        CGFloat contentWidth = 0;
        _tabBtns = [NSMutableArray array];
        //添加tab标题按钮
        for (int i = 0; i < items.count; i++)
        {
            NSString *title = items[i];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat btnWidth = 0;
            if (segmentScrollType == JKContentMatchScreenType) {
                btnWidth = self.bounds.size.width / items.count;
                contentWidth = self.bounds.size.width;
                btn.frame = CGRectMake(btnWidth * i, 0, btnWidth, self.bounds.size.height);
            } else {
                CGSize size =[title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_titleDefaultSize]}];
                btnWidth = size.width + 24;
                btn.frame = CGRectMake(contentWidth, 0, btnWidth, self.bounds.size.height);
                contentWidth = contentWidth + btnWidth;
            }
            
            btn.tag = i;
            [btn addTarget:self action:@selector(selectTabAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
            [btn setTitleColor:_titleDefaultColor forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:_titleDefaultSize];
            
            [self addSubview:btn];
            [_tabBtns addObject:btn];
        }
        self.contentSize = CGSizeMake(contentWidth, self.bounds.size.height);
        
        //初始化第一个tab为选中状态
        UIButton *firstTabBtn = (UIButton *)[_tabBtns objectAtIndex:0];
        firstTabBtn.selected = YES;
        
        //添加下标指示视图
        _indexView = [[UIView alloc] init];
        _indexView.backgroundColor = _indexViewColor;
        [self addSubview:_indexView];
        _indexView.frame = CGRectMake(0, 0, 20, _indexViewHeight);
        _indexView.center = CGPointMake(firstTabBtn.bounds.size.width/2, self.bounds.size.height - _indexViewHeight/2);
        
        _preIndex = 0;
    }
    return self;
}

- (void)selectTabAction:(UIButton *)btn {
    NSInteger index = btn.tag;
    if (_preIndex != index) {
        if (_itemSelectBlock) {
            _itemSelectBlock(index);
            
            UIButton *selectedBtn = btn;
            UIButton *predBtn = [_tabBtns objectAtIndex:_preIndex];
            selectedBtn.titleLabel.font = [UIFont systemFontOfSize:_titleSelectSize];
            predBtn.titleLabel.font = [UIFont systemFontOfSize:_titleDefaultSize];
            predBtn.selected = NO;
            selectedBtn.selected = YES;
            _preIndex = index;
            
            if (_segmentIndicateType == JKContentMatchScreenType) {
                [UIView animateWithDuration:0.2 animations:^{
                    _indexView.center = CGPointMake(btn.center.x, self.bounds.size.height - _indexViewHeight/2);
                }];
            } else {
                CGSize textSize =[selectedBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_titleSelectSize]}];
                [UIView animateWithDuration:0.2 animations:^{
                    _indexView.frame = CGRectMake(0, 0, textSize.width, _indexViewHeight);
                    _indexView.center = CGPointMake(btn.center.x, self.bounds.size.height - _indexViewHeight/2);
                }];
            }
            
            if (_segmentScrollType == JKContentMatchScreenType) {
                return;
            }
            if (self.contentSize.width < self.bounds.size.width) {
                return;
            }
            //如果内容宽度大于屏宽，使选中的tab尽量居中
            CGFloat offX = selectedBtn.center.x - self.contentOffset.x - self.bounds.size.width/2;
            if (offX > 0) {
                if (self.contentSize.width - self.frame.size.width - self.contentOffset.x > offX) {
                    [self setContentOffset:CGPointMake(self.contentOffset.x + offX, 0.0) animated:YES];
                } else {
                    [self setContentOffset:CGPointMake(self.contentSize.width - self.bounds.size.width, 0.0) animated:YES];
                }
            } else {
                if (self.contentOffset.x > -offX) {
                    [self setContentOffset:CGPointMake(self.contentOffset.x + offX, 0.0) animated:YES];
                } else {
                    [self setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
                }
            }
        }
    }
}

#pragma mark - setter

- (void)setCurrentSelectIndex:(NSInteger)currentSelectIndex {
    _currentSelectIndex = currentSelectIndex;
    UIButton *selectedBtn = [_tabBtns objectAtIndex:currentSelectIndex];
    UIButton *predBtn = [_tabBtns objectAtIndex:_preIndex];
    selectedBtn.titleLabel.font = [UIFont systemFontOfSize:_titleSelectSize];
    predBtn.titleLabel.font = [UIFont systemFontOfSize:_titleDefaultSize];
    predBtn.selected = NO;
    selectedBtn.selected = YES;
    _preIndex = currentSelectIndex;
    
    if (_segmentIndicateType == JKContentMatchScreenType) {
        _indexView.center = CGPointMake(selectedBtn.center.x, self.bounds.size.height - _indexViewHeight/2);
    } else {
        CGSize textSize =[selectedBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_titleSelectSize]}];
        _indexView.frame = CGRectMake(0, 0, textSize.width, _indexViewHeight);
        _indexView.center = CGPointMake(selectedBtn.center.x, self.bounds.size.height - _indexViewHeight/2);
    }
}

- (void)setTitleDefaultSize:(CGFloat)titleDefaultSize {
    _titleDefaultSize = titleDefaultSize;
    UIButton *btn = _tabBtns[0];
    btn.titleLabel.font = [UIFont systemFontOfSize:titleDefaultSize];
}

- (void)setTitleSelectSize:(CGFloat)titleSelectSize {
    _titleSelectSize = titleSelectSize;
    UIButton *btn = _tabBtns[0];
    btn.titleLabel.font = [UIFont systemFontOfSize:titleSelectSize];
}

- (void)setTitleDefaultColor:(UIColor *)titleDefaultColor {
    _titleDefaultColor = titleDefaultColor;
    for (UIButton *btn in _tabBtns) {
        [btn setTitleColor:titleDefaultColor forState:UIControlStateNormal];
    }
}

- (void)setTitleSelectColor:(UIColor *)titleSelectColor {
    _titleSelectColor = titleSelectColor;
    for (UIButton *btn in _tabBtns) {
        [btn setTitleColor:titleSelectColor forState:UIControlStateSelected];
    }
}

- (void)setIndexViewHeight:(CGFloat)indexViewHeight {
    _indexViewHeight = indexViewHeight;
    CGRect frame = _indexView.frame;
    frame.size.height = indexViewHeight;
    frame.origin.y = self.bounds.size.height - indexViewHeight;
    _indexView.frame = frame;
}

- (void)setIndexViewWidth:(CGFloat)indexViewWidth {
    _indexViewHeight = indexViewWidth;
    CGRect frame = _indexView.frame;
    frame.size.width = indexViewWidth;
    frame.origin.y = self.bounds.size.height - indexViewWidth;
    _indexView.frame = frame;
}

- (void)setIndexViewColor:(UIColor *)indexViewColor {
    _indexViewColor = indexViewColor;
    _indexView.backgroundColor = indexViewColor;
}

- (void)setSegmentIndicateType:(JKSegmentIndicateType)segmentIndicateType {
    _segmentIndicateType = segmentIndicateType;
    if (_segmentIndicateType == JKSegmentMatchType) {
        UIButton *btn = _tabBtns[0];
        CGSize textSize =[btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_titleSelectSize]}];
        _indexView.frame = CGRectMake(0, 0, textSize.width, _indexViewHeight);
        _indexView.center = CGPointMake(btn.center.x, self.bounds.size.height - _indexViewHeight/2);
    }
}

@end
