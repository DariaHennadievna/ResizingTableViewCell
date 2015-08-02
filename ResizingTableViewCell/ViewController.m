//
//  ViewController.m
//  ResizingTableViewCell
//
//  Created by Admin on 02.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"
#import "DRTextModel.h"
#import "DRResizingTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, DRResizingTableViewCellDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *heightForRow;
@property (nonatomic) NSInteger numberOfRows;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSInteger)numberOfRows
{
    return 4;
}

#pragma mark - Internal

- (NSMutableDictionary *)heightForRow
{
    if (!_heightForRow)
    {
        _heightForRow = [NSMutableDictionary dictionary];
        
        for (NSUInteger i = 0; i < self.numberOfRows; i++)
        {
            [_heightForRow setObject:@(130) forKey:[NSString stringWithFormat:@"%d", (int)i]];
        }
    }
    
    return _heightForRow;
}

#pragma mark - Resizing Table View Cell Delegate

- (void)resizeWithHeight:(CGFloat)height resizingTableViewCell:(DRResizingTableViewCell *)tableViewCell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tableViewCell];
    [self.heightForRow setObject:@(height) forKey:[NSString stringWithFormat:@"%d", (int)indexPath.row]];
    
    [self.tableView reloadData];
}


#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.numberOfRows;
}

- (DRResizingTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"cell";    
    DRResizingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell)
    {
        cell = [[DRResizingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.initFrame = cell.frame;
        cell.myLabel.text = [DRTextModel getText];
        cell.delegate = self;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView * )tableView heightForRowAtIndexPath:(NSIndexPath * )indexPath
{
    return [[self.heightForRow objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.row]] floatValue];
}


@end
