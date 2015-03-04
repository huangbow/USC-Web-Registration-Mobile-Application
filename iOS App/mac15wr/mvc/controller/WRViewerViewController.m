//
//  WRViewerViewController.m
//  mac15wr
//
//  Created by zwein on 2/26/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//

#import "WRViewerViewController.h"

@interface WRViewerViewController () <FTCoreTextViewDelegate>
@end


@implementation WRViewerViewController
@synthesize textView;
@synthesize textResourceString;

-(id)initWithTextResource:(NSString*) resName{
    self = [super init];
    textResourceString = resName;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"Viewer";
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollView.frame = CGRectMake(5, CGRectGetHeight(self.headerContainer.frame), SCREEN_WIDTH-10, SCREEN_HEIGHT - CGRectGetHeight(self.headerContainer.frame));
    
    
    textView = [[FTCoreTextView alloc] init];
    textView.frame = CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    textView.backgroundColor = [UIColor clearColor];
    
    [self.textView addStyles:[self coreTextStyle]];
    self.textView.text = [self textForView];
    self.textView.delegate = self;
    

    [self.scrollView addSubview:self.textView];

    [self.view addSubview:self.scrollView];

    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //  We need to recalculate fit height on every layout because
    //  when the device orientation changes, the FTCoreText's width changes
    
    //  Make the FTCoreTextView to automatically adjust it's height
    //  so it fits all its rendered text using the actual width
    [self.textView fitToSuggestedHeight];
    
    //  Adjust the scroll view's content size so it can scroll all
    //  the FTCoreTextView's content
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.bounds), CGRectGetMaxY(self.textView.frame)+20.0f)];
}

- (NSString *)textForView
{
    return [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:textResourceString ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
}

- (NSArray *)coreTextStyle{
    NSMutableArray *result = [NSMutableArray array];
    
    //  This will be default style of the text not closed in any tag
    FTCoreTextStyle *defaultStyle = [FTCoreTextStyle new];
    defaultStyle.name = FTCoreTextTagDefault;	//thought the default name is already set to FTCoreTextTagDefault
    defaultStyle.font = [UIFont fontWithName:@"ArialMT" size:16.f];
    defaultStyle.textAlignment = FTCoreTextAlignementJustified;
    defaultStyle.color = [UIColor blackColor];
    [result addObject:defaultStyle];
    
    //  Create style using convenience method
    FTCoreTextStyle *titleStyle = [FTCoreTextStyle styleWithName:@"title"];
    titleStyle.font = [UIFont fontWithName:@"Arial-BoldMT" size:40.f];
    titleStyle.paragraphInset = UIEdgeInsetsMake(10.f, 0, 15.f, 0);
    titleStyle.textAlignment = FTCoreTextAlignementCenter;
    titleStyle.color = [UIColor WR_USC_Red];
    [result addObject:titleStyle];
    
    //  Image will be centered
    FTCoreTextStyle *imageStyle = [FTCoreTextStyle new];
    imageStyle.name = FTCoreTextTagImage;
    imageStyle.textAlignment = FTCoreTextAlignementCenter;
    [result addObject:imageStyle];
    
    FTCoreTextStyle *firstLetterStyle = [FTCoreTextStyle new];
    firstLetterStyle.name = @"firstLetter";
    firstLetterStyle.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:30.f];
    [result addObject:firstLetterStyle];
    
    //  This is the link style
    //  Notice that you can make copy of FTCoreTextStyle
    //  and just change any required properties
    FTCoreTextStyle *linkStyle = [defaultStyle copy];
    linkStyle.name = FTCoreTextTagLink;
    linkStyle.color = [UIColor belizeHoleColor];
    [result addObject:linkStyle];
    
    FTCoreTextStyle *subtitleStyle = [FTCoreTextStyle styleWithName:@"subtitle"];
    subtitleStyle.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:25.f];
    subtitleStyle.color = [UIColor WR_USC_Red];
    subtitleStyle.paragraphInset = UIEdgeInsetsMake(5, 0, 10, 0);
    [result addObject:subtitleStyle];
    
    //  This will be list of items
    //  You can specify custom style for a bullet
    FTCoreTextStyle *bulletStyle = [defaultStyle copy];
    bulletStyle.name = FTCoreTextTagBullet;
    bulletStyle.bulletFont = [UIFont fontWithName:@"TimesNewRomanPSMT" size:16.f];
    bulletStyle.bulletColor = [UIColor carrotColor];
    bulletStyle.bulletCharacter = @"•";
    bulletStyle.paragraphInset = UIEdgeInsetsMake(0, 20.f, 0, 0);
    [result addObject:bulletStyle];
    
    FTCoreTextStyle *italicStyle = [defaultStyle copy];
    italicStyle.name = @"italic";
    italicStyle.underlined = YES;
    italicStyle.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:16.f];
    [result addObject:italicStyle];
    
    FTCoreTextStyle *boldStyle = [defaultStyle copy];
    boldStyle.name = @"bold";
    boldStyle.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:16.f];
    [result addObject:boldStyle];
    
    FTCoreTextStyle *coloredStyle = [defaultStyle copy];
    [coloredStyle setName:@"colored"];
    [coloredStyle setColor:[UIColor pomegranateColor]];
    [result addObject:coloredStyle];
    
    return  result;
}


#pragma mark FTCoreTextViewDelegate

- (void)coreTextView:(FTCoreTextView *)acoreTextView receivedTouchOnData:(NSDictionary *)data
{
    //  You can get detailed info about the touched links
    
    //  Name (type) of selected tag
    NSString *tagName = [data objectForKey:FTCoreTextDataName];
    
    //  URL if the touched data was link
    NSURL *url = [data objectForKey:FTCoreTextDataURL];
    
    //  Frame of the touched element
    //  Notice that frame is returned as a string returned by NSStringFromCGRect function
    CGRect touchedFrame = CGRectFromString([data objectForKey:FTCoreTextDataFrame]);
    
    //  You can get detailed CoreText information
    NSDictionary *coreTextAttributes = [data objectForKey:FTCoreTextDataAttributes];
    
    NSLog(@"Received touched on element:\n"
          @"Tag name: %@\n"
          @"URL: %@\n"
          @"Frame: %@\n"
          @"CoreText attributes: %@",
          tagName, url, NSStringFromCGRect(touchedFrame), coreTextAttributes
          );
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
