//
//  OEPS3HIDDeviceHandler.m
//  OpenEmu
//
//  Created by Joshua Weinberg on 12/30/12.
//
//

#import "OEPS3HIDDeviceHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface OEDeviceHandler ()
@property(readwrite) NSUInteger deviceNumber;
@end

@implementation OEPS3HIDDeviceHandler {
    uint8_t _reportBuffer[128];
}

- (BOOL)connect
{
    
    return YES;
}

- (void)disconnect
{
    [super disconnect];
    [self setDeviceNumber:0];
}

- (void)setDeviceNumber:(NSUInteger)deviceNumber
{
    [super setDeviceNumber:deviceNumber];
    
    uint8_t control_packet[] =	{
        0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0xFF, 0x27, 0x10,
        0x10, 0x32, 0xFF, 0x27, 0x10, 0x00, 0x32,
        0xFF, 0x27, 0x10, 0x00, 0x32, 0xFF, 0x27,
        0x10, 0x00, 0x32, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    };
    
    control_packet[10] = (deviceNumber & 0x0F) << 1;

    IOHIDDeviceSetReport([self device],
                         kIOHIDReportTypeOutput,
                         0x09,
                         control_packet,
                         sizeof(control_packet));
}

@end

NS_ASSUME_NONNULL_END
