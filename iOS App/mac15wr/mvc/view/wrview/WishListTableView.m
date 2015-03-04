//
//  WishListTableView.m
//  mac15wr
//
//  Created by zwein on 2/24/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import "WishListTableView.h"
#import "WishListCell.h"

@implementation WishListTableView


-(instancetype)initWithFrame:(CGRect)frame{
//    self =[super initWithFrame:CGRectMake(10, 30, 300, 500) style:UITableViewStyleGrouped];
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    self.separatorColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    //所有的总数据数组 数组套数组 最里面是model 下边创建的仅仅是测试数组
    _array = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i = 0; i < 3; i++) {
        NSMutableArray *arr=[[NSMutableArray alloc]initWithCapacity:0];
        
        for (int j = 0; j < 3; j++)
        {
            WishListModel *model=[[WishListModel alloc]init];
            model.str1 =[NSString stringWithFormat:@"张三%d",i];
            model.str2 = [NSString stringWithFormat:@"aaaa%d",j];
            model.isExpand = NO;
            [arr addObject:model];
        }
        
        [_array addObject:arr];
    }
    
    //表数据源数组
    _CurrentArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i = 0; i<_array.count; i++) {
        [_CurrentArray addObject:@[]];
    }
    
    //创建表
//    _bigTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 30, 300, 500) style:UITableViewStyleGrouped];
    self.delegate = self;
    self.dataSource = self;
//    [self addSubview:_bigTableView];
    
    return self;
}


#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _CurrentArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellIdentifier = @"WRRightListCell";
    
    WishListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.TitleLabel.text = @"123";

    if (!cell) {
        cell = [[WishListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    else
    {
        NSMutableDictionary *courseDict = [_CurrentArray objectAtIndex:indexPath.section];
        NSMutableArray *sections = [courseDict valueForKey:@"course_sections"];
        
        if (cell.model) {
            if (cell.model != [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]) {
                cell.model = [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                if (cell.model.isExpand==NO) {
                    cell.model=nil;
                }
            }
        }else
        {
            cell.model = [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            if (cell.model.isExpand==NO) {
                cell.model=nil;
            }
        }
    }
    
    [cell layoutSubviews];
    
    
    //    MyTableViewCell *cell = [[MyTableViewCell alloc]init];
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_CurrentArray objectAtIndex:section]count];
}
//点击单元格 展开、收缩 model信息
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WishListCell *cell=(WishListCell*)[tableView cellForRowAtIndexPath:indexPath];
//    WishListModel *model=[[_array objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
//    model.isExpand = !model.isExpand;
//    
//    if (cell.model) {
//        cell.model=nil;
//    }else
//    {
//        cell.model=model;
//    }
    [cell layoutSubviews];
    [tableView reloadData];
}
//设置区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
//判断model是否被展示 来控制单元格高度
//可以在自定义view中 写+号方法计算 以下因没具体数据是省略写法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    WishListModel *model=[[_array objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
//    if (!model.isExpand)
//    {
//        return   44;
//    }else
//    {
//        return  124;
//    }
    return 44;
    
}
//自定义区头 把区头model 创建的view写这里
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    view.backgroundColor = [UIColor WR_USC_Yellow];
    view.layer.borderWidth = 1.;
    view.layer.borderColor = [UIColor WR_USC_Red].CGColor;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44,44);
    btn.backgroundColor=[UIColor WR_USC_Red];
    btn.tag = section;
    [btn addTarget:self action:@selector(expand:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(CGRectGetMaxX(btn.bounds) + 20, 0, CGRectGetWidth(view.bounds)-CGRectGetMaxX(btn.bounds), CGRectGetHeight(view.bounds));
    headerLabel.text = @"Course Name";  // 通过setion 的 区别和获取课程表
    headerLabel.textColor = [UIColor WR_USC_Red];
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.font = [UIFont boldSystemFontOfSize:20.0];
    [view addSubview:headerLabel];
    
    
    UIView *seperator = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(view.bounds),
                                                                CGRectGetWidth(view.bounds), 0)];
    seperator.backgroundColor = [UIColor WR_USC_Yellow];
    
    UIView *container = [[UIView alloc]initWithFrame:CGRectMake(0, 0,
                                                                CGRectGetWidth(view.bounds),
                                                                CGRectGetHeight(view.bounds)+
                                                                CGRectGetHeight(seperator.bounds))];
    container.backgroundColor = [UIColor clearColor];
    [container addSubview:view];
    [container addSubview:seperator];
    
    return container;
    
}

#pragma mark - ActionMethord
//点击区头按钮 修改数据源数组 展开区
- (void)expand:(UIButton*)btn
{
    if([[_CurrentArray objectAtIndex:btn.tag] isEqualToArray:@[]])
    {
        [_CurrentArray replaceObjectAtIndex:btn.tag withObject:[_array objectAtIndex:btn.tag]];
        
    }else
    {
        
        
        [_CurrentArray replaceObjectAtIndex:btn.tag withObject:@[]];
    }
    [self reloadData];
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
