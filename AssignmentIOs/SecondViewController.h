//
//  SecondViewController.h
//  AssignmentIOs
//
//  Created by Shailesh Patil on 20/09/16.
//  Copyright © 2016 Jyoti Shinde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetail.h"
#import "AppDelegate.h"
#import "DBManager.h"

@interface SecondViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) AppDelegate *appDelegate;
@property(nonatomic,strong) NSMutableArray *cartArray;
@property(nonatomic,strong) IBOutlet UITableView *cartTable;

@property(nonatomic,strong) NSMutableArray *cellPArray;
@property(nonatomic,strong) NSMutableArray *cellVArray;
@property(nonatomic,strong) NSMutableArray *cellVAdressArray;
@property(nonatomic,strong) NSMutableArray *cellPhnArray;
@property(nonatomic,strong) NSMutableArray *cellImgArray;
@property(nonatomic,strong) NSMutableArray *cellPriceArray;



@end

