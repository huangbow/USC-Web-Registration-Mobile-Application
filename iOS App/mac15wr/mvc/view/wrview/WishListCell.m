//
//  WishListCell.m
//  mac15wr
//
//  Created by zwein on 2/24/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import "WishListCell.h"
#import "WishListDetailView.h"


@implementation WishListCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self initdata];
    }
    
    return self;
}
- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self initdata];
    }
    
    return self;
}
//初始化Cell
- (void)initdata
{
    self.detialView = [[WishListDetailView alloc] initWithFrame:CGRectZero];
    self.backgroundColor = [UIColor pomegranateColor];
    [self addSubview:self.detialView];
    //    self.detialView.frame=CGRectMake(0, 1, 0, 1);
    //此处label无论单元格展开与否都显示 应通过另外的数据源赋值 此处写死了
    self.courseTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 30, 44)];
    self.courseTypeLabel.text = @"Lec";
    self.courseTypeLabel.textColor = [UIColor WR_USC_Yellow];
    self.courseTypeLabel.font = [UIFont boldSystemFontOfSize:16];
    [self addSubview:self.courseTypeLabel];
    
    self.courseDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.courseTypeLabel.bounds) + 30, 0, 160, 44)];
    self.courseDateLabel.text = @"10:00-11:50 M";
    self.courseDateLabel.textColor = [UIColor WR_USC_Yellow];
    self.courseDateLabel.font = [UIFont boldSystemFontOfSize:16];
    [self addSubview:self.courseDateLabel];
    
    self.courseLocationLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.courseDateLabel.bounds) + CGRectGetMaxX(self.courseTypeLabel.bounds) , 0, 100, 44)];
    self.courseLocationLabel.text = @"THH205";
    self.courseLocationLabel.textColor = [UIColor WR_USC_Yellow];
    self.courseLocationLabel.font = [UIFont boldSystemFontOfSize:16];
    [self addSubview:self.courseLocationLabel];
    
}
//自动布局 将model传给自定义View
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_model != nil ) {
        _detialView.model = self.model;
        //下面这行代码只是为了开始自动布局
        [_detialView layoutSubviews];
        //        _detialView.hidden=NO;
    }else{
        _detialView.model = nil;
        _detialView.frame = CGRectZero;
        //        _detialView.hidden=YES;
        
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
