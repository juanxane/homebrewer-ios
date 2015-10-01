//
//  ProductTableViewController.h
//  Homebrewer
//
//  Created by Juanx Ane on 9/11/15.
//  Copyright (c) 2015 JuanxAne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTableViewController : UITableViewController <UITextFieldDelegate>


-(void) setProducts:(NSArray*)products;

+(NSString *) viewName;

@end
