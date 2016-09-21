//
//  FirstViewController.m
//  AssignmentIOs
//
//  Created by Shailesh Patil on 20/09/16.
//  Copyright © 2016 Jyoti Shinde. All rights reserved.
//

#import "FirstViewController.h"
#import "ProductDetail.h"
#import "CustomCollectionCell.h"
#import "DBManager.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title=@"Shop";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [self FetchRequest];
    //CustomCollectionCell
    
    
    _arrProductName=[[NSMutableArray alloc]init];
    _arrProductPrice=[[NSMutableArray alloc]init];
    _arrVenderName=[[NSMutableArray alloc]init];
    _arrVenderAdress=[[NSMutableArray alloc]init];
    _arrProductImg=[[NSMutableArray alloc]init];

    NSLog(@"In First View");
}


-(void)FetchRequest{
    
    NSURL *url=[NSURL URLWithString:@"https://mobiletest-hackathon.herokuapp.com/getdata/"];
    
    //https://mobiletest-hackathon.herokuapp.com/getdata/
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if(connection)
    {
        webData =[[NSMutableData alloc]init];
        NSLog(@"TOP MOVIES");
    }

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*NSURLConnectionDelegateMethods*/

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int responseStatusCode = [httpResponse statusCode];
    NSLog(@"responseStatusCode=%d",responseStatusCode);
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Fail");
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSDictionary *dict= [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    NSLog(@"dict=%@",dict);
    
    NSMutableArray *arrProduct=[dict objectForKey:@"products"];
    NSLog(@"arrProduct=%@",arrProduct);
    
    if(arrProduct.count>0)
    {
        for(int i=0; i<arrProduct.count; i++)
        {
             NSDictionary *details= [arrProduct objectAtIndex:i];
            
            ProductDetail *productData=[[ProductDetail alloc]init];
            productData.productname=[details objectForKey:@"productname"];
            productData.price=[details objectForKey:@"price"];
            productData.productImg=[details objectForKey:@"productImg"];
            productData.vendorname=[details objectForKey:@"vendorname"];
            productData.vendoraddress=[details objectForKey:@"vendoraddress"];
            productData.phoneNumber=[details objectForKey:@"phoneNumber"];
            productData.photoGallery=[details objectForKey:@"productGallery"];
            
            
            [_arrProductName addObject:productData.productname];
            [_arrProductPrice addObject:productData.price];
            [_arrVenderName addObject:productData.vendorname];
            [_arrVenderAdress addObject:productData.vendoraddress];
            [_arrProductImg addObject:productData.productImg];
            
            [self.appDelegate.productArray addObject:productData];
            
            
            

        }
        NSLog(@"self.appDelegate.productArray=%lu",(unsigned long)[self.appDelegate.productArray count]);
    }
    else{
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"ShoppingApp"
                                                                       message:@"Data Not Found."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    
    [_productCollection reloadData];

    

    
    
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    
    //        if([challenge.protectionSpace.host isEqualToString:@"https://api.cinemalytics.com"] /*check if this is host you trust: */ )
    //            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        NSLog(@"Ignoring SSL");
        SecTrustRef trust = challenge.protectionSpace.serverTrust;
        NSURLCredential *cred;
        cred = [NSURLCredential credentialForTrust:trust];
        [challenge.sender useCredential:cred forAuthenticationChallenge:challenge];
        return;
    }
    
}


- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}

-(void)btnAddToCartClicked:(UIButton*)btnClicked
{
    NSInteger btnIndex=btnClicked.tag;
    NSLog(@"chkOut=%ld",(long)btnIndex);
    
    ProductDetail *cartPdetail=[self.appDelegate.productArray objectAtIndex:btnClicked.tag];
    NSString *strPname=cartPdetail.productname;
    NSString *strPprice=cartPdetail.price;
    NSString *strVname=cartPdetail.vendorname;
    
    NSString *strVadress=cartPdetail.vendoraddress;
    NSString *strPhnNumber=cartPdetail.phoneNumber;
    
    NSString *strPimg=cartPdetail.productImg;
    NSLog(@"all there are %@,%@,%@,%@,%@,%@",strPname,strPprice,strVname,strVadress,strPhnNumber,strPimg);
    
    [[DBManager getSharedInstance]saveData:strPname price:strPprice phoneNumber:strPhnNumber vendorname:strVname vendoraddress:strVadress productImg:strPimg];
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


#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    
//    NSLog(@"title count=%lu",(unsigned long)[title count]);
//    NSLog(@"avatarimageArray count=%lu",(unsigned long)[avatarimageArray count]);
    return [self.appDelegate.productArray count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"CustomCollectionCell";
    
    CustomCollectionCell *cell = [cv dequeueReusableCellWithReuseIdentifier:simpleTableIdentifier forIndexPath:indexPath];
   // cell.collectionLabel.text = [title objectAtIndex:indexPath.row];
    cell.lblProductName.text=[_arrProductName objectAtIndex:indexPath.row];
    cell.lblProductPrice.text=[_arrProductPrice objectAtIndex:indexPath.row];
    cell.lblVenderName.text=[_arrVenderName objectAtIndex:indexPath.row];
    cell.lblVenderAdress.text=[_arrVenderAdress objectAtIndex:indexPath.row];
    
    NSString *myImage = [_arrProductImg objectAtIndex:indexPath.row];
    [self loadImageFromURL:[NSURL URLWithString:[myImage stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] callback:^(UIImage *image) {
        cell.imgProduct.image = image;
    }];
    
    cell.btnAddToCart.tag=indexPath.row;
    [cell.btnAddToCart addTarget:self action:@selector(btnAddToCartClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=[UIColor colorWithRed:128.0/255.0 green:69.0/255.0 blue:80.0/255.0 alpha:1.0].CGColor;
    return cell;
}



#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Clicked %d", indexPath.row);
    [self performSegueWithIdentifier:@"DataSegue" sender:self];
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize s = CGSizeMake([[UIScreen mainScreen] bounds].size.width/2 - 9, [[UIScreen mainScreen] bounds].size.height/2-100);
    return s;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1,1 , 7, 7);
}


@end
