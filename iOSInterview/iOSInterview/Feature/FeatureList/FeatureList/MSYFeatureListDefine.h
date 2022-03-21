//
//  MSYFeatureListDefine.h
//  iOSInterview
//
//  Created by Simon Miao on 2022/3/1.
//

#ifndef MSYFeatureListDefine_h
#define MSYFeatureListDefine_h

static NSString *const kSecFeature_SQL = @"数据库";
static NSString *const kRowFeature_databaseFileEncrpt = @"数据库文件加密";
//static NSString *const kRowFeature_SQL = @"数据库加密";

static NSString *const kSecFeature_iCloud = @"iCloud";
static NSString *const kRowFeature_iCloud_keyValue = @"iCloud keyValue存储";
static NSString *const kRowFeature_iCloud_document = @"iCloud document";
static NSString *const kRowFeature_iCloud_cloudKit = @"cloud kit";

static NSString *const kSecFeature_background = @"App 后台处理";
static NSString *const kRowFeature_backgroundKeepAlive = @"App 后台保活";

static NSString *const kSecFeature_image = @"图像处理";
static NSString *const kRowFeature_imageSynthesis = @"图像合成";
static NSString *const kRowFeature_watermark = @"图像水印";
static NSString *const kRowFeature_imageCorner = @"图像圆角";

#endif /* MSYFeatureListDefine_h */
