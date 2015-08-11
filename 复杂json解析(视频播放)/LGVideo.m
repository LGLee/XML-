//
//  LGVideo.m
//  复杂json解析(视频播放)
//
//  Created by MacBookPro on 15/8/11.
//  Copyright (c) 2015年 sky5156. All rights reserved.
//

#import "LGVideo.h"

@implementation LGVideo

+ (instancetype)videoWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        //[self setValuesForKeysWithDictionary:dict];
       
        
        self.image = dict[@"image"];
        self.name = dict[@"name"];
        self.length = dict[@"length"];
        self.url = dict[@"url"];
        self.ID = dict[@"id"];
    }
    return self;
}

@end
