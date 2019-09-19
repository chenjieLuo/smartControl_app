#import <UIKit/UIKit.h>
@import Firebase;
@import FirebaseAnalytics;
@import FileProviderUI;
@interface ParticleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *actionsButton;
@property (weak, nonatomic) IBOutlet UITextField *UserNameField;
@property (weak, nonatomic) IBOutlet UITextField *PasscodeField;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (weak, nonatomic) IBOutlet UIButton *SignupButton;

@property NSString * usernameinput;
@property NSString * userpasswordinput;

@end
