//
//  AppDelegate.m
//  TextbookDownloader
//
//  Created by Ian Glen on 8/28/13.
//  Copyright (c) 2013 Ian Glen. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window;

@synthesize textbookURL;
@synthesize downloadTo;

@synthesize minPage;
@synthesize maxPage;

@synthesize leadingZerosCheckbox;
@synthesize leadingZerosTextfield;
@synthesize leadingZerosStepper;

@synthesize prefixCheckbox;
@synthesize prefixTextfield;

@synthesize cookie;

@synthesize progressBar;
@synthesize spinner;

@synthesize downloadButton;

@synthesize downloads;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)browseForDownloadLocation:(id)sender
{
    
}

- (IBAction)leadingZerosChecked:(id)sender
{
    if([leadingZerosCheckbox state] == NSOnState)
    {
        [leadingZerosTextfield setEnabled:YES];
        [leadingZerosStepper setEnabled:YES];
    }
    else
    {
        [leadingZerosTextfield setEnabled:NO];
        [leadingZerosStepper setEnabled:NO];
    }
}

- (IBAction)prefixChecked:(id)sender
{
    if([prefixCheckbox state] == NSOnState)
    {
        [prefixTextfield setEnabled:YES];
    }
    else
    {
        [prefixTextfield setEnabled:NO];
    }
}

- (IBAction)downloadTextbook:(id)sender
{
    // TODO: add prefixes, leading zeros ui, better error handling
    
    NSString *downloadFilename;
    NSURL *downloadURL;
    NSMutableURLRequest *downloadRequest;
    NSURLDownload *download;
    
    // check if url and download location are filled in
    if(![[downloadTo stringValue] isEqual: @""] && ![[textbookURL stringValue] isEqual: @""] && ![[cookie string] isEqual: @""])
    {
        // add trailing slash to both download and textbook url if there isn't one
        if(![[[textbookURL stringValue] substringFromIndex:[[textbookURL stringValue] length] - 1] isEqualTo:@"/"]) [textbookURL setStringValue:[[textbookURL stringValue] stringByAppendingString:@"/"]];
        if(![[[downloadTo stringValue] substringFromIndex:[[downloadTo stringValue] length] - 1] isEqualTo:@"/"]) [downloadTo setStringValue:[[downloadTo stringValue] stringByAppendingString:@"/"]];
        
        // disable download button
        [downloadButton setEnabled:NO];
        
        // start spinner
        [spinner startAnimation:self];
        
        // calculate max downloads
        [progressBar setMaxValue:[maxPage intValue] - [minPage intValue] + 1];
        
        downloads = 0;
        
        for (int page = [minPage intValue]; page <= [maxPage intValue]; page++)
        {
            // create filename
            downloadFilename = [NSString stringWithFormat:@"ap0%d%@", page, @".swf"];
            NSLog(@"%@%@", @"Downloading ", downloadFilename);
            
            // create download URL
            downloadURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [textbookURL stringValue], downloadFilename]];
            
            // create request
            downloadRequest = [NSMutableURLRequest requestWithURL:downloadURL];
            [downloadRequest addValue:[cookie string] forHTTPHeaderField:@"Cookie"];
            
            // download file
            download = [[NSURLDownload alloc] initWithRequest:downloadRequest delegate:self];
            
            // add download location to download
            if(download) [download setDestination:[NSString stringWithFormat:@"%@%@", [downloadTo stringValue], downloadFilename] allowOverwrite:YES];
        }
    }
    else
    {
        NSAlert *downloadToAlert = [[NSAlert alloc] init];
        [downloadToAlert setAlertStyle:NSCriticalAlertStyle];
        [downloadToAlert setMessageText:@"Please select a download location and enter a textbook URL and cookie."];
        [downloadToAlert addButtonWithTitle:@"OK"];
        [downloadToAlert runModal];
    }
}

- (void)download:(NSURLDownload *)download didFailWithError:(NSError *)error
{
    NSLog(@"Download failed: %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    NSLog(@"%@", @"Downloading complete.");
    
    // enable download button
    [downloadButton setEnabled:YES];
    
    // stop spinner
    [spinner stopAnimation:self];
    
    // reset progress bar
    [progressBar setMaxValue:1];
    [progressBar setDoubleValue:0];
}

- (void)downloadDidFinish:(NSURLDownload *)download
{
    [progressBar incrementBy:1];
    downloads++;
    NSLog(@"Downloaded %@", [[[download request] URL] lastPathComponent]);
    
    if(downloads == [maxPage intValue] - [minPage intValue] + 1)
    {
        NSLog(@"%@", @"Downloading complete.");
        
        // enable download button
        [downloadButton setEnabled:YES];
        
        // stop spinner
        [spinner stopAnimation:self];
        
        // reset progress bar
        [progressBar setMaxValue:1];
        [progressBar setDoubleValue:0];
        
        // all downloads complete
        NSAlert *downloadCompleteAlert = [[NSAlert alloc] init];
        [downloadCompleteAlert setAlertStyle:NSInformationalAlertStyle];
        [downloadCompleteAlert setMessageText:@"Download completed."];
        [downloadCompleteAlert addButtonWithTitle:@"OK"];
        [downloadCompleteAlert runModal];
    }
}

@end
