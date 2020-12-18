//
//  PMBaseParams.m
//  LWUniversalKit
//
//  Created by Liang Wang (QXW7463) on 2020/12/17.
//

#import "PMBaseParams.h"

@implementation PMBaseParams

+ (instancetype)initWithModule: (NSString *)module method: (NSString *)method AndParams: (NSDictionary *)params {
    PMBaseParams *p = [[PMBaseParams alloc] init];
    p.module = module;
    p.method = method;
    p.currentPage = @"1";
    p.showCount = @"20";
    p.pd = params;
    return p;
}

@end
