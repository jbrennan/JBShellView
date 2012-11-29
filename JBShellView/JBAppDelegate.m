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


@interface JBAppDelegate ()
@property (nonatomic, strong) JBShellContainerView *shellContainer;
@end


@implementation JBAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
	CGRect bounds = [[self.window contentView] bounds];
	NSString *prompt = [NSString stringWithFormat:@"%@> ", @"JBShellView"];

	
    self.shellContainer = [[JBShellContainerView alloc] initWithFrame:bounds shellViewClass:nil prompt:prompt shellInputProcessingHandler:^(NSString *input, JBShellView *sender) {
		
		// If you're doing a long operation, use this and make sure to end it when you're done.
		//[sender beginDelayedOutputMode];
		
		// Do some potentially long asynchronous task and append any output
		[sender appendOutputWithNewlines:@"I'm sorry Dave, I'm afraid I can't do that."];
		// Or append an error
		// [sender showErrorOutput:@"I'm sorry Dave." errorRange:NSMakeRange(0, [input length])];
		
		// Call this when the task is done
		//[sender endDelayedOutputMode];
		
		
	}];
	
	
	[[[self window] contentView] addSubview:self.shellContainer];
	[self.window makeFirstResponder:self.shellContainer.shellView];
}

@end
