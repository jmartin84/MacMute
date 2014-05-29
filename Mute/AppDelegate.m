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
	[self addOutput:[NSString stringWithFormat:@"Firing -[%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd)]];
	[self addOutput:[NSString stringWithFormat:@"Hotkey event: %@", hkEvent]];
}
- (void) hotkeyWithEvent:(NSEvent *)hkEvent object:(id)anObject {
	[self addOutput:[NSString stringWithFormat:@"Firing -[%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd)]];
	[self addOutput:[NSString stringWithFormat:@"Hotkey event: %@", hkEvent]];
	[self addOutput:[NSString stringWithFormat:@"Object: %@", anObject]];
}

- (void) addOutput:(NSString *)newOutput {
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
    [statusItem setTitle:@"Mute"];
    [statusItem setHighlightMode:YES];
    
}

- (void)dealloc
{
    // Cleanup
    
}


@end
