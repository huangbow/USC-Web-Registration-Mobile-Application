//
//  WishListCell.h
//  mac15wr
//
//  Created by zwein on 2/24/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WishListModel.h"
#import "WishListDetailView.h"

@interface WishListCell : UITableViewCell

//此处label无论单元格展开与否都显示
@property(nonatomic,strong) UILabel *TitleLabel;

@property(nonatomic,strong) UILabel *courseTypeLabel;
@property(nonatomic,strong) UILabel *courseLocationLabel;
@property(nonatomic,strong) UILabel *courseDateLabel;
@property(nonatomic,strong) UIButton *addToCalendarBtn;






@property(nonatomic,strong)WishListModel *model;
@property(nonatomic,strong  )WishListDetailView *detialView;
@end
