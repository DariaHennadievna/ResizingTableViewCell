//
//  DRResizingTableViewCell.h
//  ResizingTableViewCell
//
//  Created by Admin on 02.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DRResizingTableViewCellDelegate;

@interface DRResizingTableViewCell : UITableViewCell

@property (nonatomic) UIButton *showMoreButton;
@property (nonatomic) UILabel *myLabel;

@property CGFloat height;
@property (nonatomic, assign) CGRect initFrame;

@property (nonatomic, weak) id<DRResizingTableViewCellDelegate> delegate;

@end

@protocol DRResizingTableViewCellDelegate <NSObject>

- (void)resizeWithHeight:(CGFloat)height resizingTableViewCell:(DRResizingTableViewCell *)tableViewCell;

@end
