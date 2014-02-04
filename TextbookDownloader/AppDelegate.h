//
//  AppDelegate.h
//  TextbookDownloader
//
//  Created by Ian Glen on 8/28/13.
//  Copyright (c) 2013 Ian Glen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSString+Repeat.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (assign) IBOutlet NSTextField *textbookURL;
@property (assign) IBOutlet NSTextField *downloadTo;
- (IBAction)browseForDownloadLocation:(id)sender;

@property (assign) IBOutlet NSTextField *minPage;
@property (assign) IBOutlet NSTextField *maxPage;

@property (assign) IBOutlet NSButtonCell *swfRadio;
@property (assign) IBOutlet NSButtonCell *pdfRadio;

@property (assign) IBOutlet NSButton *leadingZerosCheckbox;
- (IBAction)leadingZerosChecked:(id)sender;
@property (assign) IBOutlet NSTextField *leadingZerosTextfield;
@property (assign) IBOutlet NSStepper *leadingZerosStepper;

@property (assign) IBOutlet NSButton *prefixCheckbox;
- (IBAction)prefixChecked:(id)sender;
@property (assign) IBOutlet NSTextField *prefixTextfield;

@property (assign) IBOutlet NSTextView *cookie;

@property (assign) IBOutlet NSProgressIndicator *progressBar;
@property (assign) IBOutlet NSProgressIndicator *spinner;

@property (assign) IBOutlet NSButton *downloadButton;
- (IBAction)downloadTextbook:(id)sender;

@property (assign) int downloads;

@end