//
//  AppDelegate.h
//  Mute
//
//  Created by Justen Martin on 5/9/14.
//  Copyright (c) 2014 Justen Martin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    NSWindow *window;
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
}

@property (nonatomic, assign) IBOutlet NSWindow *window;

@end
