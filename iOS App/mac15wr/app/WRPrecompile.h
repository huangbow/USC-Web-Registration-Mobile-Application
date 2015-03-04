//
//  WRPrecompile.h
//  mac15wr
//
//  Created by zwein on 2/8/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//


// ----------------------------------
// Option Values
// ----------------------------------

#pragma mark - Option Values

#undef	__ON__
#define __ON__		(1)

#undef	__OFF__
#define __OFF__		(0)

#undef	__AUTO__

#if defined (DEBUG) && (DEBUG == 1)
#define __AUTO__	(1)
#else
#define __AUTO__	(0)
#endif  // #if defined(_DEBUG) || defined(DEBUG)

// ----------------------------------
// Global Compile Option
// ----------------------------------

#pragma mark - Global Compile Option

#define __WR_LOG__						(__AUTO__)



//#undef	ISNULLVALUE
//#define ISNULLVALUE( __value ) \
//__value?1:0


//#if defined(__WR_LOG__) && __WR_LOG__
//#undef	NSLog
//#define	NSLog	WRLog
//#endif	// #if (__ON__ == __WR_LOG__)
