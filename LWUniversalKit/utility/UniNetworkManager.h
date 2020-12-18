//
//  UniNetworkManager.h
//  LWUniversalKit
//
//  Created by Liang Wang (QXW7463) on 2020/12/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UniNetworkManager : NSObject

@end

NS_ASSUME_NONNULL_END

#import <Foundation/Foundation.h>
#import "UniMacro.h"
#import "PMBaseParams.h"

static BOOL TEST_ENV = YES;
static NSString *APPTEST_IP = @"http://47.101.195.63:8080/rest-services/";
static NSString *APPSTORE_IP = @"http://47.101.20.110:8080/rest-services/";


typedef void (^RequestSuccessBlock) (id responseObject, NSDictionary *userInfo);
typedef void (^RequestErrorBlock) (NSError *error);

@interface UniNetworkManager()

+ (UniNetworkManager *)sharedInstance;

+ (void)RequestDataWithParaters:(PMBaseParams *)paraters successBlock:(RequestSuccessBlock)successHandler errorBlock:(RequestErrorBlock)errorHandler;

@end

