/*
 * Copyright (c) 2010-2012 Matias Muhonen <mmu@iki.fi>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "MAWeekView.h"

#import "MAEvent.h"               /* MAEvent */
#import <QuartzCore/QuartzCore.h> /* CALayer */
#import "MAGridView.h"            /* MAGridView */
#import "TapDetectingView.h"      /* TapDetectingView */

static const unsigned int HOURS_IN_DAY                        = 24;
static const unsigned int DAYS_IN_WEEK                        = 7;
static const unsigned int MINUTES_IN_HOUR                     = 60;
static const unsigned int SPACE_BETWEEN_HOUR_LABELS           = 3;
static const unsigned int SPACE_BETWEEN_HOUR_LABELS_LANDSCAPE = 2;
static const unsigned int DEFAULT_LABEL_FONT_SIZE             = 10;
static const unsigned int VIEW_EMPTY_SPACE                    = 10;
static NSString *TEXT_WHICH_MUST_FIT                          = @"Noon123";

static NSString *TOP_BACKGROUND_IMAGE                         = @"ma_topBackground.png";
static NSString *LEFT_ARROW_IMAGE                             = @"ma_leftArrow.png";
static NSString *RIGHT_ARROW_IMAGE                            = @"ma_rightArrow.png";


#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]





@interface MAEventView : TapDetectingView <TapDetectingViewDelegate> {
	NSString *_title;
	UIColor *_textColor;
	UIFont *_textFont;
	MAWeekView *_weekView;
	MAEvent *_event;
	CGRect _textRect;
	size_t _xOffset;
	size_t _yOffset;
	CGPoint _touchStart;
	BOOL _wasDragged;
}

- (void)setupCustomInitialisation;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) MAWeekView *weekView;
@property (nonatomic, strong) MAEvent *event;
@property (nonatomic, assign) size_t xOffset;
@property (nonatomic, assign) size_t yOffset;

@end

@interface MAHourView : UIView {
	MAWeekView *_weekView;
	UIColor *_textColor;
	UIFont *_textFont;
}

- (BOOL)timeIs24HourFormat;

@property (nonatomic, strong) MAWeekView *weekView;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;

@end

@interface MAWeekdayBarView : UIView {
	MAWeekView *_weekView;
	NSDate *_week;
	UIColor *_textColor, *_sundayColor, *_todayColor;
	UIFont *_textFont;
	NSDateFormatter *_dateFormatter;
	NSMutableArray *_weekdays;
}

@property (nonatomic, strong) MAWeekView *weekView;
@property (nonatomic,copy) NSDate *week;
@property (nonatomic, strong) UIColor *textColor, *sundayColor, *todayColor;
@property (nonatomic, strong) UIFont *textFont;
@property (weak, readonly) NSDateFormatter *dateFormatter;
@property (readonly) NSArray *weekdays;

@end



@interface MAGridView (MAWeekViewAdditions)
- (void)addEventToOffset:(unsigned int)offset event:(MAEvent *)event weekView:(MAWeekView *)weekView;
@end

@interface MAWeekView (PrivateMethods)
- (void)setupCustomInitialisation;
- (void)changeWeek:(UIButton *)sender;
- (NSDate *)firstDayOfWeekFromDate:(NSDate *)date;
- (NSDate *)nextWeekFromDate:(NSDate *)date;
- (NSDate *)previousWeekFromDate:(NSDate *)date;
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer;


@property (readonly) MAGridView *gridView;
@property (readonly) UIScrollView *scrollView;
@property (readonly) UIFont *regularFont;
@property (readonly) UIFont *boldFont;
@property (readonly) MAHourView *hourView;
@property (readonly) MAWeekdayBarView *weekdayBarView;
@property (readonly) UISwipeGestureRecognizer *swipeLeftRecognizer;
@property (readonly) UISwipeGestureRecognizer *swipeRightRecognizer;
@property (readonly) NSString *titleText;
@end

@implementation MAWeekView

@synthesize labelFontSize=_labelFontSize;
@synthesize delegate=_delegate;
@synthesize eventDraggingEnabled;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		[self setupCustomInitialisation];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super initWithCoder:decoder]) {
		[self setupCustomInitialisation];
	}
	return self;
}

- (void)setupCustomInitialisation {
	self.labelFontSize = DEFAULT_LABEL_FONT_SIZE;
	self.eventDraggingEnabled = YES;
	self.week = [NSDate date];
	
	
	[self addSubview:self.weekdayBarView];
	
//	[self addSubview:self.scrollView];
	
	[self addSubview:self.hourView];
	[self addSubview:self.gridView];
	
//	[self.gridView addGestureRecognizer:self.swipeLeftRecognizer];
//	[self.gridView addGestureRecognizer:self.swipeRightRecognizer];
}

