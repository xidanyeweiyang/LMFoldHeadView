//
//  LMFoldHeadView.h
//  LMFoldHeadView
//
//  Created by 刘明 on 16/7/29.
//  Copyright © 2016年 刘明. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailHeadViewDelegate;

@protocol LMFoldHeadViewDelegate <NSObject>

- (void)foldHeaderInSection:(NSInteger)SectionHeader;

@end
@interface LMFoldHeadView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIImage *statusImage;

@property (nonatomic, assign) NSInteger selectSection;

@property (nonatomic, assign) BOOL openOrClose;

@property (nonatomic, weak) id<LMFoldHeadViewDelegate> delegate;

- (void)initWithStatus:(BOOL)status section:(NSInteger)section canFold:(BOOL)canFold;
@end
