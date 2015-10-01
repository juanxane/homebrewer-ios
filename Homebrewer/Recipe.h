//
//  Recipe.h
//  Homebrewer
//
//  Created by Juanx Ane on 9/10/15.
//  Copyright (c) 2015 JuanxAne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Recipe : NSObject

@property (nonatomic) NSInteger code;

@property (nonatomic) NSInteger batchSize;

@property (nonatomic) NSString* style;
@property (nonatomic) NSString* name;
@property (nonatomic) NSInteger IBU;
@property (nonatomic) NSInteger DO;
@property (nonatomic) NSInteger DF;
@property (nonatomic) NSInteger ALC;
@property (nonatomic) NSInteger SRM;

@property (nonatomic) NSString* yeast;

@property (nonatomic) NSDate* date_brew;
@property (nonatomic) NSDate* date_trasvase;
@property (nonatomic) NSDate* date_bottled;

@property (nonatomic) NSMutableArray* grains;
@property (nonatomic) NSMutableArray* hops;







@end