- (void)layoutSubviews {
	const CGSize sizeNecessary = [TEXT_WHICH_MUST_FIT sizeWithFont:self.regularFont];
	const CGSize sizeNecessaryBold = [TEXT_WHICH_MUST_FIT sizeWithFont:self.boldFont];
	
	unsigned int hourLabelSpacer;
	if (CGRectGetWidth(self.bounds) > CGRectGetHeight(self.bounds)) {
		hourLabelSpacer = SPACE_BETWEEN_HOUR_LABELS_LANDSCAPE;
	} else {
		hourLabelSpacer = SPACE_BETWEEN_HOUR_LABELS;
	}
	
	self.hourView.frame = CGRectMake(0,
									 25,
//									 sizeNecessary.width,
									 30,
									 sizeNecessary.height * HOURS_IN_DAY * hourLabelSpacer
                                     );
	
//	[self.hourView setNeedsDisplay];
	
	self.weekdayBarView.frame = CGRectMake(CGRectGetMaxX(self.hourView.bounds),
										5,
										CGRectGetWidth(self.gridView.bounds),
										sizeNecessaryBold.height+5
										   );
//	[self.weekdayBarView setNeedsDisplay];

//	self.scrollView.frame = CGRectMake(CGRectGetMinX(self.bounds),
//										0,
//									   CGRectGetWidth(self.bounds),
//									   CGRectGetHeight(self.bounds));
	
	self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds),
											  CGRectGetHeight(self.hourView.bounds) + VIEW_EMPTY_SPACE);
	
	self.gridView.frame = CGRectMake(CGRectGetMaxX(self.hourView.bounds),
                                     25,
									 CGRectGetWidth(self.bounds) - CGRectGetWidth(self.hourView.bounds),
									 CGRectGetHeight(self.bounds)-25);
    [self.gridView setNeedsDisplay];
}

- (UIScrollView *)scrollView {
	if (!_scrollView) {
		_scrollView = [[UIScrollView alloc] init];
		_scrollView.backgroundColor      = [UIColor whiteColor];
		_scrollView.scrollEnabled        = TRUE;
		_scrollView.alwaysBounceVertical = TRUE;
		_scrollView.canCancelContentTouches = NO;
	}
	return _scrollView;
}



- (MAHourView *)hourView {
	if (!_hourView) {
		_hourView = [[MAHourView alloc] init];
		_hourView.weekView        = self;
		_hourView.backgroundColor = [UIColor colorWithIntegerRed:251. green:198 blue:80. alpha:1];
		_hourView.textColor       = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.f];
		_hourView.textFont        = self.boldFont;
	}
	return _hourView;
}

- (MAWeekdayBarView *)weekdayBarView {
	if (!_weekdayBarView) {
		_weekdayBarView = [[MAWeekdayBarView alloc] init];
		_weekdayBarView.weekView        = self;
		_weekdayBarView.backgroundColor = [UIColor clearColor];
		_weekdayBarView.textColor       = [UIColor blackColor];
		_weekdayBarView.sundayColor     = [UIColor colorWithRed:0.6 green:0 blue:0 alpha:1.f];
		_weekdayBarView.todayColor      = [UIColor colorWithRed:0.1 green:0.5 blue:0.9 alpha:1.f];
		_weekdayBarView.textFont        = self.regularFont;
		_weekdayBarView.backgroundColor = [UIColor WR_USC_Red];
	}
	return _weekdayBarView;
}

- (MAGridView *)gridView {
	if (!_gridView){		
		_gridView = [[MAGridView alloc] init];
		_gridView.backgroundColor = [UIColor whiteColor];
		_gridView.rows            = HOURS_IN_DAY;
		_gridView.columns         = DAYS_IN_WEEK;
		_gridView.outerBorder     = YES;
		_gridView.verticalLines   = YES;
		_gridView.horizontalLines = YES;
		_gridView.lineColor       = [UIColor lightGrayColor];
		_gridView.lineWidth       = 1;
	}
	return _gridView;
}

- (UIFont *)regularFont {
	if (!_regularFont) {
		_regularFont = [UIFont systemFontOfSize:_labelFontSize];
	}
	return _regularFont;
}

- (UIFont *)boldFont {
	if (!_boldFont) {
		_boldFont = [UIFont boldSystemFontOfSize:_labelFontSize];
	}
	return _boldFont;
}

- (UISwipeGestureRecognizer *)swipeLeftRecognizer {
	if (!_swipeLeftRecognizer) {
		_swipeLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
		_swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
	}
	return _swipeLeftRecognizer;
}

- (UISwipeGestureRecognizer *)swipeRightRecognizer {
	if (!_swipeRightRecognizer) {
		_swipeRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
		_swipeRightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
	}
	return _swipeRightRecognizer;
}

- (void)setDataSource:(id <MAWeekViewDataSource>)dataSource {
	_dataSource = dataSource;
	[self reloadData];
}

