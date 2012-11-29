//
//  JBAppDelegate.m
//  JBShellView
//
//  Created by Jason Brennan on 2012-11-29.
//  Copyright (c) 2012 Jason Brennan. All rights reserved.
//

#import "JBAppDelegate.h"
#import "JBShellContainerView.h"
#import "JBShellView.h"

#define kSearchString @"search "


@interface JBAppDelegate ()
@property (nonatomic, strong) JBShellContainerView *shellContainer;
@end


@implementation JBAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
	CGRect bounds = [[self.window contentView] bounds];
	NSString *prompt = [NSString stringWithFormat:@"%@> ", @"JBShellView"];

	
    self.shellContainer = [[JBShellContainerView alloc] initWithFrame:bounds shellViewClass:nil prompt:prompt shellInputProcessingHandler:^(NSString *input, JBShellView *sender) {
		
		if ([input hasPrefix:kSearchString]) {
			// If you're doing a long operation, use this and make sure to end it when you're done.
			[sender beginDelayedOutputMode];
			
			// Do some potentially long asynchronous task and append any output
			NSInteger index = NSMaxRange([input rangeOfString:kSearchString]);
			NSString *query = [[input substringFromIndex:index] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
			NSString *url = [NSString stringWithFormat:@"http://api.duckduckgo.com/?q=%@&format=json", query];
			NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
			
			[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
				if (error) {
					[sender showErrorOutput:@"Error searching" errorRange:NSMakeRange(0, [input length])];
				} else {
					NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
					NSArray *relatedTopics = [results valueForKey:@"RelatedTopics"];
					if ([relatedTopics count]) {
						NSDictionary *firstResult = relatedTopics[0];
						[sender appendOutputWithNewlines:firstResult[@"Text"]];
					} else {
						[sender appendOutputWithNewlines:@"No results"];
					}
				}
				// Call this when the task is done
				[sender endDelayedOutputMode];
			}];
			
		} else {
			[sender appendOutputWithNewlines:@"Try 'search Kubrick'"];
		}
	}];
	
	
	[[[self window] contentView] addSubview:self.shellContainer];
	[self.window makeFirstResponder:self.shellContainer.shellView];
}

@end
