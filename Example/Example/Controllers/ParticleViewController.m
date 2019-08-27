#import "ParticleViewController.h"
#ifdef USE_FRAMEWORKS
#import <ParticleSDK/ParticleCloud.h>
#else
#import "ParticleCloud.h"
#endif

//Make sure to change value of these constants
#define PARTICLE_USER   @"ben.yang@cmvisiontech.com"
#define PARTICLE_PASSWORD   @"Harwin9947"

@interface ParticleViewController()

@property (assign) BOOL loggedIn;

@end


@implementation ParticleViewController

@synthesize loggedIn;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ref = [[FIRDatabase database] reference];
    [self updateButtonsState];
}

#pragma mark - SDK

- (void)login {
    /////////need read data and start here now
    
    if ([PARTICLE_USER isEqualToString:@"NOT SET"] || [PARTICLE_PASSWORD isEqualToString:@"NOT SET"]) {
        NSLog(@"To log in, you must change PARTICLE_USER and PARTICLE_PASSWORD constant values in ParticleViewController.m");
        return;
    }

    self.loginButton.enabled = NO;

    __weak ParticleViewController *wSelf = self;
    [[ParticleCloud sharedInstance] loginWithUser:PARTICLE_USER password:PARTICLE_PASSWORD completion:^(NSError *error) {
        __strong ParticleViewController *sSelf = wSelf;

        if (!error) {
            //Success
            NSLog(@"Successfully logged in to the cloud!\nAccess Token: %@", [ParticleCloud sharedInstance].accessToken);

            //Update UI state
            sSelf.loggedIn = YES;
            [sSelf updateButtonsState];
        } else {
            //Failed to log in
            NSLog(@"Error while logging in to the cloud: %@", error.localizedDescription);

            sSelf.loggedIn = NO;
            [sSelf updateButtonsState];
        }
    }];
}

- (void) signup {
    [[[self.ref child:@"users"] child:_UserNameField.text]
     setValue:@{@"password": _PasscodeField.text}];
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Signup Complete!"
                                 message:@"Please log in with your password now!"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:NULL];
    _UserNameField.text = @"";
    _PasscodeField.text = @"";
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)logout {
    [[ParticleCloud sharedInstance] logout];
    NSLog(@"Successfully logged out!\nAccess Token: %@",[ParticleCloud sharedInstance].accessToken);

    //Update UI state
    self.loggedIn = NO;
    [self updateButtonsState];
}

#pragma mark - UI events

- (IBAction)loginButtonClicked:(UIButton *)sender {
    if (self.loggedIn) {
        [self logout];
    } else {
        [self login];
    }
}

- (IBAction)signupButtonClicked:(UIButton *)sender {
    [self signup];
}



#pragma mark - Helpers

- (void)updateButtonsState {
    self.loginButton.enabled = YES;

    if (self.loggedIn) {
        self.actionsButton.enabled = YES;
        [self.loginButton setTitle:@"Quit" forState:UIControlStateNormal];
    } else {
        self.actionsButton.enabled = NO;
        [self.loginButton setTitle:@"Start Now" forState:UIControlStateNormal];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_UserNameField isExclusiveTouch]) {
        [_UserNameField resignFirstResponder];
    }
    if (![_PasscodeField isExclusiveTouch]) {
        [_PasscodeField resignFirstResponder];
    }
}



@end