- (id <MAWeekViewDataSource>)dataSource {
	return _dataSource;
}




- (void)reloadData {
    
    for (int day = 0; day < DAYS_IN_WEEK; day++) {
        NSArray *events = [self.dataSource weekView:self eventsForDay:day];
        
//        for (id e in events) {
//            MAEvent *event = e;
//            event.displayDate = weekday;
//        }
        for (id e in [events sortedArrayUsingFunction:MAEvent_sortByStartTime context:NULL]) {
            MAEvent *event = e;
                [self.gridView addEventToOffset:day event:event weekView:self];
        }
    }
    
}




@end

static NSString const * const HOURS_AM_PM[] = {
	@" 12 AM", @" 1 AM", @" 2 AM", @" 3 AM", @" 4 AM", @" 5 AM", @" 6 AM", @" 7 AM", @" 8 AM", @" 9 AM", @" 10 AM", @" 11 AM",
	@" Noon", @" 1 PM", @" 2 PM", @" 3 PM", @" 4 PM", @" 5 PM", @" 6 PM", @" 7 PM", @" 8 PM", @" 9 PM", @" 10 PM", @" 11 PM", @" 12 PM"
};

static NSString const * const HOURS_24[] = {
	@" 0", @" 1", @" 2", @" 3", @" 4", @" 5", @" 6", @" 7", @" 8", @" 9", @" 10", @" 11",
	@" 12", @" 13", @" 14", @" 15", @" 16", @" 17", @" 18", @" 19", @" 20", @" 21", @" 22", @" 23", @" 24"
};

@implementation MAHourView

@synthesize weekView=_weekView;
@synthesize textColor=_textColor;
@synthesize textFont=_textFont;

- (BOOL)timeIs24HourFormat {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterNoStyle];
	[formatter setTimeStyle:NSDateFormatterShortStyle];
	NSString *dateString = [formatter stringFromDate:[NSDate date]];
	NSRange amRange = [dateString rangeOfString:[formatter AMSymbol]];
	NSRange pmRange = [dateString rangeOfString:[formatter PMSymbol]];
	BOOL is24Hour = amRange.location == NSNotFound && pmRange.location == NSNotFound;
	return is24Hour;
}

- (void)drawRect:(CGRect)rect {
	register unsigned int i;
	const CGFloat cellHeight = self.weekView.gridView.cellHeight;
	const NSString *const *HOURS = HOURS_24;//([self timeIs24HourFormat] ? HOURS_24 : HOURS_AM_PM);
	
	[self.textColor set];
	
	for (i=1; i < HOURS_IN_DAY; i++) {
		CGSize sizeNecessary = [HOURS[i] sizeWithFont:self.textFont];
		CGRect rect = CGRectMake(CGRectGetMinX(self.bounds)+6,
								 (cellHeight * i) - (sizeNecessary.height / 2.f),
								 sizeNecessary.width,
								 sizeNecessary.height);
        [[UIColor colorWithIntegerRed:162. green:39. blue:50. alpha:1] set];
		[HOURS[i] drawInRect: rect
					 withFont:self.textFont
				lineBreakMode:UILineBreakModeTailTruncation
					alignment:UITextAlignmentCenter];
	}
}


@end

@implementation MAGridView (MAWeekViewAdditions)

- (void)addEventToOffset:(unsigned int)offset event:(MAEvent *)event weekView:(MAWeekView *)weekView {
	MAEventView *eventView = [[MAEventView alloc] init];
	eventView.weekView = weekView;
	eventView.event = event;
	eventView.backgroundColor = event.backgroundColor;
	eventView.title = event.title;
	eventView.textFont = weekView.regularFont;
	eventView.textColor = event.textColor;
	eventView.xOffset = offset;
	
	[self addSubview:eventView];
}

- (void)layoutSubviews {
	CGFloat cellWidth = self.cellWidth;
	CGFloat cellHeight = self.cellHeight;
	
	for (id view in self.subviews) {
		if (![NSStringFromClass([view class])isEqualToString:@"MAEventView"]) {
			continue;
		}
		MAEventView *eventView = (MAEventView *) view;
		eventView.frame = CGRectMake(cellWidth * eventView.xOffset,
									 cellHeight / MINUTES_IN_HOUR * [eventView.event minutesSinceMidnight],
									 cellWidth,
									 cellHeight / MINUTES_IN_HOUR * [eventView.event durationInMinutes]);
		[eventView setNeedsDisplay];
        
        
	}
}

@end

@implementation MAWeekdayBarView

@synthesize weekView=_weekView;
@synthesize textColor=_textColor, sundayColor=_sundayColor, todayColor=_todayColor;
@synthesize textFont=_textFont;





