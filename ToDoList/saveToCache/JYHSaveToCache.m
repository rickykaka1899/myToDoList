//
//  JYHSaveToCache.m
//  ToDoList
//
//  Created by Kaka on 8/20/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import "JYHSaveToCache.h"

@implementation JYHSaveToCache

+ (NSString *)localFilename;
{
  NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  NSString *filename = [Path stringByAppendingPathComponent:@"todolist.txt"];
  return filename;
}

+ (void)writeToFile:(id)content
{
    //返回值是BOOL，理论上应该有后续操作
  [NSKeyedArchiver archiveRootObject:content toFile:[self localFilename]];
}

+ (id)readFromFile
{
  return [NSKeyedUnarchiver unarchiveObjectWithFile:[self localFilename]];
}

@end
