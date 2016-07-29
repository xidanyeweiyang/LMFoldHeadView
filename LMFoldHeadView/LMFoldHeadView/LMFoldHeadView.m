
//
//  LMFoldHeadView.m
//  LMFoldHeadView
//
//  Created by 刘明 on 16/7/29.
//  Copyright © 2016年 刘明. All rights reserved.
//

#import "LMFoldHeadView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation LMFoldHeadView{
    
    UIView *backView;
    UIImageView *imageView;
    UIView *lineView;
    BOOL _canFold;
    BOOL _created;
}


- (void)initWithStatus:(BOOL)status section:(NSInteger)section canFold:(BOOL)canFold{
    
    if (!_created) {
        
        [self setupUI];
    }
    
    _selectSection = section;
    _canFold = canFold;
}

- (void)setupUI{
    _created = YES;
    
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    backView.backgroundColor = [UIColor lightGrayColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickHeadView)];
    [backView addGestureRecognizer:tap];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 20)];
    imageView.center = backView.center;
    imageView.image = [UIImage imageNamed:@"展开_u98"];
    
    lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 19, kScreenWidth, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    [backView addSubview:lineView];
    
    [backView addSubview:imageView];
    [self.contentView addSubview:backView];
    
    
}

- (void)setOpenOrClose:(BOOL)openOrClose{
    
    _openOrClose = openOrClose;
    
    imageView.image = openOrClose? [UIImage imageNamed:@"展开_u98"]:[UIImage imageNamed:@"收起_u173"];
    
    
}

- (void)didClickHeadView{
    
    
    if ([self.delegate respondsToSelector:@selector(foldHeaderInSection:)]) {
        [self.delegate foldHeaderInSection:_selectSection];
    }
    
}

@end
