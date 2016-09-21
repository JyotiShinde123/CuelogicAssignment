//
//  CustomTableViewCell.h
//  AssignmentIOs
//
//  Created by Shailesh Patil on 21/09/16.
//  Copyright © 2016 Jyoti Shinde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property(nonatomic,strong) IBOutlet UIImageView *tableCellImage;
@property(nonatomic,strong) IBOutlet UILabel *cellLblPName;
@property(nonatomic,strong) IBOutlet UILabel *cellLblVName;
@property(nonatomic,strong) IBOutlet UILabel *cellLblVAdress;
@property(nonatomic,strong) IBOutlet UILabel *cellLblPrice;
@property(nonatomic,strong) IBOutlet UIButton *cellBtnCall;
@property(nonatomic,strong) IBOutlet UIButton *cellBtnRmvCart;



@end
