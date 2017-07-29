//
//  JKSegmentControl.h
//  ZY-Houserkeeper
//
//  Created by JayKing on 17/7/17.
//  Copyright © 2017年 zallsoon-zf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JKSegmentIndicateType) {
    JKSegmentAverageType = 0,  //指示条等分
    JKSegmentMatchType,    //指示条适应文字长度
};

typedef NS_ENUM(NSUInteger, JKSegmentType) {
    JKContentMatchScreenType,  //内容宽度匹配屏宽
    JKContentMatchTextType,   //内容宽度匹配文本
};

typedef void(^SelectItemBlock)(NSInteger selectIndex);

@interface JKSegmentControl : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray <NSString *>*)items segmentScrollType:(JKSegmentType)segmentScrollType selectBlock:(SelectItemBlock)block;

/**
 设置当前选中项，默认0
 */
@property (assign, nonatomic) NSInteger currentSelectIndex;

/**
 设置底部指示条类型
 */
@property (assign, nonatomic) JKSegmentIndicateType segmentIndicateType;

/**
 设置默认文本字体大小
 */
@property (assign, nonatomic) CGFloat titleDefaultSize;

/**
 设置选中文本字体大小
 */
@property (assign, nonatomic) CGFloat titleSelectSize;

/**
 设置默认文本字体颜色
 */
@property (strong, nonatomic) UIColor *titleDefaultColor;

/**
 设置选中文本字体颜色
 */
@property (strong, nonatomic) UIColor *titleSelectColor;

/**
 设置底部指示条高度
 */
@property (assign, nonatomic) CGFloat indexViewHeight;

/**
 设置底部指示条宽度
 */
@property (assign, nonatomic) CGFloat indexViewWidth;

/**
 设置底部指示条颜色
 */
@property (strong, nonatomic) UIColor *indexViewColor;

@end
