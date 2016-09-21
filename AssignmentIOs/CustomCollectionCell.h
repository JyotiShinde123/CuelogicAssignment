//
//  CustomCollectionCell.h
//  AssignmentIOs
//
//  Created by Shailesh Patil on 20/09/16.
//  Copyright © 2016 Jyoti Shinde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionCell : UICollectionViewCell

@property(nonatomic,strong) IBOutlet UIImageView *imgProduct;
@property(nonatomic,strong) IBOutlet UILabel *lblProductName;
@property(nonatomic,strong) IBOutlet UILabel *lblProductPrice;
@property(nonatomic,strong) IBOutlet UILabel *lblVenderName;
@property(nonatomic,strong) IBOutlet UILabel *lblVenderAdress;
@property (nonatomic,strong) IBOutlet UIButton *btnAddToCart;




@end
