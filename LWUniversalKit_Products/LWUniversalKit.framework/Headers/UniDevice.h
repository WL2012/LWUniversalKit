//
//  UniDevice.h
//  LWUniversalKit
//
//  Created by Liang Wang (QXW7463) on 2020/12/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UniDevice : NSObject

+ (BOOL)iPhoneXSeries;

+ (BOOL)iPhone12Mini;

+ (NSString *)deviceType;

+ (NSString*)UUIDString;

@end

NS_ASSUME_NONNULL_END
