//
//  DBModel.m
//  Homebrewer
//
//  Created by Juanx Ane on 9/11/15.
//  Copyright (c) 2015 JuanxAne. All rights reserved.
//

#import "DBModel.h"

//Statics
static sqlite3 *database = nil;
static NSString *databaseName = @"HomeBrewerDB.sqlite";
static NSString * documentsDirectory;

@implementation DBModel



+(sqlite3 *) database
{
    if(database == nil){
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsDirectory = [paths objectAtIndex:0];
        
        [DBModel copyDatabaseIntoDocumentsDirectory];
        
        NSString * databasePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, databaseName];
        const char *dbpath = [databasePath UTF8String];
        
        //open database
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            //ok, its opened
            NSString * sd = @"sadas";
        }
    }
    return database;
}

+(void)copyDatabaseIntoDocumentsDirectory{
    // Check if the database file exists in the documents directory.
    NSString *destinationPath = [documentsDirectory stringByAppendingPathComponent:databaseName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        // The database file does not exist in the documents directory, so copy it from the main bundle now.
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        // Check if any error occurred during copying and display it.
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
}


@end
