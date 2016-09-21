//
//  DBManager.h
//  AssignmentIOs
//
//  Created by Shailesh Patil on 21/09/16.
//  Copyright © 2016 Jyoti Shinde. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject

{
    NSString *databasePath;
}

+(DBManager*)getSharedInstance;
-(BOOL)createDB;
-(BOOL) saveData:(NSString*)registerNumber name:(NSString*)name
      department:(NSString*)department year:(NSString*)year;
-(NSArray*) findByRegisterNumber:(NSString*)registerNumber;

-(BOOL) saveData:(NSString *)productName price:(NSString*)price
     phoneNumber:(NSString*)phoneNumber vendorname:(NSString*)vendorname vendoraddress:(NSString*)vendoraddress productImg:(NSString*)productImg;
-(NSMutableArray *) FindAllCartData;

-(BOOL)DeleteByIndexId:(int) registerNumber;

@end
