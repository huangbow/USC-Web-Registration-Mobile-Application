//
//  WishListTableView.h
//  mac15wr
//
//  Created by zwein on 2/24/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WishListTableView : UITableView <UITableViewDataSource,UITableViewDelegate>{
    //表
//    UITableView *_bigTableView;
    
    //所有数据的数组
    NSMutableArray *_array;
    
    //表的数据源数组
    NSMutableArray *_CurrentArray;
}


@end

