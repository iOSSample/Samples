//
//  TableViewController.m
//  NewWatchDemo
//
//  Created by DuHao on 15/4/27.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import "TableViewController.h"
#import "XIBTableViewCell.h"
@interface TableViewController (){
    NSMutableArray *dataArrray;
}
@property (nonatomic, strong) UITableViewCell *prototypeCell;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArrray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 30; i ++) {
        NSMutableString * str = [[NSMutableString alloc] init];
        for(int j = 0 ; j < i+1; j++) {
            [str appendString:@"Apple Watch"];
        }
        [dataArrray addObject:str];
    }
    
    UINib *cellNib = [UINib nibWithNibName:@"XIBTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"xibcell"];
    
    self.prototypeCell  = [self.tableView dequeueReusableCellWithIdentifier:@"xibcell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return dataArrray.count;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    XIBTableViewCell *cell = (XIBTableViewCell *)self.prototypeCell;
//    cell.contentLabel.text = [dataArrray objectAtIndex:indexPath.row];
//    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    NSLog(@"h=%f", size.height + 1);
//    return 1 + size.height;
//}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XIBTableViewCell *cell = (XIBTableViewCell *)self.prototypeCell;
    cell.contentLabel.text = [dataArrray objectAtIndex:indexPath.row];
    CGSize s =  [cell.contentLabel sizeThatFits:CGSizeMake(cell.contentLabel.frame.size.width, FLT_MAX)];
    CGFloat defaultHeight = cell.contentView.frame.size.height;
    CGFloat height = s.height > defaultHeight ? s.height : defaultHeight;
    return 1  + height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XIBTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"xibcell"];
    cell.contentLabel.text = [dataArrray objectAtIndex:indexPath.row];
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
