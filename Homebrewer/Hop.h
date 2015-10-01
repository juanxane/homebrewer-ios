//
//  Hop.h
//  Homebrewer
//
//  Created by Juanx Ane on 9/11/15.
//  Copyright (c) 2015 JuanxAne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductTableProtocol.h"
#import "DBModel.h"

@interface Hop : NSObject <ProductTableProtocol>

@property (nonatomic) NSInteger code;
@property (nonatomic) NSString* name;
@property (nonatomic) double AA;
@property (nonatomic) double amount;
@property (nonatomic) NSInteger time;



-(BOOL)isEqual:(id)object;

#pragma ProductTableProtocol

- (NSString*)getTitle;
- (NSString*)getDetail;

#pragma mark - DataBase

+(NSMutableArray *) hopsInDataBase:(sqlite3 *) database;
+(NSMutableArray *) hopsForRecipe:(NSInteger) recipe_code InDataBase:(sqlite3 *) database;

@end
