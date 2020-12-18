//
//  PMBaseParams.h
//  LWUniversalKit
//
//  Created by Liang Wang (QXW7463) on 2020/12/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PMBaseParams : NSObject

@property (nonatomic, copy) NSString *module;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, copy) NSString *showCount;
@property (nonatomic, copy) NSString *currentPage;
@property (nonatomic, strong) NSDictionary *pd;

+ (instancetype)initWithModule: (NSString *)module method: (NSString *)method AndParams: (NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
