
#import "substrate.h"
#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <UIKit/UIKit.h>
#import "IOKit/IOKit.h"
#import "MobileGestalt.h"



CFTypeRef (*origIORegistryEntryCreateCFProperty) ( io_registry_entry_t entry, CFStringRef key, CFAllocatorRef allocator, IOOptionBits options );

/*CFTypeRef hookedIORegistryEntryCreateCFProperty ( io_registry_entry_t entry, CFStringRef key, CFAllocatorRef allocator, IOOptionBits options )
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:@"/./Library/PreferenceBundles/com.apple.ex3cutevalue.plist"];
    NSString *sn_plist = [dictionary objectForKey:@"SerialNumber"];
    
    CFStringRef SerialNumber = (CFStringRef) sn_plist;
    
    if(!CFStringCompare(key, CFSTR("IOPlatformSerialNumber"), 0))
    {
        NSLog(@"You've successfully spoofed your IOPlatformSerialNumber");
        return SerialNumber;
    }
    else
    {
    NSLog(@"The orignal IOPLatformSerialNumber is %@", key);
    NSLog(@"IOkit returned: %@", origIORegistryEntryCreateCFProperty(entry, key, allocator, options));
    return origIORegistryEntryCreateCFProperty(entry, key, allocator, options);
    }
    
    
}*/

CFPropertyListRef (*orig_MGCopyAnswer)(CFStringRef key);//hook MGCopyAnswer
CFPropertyListRef hooked_MGCopyAnswer(CFStringRef key)
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:@"/./Library/PreferenceBundles/com.apple.ex3cutevalue.plist"];
    NSString *imei_plist = [dictionary objectForKey:@"Imei"];
	NSString *iccid_plist = [dictionary objectForKey:@"ICCID"];
    NSString *serial_plist = [dictionary objectForKey:@"SerialNumber"];
    //NSString *meid_plist = [dictionary objectForKey:@"MobileEquipmentIdentifier"];
    NSString *UniqueChipID_plist = [dictionary objectForKey:@"UniqueChipID"];
	NSString *udid_plist = [dictionary objectForKey:@"UDID"];
	NSString *BBATV_plist = [dictionary objectForKey:@"BasebandActivationTicketVersion"];
	NSString *BCID_plist = [dictionary objectForKey:@"BasebandChipID"];
    
    CFStringRef InternationalMobileEquipmentIdentity = (CFStringRef) imei_plist;
    CFStringRef IntegratedCircuitCardIdentity = (CFStringRef) iccid_plist;
    CFStringRef SerialNumber = (CFStringRef) serial_plist;
    //CFStringRef MobileEquipmentIdentifier = (CFStringRef) meid_plist;
    CFStringRef UniqueChipID = (CFStringRef) UniqueChipID_plist;
    CFStringRef UniqueDeviceIdentifier = (CFStringRef) udid_plist;
    CFStringRef BasebandActivationTicketVersion = (CFStringRef) BBATV_plist;
    CFStringRef BasebandChipID = (CFStringRef) BCID_plist;
    
    
    if(!CFStringCompare(key, CFSTR("InternationalMobileEquipmentIdentity"), 0))
    {
        NSLog(@"Gestalt Key Spoofed:  IMEI");
        return InternationalMobileEquipmentIdentity;
    }
    else if(!CFStringCompare(key, CFSTR("IntegratedCircuitCardIdentity"), 0))
    {
        NSLog(@"Gestalt Key Spoofed: IntegratedCircuitCardIdentity");
        return IntegratedCircuitCardIdentity;
    }
    else if(!CFStringCompare(key, CFSTR("SerialNumber"), 0))
    {
        NSLog(@"Gestalt Key Spoofed: SerialNumber");
        return SerialNumber;
    }
    else if(!CFStringCompare(key, CFSTR("UniqueChipID"), 0))
    {
        NSLog(@"Gestalt Key Spoofed: UniqueChipID");
        return UniqueChipID;
    }
    else if(!CFStringCompare(key, CFSTR("UniqueDeviceIdentifier"), 0))
    {
        NSLog(@"Gestalt Key Spoofed: UniqueDeviceIdentifier");
        return UniqueDeviceIdentifier;
    }
    else if(!CFStringCompare(key, CFSTR("BasebandActivationTicketVersion"), 0))
    {
        NSLog(@"Gestalt Key Spoofed: BasebandActivationTicketVersion");
        return BasebandActivationTicketVersion;
    }
    else if(!CFStringCompare(key, CFSTR("BasebandChipID"), 0))
    {
        NSLog(@"Gestalt Key Spoofed: BasebandChipID");
        return BasebandChipID;
    }
    else
    {
        NSLog(@"Gestalt Key: %@ ",key);
        NSLog(@"Gestalt Key Original Value: %@ ", orig_MGCopyAnswer(key) );
        return orig_MGCopyAnswer(key);
    }
}

__attribute__((constructor)) static void initialize() {
MSHookFunction(MGCopyAnswer, hooked_MGCopyAnswer,&orig_MGCopyAnswer);
MSHookFunction(IORegistryEntryCreateCFProperty, hookedIORegistryEntryCreateCFProperty,&origIORegistryEntryCreateCFProperty);
}
