//
//  CheckListDetailView.m
//  mac15wr
//
//  Created by zwein on 2/25/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import "CheckListDetailView.h"

@implementation CheckListDetailView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initdata];
        self.isExpand = NO;
    }
    return self;
}

//初始化View 创建展开后控件！并将frame初始化为（0，0，0，0）包括要写死的控件
- (void)initdata
{
//    _label1 = [[UILabel alloc]initWithFrame:CGRectZero];
//    [self addSubview:_label1];
//    _label2 = [[UILabel alloc]initWithFrame:CGRectZero];
//    [self addSubview:_label2];
//    
    
    self.deleteBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    self.deleteBtn.backgroundColor = [UIColor WR_USC_Yellow];
    [self addSubview:self.deleteBtn];
    
    self.addToWLBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    self.addToWLBtn.backgroundColor = [UIColor WR_USC_Yellow];
    [self addSubview:self.addToWLBtn];
    
    self.sectionIdLabel = [[UILabel alloc] init];
    self.sectionIdLabel.textColor = [UIColor WR_USC_Yellow];
    [self addSubview:self.sectionIdLabel];
    
    self.sectionSeatsLabel = [[UILabel alloc] init];
    self.sectionSeatsLabel.textColor = [UIColor WR_USC_Yellow];
    [self addSubview:self.sectionSeatsLabel];
    
    self.sectionProfessorLabel = [[UILabel alloc] init];
    self.sectionProfessorLabel.textColor = [UIColor WR_USC_Yellow];
    [self addSubview:self.sectionProfessorLabel];
    
}
//自动布局 通过model 给展开后控件复制！！（详细控件在该方法内创建 在else中隐藏 包括要写死的控件）
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.isExpand==YES) {
        self.backgroundColor=[UIColor alizarinColor];

        //高度可以通过实现计算高度的方法来获得
        self.frame = CGRectMake(0, 44, 300, 150);
        
        self.sectionIdLabel.frame = CGRectMake(20, 0, 300, 30);
        self.sectionIdLabel.hidden = NO;
        
        self.sectionSeatsLabel.frame = CGRectMake(20, CGRectGetMaxY(self.sectionIdLabel.frame), 300, 30);
        self.sectionSeatsLabel.hidden = NO;
        
        self.sectionProfessorLabel.frame = CGRectMake(20, CGRectGetMaxY(self.sectionSeatsLabel.frame), 300, 30);
        self.sectionProfessorLabel.hidden = NO;
        
        self.deleteBtn.frame = CGRectMake(0, 0, 60, 30);
        self.deleteBtn.center = CGPointMake(CGRectGetWidth(self.frame)/2-100, CGRectGetHeight(self.frame)-30);
        [self.deleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
        self.deleteBtn.titleLabel.textColor = [UIColor WR_USC_Red];
        self.deleteBtn.hidden = NO;
        
        self.addToWLBtn.frame = CGRectMake(0, 0, 160, 30);
        self.addToWLBtn.center = CGPointMake(CGRectGetWidth(self.frame)/2+50, CGRectGetHeight(self.frame)-30);
        [self.addToWLBtn setTitle:@"Add to Wish List" forState:UIControlStateNormal];
        self.addToWLBtn.titleLabel.textColor = [UIColor WR_USC_Red];
        self.addToWLBtn.hidden = NO;
        
        
    }else {
        self.backgroundColor=[UIColor clearColor];
  
        self.deleteBtn.hidden = YES;
        self.addToWLBtn.hidden = YES;


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
