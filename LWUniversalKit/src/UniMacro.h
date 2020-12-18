//
//  UniMacro.h
//  LWUniversalKit
//
//  Created by Liang Wang (QXW7463) on 2020/12/17.
//

#import "UniDevice.h"

#ifndef UniMacro_h
#define UniMacro_h

#ifndef iOSVersion
#define iOSVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
#endif

#ifndef iOS6
#define iOS6 (iOSVersion >= 6.0 && iOSVersion < 7.0)
#endif

#ifndef iOS6_OR_LATER
#define iOS6_OR_LATER iOSVersion >= 6.0
#endif

#ifndef iOS7
#define iOS7 (iOSVersion >= 7.0 && iOSVersion < 8.0)
#endif

#ifndef iOS7_OR_LATER
#define iOS7_OR_LATER iOSVersion >= 7.0
#endif

#ifndef iOS8
#define iOS8 (iOSVersion >= 8.0 && iOSVersion < 9.0)
#endif

#ifndef iOS8_OR_LATER
#define iOS8_OR_LATER iOSVersion >= 8.0
#endif

#ifndef iOS9
#define iOS9 (iOSVersion >= 9.0 && iOSVersion < 10.0)
#endif

#ifndef iOS9_OR_LATER
#define iOS9_OR_LATER iOSVersion >= 9.0
#endif

#ifndef iOS10
#define iOS10 (iOSVersion >= 10.0 && iOSVersion < 11.0)
#endif

#ifndef iOS10_OR_LATER
#define iOS10_OR_LATER iOSVersion >= 10.0
#endif

#ifndef iOS11
#define iOS11 (iOSVersion >= 11.0 && iOSVersion < 12.0)
#endif

#ifndef iOS11_OR_LATER
#define iOS11_OR_LATER iOSVersion >= 11.0
#endif

#ifndef iOS12
#define iOS12 (iOSVersion >= 12.0 && iOSVersion < 13.0)
#endif

#ifndef iOS12_OR_LATER
#define iOS12_OR_LATER iOSVersion >= 12.0
#endif

#ifndef iOS13_OR_LATER
#define iOS13_OR_LATER iOSVersion >= 13.0
#endif

#ifndef iOS14_OR_LATER
#define iOS14_OR_LATER iOSVersion >= 14.0
#endif

#define kKeyWindow (iOS13_OR_LATER ? [UIApplication sharedApplication].windows[0]:[[UIApplication sharedApplication] keyWindow])

#ifndef kDeviceScale
#define kDeviceScale ([[UIScreen mainScreen] scale])
#endif

#ifndef kDeviceWidth
#define kDeviceWidth ([[UIScreen mainScreen] bounds].size.width)
#endif

#ifndef kDeviceHeight
#define kDeviceHeight ([[UIScreen mainScreen] bounds].size.height)
#endif

#ifndef kStatusBarHeight
#define kStatusBarHeight ([UniDevice iPhoneXSeries] ? 44.0 : 20.0)
#endif

#ifndef kBottomHomeHeight
#define kBottomHomeHeight ([UniDevice iPhoneXSeries] ? 34.0 : 0.0)
#endif

#ifndef kNavHeight
#define kNavHeight ([UniDevice iPhoneXSeries] ? ([UniDevice iPhone12Mini] ? 94.0 : 88.0) : 64.0)

#endif

#ifndef kTabbarHeight
#define kTabbarHeight ([UniDevice iPhoneXSeries] ? 83.0 : 49.0)
#endif

#ifndef kScreenContentHeight
#define kScreenContentHeight (kDeviceHeight - kNavHeight - kTabbarHeight)
#endif

#ifndef kScreenSafeAreaHeight
#define kScreenSafeAreaHeight (kDeviceHeight - kStatusBarHeight - kBottomHomeHeight)
#endif


#ifndef kAppFrame
#define kAppFrame [[UIScreen mainScreen] applicationFrame]
#endif

#ifndef kAppBounds
#define kAppBounds [[UIScreen mainScreen] bounds]
#endif

#ifndef kAppScale
#define kAppScale [[UIScreen mainScreen] scale]
#endif


#ifndef kRGB
#define kRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#endif

#ifndef kRGBA
#define kRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#endif

#define kHRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kHRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#define kRandomColor (kRGB(arc4random()%255, arc4random()%255, arc4random()%255))
#define kRandomColorA(alpha) (kRGBA(arc4random()%255, arc4random()%255, arc4random()%255, alpha))

#ifndef kAppVersion
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#endif

#ifndef kAppIdentifier
#define kAppIdentifier [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"]
#endif

#ifndef kAppBuild
#define kAppBuild [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#endif

#ifndef kAppName
#define kAppName [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"]
#endif


#define kFont(fsize, name) [UIFont fontWithName:name size:fsize]
#define kAppFont(size) [UIFont systemFontOfSize:size]
#define kAppFontBold(size) [UIFont boldSystemFontOfSize:size]

#define kOpenURL(url) if(iOS10_OR_LATER) {[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];\
}else {[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];\
}

#define kCanOpenURL(url) [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]

#define canTel                 kCanOpenURL(@"tel:")
#define tel(phoneNumber)       kOpenURL(([NSString stringWithFormat:@"tel:%@",phoneNumber]))
#define telprompt(phoneNumber) kOpenURL(([NSString stringWithFormat:@"telprompt:%@",phoneNumber]))

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define DLogFrame(rect) DLog(@"x:%f, y: %f, w: %f, h: %f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#else
#define DLog(...)
#define DLogFrame(rect)
#endif

#ifndef kDeviceWidthScaleToiPhone6
#define kDeviceWidthScaleToiPhone6 (kDeviceWidth/375.0)
#endif

#define kAdaptFont(fsize, name) [UIFont fontWithName:name size:fsize*kDeviceWidthScaleToiPhone6]
#define kAppAdaptFont(size) [UIFont systemFontOfSize:size*kDeviceWidthScaleToiPhone6]
#define kAppAdaptFontBold(size) [UIFont boldSystemFontOfSize:size*kDeviceWidthScaleToiPhone6]

#define kAppAdaptHeight(height) (((NSInteger)((height) * kDeviceWidthScaleToiPhone6 * kAppScale)) / kAppScale)
#define kAppAdaptWidth(width) (((NSInteger)((width) * kDeviceWidthScaleToiPhone6 * kAppScale)) / kAppScale)

#define kAppSepratorLineHeight (1.0 / kAppScale)

#define kUserDefaultSetObjectForKey(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

#define kUserDefaultObjectForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]

#define kNotificationCenter [NSNotificationCenter defaultCenter]

#endif 

