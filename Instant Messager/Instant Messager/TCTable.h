//
//  TCTable.h
//
//  Created by Thomas Cheung on 17/10/2016.
//  Copyright © 2016 Thomas Cheung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCTable : NSObject

@property NSMutableArray *table;
@property NSMutableArray *record;
@property int count;

-(void)addRecord:(id)obj,...;
-(NSMutableArray*)getRecord:(int)index;
-(void)updateField:(int)field fromRow:(int)row withObject:(id)obj;
-(void)updateRecord:(int)row withObjects:(id)obj,... ;
-(id)getObject:(int)col fromRow:(NSInteger)row;
-(void)deleteRecordAtIndex:(int)index;
-(int)getRecordIndexOfObject:(NSString*)obj atIndex:(int)objIndex ;
-(void)printArray;

@end
