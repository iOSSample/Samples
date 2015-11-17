//
//  XIBTableViewCell.h
//  NewWatchDemo
//
//  Created by DuHao on 15/4/27.
//  Copyright (c) 2015年 DuHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XIBTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
