//
//  Grain.h
//  Homebrewer
//
//  Created by Juanx Ane on 9/11/15.
//  Copyright (c) 2015 JuanxAne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductTableProtocol.h"
#import "DBModel.h"

@interface Grain : NSObject <ProductTableProtocol>

@property (nonatomic) NSInteger code;
@property (nonatomic) NSString* name;
@property (nonatomic) double amount;


-(BOOL)isEqual:(id)object;


#pragma mark - ProductTableProtocol

- (NSString*)getTitle;
- (NSString*)getDetail;


#pragma mark - DataBase

+(NSMutableArray *) grainsInDataBase:(sqlite3 *) database;
+(NSMutableArray *) grainsForRecipe:(NSInteger) recipe_code InDataBase:(sqlite3 *) database;

@end
