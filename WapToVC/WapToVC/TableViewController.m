//
//  TableViewController.m
//  WapToVC
//
//  Created by 杜豪 on 15/8/10.
//  Copyright (c) 2015年 杜豪. All rights reserved.
//

#import "TableViewController.h"
#import "TableHeadView.h"

@interface TableViewController (){
    TableHeadView *_headView;
    NSMutableArray *_array;
}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _array = [NSMutableArray array];
    
    for (int i = 0; i < 30; i++) {
        [_array addObject:[NSString stringWithFormat:@"中华人民共和国 %d",i]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _array[indexPath.row];
    // Configure the cell...
    
    return cell;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    
//    [_headView setScaleWithOffset: scrollView.contentOffset.y];
//    
//    if (scrollView.contentOffset.y > _lessonInfoView.height/3) {
//        
//        [self setNaviViewHidden: YES];
//    }else {
//        
//        [self setNaviViewHidden: NO];
//    }
//}
//
//// 通过动画的方式打开和关掉上面你的naviView
//- (void)setNaviViewHidden:(BOOL)hidden {
//    if (hidden) {
//        if (_naviView.bottom <= 0) {
//            return;
//        }
//    } else {
//        
//        if (_naviView.top >= 0) {
//            return;
//        }
//    }
//    [UIView animateWithDuration: 0.3
//                     animations:^{
//                         if (hidden) {
//                             _naviView.bottom = 0;
//                         } else {
//                             _naviView.top = 0;
//                         }
//                     }];
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
