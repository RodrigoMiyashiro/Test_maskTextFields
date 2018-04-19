//
//  Mask.m
//  Pernambucanas
//
//  Created by Eder Baldrighi on 08/09/16.
//  Copyright © 2016 Kanamobi. All rights reserved.
//

#import "Mask.h"

@implementation Mask

+ (NSString *)setCPFMask:(NSString *)cpf isBackspace:(BOOL)isBackspace {
    
    if (isBackspace == FALSE) {
        
        NSString *cleanCPF = cpf;
        cleanCPF = [cleanCPF stringByReplacingOccurrencesOfString:@"." withString:@""];
        cleanCPF = [cleanCPF stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        NSMutableString *maskedCPF = [[NSMutableString alloc] initWithString:cleanCPF];
        
        if (maskedCPF.length == 11) {
            
            [maskedCPF insertString:@"." atIndex:3];
            [maskedCPF insertString:@"." atIndex:7];
            [maskedCPF insertString:@"-" atIndex:11];
            
        } else if (maskedCPF.length >= 9) {
            
            [maskedCPF insertString:@"." atIndex:3];
            [maskedCPF insertString:@"." atIndex:7];
            [maskedCPF insertString:@"-" atIndex:11];
            
        } else if (maskedCPF.length >= 6) {
            
            [maskedCPF insertString:@"." atIndex:3];
            [maskedCPF insertString:@"." atIndex:7];
            
        } else if (maskedCPF.length >= 3) {
            
            [maskedCPF insertString:@"." atIndex:3];
        }
        
        return maskedCPF;
    }
    
    return cpf;
}

+ (NSString *)setCellPhoneMask:(NSString *)cellPhone isBackspace:(BOOL)isBackspace {
    
    NSString *cleanCellPhone = cellPhone;
    cleanCellPhone = [cleanCellPhone stringByReplacingOccurrencesOfString:@"(" withString:@""];
    cleanCellPhone = [cleanCellPhone stringByReplacingOccurrencesOfString:@")" withString:@""];
    cleanCellPhone = [cleanCellPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    cleanCellPhone = [cleanCellPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
    cleanCellPhone = [cleanCellPhone stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSInteger cleanCellPhoneLenght = cleanCellPhone.length;
    
    NSMutableString *maskedCellPhone = [[NSMutableString alloc] initWithString:cleanCellPhone];
    
    if (isBackspace == FALSE) {
        
        if (cleanCellPhoneLenght >= 10) {
            
            [maskedCellPhone insertString:@"(" atIndex:0];
            [maskedCellPhone insertString:@")" atIndex:3];
            [maskedCellPhone insertString:@" " atIndex:4];
            [maskedCellPhone insertString:@"-" atIndex:10];
            
        } else if (cleanCellPhoneLenght >= 6) {
            
            [maskedCellPhone insertString:@"(" atIndex:0];
            [maskedCellPhone insertString:@")" atIndex:3];
            [maskedCellPhone insertString:@" " atIndex:4];
            [maskedCellPhone insertString:@"-" atIndex:9];
            
        } else if (cleanCellPhoneLenght >= 2) {
            
            [maskedCellPhone insertString:@"(" atIndex:0];
            [maskedCellPhone insertString:@")" atIndex:3];
            [maskedCellPhone insertString:@" " atIndex:4];
            
        } else if (cleanCellPhoneLenght >= 0) {
            
            [maskedCellPhone insertString:@"(" atIndex:0];
        }
        
        return maskedCellPhone;
        
    } else if ((isBackspace == TRUE) && (cleanCellPhoneLenght == 11)) {
        
        [maskedCellPhone insertString:@"(" atIndex:0];
        [maskedCellPhone insertString:@")" atIndex:3];
        [maskedCellPhone insertString:@" " atIndex:4];
        [maskedCellPhone insertString:@"-" atIndex:9];
        
        return maskedCellPhone;
    }
    
    return cellPhone;
}

+ (NSString *)setBirthDateMask:(NSString *)birthDate isBackspace:(BOOL)isBackspace {
    
    NSString *cleanBirthDate = [birthDate stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    NSInteger cleanBirthDateLenght = cleanBirthDate.length;
    
    NSMutableString *maskedBirthDate = [[NSMutableString alloc] initWithString:cleanBirthDate];
    
    if (isBackspace == FALSE) {
        
        if (cleanBirthDateLenght >= 4) {
            
            [maskedBirthDate insertString:@"/" atIndex:2];
            [maskedBirthDate insertString:@"/" atIndex:5];
            
        } else if (cleanBirthDateLenght >= 2) {
            
            [maskedBirthDate insertString:@"/" atIndex:2];
        }
        
        return maskedBirthDate;
    }
    
    return birthDate;
}

+ (NSString *)setBrazilianZipcodeMask:(NSString *)zipcode isBackspace:(BOOL)isBackspace {
    
    NSMutableString *mutableZipcode = [[NSMutableString alloc] initWithString:zipcode];
    
    if (mutableZipcode.length > 5) {
        [mutableZipcode insertString:@"-" atIndex:5];
    }
    
    return mutableZipcode;
}

@end
