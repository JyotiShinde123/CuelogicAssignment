//
//  FirstViewController.h
//  AssignmentIOs
//
//  Created by Shailesh Patil on 20/09/16.
//  Copyright © 2016 Jyoti Shinde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface FirstViewController : UIViewController<NSURLConnectionDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

{
   NSMutableData *webData;
   NSURLConnection *connection;
    
}

@property(nonatomic,strong) AppDelegate *appDelegate;
@property(nonatomic,strong) IBOutlet UICollectionView *productCollection;

@property(nonatomic,strong) NSMutableArray *arrProductName;
@property(nonatomic,strong) NSMutableArray *arrProductPrice;
@property(nonatomic,strong) NSMutableArray *arrVenderName;
@property(nonatomic,strong) NSMutableArray *arrVenderAdress;
@property(nonatomic,strong) NSMutableArray *arrProductImg;


@end

