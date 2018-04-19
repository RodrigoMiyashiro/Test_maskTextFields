//
//  Mask.h
//  Pernambucanas
//
//  Created by Eder Baldrighi on 08/09/16.
//  Copyright © 2016 Kanamobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mask : NSObject

+ (NSString *)setCPFMask:(NSString *)cpf isBackspace:(BOOL)isBackspace;
+ (NSString *)setCellPhoneMask:(NSString *)cellPhone isBackspace:(BOOL)isBackspace;
+ (NSString *)setBirthDateMask:(NSString *)birthDate isBackspace:(BOOL)isBackspace;
+ (NSString *)setBrazilianZipcodeMask:(NSString *)zipcode isBackspace:(BOOL)isBackspace;

@end
