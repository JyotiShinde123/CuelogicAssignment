//
//  SecondViewController.m
//  AssignmentIOs
//
//  Created by Shailesh Patil on 20/09/16.
//  Copyright © 2016 Jyoti Shinde. All rights reserved.
//

#import "SecondViewController.h"
#import "CustomTableViewCell.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title=@"Cart";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    NSLog(@"In second View");
    
    //NSLog(@"count cart Array=%d",[_appDelegate.cartArray count]);
    _cartArray=[[NSMutableArray alloc]init];
    _cellPriceArray=[[NSMutableArray alloc]init];
    _cellImgArray=[[NSMutableArray alloc]init];
    
    _cellPhnArray=[[NSMutableArray alloc]init];
    _cellVAdressArray=[[NSMutableArray alloc]init];
    _cellVArray=[[NSMutableArray alloc]init];
    _cellPArray=[[NSMutableArray alloc]init];

    
    
//   _cartArray= [[DBManager getSharedInstance]FindAllCartData];
//    [self Data];
}
//static NSString *simpleTableIdentifier = @"CustomCollectionCell";

- (void)viewWillAppear:(BOOL)animated
{
    //[self doMyLayoutStuff:self];
    _cartArray= [[DBManager getSharedInstance]FindAllCartData];
    [self Data];
}


//CustomCollectionCell *cell = [cv dequeueReusableCellWithReuseIdentifier:simpleTableIdentifier forIndexPath:indexPath];
-(void )Data{
    
    if(_cartArray.count>0)
    {
        ProductDetail *pData=[[ProductDetail alloc]init];
        for (int i=0; i<[_cartArray count]; i++)
        {
            pData=[_cartArray objectAtIndex:i];
            
            NSString *pName=pData.productname;
            NSString *vName=pData.vendorname;
            NSString *vAdress=pData.vendoraddress;
            NSString *pPrice=pData.price;
            NSString *pPhnNumber=pData.phoneNumber;
            NSString *pImagePath=pData.productImg;
           
            
            [_cellPArray addObject:pName];
            [_cellVArray addObject:vName];
            [_cellVAdressArray addObject:vAdress];
            [_cellPriceArray addObject:pPrice];
            [_cellPhnArray addObject:pPhnNumber];
            [_cellImgArray addObject:pImagePath];
            
        }
      
        
        NSLog(@"_cellPArray=%@",_cellPArray);
        NSLog(@"_cellVArray=%@",_cellVArray);
        NSLog(@"_cellVAdressArray=%@",_cellVAdressArray);
        NSLog(@"_cellPriceArray=%@",_cellPriceArray);
        NSLog(@"_cellPhnArray=%@",_cellPhnArray);
        NSLog(@"_cellImgArray=%@",_cellImgArray);
        

    }
}

- (void) loadImageFromURL: (NSURL*) url callback:(void (^)(UIImage *image))callback {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIImage *image = [UIImage imageWithData:imageData];
            callback(image);
            
        });
    });
}

-(void)btnRmvCartClicked:(UIButton*)btnClicked
{
    int btnIndex=btnClicked.tag;
    NSLog(@"chkOut=%ld",(long)btnIndex);
    
    int count=btnIndex+1;
    
    NSLog(@"count=%d",count);
    
    
    
    [[DBManager getSharedInstance]DeleteByIndexId:count];
    
    
    
   // [[DBManager getSharedInstance]saveData:strPname price:strPprice phoneNumber:strPhnNumber vendorname:strVname vendoraddress:strVadress productImg:strPimg];
    
    [_cartTable reloadData];
    
}

-(void)btnCallVenderClicked:(UIButton*)btnClicked
{
    NSInteger btnIndex=btnClicked.tag;
    NSLog(@"chkOut=%ld",(long)btnIndex);
    
    ProductDetail *cartPdetail=[_cartArray objectAtIndex:btnClicked.tag];
   
    NSString *strPhnNumber=cartPdetail.phoneNumber;
    
   
    NSLog(@"all there are %@",strPhnNumber);
    
   // [[DBManager getSharedInstance]saveData:strPname price:strPprice phoneNumber:strPhnNumber vendorname:strVname vendoraddress:strVadress productImg:strPimg];
//    NSString* phoneNumber1=self.lblHnumber.text;
//    NSString *phnNumber2=[phoneNumber1 stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:strPhnNumber];//123-4567-890
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];

}

//UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
       return [_cartArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    
    static NSString *cellIdentifier = @"CustomTableViewCell";
    CustomTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.cellLblPName.text=[_cellPArray objectAtIndex:indexPath.row];
    cell.cellLblPrice.text=[_cellPriceArray objectAtIndex:indexPath.row];
    cell.cellLblVName.text=[_cellVArray objectAtIndex:indexPath.row];
    cell.cellLblVAdress.text=[_cellVAdressArray objectAtIndex:indexPath.row];
    
     NSLog(@"cell.cellLblPName.text=%@",cell.cellLblPName.text);
     NSLog(@"cell.cellLblPrice.text=%@",cell.cellLblPrice.text);
     NSLog(@"cell.cellLblVName.textt=%@",cell.cellLblVName.text);
     NSLog(@"cell.cellLblVAdress.text=%@",cell.cellLblVAdress.text);
    
    
    NSString *myImage = [_cellImgArray objectAtIndex:indexPath.row];
    [self loadImageFromURL:[NSURL URLWithString:[myImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] callback:^(UIImage *image) {
        cell.tableCellImage.image = image;
    }];

    
    cell.cellBtnCall.tag=indexPath.row;
    [cell.cellBtnCall addTarget:self action:@selector(btnCallVenderClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.cellBtnRmvCart.tag=indexPath.row;
    [cell.cellBtnRmvCart addTarget:self action:@selector(btnRmvCartClicked:) forControlEvents:UIControlEventTouchUpInside];

    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    
        //NSIndexPath *path = [self.programTable indexPathForSelectedRow];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
           
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
