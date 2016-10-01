//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnPacketWriter.h"
#import "JegarnLog.h"
#import "JegarnClient.h"
#import "JegarnListener.h"

@interface JegarnPacketWriter()
@property (strong, nonatomic) NSMutableData *buffer;
@property (nonatomic) BOOL enableWrite;
@end
@implementation JegarnPacketWriter {
@private
    NSOutputStream *_stream;
}
@synthesize stream = _stream;

- (instancetype)init {
    self = [super init];
    if (self) {
        _buffer = [[NSMutableData alloc] init];
    }

    return self;
}

- (void)startup {
    self.enableWrite = NO;
    [super startup];
}

- (void)shutdown {
    self.enableWrite = NO;
    [super shutdown];
}


- (void)stream:(NSStream*)sender handleEvent:(NSStreamEvent)eventCode {
#ifdef DEBUG
    [self streamHandledEvents:eventCode];
#endif
    if (eventCode & NSStreamEventOpenCompleted) {
        [self.client.listener connectListener:self.client];
    }

    if (eventCode & NSStreamEventHasSpaceAvailable) {
        if (self.client.enableSsl) {
            if (![self applySSLSecurityPolicy:sender withEvent:eventCode]) {
                DDLogVerbose(@"[JegarnPacketWriter] NSStreamEventHasSpaceAvailable error %@", sender.streamError);
                self.enableWrite = NO;
            } else {
                self.enableWrite = YES;
            }
        } else {
            self.enableWrite = YES;
        }
    }
    if (eventCode & NSStreamEventErrorOccurred) {
        [self.client.listener errorListener:JegarnErrorTypeNetworkError client:self.client];
        [self.client reconnectDelayInterval];
    }
}

- (BOOL)send:(NSData *)data {
    if (!self.client.running) {
        return NO;
    }
    @synchronized(self) {
        if (!self.enableWrite) {
            return NO;
        }

        if (data) {
            [self.buffer appendData:data];
        }

        if (self.buffer.length) {
            DDLogVerbose(@"[JegarnPacketWriter] buffer to write (%lu)=%@...",
                    (unsigned long)self.buffer.length,
                    [self.buffer subdataWithRange:NSMakeRange(0, MIN(256, self.buffer.length))]);

            NSInteger n = [self.stream write:self.buffer.bytes maxLength:self.buffer.length];
            if (n == -1) {
                DDLogVerbose(@"[JegarnPacketWriter] streamError: %@", self.stream.streamError);
                return NO;
            } else {
                if (n < self.buffer.length) {
                    DDLogVerbose(@"[JegarnPacketWriter] buffer partially written: %ld", (long) n);
                }
                [self.buffer replaceBytesInRange:NSMakeRange(0, n) withBytes:NULL length:0];
            }
        }
        return YES;
    }
}

- (void)streamHandledEvents:(NSStreamEvent)eventCode {
    if (eventCode & NSStreamEventNone) {
        DDLogVerbose(@"[JegarnPacketWriter] NSStreamEventNone");
    }
    if (eventCode & NSStreamEventOpenCompleted) {
        DDLogVerbose(@"[JegarnPacketWriter] NSStreamEventOpenCompleted");
    }
    if (eventCode & NSStreamEventHasBytesAvailable) {
        DDLogVerbose(@"[JegarnPacketWriter] NSStreamEventHasBytesAvailable");
    }
    if (eventCode & NSStreamEventHasSpaceAvailable) {
        DDLogVerbose(@"[JegarnPacketWriter] NSStreamEventHasSpaceAvailable");
    }
    if (eventCode & NSStreamEventErrorOccurred) {
        DDLogVerbose(@"[JegarnPacketWriter] NSStreamEventErrorOccurred");
    }
    if (eventCode & NSStreamEventEndEncountered) {
        DDLogVerbose(@"[JegarnPacketWriter] NSStreamEventEndEncountered");
    }
}

@end