- (void)drawRect:(CGRect)rect {
	register unsigned int i = 0;
	
	const CGFloat cellWidth = self.weekView.gridView.cellWidth;
	
    
	
	NSArray *weekdaySymbols = [self.dateFormatter veryShortWeekdaySymbols];
    
    for (int d=0; d<7; d++) {
      
    
        
		NSString *displayText = [NSString stringWithFormat:@"%@", [weekdaySymbols objectAtIndex:d]];
        UIFont *headerFont = [UIFont boldSystemFontOfSize:15];
        
		CGSize sizeNecessary = [displayText sizeWithFont:headerFont];
		CGRect rect = CGRectMake(cellWidth * i + ((cellWidth - sizeNecessary.width) / 2.f),
								 CGRectGetMinY(self.bounds),
								 sizeNecessary.width,
								 sizeNecessary.height);
		
        [[UIColor WR_USC_Yellow] set];
		
		[displayText drawInRect: rect
					withFont:headerFont
			   lineBreakMode:UILineBreakModeTailTruncation
				   alignment:UITextAlignmentLeft];
//		
//		d = (d+1) % 7;
		i++;
	}
}

- (NSDateFormatter *)dateFormatter {
	if (!_dateFormatter) {
		_dateFormatter = [[NSDateFormatter alloc] init];
	}
	return _dateFormatter;
}

@end

static const CGFloat kAlpha        = 0.8;
static const CGFloat kCornerRadius = 10.0;
static const CGFloat kCorner       = 5.0;

@implementation MAEventView

@synthesize textColor=_textColor;
@synthesize textFont=_textFont;
@synthesize title=_title;
@synthesize weekView=_weekView;
@synthesize event=_event;
@synthesize xOffset=_xOffset;
@synthesize yOffset=_yOffset;


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		[self setupCustomInitialisation];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super initWithCoder:decoder]) {
		[self setupCustomInitialisation];
	}
	return self;
}

- (void)setupCustomInitialisation {
	twoFingerTapIsPossible = NO;
	multipleTouches = NO;
	delegate = self;
	self.exclusiveTouch = YES;
	
	self.alpha = kAlpha;
	CALayer *layer = [self layer];
	layer.masksToBounds = YES;
	[layer setCornerRadius:kCornerRadius];
}

- (void)layoutSubviews {
	_textRect = CGRectMake(CGRectGetMinX(self.bounds) + kCorner,
						   CGRectGetMinY(self.bounds) + kCorner,
						   CGRectGetWidth(self.bounds) - 2*kCorner,
						   CGRectGetHeight(self.bounds) - 2*kCorner);
}

- (void)drawRect:(CGRect)rect {
	[self.textColor set];
	
	[self.title drawInRect:_textRect
				withFont:self.textFont
				lineBreakMode:UILineBreakModeTailTruncation
				alignment:UITextAlignmentLeft];
}

- (void)tapDetectingView:(TapDetectingView *)view gotSingleTapAtPoint:(CGPoint)tapPoint {
	if ([self.weekView.delegate respondsToSelector:@selector(weekView:eventTapped:)]) {
        [self.weekView.delegate weekView:self.weekView eventTapped:self.event];
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	_touchStart = [[touches anyObject] locationInView:self];
	_wasDragged = NO;
	[super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (_wasDragged) {
		const double posX = self.frame.origin.x / self.weekView.gridView.cellWidth;
		const double posY = self.frame.origin.y / self.weekView.gridView.cellHeight;
		
		/* Align to the grid */		
		CGRect alignedFrame = CGRectMake(self.weekView.gridView.cellWidth * (int)round(posX),
										 self.frame.origin.y,
										 self.frame.size.width,
										 self.frame.size.height);
		
		self.frame = alignedFrame;
		
		/* Calculate the new time for the event */
		
		const int eventDurationInMinutes = [self.event durationInMinutes];
		NSDate *weekday = [self.weekView.weekdayBarView.weekdays objectAtIndex:(int)round(posX)];
		double hours;
		double minutes;
		minutes = modf(posY, &hours) * 60;
		
		NSDateComponents *startComponents = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:weekday];
		[startComponents setHour:(int)hours];
		[startComponents setMinute:(int)minutes];
		[startComponents setSecond:0];
		
		self.event.start = [CURRENT_CALENDAR dateFromComponents:startComponents];
		self.event.end   = [self.event.start dateByAddingTimeInterval:eventDurationInMinutes * 60];
		self.event.displayDate = [CURRENT_CALENDAR dateFromComponents:startComponents];
		
		self.weekView.swipeLeftRecognizer.enabled = YES;
		self.weekView.swipeRightRecognizer.enabled = YES;
		
		if ([self.weekView.delegate respondsToSelector:@selector(weekView:eventDragged:)]) {
			[self.weekView.delegate weekView:self.weekView eventDragged:self.event];
		}
		
		return;
	}
	
	[super touchesEnded:touches withEvent:event];
}

@end
