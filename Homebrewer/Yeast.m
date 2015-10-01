//
//  Yeast.m
//  Homebrewer
//
//  Created by Juanx Ane on 9/11/15.
//  Copyright (c) 2015 JuanxAne. All rights reserved.
//

#import "Yeast.h"

@implementation Yeast


- (NSString*)getTitle {
    return _name;
}
- (NSString*)getDetail {
    return @"";
}

+(NSMutableArray *) yeastsInDataBase:(sqlite3 *) database
{
    NSMutableArray *response = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    
    //call table
    NSString * querySQL = @"SELECT name, id_yeast FROM yeast ORDER BY name";
    const char * query_stmt = [querySQL UTF8String];
    
    if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            
            Yeast * yeast = [[Yeast alloc] init];
            
            const char * name = (const char *) sqlite3_column_text(statement,  0);
            if(name) yeast.name = [[NSString alloc] initWithUTF8String:name];
            
            yeast.code =  sqlite3_column_int(statement,  1);
            
            [response addObject:yeast];
        }
        
        sqlite3_finalize(statement);
    }
    
    return response;
}

@end
