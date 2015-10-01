//
//  Hop.m
//  Homebrewer
//
//  Created by Juanx Ane on 9/11/15.
//  Copyright (c) 2015 JuanxAne. All rights reserved.
//

#import "Hop.h"

@implementation Hop

-(BOOL)isEqual:(id)object {
    Hop * gr = (Hop*) object;
    return [gr.name isEqualToString:self.name];
}

#pragma ProductTableProtocol

- (NSString*)getTitle {
    return _name;
}
- (NSString*)getDetail {
    return [NSString stringWithFormat:@"%.f %", _AA ];
}

+(NSMutableArray *) hopsInDataBase:(sqlite3 *) database
{
    NSMutableArray *response = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    
    //call table
    NSString * querySQL = @"SELECT name, id_hop, AA FROM hops ORDER BY AA";
    const char * query_stmt = [querySQL UTF8String];
    
    if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            
            Hop * hop = [[Hop alloc] init];
            
            const char * name = (const char *) sqlite3_column_text(statement,  0);
            if(name) hop.name = [[NSString alloc] initWithUTF8String:name];
            
            hop.code =  sqlite3_column_int(statement,  1);
            hop.AA =  sqlite3_column_double(statement,  2);
            
            [response addObject:hop];
        }
        
        sqlite3_finalize(statement);
    }
    
    return response;
}

+(NSMutableArray *) hopsForRecipe:(NSInteger) recipe_code InDataBase:(sqlite3 *) database
{
    NSMutableArray *response = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    
    //call table
    NSString * querySQL = @"SELECT H.name, H.id_hop, RH.amount, RH.time, H.AA FROM Hops H  LEFT JOIN Recipe_Hops RH on (RH.id_hop = H.id_hop) ORDER BY RH.time DESC";
    const char * query_stmt = [querySQL UTF8String];
    
    if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            
            Hop * hop = [[Hop alloc] init];
            
            const char * name = (const char *) sqlite3_column_text(statement,  0);
            if(name) hop.name = [[NSString alloc] initWithUTF8String:name];
            
            hop.code =  sqlite3_column_int(statement,  1);
            hop.amount =  sqlite3_column_double(statement, 2);
            hop.time =  sqlite3_column_int(statement,  3);
            hop.AA =  sqlite3_column_double(statement,  4);
            
            [response addObject:hop];
        }
        
        sqlite3_finalize(statement);
    }
    
    return response;
}


@end
