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
@property NSString* input_password;
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
    _usernameinput = _UserNameField.text;
    _userpasswordinput = _PasscodeField.text;
    [[self.ref child:@"users"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSDictionary *usersDict = snapshot.value;
        
        self->_input_password = usersDict[self->_usernameinput][@"password"];

        if (self->_input_password == self->_userpasswordinput){
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
        else{
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Error!"
                                         message:@"Your username is not found or your pasworrd is incorrect, please try again"
                                         preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Yes"
                                        style:UIAlertActionStyleDefault
                                        handler:NULL];
            [alert addAction:yesButton];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        //NSLog(@"The Info: %@", _input_password);
        //NSLog(@"the password: %@",_userpasswordinput);
    }];
}

- (void) signup {
    _usernameinput = _UserNameField.text;
    _userpasswordinput = _PasscodeField.text;
    
    [[self.ref child:@"users"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSDictionary *usersDict = snapshot.value;
        
        if (usersDict[_usernameinput] != NULL){
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Signup Incomplete!"
                                         message:@"The user name has been used. Please try another name."
                                         preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Yes"
                                        style:UIAlertActionStyleDefault
                                        handler:NULL];
            
            [alert addAction:yesButton];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        else{
            [[[self.ref child:@"users"] child:_usernameinput]
             setValue:@{@"password": _userpasswordinput}];
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Signup Complete!"
                                         message:@"Please log in with your password now!"
                                         preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Yes"
                                        style:UIAlertActionStyleDefault
                                        handler:NULL];
            //_UserNameField.text = @"";
            //_PasscodeField.text = @"";
            [alert addAction:yesButton];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
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
        _UserNameField.text = @"";
        _PasscodeField.text = @"";
    }
}

- (IBAction)signupButtonClicked:(UIButton *)sender {
    [self signup];
    _UserNameField.text = @"";
    _PasscodeField.text = @"";
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
