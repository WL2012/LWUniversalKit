//
//  UniNetworkManager.m
//  LWUniversalKit
//
//  Created by Liang Wang (QXW7463) on 2020/12/17.
//

#import "UniNetworkManager.h"
#import "NSString+extension.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "YYModel.h"

@implementation UniNetworkManager

static UniNetworkManager *requestInterface = nil;

+ (UniNetworkManager *)sharedInstance {
    @synchronized([UniNetworkManager class]) {
        if (requestInterface == nil) {
            requestInterface = [[self alloc] init] ;
        }
    }
    return requestInterface ;
}

+ (id)alloc {
    @synchronized([UniNetworkManager class]) {
        if (requestInterface == nil) {
            requestInterface = [super alloc];
            return requestInterface;
        }
    }
    return nil;
}


+ (void)RequestDataWithParaters:(PMBaseParams *)paraters successBlock:(RequestSuccessBlock)successHandler errorBlock:(RequestErrorBlock)errorHandler {
    NSString *requestURL = [NSString stringWithFormat:@"%@restservices",TEST_ENV ? APPTEST_IP : APPSTORE_IP];
    NSString *username = @"dove_administrator";
    NSString *source = @"API";
    NSString *key = @"\"576F2D47851B7E045C30F941F6137CB1\"";
    NSDictionary *tempParaters = @{@"page":@{@"showCount":paraters.showCount,@"currentPage":paraters.currentPage,@"pd":paraters.pd}};
    NSString *jsonString =  [tempParaters yy_modelToJSONString];
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *encodeJsonString = [[jsonString md5] uppercaseString];
    DLog(@"请求参数===%@===%@===%@===%@",paraters.module,paraters.method,jsonString,encodeJsonString);
    NSDate* localDate = [NSDate date];
    NSTimeInterval interval=[localDate timeIntervalSince1970];
    NSString *timestamp = [NSString stringWithFormat:@"%ld", (long)interval*1000];
    NSString *signParams = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",username,paraters.module,paraters.method,encodeJsonString,timestamp,source,key];
    signParams = [signParams md5];
    NSDictionary *requestParaters = @{@"username":username,
                                      @"module":paraters.module,
                                      @"method":paraters.method,
                                      @"params":jsonString,
                                      @"source":source,
                                      @"timestamp":timestamp,
                                      @"sign":signParams
                                      };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager.requestSerializer setValue:kAppVersion forHTTPHeaderField:@"app-version"];
    [manager.requestSerializer setValue:@"liewu" forHTTPHeaderField:@"app-source"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"app-device"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager POST:requestURL parameters:requestParaters headers:manager.requestSerializer.HTTPRequestHeaders
         progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"respCode"] integerValue] == 0) {
            NSString *jsonString = [responseObject objectForKey:@"respData"];
            NSDictionary *dictionary = [self dictionaryWithJsonString:jsonString];
            DLog(@"Response:%@======%@====%@",requestParaters,paraters.method, dictionary);
            successHandler(dictionary, nil);
        }
        else {
            successHandler(nil, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorHandler(error);
    }];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSDictionary *)SignParaters: (NSDictionary *)paraters {
    NSString *localKey = @"CD6H8ZKKMFQP70KXUXY32PK4S8W5LQDNNGTRIQWKBHG6D5HTMFQ32MSNFKZVE075";
    NSDate* localDate = [NSDate date];
    NSTimeInterval interval=[localDate timeIntervalSince1970];
    NSString *timestamp = [NSString stringWithFormat:@"%ld", (long)interval*1000];
    NSMutableDictionary *mParaters = [NSMutableDictionary dictionaryWithDictionary:paraters];
    [mParaters setObject:timestamp forKey:@"timestamp"];
    NSMutableArray *paratersArray = [NSMutableArray array];
    [mParaters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (![NSString isNullOrEmpty:[NSString stringWithFormat:@"%@",obj]] && ![@"act" isEqualToString:key]) {
            [paratersArray addObject:key];
        }
    }];
    
    //对比字段参数的大小然后排序
    NSArray * array = [[NSArray alloc] initWithArray:paratersArray];
    NSStringCompareOptions comparisonOptions =NSCaseInsensitiveSearch|NSNumericSearch|NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    //根据ASCII排序
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range =NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray *resultArray2 = [array sortedArrayUsingComparator:sort];
    //原始数据
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    for (NSString *keyString in array) {
        [dic setObject:[mParaters objectForKey:keyString] forKey:keyString];
    }
    //拼接串   key1=value1
    NSMutableArray * arraya = [[NSMutableArray alloc] init];
    NSString * Sign = [[NSString alloc]init];
    for (int i =0; i < resultArray2.count; i++) {
        NSString * Signa = [NSString stringWithFormat:@"%@=%@",[resultArray2 objectAtIndex:i],[dic objectForKey:[resultArray2 objectAtIndex:i]]];
        [arraya addObject:Signa];
    }
    // 原始 格式 sign = key1=value1&key2=value2&....
    for (int i =0; i < arraya.count; i++) {
        Sign = [NSString stringWithFormat:@"%@&%@",Sign,[arraya objectAtIndex:i]];
    }
    if (Sign.length > 0) {
        Sign =  [Sign substringFromIndex:1];
    }
    Sign = [NSString stringWithFormat:@"%@&key=%@",Sign, localKey];
    Sign = [[Sign md5] uppercaseString];
    [mParaters setObject:Sign forKey:@"sign"];
    return mParaters;
}

@end
