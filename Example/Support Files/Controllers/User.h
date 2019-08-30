//
//  User.h
//  CMVision_ios_develop
//
//  Created by Chenjie Luo on 8/28/19.
//  Copyright © 2019 Particle Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(strong, nonatomic) NSString *pswd;

- (instancetype)initWithPswd:(NSString *)pswd NS_DESIGNATED_INITIALIZER;

@end
