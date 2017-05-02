//
//  HomeTableViewController.m
//  JSInteractiveDemo
//
//  Created by 李俊涛 on 17/4/14.
//  Copyright © 2017年 myhexin. All rights reserved.
//

#import "HomeTableViewController.h"
#import "NativeAPIViewController.h"
#import "BrigeViewController.h"
#import "ContextViewController.h"
#import "JSExportViewController.h"
@interface HomeTableViewController ()

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    } else if (section == 2) {
        return 2;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (indexPath.section == 0) {
        cell.textLabel.text = @"原生api交互";
        cell.detailTextLabel.text = @"直接执行脚本，拦截代理";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"WebViewJavascriptBrige交互";
        cell.detailTextLabel.text = @"WebViewJavascriptBrige使用，实质还是拦截代理";
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"context上下文";
            cell.detailTextLabel.text = @"context上下文直接设置和调用";
        } else {
            cell.textLabel.text = @"JSExport协议";
            cell.detailTextLabel.text = @"通过JSExport协议设置和调用";
        }
    }
    
    return cell;
}


#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NativeAPIViewController *pushVC = [[NativeAPIViewController alloc] init];
        [self.navigationController pushViewController:pushVC animated:YES];
    } else if (indexPath.section == 1) {
        BrigeViewController *pushVC = [[BrigeViewController alloc] init];
        [self.navigationController pushViewController:pushVC animated:YES];
        
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            ContextViewController *pushVC = [[ContextViewController alloc] init];
            [self.navigationController pushViewController:pushVC animated:YES];
        } else {
            JSExportViewController *pushVC = [[JSExportViewController alloc] init];
            [self.navigationController pushViewController:pushVC animated:YES];
        }
    }
    else {
        return;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    [view addSubview:label];
    if (section == 0) {
        label.text = @"直接交互";
    } else if (section == 1){
        label.text = @"第三方库交互";
    } else {
        label.text = @"JavascriptCore框架";
    }
    return view;
}
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
