//
//  DRResizingTableViewCell.m
//  ResizingTableViewCell
//
//  Created by Admin on 02.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "DRResizingTableViewCell.h"

@interface DRResizingTableViewCell ()

@property (nonatomic) BOOL isOpen;

@end

@implementation DRResizingTableViewCell

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configurationCell];
    }
    return self;
}

#pragma mark - Internal

- (void)configurationCell
{
    CGRect mainFrame = [[[[UIApplication sharedApplication] windows] firstObject] frame];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    CGRect frame;
    CGPoint origin= CGPointMake(8.0f, 8.0f);
    CGSize size = CGSizeMake(mainFrame.size.width - 16, 75.0f);
    frame.origin =origin;
    frame.size = size;
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:16];
    label.backgroundColor = [UIColor greenColor];
    self.myLabel = label;
    [self.contentView addSubview:self.myLabel];
    
    size = CGSizeMake(150.0f, 25.0f);
    origin = CGPointMake(mainFrame.size.width/2 - size.width/2, CGRectGetMaxY(self.myLabel.frame) + 8.0f);
    frame.size = size;
    frame.origin = origin;
    
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setTitle:@"Show More..." forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didPressedShowMoreButton) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    self.showMoreButton = button;
    
    [self.contentView addSubview:self.showMoreButton];
}

#pragma mark - Actions

- (void)didPressedShowMoreButton
{
    CGSize constraint = CGSizeMake(self.frame.size.width - 16, 1000);
    
    NSStringDrawingContext *context  = [[NSStringDrawingContext alloc] init];
    
    CGSize boundingBox = [self.myLabel.text boundingRectWithSize:constraint
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}
                                                 context:context].size;
    
    CGSize newSize = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    //NSLog(@"new width = %f", newSize.width);
    //NSLog(@"new height = %f", newSize.height);
    
    // от высоты label отнимает текущую высоту на UI.
    CGFloat height = newSize.height - self.initFrame.size.height;
    
    height = self.isOpen? height * -1 : height;
    
    CGRect frameForTextLabel = self.myLabel.frame;
    //NSLog(@"height %f + %f", frameForTextLabel.size.height, height);
    frameForTextLabel.size.height = frameForTextLabel.size.height + height;
    self.myLabel.frame = frameForTextLabel;
    
    CGRect frameForShowMoreButton = self.showMoreButton.frame;
    frameForShowMoreButton.origin.y = frameForShowMoreButton.origin.y + height;
    self.showMoreButton.frame = frameForShowMoreButton;
    
    CGRect frameForCell = self.frame;
    frameForCell.size.height = frameForCell.size.height + height;
    self.frame = frameForCell;
    
    CGRect frameForContent = self.contentView.frame;
    frameForContent.size.height = frameForContent.size.height + height;
    self.contentView.frame = frameForContent;
    
    [self.delegate resizeWithHeight:self.frame.size.height resizingTableViewCell:self];
    
    self.isOpen = !self.isOpen;
}



@end
