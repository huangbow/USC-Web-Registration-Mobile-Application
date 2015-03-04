//
//  CheckListDetailView.h
//  mac15wr
//
//  Created by zwein on 2/25/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CheckListDetailView : UIView
{
    
    
}

//下边方法可以自己实现 用于计算view高度 或者单元格高度

//+(CGFloat)getHeightByModel:(Model*)model;

//@property(nonatomic,strong)CheckListModel *model;

@property(nonatomic,strong) UILabel *sectionIdLabel;
@property(nonatomic,strong) UILabel *sectionSeatsLabel;
@property(nonatomic,strong) UILabel *sectionProfessorLabel;


@property(nonatomic,strong) UIButton *deleteBtn;
@property(nonatomic,strong) UIButton *addToWLBtn;
@property(assign,nonatomic) BOOL isExpand;

//@property(nonatomic,assign) CheckListCell *cellDelegate;

@end
