//
//  AppDelegate.m
//  Mute
//
//  Created by Justen Martin on 5/9/14.
//  Copyright (c) 2014 Justen Martin. All rights reserved.
//

#import "AppDelegate.h"
#import "DDHotKeyCenter.h"

@implementation AppDelegate

@synthesize window = _window;

- (void) hotkeyWithEvent:(NSEvent *)hkEvent {
    NSDictionary* errorDict;
    NSAppleEventDescriptor* returnDescriptor = NULL;

	NSAppleScript* scriptObject = [[NSAppleScript alloc] initWithSource:
                                   @"if input volume of (get volume settings) = 0 then\n\
                                        set level to 100\n\
                                     else\n\
                                        set level to 0\n\
                                     end if\n\
                                     set volume input volume level"];

    returnDescriptor = [scriptObject executeAndReturnError: &errorDict];
    
    
    if (returnDescriptor == NULL)
    {
        [self addOutput: errorDict];
    }
    else{
        [self setVisualIndicator];
    }
}


-(void) setVisualIndicator {
    //placeholder until I find some icons
    if([statusItem.title  isEqual: @"Not Muted"]){
        [statusItem setTitle:@"Muted"];
    }
    else{
        [statusItem setTitle:@"Not Muted"];
    }
}

- (void) addOutput:(NSObject *)newOutput {
	NSLog(newOutput);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
	DDHotKeyCenter *c = [DDHotKeyCenter sharedHotKeyCenter];
	if (![c registerHotKeyWithKeyCode:46 modifierFlags:NSShiftKeyMask | NSControlKeyMask target:self action:@selector(hotkeyWithEvent:) object:nil]) {
		[self addOutput:@"Unable to register hotkey for example 1"];
	} else {
		[self addOutput:@"Registered hotkey for example 1"];
		[self addOutput:[NSString stringWithFormat:@"Registered: %@", [c registeredHotKeys]]];
	}
}
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

- (void) awakeFromNib{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    [statusItem setTitle:@"Not Muted"];
    [statusItem setHighlightMode:YES];
    NSDictionary* errorDict;
    NSAppleEventDescriptor* returnDescriptor = NULL;
    
	NSAppleScript* scriptObject = [[NSAppleScript alloc] initWithSource:
                                   @"set level to 100\n\
                                   set volume input volume level"];
    
    returnDescriptor = [scriptObject executeAndReturnError: &errorDict];
    
}

- (void)dealloc
{
    // Cleanup
    
}


@end
