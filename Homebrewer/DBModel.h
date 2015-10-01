//
//  DBModel.h
//  Homebrewer
//
//  Created by Juanx Ane on 9/11/15.
//  Copyright (c) 2015 JuanxAne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBModel : NSObject


+(sqlite3 *) database;

+(void)copyDatabaseIntoDocumentsDirectory;
@end