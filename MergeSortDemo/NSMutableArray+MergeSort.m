//
//  NSMutableArray+MergeSort.m
//  MergeSortDemo
//
//  Created by Cole Bratcher on 5/21/14.
//  Copyright (c) 2014 Cole Bratcher. All rights reserved.
//

#import "NSMutableArray+MergeSort.h"

@implementation NSMutableArray (MergeSort)


-(NSMutableArray *)mergeSort
{
    return [[self mergeSort:self]mutableCopy];
}

-(NSArray *)mergeSort:(NSArray *)unsortedArray
{
    if ([unsortedArray count] < 2) {
        return unsortedArray;
    }
    
    long middle = ([unsortedArray count]/2);
    NSRange left = NSMakeRange(0, middle);
    NSRange right = NSMakeRange(middle, ([unsortedArray count] - middle));
    NSArray *rightArr = [unsortedArray subarrayWithRange:right];
    NSArray *leftArr = [unsortedArray subarrayWithRange:left];
    
    //Or iterate through the unsortedArray and create your left and right array
    //for left array iteration starts at index =0 and stops at middle, for right array iteration starts at midde and end at the end of the unsorted array
    NSArray *resultArray =[self merge:[self mergeSort:leftArr] andRight:[self mergeSort:rightArr]];
    return resultArray;
}

-(NSArray *)merge:(NSArray *)leftArr andRight:(NSArray *)rightArr
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    int right = 0;
    int left = 0;
    while (left < [leftArr count] && right < [rightArr count]) {
        if ([[leftArr objectAtIndex:left] intValue] < [[rightArr objectAtIndex:right] intValue]) {
            [result addObject:[leftArr objectAtIndex:left++]];
        } else {
            [result addObject:[rightArr objectAtIndex:right++]];
        }
    }
    
    NSRange leftRange = NSMakeRange(left, ([leftArr count] - left));
    NSRange rightRange = NSMakeRange(right, ([rightArr count] - right));
    NSArray *newRight = [rightArr subarrayWithRange:rightRange];
    NSArray *newLeft = [leftArr subarrayWithRange:leftRange];
    newLeft = [result arrayByAddingObjectsFromArray:newLeft];
    return [newLeft arrayByAddingObjectsFromArray:newRight];
}

@end
