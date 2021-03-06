#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "OSSClient.h"
#import "OSSCompat.h"
#import "OSSLog.h"
#import "OSSModel.h"
#import "OSSNetworking.h"
#import "OSSService.h"
#import "OSSUtil.h"
#import "OSSXMLDictionary.h"
#import "OSSHTTPDNSCacheTable.h"
#import "OSSHTTPDNSMini.h"
#import "OSSHTTPDNSOrigin.h"
#import "OSSHTTPDNSTools.h"
#import "OSSBolts.h"
#import "OSSBoltsVersion.h"
#import "OSSCancellationToken.h"
#import "OSSCancellationTokenRegistration.h"
#import "OSSCancellationTokenSource.h"
#import "OSSDefines.h"
#import "OSSExecutor.h"
#import "OSSTask.h"
#import "OSSTaskCompletionSource.h"

FOUNDATION_EXPORT double AliyunOSSiOSVersionNumber;
FOUNDATION_EXPORT const unsigned char AliyunOSSiOSVersionString[];

