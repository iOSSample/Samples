#import "NSString+AvoidMTLModelCrash.h"

static NSNumberFormatter *__avoidCrashNumberFormatter = nil;

@implementation NSString (AvoidMTLModelCrash)

+ (void)load
{
    __avoidCrashNumberFormatter = [[NSNumberFormatter alloc] init];
}

- (NSNumber *)stringNumber
{
    return [__avoidCrashNumberFormatter numberFromString:self];
}

- (char)charValue
{
    return [[self stringNumber] charValue];
}

- (unsigned char)unsignedCharValue
{
    return [[self stringNumber] unsignedCharValue];
}

- (short)shortValue
{
    return [[self stringNumber] shortValue];
}

- (unsigned short)unsignedShortValue
{
    return [[self stringNumber] unsignedShortValue];
}

- (unsigned int)unsignedIntValue
{
    return [[self stringNumber] unsignedIntValue];
}

- (long)longValue
{
    return [[self stringNumber] longValue];
}

- (unsigned long)unsignedLongValue
{
    return [[self stringNumber] unsignedLongValue];
}

- (unsigned long long)unsignedLongLongValue
{
    return [[self stringNumber] unsignedLongLongValue];
}

- (NSUInteger)unsignedIntegerValue
{
    return [[self stringNumber] unsignedIntegerValue];
}

- (NSString *)stringValue
{
    return self;
}

- (BOOL)isEqualToNumber:(NSNumber *)number
{
    return [[self stringNumber] isEqualToNumber:number];
}

- (NSUInteger)count {
    return 0;
}

- (id)objectForKeyedSubscript:(id)key {
    NSAssert(NO , @"NSString not respond to selctore");
    return nil;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    NSAssert(NO , @"NSString not respond to selctore");
    return nil;
}

- (id)objectAtIndex:(NSUInteger)index {
    NSAssert(NO , @"NSString not respond to selctore");
    return nil;
}

@end
