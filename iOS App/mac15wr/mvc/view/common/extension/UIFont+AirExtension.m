////
////  UIFont+AirExtension.m
////  Boodex
////
////  Created by zwein on 5/26/14.
////  Copyright (c) 2014 lzhteng. All rights reserved.
////
//
//
//#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
//
//#import "UIFont+AirExtension.h"
//
//#pragma mark -
//
//@interface UIFont(ThemePrivate)
//@end
//
//@implementation UIFont(Theme)
//
//static NSString * __fontName = nil;
//static NSString * __boldFontName = nil;
//static NSString * __italicFontName = nil;
//
//static NSMutableDictionary * __customFonts = nil;
//
//+ (void)swizzle
//{
//	static BOOL __swizzled = NO;
//	if ( NO == __swizzled )
//	{
//		Method method;
//		IMP implement;
//        
//		method = class_getClassMethod( [UIFont class], @selector(systemFontOfSize:) );
//		implement = class_getMethodImplementation( [UIFont class], @selector(mySystemFontOfSize:) );
//		method_setImplementation( method, implement );
//        
//		method = class_getClassMethod( [UIFont class], @selector(boldSystemFontOfSize:) );
//		implement = class_getMethodImplementation( [UIFont class], @selector(myBoldSystemFontOfSize:) );
//		method_setImplementation( method, implement );
//        
//		method = class_getClassMethod( [UIFont class], @selector(italicSystemFontOfSize:) );
//		implement = class_getMethodImplementation( [UIFont class], @selector(myItalicSystemFontOfSize:) );
//		method_setImplementation( method, implement );
//        
//		__swizzled = YES;
//	}
//}
//
//- (UIFont *)mySystemFontOfSize:(CGFloat)fontSize
//{
//	if ( __fontName && [__fontName length] )
//	{
//		if ( nil == __customFonts )
//		{
//			__customFonts = [[NSMutableDictionary alloc] init];
//		}
//		
//		UIFont * customFont = [__customFonts objectForKey:__fontName];
//		if ( nil == customFont )
//		{
//			customFont = [UIFont fontWithName:__fontName size:fontSize];
//			if ( customFont )
//			{
//				[__customFonts setObject:customFont forKey:__fontName];
//			}
//		}
//		
//		return customFont;
//	}
//	else
//	{
//		return [UIFont systemFontOfSize:fontSize];
//	}
//}
//
//- (UIFont *)myBoldSystemFontOfSize:(CGFloat)fontSize
//{
//	if ( __boldFontName && [__boldFontName length] )
//	{
//		if ( nil == __customFonts )
//		{
//			__customFonts = [[NSMutableDictionary alloc] init];
//		}
//		
//		UIFont * customFont = [__customFonts objectForKey:__boldFontName];
//		if ( nil == customFont )
//		{
//			customFont = [UIFont fontWithName:__boldFontName size:fontSize];
//			if ( customFont )
//			{
//				[__customFonts setObject:customFont forKey:__boldFontName];
//			}
//		}
//		
//		return customFont;
//	}
//	else
//	{
//		return [UIFont systemFontOfSize:fontSize];
//	}
//}
//
//- (UIFont *)myItalicSystemFontOfSize:(CGFloat)fontSize
//{
//	if ( __italicFontName && [__italicFontName length] )
//	{
//		if ( nil == __customFonts )
//		{
//			__customFonts = [[NSMutableDictionary alloc] init];
//		}
//		
//		UIFont * customFont = [__customFonts objectForKey:__italicFontName];
//		if ( nil == customFont )
//		{
//			customFont = [UIFont fontWithName:__italicFontName size:fontSize];
//			if ( customFont )
//			{
//				[__customFonts setObject:customFont forKey:__italicFontName];
//			}
//		}
//		
//		return customFont;
//	}
//	else
//	{
//		return [UIFont systemFontOfSize:fontSize];
//	}
//}
//
//+ (void)setFontName:(NSString *)name
//{
//	__fontName = name;
//	
//	[self swizzle];
//}
//
//+ (void)setBoldFontName:(NSString *)name
//{
//	__boldFontName = name;
//	
//	[self swizzle];
//}
//
//+ (void)setItalicFontName:(NSString *)name
//{
//	__italicFontName = name;
//	
//	[self swizzle];
//}
//
//+ (UIFont *)fontFromString:(NSString *)font
//{
//	UIFont * userFont = nil;
//	
//	NSArray * array = [font componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//	if ( 1 == array.count )
//	{
//		userFont = [UIFont systemFontOfSize:font.floatValue];
//	}
//	else
//	{
//		NSString * size = nil;
//		NSString * family = nil;
//		NSString * attribute = nil;
//		
//		if ( array.count >= 3 )
//		{
//			attribute = ((NSString *)[array objectAtIndex:2]).trim;
//		}
//		if ( array.count >= 2 )
//		{
//			NSString * temp = ((NSString *)[array objectAtIndex:1]).trim;
//			
//			NSComparisonResult result1 = [temp compare:@"bold" options:NSCaseInsensitiveSearch];
//			NSComparisonResult result2 = [temp compare:@"italic" options:NSCaseInsensitiveSearch];
//			
//			if ( NSOrderedSame == result1 || NSOrderedSame == result2 )
//			{
//				attribute = temp;
//			}
//			else
//			{
//				family = temp;
//			}
//		}
//		if ( array.count >= 1 )
//		{
//			size = ((NSString *)[array objectAtIndex:0]).trim;
//		}
//		
//		BOOL isSystem = YES;
//		BOOL isItalic = NO;
//		BOOL isBold = NO;
//		
//		if ( NSOrderedSame != [family compare:@"system" options:NSCaseInsensitiveSearch] )
//		{
//			isSystem = NO;
//		}
//		
//		if ( NSOrderedSame == [attribute compare:@"bold" options:NSCaseInsensitiveSearch] )
//		{
//			isBold = YES;
//		}
//		else if ( NSOrderedSame == [attribute compare:@"italic" options:NSCaseInsensitiveSearch] )
//		{
//			isItalic = YES;
//		}
//		
//		if ( isSystem )
//		{
//			if ( isBold )
//			{
//				userFont = [UIFont boldSystemFontOfSize:size.floatValue];
//			}
//			else if ( isItalic )
//			{
//				userFont = [UIFont italicSystemFontOfSize:size.floatValue];
//			}
//			else
//			{
//				userFont = [UIFont systemFontOfSize:size.floatValue];
//			}
//		}
//		else
//		{
//			userFont = [UIFont fontWithName:family size:size.floatValue];
//		}
//	}
//	
//	if ( nil == userFont )
//	{
//		userFont = [UIFont systemFontOfSize:12.0f];
//	}
//	
//	return userFont;
//}
//
//@end
//
//#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
