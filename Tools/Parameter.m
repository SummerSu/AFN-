//
//  Parameter.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/7/8.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "Parameter.h"


@interface Parameter()


@end

@implementation Parameter

+ (NSDictionary *)getLocationShopListWithCityID:(NSString *)city{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
    [dic setObject:@"GWIL5qn0nLqf8f03Kvr3HLVp" forKey:@"ak"];//百度地图key
    [dic setObject:@"89546" forKey:@"geotable_id"];//地图id
    [dic setObject:@"1" forKey:@"page_index"];//页码
    [dic setObject:@"20" forKey:@"page_size"];//单页条目
    [dic setObject:@"distance:1" forKey:@"sortby"];//按距离排序 1表示升序
    [dic setObject:city forKey:@"region"];//城市
    return dic;
}





@end
