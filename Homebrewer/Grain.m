//
//  Grain.m
//  Homebrewer
//
//  Created by Juanx Ane on 9/11/15.
//  Copyright (c) 2015 JuanxAne. All rights reserved.
//

#import "Grain.h"

@implementation Grain


#pragma ProductTableProtocol

- (NSString*)getTitle {
    return _name;
}
- (NSString*)getDetail {
    return @"";
}


-(BOOL)isEqual:(id)object {
    Grain * gr = (Grain*) object;
    return [gr.name isEqualToString:self.name];
}

+(NSMutableArray *) grainsInDataBase:(sqlite3 *) database
{
    NSMutableArray *response = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    
    //call table
    NSString * querySQL = @"SELECT name, id_grain FROM grain ORDER BY name";
    const char * query_stmt = [querySQL UTF8String];
    
    if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            
            Grain * grain = [[Grain alloc] init];
            
            const char * name = (const char *) sqlite3_column_text(statement,  0);
            if(name) grain.name = [[NSString alloc] initWithUTF8String:name];
            
            grain.code =  sqlite3_column_int(statement,  1);
            
            [response addObject:grain];
        }
        
        sqlite3_finalize(statement);
    }
    
    return response;
}

+(NSMutableArray *) grainsForRecipe:(NSInteger) recipe_code InDataBase:(sqlite3 *) database
{
    NSMutableArray *response = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    
    //call table
    NSString * querySQL = @"SELECT G.name, G.id_grain, RG.amount FROM Grain G  LEFT JOIN Recipe_Grains RG  on (RG.id_grain = G.id_grain) ORDER BY RG.amount";
    const char * query_stmt = [querySQL UTF8String];
    
    if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            
            Grain * grain = [[Grain alloc] init];
            
            const char * name = (const char *) sqlite3_column_text(statement,  0);
            if(name) grain.name = [[NSString alloc] initWithUTF8String:name];
            
            grain.code =  sqlite3_column_int(statement,  1);
            grain.amount =  sqlite3_column_double(statement, 2);
            
            [response addObject:grain];
        }
        
        sqlite3_finalize(statement);
    }
    
    return response;
}

@end
