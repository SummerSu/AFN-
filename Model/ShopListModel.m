//
//  ShopListModel.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/6/26.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "ShopListModel.h"


@implementation ShopListModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}


+ (ShopListModel *)modelWithDic:(NSDictionary *)dic{
    
    return [[ShopListModel alloc]initWithDic:dic];
    
}


+ (void)getShopListDatasWithUrl:(NSString *)url parameters:(NSDictionary *)parameters andBlock:(void (^)(NSArray *, NSError *))block{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];

    [AFRequest GetRequestWithUrl:BDUrl_location parameters:parameters andBlock:^(NSDictionary * Datas, NSError *error) {
        
        if (error == nil) {
            NSArray *contents = Datas[@"contents"];
            for (NSDictionary *dic in contents) {
                ShopListModel *model = [self modelWithDic:dic];
                
                [array addObject:model];
            }
            block(array, nil);
        } else {
            block([NSArray array], error);
        }
    }];
}


- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@", key);
}

@end
