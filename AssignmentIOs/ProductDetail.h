//
//  ProductDetail.h
//  AssignmentIOs
//
//  Created by Shailesh Patil on 20/09/16.
//  Copyright © 2016 Jyoti Shinde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetail : NSObject

@property(nonatomic,strong) NSString *productname;
@property(nonatomic,strong) NSString *price;

@property(nonatomic,strong) NSString *vendorname;

@property(nonatomic,strong) NSString *vendoraddress;

@property(nonatomic,strong) NSString *productImg;
@property(nonatomic,strong) NSString *phoneNumber;

@property(nonatomic,strong) NSMutableArray *photoGallery;



@end
