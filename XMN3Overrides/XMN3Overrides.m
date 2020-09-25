//
//  XMN3Overrides.m
//  XMN3Overrides
//
//  Created by lugeek on 2020/9/24.
//

#import "XMN3Overrides.h"

#include <objc/runtime.h>
#include <Foundation/Foundation.h>
#include <AppKit/AppKit.h>

#include <sys/syslog.h>


//__attribute__((constructor)) void myentry() {
//    printf("Hello from dylib!\n");
//    syslog(LOG_ERR, "Dylibx 1 injection successful");
//}
//
//__attribute__((constructor))
//static void customConstructor(int argc, const char **argv)
// {
//     printf("Hello from dylib!\n");
//     syslog(LOG_ERR, "Dylibx 2 injection successful in %s\n", argv[0]);
//}

@implementation XMN3Overrides

+(void)load
{
    [self exchangeMethodOriginClass:@"AppDelegate" originMethod:@selector(willShowPaddleUIType:product:) newClass:@"XMN3Overrides" newMethod:@selector(hookWillShowPaddleUI:product:)];
    
    [self exchangeMethodOriginClass:@"AppDelegate" originMethod:@selector(pushActiveWindow:) newClass:@"XMN3Overrides" newMethod:@selector(hookPushActiveWindow:)];
    
    [self exchangeMethodOriginClass:@"MbUIRootViewController" originMethod:@selector(showUpgrade:) newClass:@"XMN3Overrides" newMethod:@selector(hookShowUpgrade:)];
    
    [self exchangeMethodOriginClass:@"MbUIRootViewController" originMethod:@selector(checkPurchase) newClass:@"XMN3Overrides" newMethod:@selector(hookCheckPurchase)];
    
    [self exchangeMethodOriginClass:@"MbUIRootViewController" originMethod:@selector(checkAppPurchased) newClass:@"XMN3Overrides" newMethod:@selector(hookCheckAppPurchased)];
    
//    [self setPro];
    
    [self exchangeMethodOriginClass:@"AppDelegate" originMethod:@selector(isTrial) newClass:@"XMN3Overrides" newMethod:@selector(hookisTrial)];
    
    [self exchangeMethodOriginClass:@"AppDelegate" originMethod:@selector(isValidProduct) newClass:@"XMN3Overrides" newMethod:@selector(hookisValidProduct)];
    
}

+(void)exchangeMethodOriginClass:(NSString *)originClass originMethod:(SEL *)originMethod newClass:(NSString *)newClass newMethod:(SEL *)newMethod
{
    Class originalClass = NSClassFromString(originClass);
    Method originalMeth = class_getInstanceMethod(originalClass, originMethod);
    
    Method replacementMeth = class_getInstanceMethod(NSClassFromString(newClass), newMethod);
    method_exchangeImplementations(originalMeth, replacementMeth);
}

// 🍺成功 应用内购买弹窗，比如进入学习进行标注时，会提示购买
// void -[MbUIRootViewController showUpgrade:](void * self, void * _cmd, void * arg2) {
-(void)hookShowUpgrade:(id)arg2
{
//    NSAlert *alert = [[NSAlert alloc] init];
//    [alert addButtonWithTitle:@"OK"];
//    [alert setMessageText:@"hookShowUpgrade has been injected!"];
//    [alert setAlertStyle:NSAlertStyleCritical];
//    [alert runModal];
}

// 🍺成功, 到期购买的自动弹窗
// void * -[AppDelegate willShowPaddleUIType:product:](void * self, void * _cmd, long long arg2, void * arg3) {
-(void)hookWillShowPaddleUI:(id)arg2 product:(id)arg3
{
//    NSAlert *alert = [[NSAlert alloc] init];
//    [alert addButtonWithTitle:@"OK"];
//    [alert setMessageText:@"Code has been injected!"];
//    [alert setInformativeText:@"The code has been injected using DYLD_INSERT_LIBRARIES into Calculator.app"];
//    [alert setAlertStyle:NSAlertStyleCritical];
//    [alert runModal];
}

// 🍺成功, 进入学习脑图时的弹窗，用处不大
//void -[AppDelegate pushActiveWindow:](void * self, void * _cmd, void * arg2) {
-(void)hookPushActiveWindow:(id)arg2
{
//    NSAlert *alert = [[NSAlert alloc] init];
//    [alert addButtonWithTitle:@"OK"];
//    [alert setMessageText:@"hookPushActiveWindow has been injected!"];
//    [alert setAlertStyle:NSAlertStyleCritical];
//    [alert runModal];
}

//void -[MbUIRootViewController checkPurchase](void * self, void * _cmd) {
-(void)hookCheckPurchase
{
    
}
//void -[MbUIRootViewController checkAppPurchased](void * self, void * _cmd) {
-(void)hookCheckAppPurchased
{
    
}

+(void)setPro
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults performSelector:@selector(setSecretObject:forKey:) withObject:@"Pro" withObject:@"mindbooks_edition"];
    [defaults synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"mindbooks_tempstartdate"];
}

//char -[AppDelegate isTrial](void * self, void * _cmd) {
-(char)hookisTrial
{
//    NSAlert *alert = [[NSAlert alloc] init];
//    [alert addButtonWithTitle:@"OK"];
//    [alert setMessageText:@"hookisTrial has been injected!"];
//    [alert setAlertStyle:NSAlertStyleCritical];
//    [alert runModal];
    return 0x0;
}

// char -[AppDelegate isValidProduct](void * self, void * _cmd) {
-(char)hookisValidProduct
{
    return 0x1;
}
@end
