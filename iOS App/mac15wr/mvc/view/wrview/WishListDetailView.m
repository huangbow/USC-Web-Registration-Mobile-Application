//
//  WishListDetailView.m
//  mac15wr
//
//  Created by zwein on 2/24/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import "WishListDetailView.h"

@implementation WishListDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initdata];
    }
    return self;
}

//初始化View 创建展开后控件！并将frame初始化为（0，0，0，0）包括要写死的控件
- (void)initdata
{
    _label1 = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_label1];
    _label2 = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_label2];
    
}
//自动布局 通过model 给展开后控件复制！！（详细控件在该方法内创建 在else中隐藏 包括要写死的控件）
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.model != nil && _model.isExpand==YES) {
        self.backgroundColor=[UIColor alizarinColor];
        _label1.text =_model.str1;
        _label1.frame = CGRectMake(0, 10, 300, 30);
        _label2.text = _model.str2;
        _label2.frame = CGRectMake(0, 50, 300, 30);
        //控件必须改为不隐藏
        _label1.hidden = NO;
        _label2.hidden = NO;
        //高度可以通过实现计算高度的方法来获得
        self.frame = CGRectMake(0, 44, 300, 80);
        
        
    }else {
        self.backgroundColor=[UIColor clearColor];
        _label1.hidden = YES;
        _label2.hidden = YES;
    }
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
