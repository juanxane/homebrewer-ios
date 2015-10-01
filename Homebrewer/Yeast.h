//
//  Yeast.h
//  Homebrewer
//
//  Created by Juanx Ane on 9/11/15.
//  Copyright (c) 2015 JuanxAne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductTableProtocol.h"
#import "DBModel.h"

@interface Yeast : NSObject <ProductTableProtocol>

@property (nonatomic) NSInteger code;
@property (nonatomic) NSString* name;

#pragma mark - ProductTableProtocol

- (NSString*)getTitle;
- (NSString*)getDetail;

#pragma mark - DataBase

+(NSMutableArray *) yeastsInDataBase:(sqlite3 *) database;


@end
