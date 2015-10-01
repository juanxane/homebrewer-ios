//
//  Recipe.m
//  Homebrewer
//
//  Created by Juanx Ane on 9/10/15.
//  Copyright (c) 2015 JuanxAne. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe


-(instancetype) init {
   
    self.grains = [[NSMutableArray alloc] init];
    self.hops = [[NSMutableArray alloc] init];
    
    return self;
    
}

@end
