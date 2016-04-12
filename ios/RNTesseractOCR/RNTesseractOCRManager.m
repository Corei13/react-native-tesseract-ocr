#import "RNTesseractOCRManager.h"
#import "G8Tesseract.h"
#import "UIImage+G8Filters.h"
#import "G8RecognitionOperation.h"
#import "G8TesseractDelegate.h"

#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import "UIView+React.h"
#import "RCTConvert.h"

@interface RNTesseractOCRManager() <G8TesseractDelegate>
@end

@implementation RNTesseractOCRManager

RCT_EXPORT_MODULE();

- (UIView *)view
{
    RCTLogInfo(@"Hello World");
    G8Tesseract *tesseract = [[G8Tesseract alloc] initWithLanguage:@"eng"];
    tesseract.delegate = self;
    tesseract.charWhitelist = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ -.'";
    tesseract.image = [[UIImage imageNamed:@"image_sample.png"] g8_blackAndWhite];
    [tesseract recognize];
    RCTLogInfo(@"%@", [tesseract recognizedText]);
    NSArray *characterBoxes = [tesseract recognizedBlocksByIteratorLevel:G8PageIteratorLevelSymbol];
    // NSArray *paragraphs = [tesseract recognizedBlocksByIteratorLevel:G8PageIteratorLevelParagraph];
    // NSArray *characterChoices = tesseract.characterChoices;
    UIImage *imageWithBlocks = [tesseract imageWithBlocks:characterBoxes drawText:YES thresholded:NO];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [view setBackgroundColor:[UIColor colorWithPatternImage:imageWithBlocks]];
    return view;
}

#pragma mark G8TesseractDelegate
- (void)progressImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    RCTLogInfo(@"progress: %lu", (unsigned long)tesseract.progress);
}

- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    return NO;  // return YES, if you need to interrupt tesseract before it finishes
}

@end
