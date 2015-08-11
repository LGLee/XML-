//
//  LGVideo.h
//  复杂json解析(视频播放)
//
//  Created by MacBookPro on 15/8/11.
//  Copyright (c) 2015年 sky5156. All rights reserved.
//video模型

#import <Foundation/Foundation.h>

@interface LGVideo : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;

/** image */
@property (nonatomic, copy) NSString *image;

/** length */
@property (nonatomic, copy) NSString *length;

/** name */
@property (nonatomic, copy) NSString *name;

/** url */
@property (nonatomic, copy) NSString *url;


+ (instancetype)videoWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
