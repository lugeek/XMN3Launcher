//
//  AppDelegate.m
//  XMN3Launcher
//
//  Created by lugeek on 2020/9/24.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (strong) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

-(void)bringToFrontApplicationWithBundleIdentifier:(NSString*)inBundleIdentifier
{
    // Try to bring the application to front
    NSArray* appsArray = [NSRunningApplication runningApplicationsWithBundleIdentifier:inBundleIdentifier];
    if([appsArray count] > 0)
    {
        [[appsArray objectAtIndex:0] activateWithOptions:NSApplicationActivateIgnoringOtherApps];
    }
    
    // Quit ourself
    [[NSApplication sharedApplication] terminate:self];
}

-(void)launchApplicationWithPath:(NSString*)inPath andBundleIdentifier:(NSString*)inBundleIdentifier
{
    if(inPath != nil)
    {
        // Run Calculator.app and inject our dynamic library
        NSString *dyldLibrary = [[NSBundle bundleForClass:[self class]] pathForResource:@"libXMN3Overrides" ofType:@"dylib"];
        NSString *launcherString = [NSString stringWithFormat:@"DYLD_INSERT_LIBRARIES=\"%@\" \"%@\" &", dyldLibrary, inPath];
        system([launcherString UTF8String]);
        
        // Bring it to front after a delay
        [self performSelector:@selector(bringToFrontApplicationWithBundleIdentifier:) withObject:inBundleIdentifier afterDelay:1.0];
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSString *calculatorPath = @"/Applications/MarginNote 3.app/Contents/MacOS/MarginNote 3";
    if([[NSFileManager defaultManager] fileExistsAtPath:calculatorPath])
        [self launchApplicationWithPath:calculatorPath andBundleIdentifier:@"QReader.MarginStudyMac"];
}


@end
