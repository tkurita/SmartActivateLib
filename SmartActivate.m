#import "SmartActivate.h"

#define useLog 0

@implementation SmartActivate

+(BOOL)activateAppOfInfo:(NSDictionary *)pDict
{
	if (pDict != nil) {
		OSStatus result = activateForProcessInfo((__bridge CFDictionaryRef)pDict);
		return result==noErr;
	}
	else {
		return NO;
	}
}

+(NSDictionary *)processInfoOfIdentifier:(NSString*)targetIdentifier
{
	NSDictionary *pDict = (NSDictionary *)CFBridgingRelease(getProcessInfo(NULL,NULL,
														 (__bridge CFStringRef)targetIdentifier));
	return pDict;
}


+(NSDictionary *)processInfoOfName:(NSString*)targetName
{
	NSDictionary *pDict = (NSDictionary *)CFBridgingRelease(getProcessInfo(NULL,
														 (__bridge CFStringRef)targetName,
														 NULL));
	return pDict;
}

+(NSDictionary *)processInfoOfType:(NSString *)targetCreator 
{
	NSDictionary *pDict = (NSDictionary *)CFBridgingRelease(getProcessInfo((__bridge CFStringRef)targetCreator,
														 NULL,NULL));
	return pDict;
}

+(NSDictionary *)processInfoOfType:(NSString *)targetCreator processName:(NSString*)targetName identifier:(NSString*)targetIdentifier
{
	NSDictionary *pDict = (NSDictionary *)CFBridgingRelease(getProcessInfo((__bridge CFStringRef)targetCreator,
										   (__bridge CFStringRef)targetName,
										   (__bridge CFStringRef)targetIdentifier));
	return pDict;
}

+(BOOL)activateAppOfIdentifier:(NSString *)targetIdentifier
{
	return [self activateAppOfType:nil processName:nil identifier:targetIdentifier];
}

+(BOOL)activateAppOfName:(NSString *)targetName
{
	return [self activateAppOfType:nil processName:targetName identifier:nil];
}

+(BOOL)activateAppOfType:(NSString *)targetCreator
{
	return [self activateAppOfType:targetCreator processName:nil identifier:nil];
}

+(BOOL)activateAppOfType:(NSString *)targetCreator processName:(NSString*)targetName identifier:(NSString*)targetIdentifier
{
	CFDictionaryRef pDict = getProcessInfo((__bridge CFStringRef)targetCreator,
															(__bridge CFStringRef)targetName,
															(__bridge CFStringRef)targetIdentifier);
	if (pDict != nil) {
		OSStatus result = activateForProcessInfo(pDict);
		CFRelease(pDict);
		
		return result==noErr;
	}
	else {
		return NO;
	}
}

+(BOOL)activateSelf
{
	OSStatus result = activateSelf();
	return result == noErr;
}

@end
