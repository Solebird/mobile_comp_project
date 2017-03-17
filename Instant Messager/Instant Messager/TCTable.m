//
//  TCTable.m
//
//  Created by Thomas Cheung on 17/10/2016.
//  Copyright © 2016 Thomas Cheung. All rights reserved.
//

#import "TCTable.h"

@implementation TCTable

@synthesize table, record, count;

-(instancetype)init{
    self = [super init];
    table = [[NSMutableArray alloc] init];
    record = [[NSMutableArray alloc] init];
    count = 0;
    return self;
}

-(void)addRecord:(id)obj,...{
    NSMutableArray *newRecord = [[NSMutableArray alloc] init];
    id eachObj;
    va_list argumentList;
    if (obj){
        [newRecord addObject: obj];
        va_start(argumentList, obj);
        while ((eachObj = va_arg(argumentList, id))){
            [newRecord addObject: eachObj];
        }
        va_end(argumentList);
    }
    [table insertObject:newRecord atIndex:[table count]];
    count++;
}

-(void)addEntireRecord:(NSMutableArray*)source_record{
    [table insertObject:source_record atIndex:[table count]];
    count++;
}

-(NSMutableArray*)getRecord:(long)index{
    if ([table count]>0)
        return [table objectAtIndex:index];
    return nil;
}

-(void)updateField:(int)field fromRow:(int)row withObject:(id)obj{
    NSMutableArray *theRecord = [table objectAtIndex:row];
    [theRecord replaceObjectAtIndex:field withObject:obj];
}

-(void)updateRecord:(int)row withObjects:(id)obj, ...{
    NSMutableArray *newRecord = [[NSMutableArray alloc] init];
    id eachObj;
    va_list argumentList;
    if (obj){
        [newRecord addObject: obj];
        va_start(argumentList, obj);
        while ((eachObj = va_arg(argumentList, id))){
            [newRecord addObject: eachObj];
        }
        va_end(argumentList);
    }
    [table replaceObjectAtIndex:row withObject:newRecord];
}

-(id)getObject:(int)col fromRow:(NSInteger)row{
    NSObject *obj = nil;
    if ([table count]>0){
        NSMutableArray *theRecord = [table objectAtIndex:(int)row];
        if ([theRecord count]>0)
        obj = [theRecord objectAtIndex:col];
    }
    return obj;
}

-(void)deleteRecordAtIndex:(int)index{
    for (int i=index; i<[table count]-1; i++) {
        [table replaceObjectAtIndex:i withObject:[table objectAtIndex:i+1]];
    }
    [table removeObjectAtIndex:[table count]-1];
    count = (int)[table count];
}

-(int)getRecordIndexOfObject:(NSString*)obj atIndex:(int)objIndex {
    int index = -1;
    for (int i=0; i<[table count]; i++) {
        NSMutableArray *_record = [table objectAtIndex:i];
        if ([[_record objectAtIndex:objIndex] isEqualToString:obj]) {
            index = i;
            break;
        }
    }
    return index;
}

-(void)printArray{
    for (NSMutableArray *array in table) {
        NSLog(@"%@",array);
    }
    NSLog(@"******");
}

@end
