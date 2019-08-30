#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ActionsViewController : UITableViewController <UIPickerViewDataSource,UIPickerViewDelegate>

//@property (weak, nonatomic) IBOutlet UILabel *eventsCellLabel;
//
//@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *deviceIdLabel;
//@property (weak, nonatomic) IBOutlet UILabel *deviceIdLabel2;
//
//@property (weak, nonatomic) IBOutlet UILabel *variableNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *functionNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *renameLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ModeChoice;
@property (weak, nonatomic) IBOutlet UISwitch *startSwtich;
@property (weak, nonatomic) IBOutlet UIView *opt1;
@property (weak, nonatomic) IBOutlet UIView *opt2;
@property (weak, nonatomic) IBOutlet UIView *opt3;
@property (weak, nonatomic) IBOutlet UIView *opt4;
@property (weak, nonatomic) IBOutlet UIView *opt5;
@property (weak, nonatomic) IBOutlet UIView *opt6;
@property (weak, nonatomic) IBOutlet UIView *opt7;


@end


UISegmentedControl *currentChoice;
NSString *device_ID;
int userDecision = 0;
BOOL Recording = FALSE;
