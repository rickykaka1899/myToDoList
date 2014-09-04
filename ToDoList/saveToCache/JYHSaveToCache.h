//
//  JYHSaveToCache.h
//  ToDoList
//
//  Created by Kaka on 8/20/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYHSaveToCache : NSObject

+ (void)writeToFile:(id)content;
+ (NSString *)localFilename;
+ (id)readFromFile;

@end
