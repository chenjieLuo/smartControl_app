#ifdef USE_FRAMEWORKS
#import <ParticleSDK/ParticleCloud.h>
#else
#import "ParticleCloud.h"
#endif
#import "ActionsViewController.h"

#define DEVICE_NAME   @"scrapple_raptor"
//#define DEVICE_ID   @"440032000947363339343638" //e.g. 3c0025000b47363330353437
#define DEVICE_RENAME_NAME   @"NOT SET"
#define VARIABLE_NAME   @"NOT SET"
#define FUNCTION_NAME   @"digitalWrite"
#define FUNCTION_ARGUMENTS   @[@"D7", @1]

@interface ActionsViewController()

@property (strong, nonatomic) ParticleDevice *selectedDevice;
//@property (weak, nonatomic) IBOutlet UITextView *TempDisplay;
@property (weak, nonatomic) IBOutlet UISlider *wave850nmControl;
@property (weak, nonatomic) IBOutlet UISlider *wave630nmControl;
@property (weak, nonatomic) IBOutlet UISlider *wave660nmControl;
@property (weak, nonatomic) IBOutlet UISlider *wave940nmControl;
@property (weak, nonatomic) IBOutlet UISlider *wave830nmControl;
@property (weak, nonatomic) IBOutlet UILabel *option1;
@property (weak, nonatomic) IBOutlet UILabel *option2;
@property (weak, nonatomic) IBOutlet UILabel *option3;
@property (weak, nonatomic) IBOutlet UILabel *option4;
@property (weak, nonatomic) IBOutlet UILabel *option5;

@property (weak, nonatomic) IBOutlet UITextField *moduleField;
@property (weak, nonatomic) IBOutlet UITextField *SSIDField;
@property (weak, nonatomic) IBOutlet UITextField *passcodeField;
@property (weak, nonatomic) IBOutlet UITextField *option1_display;
@property (weak, nonatomic) IBOutlet UITextField *option2_display;
@property (weak, nonatomic) IBOutlet UITextField *option3_display;
@property (weak, nonatomic) IBOutlet UITextField *option4_display;
@property (weak, nonatomic) IBOutlet UITextField *option5_display;
@property (weak, nonatomic) IBOutlet UISlider *FrequencyChoice;
@property (weak, nonatomic) IBOutlet UIButton *connectionCheck;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *decisionDone;

@end


@implementation ActionsViewController {
    id _eventListenerID;
    NSArray *choices;
}

- (IBAction)connectDevice:(id)sender {
    
    device_ID = [self checkDeviceID];
}
- (IBAction)decisionFinished:(id)sender {
    NSLog(@"%d", userDecision);
    if (userDecision == 0|| userDecision == 1){
        _opt1.userInteractionEnabled = NO;
        _opt1.alpha = 0.5;
        _opt2.userInteractionEnabled = NO;
        _opt2.alpha = 0.5;
        _opt3.userInteractionEnabled = NO;
        _opt3.alpha = 0.5;
        _opt4.userInteractionEnabled = NO;
        _opt4.alpha = 0.5;
        _opt5.userInteractionEnabled = NO;
        _opt5.alpha = 0.5;
        _opt6.userInteractionEnabled = NO;
        _opt6.alpha = 0.5;
        _opt7.userInteractionEnabled = NO;
        _opt7.alpha = 0.5;
    }
    else {
        _opt1.userInteractionEnabled = YES;
        _opt1.alpha = 1;
        _opt2.userInteractionEnabled = YES;
        _opt2.alpha = 1;
        _opt3.userInteractionEnabled = YES;
        _opt3.alpha = 1;
        _opt4.userInteractionEnabled = YES;
        _opt4.alpha = 1;
        _opt5.userInteractionEnabled = YES;
        _opt5.alpha = 1;
        _opt6.userInteractionEnabled = YES;
        _opt6.alpha = 1;
        _opt7.userInteractionEnabled = YES;
        _opt7.alpha = 1;
    }
}

- (IBAction)_option1Control:(id)sender {
    UISlider *myControl = (UISlider *)sender;
    if (currentChoice.selectedSegmentIndex == 0)
        [self upload_request:@"_GWGWG" atIndex:myControl.value/2];
    else if (currentChoice.selectedSegmentIndex == 1)
        [self upload_request:@"_850nm" atIndex:myControl.value/2];
    NSString *string = [NSString stringWithFormat:@"%d",(int)myControl.value/2];
    _option1_display.text = string;
}
- (IBAction)_option2Control:(id)sender {
    UISlider *myControl = (UISlider *)sender;
    if (currentChoice.selectedSegmentIndex == 0)
        [self upload_request:@"_WWWWW" atIndex:myControl.value/2];
    else if (currentChoice.selectedSegmentIndex == 1)
        [self upload_request:@"_940nm" atIndex:myControl.value/2];
    NSString *string = [NSString stringWithFormat:@"%d",(int)myControl.value/2];
    _option2_display.text = string;
}
- (IBAction)_option3Control:(id)sender {
    UISlider *myControl = (UISlider *)sender;
    if (currentChoice.selectedSegmentIndex == 0)
        [self upload_request:@"_RRRRR" atIndex:myControl.value/2];
    else if (currentChoice.selectedSegmentIndex == 1)
        [self upload_request:@"_830nm" atIndex:myControl.value/2];
    NSString *string = [NSString stringWithFormat:@"%d",(int)myControl.value/2];
    _option3_display.text = string;
}
- (IBAction)_option4Control:(id)sender {
    UISlider *myControl = (UISlider *)sender;
    if (currentChoice.selectedSegmentIndex == 0)
        [self upload_request:@"_GGGGG" atIndex:myControl.value/2];
    else if (currentChoice.selectedSegmentIndex == 1)
        [self upload_request:@"_660nm" atIndex:(int)myControl.value/2];
    NSString *string = [NSString stringWithFormat:@"%d",(int)myControl.value/2];
    _option4_display.text = string;
}
- (IBAction)_option5Control:(id)sender {
    UISlider *myControl = (UISlider *)sender;
    if (currentChoice.selectedSegmentIndex == 0)
        [self upload_request:@"_BBBBB" atIndex:myControl.value/2];
    else if (currentChoice.selectedSegmentIndex == 1)
        [self upload_request:@"_630nm" atIndex:myControl.value/2];
    NSString *string = [NSString stringWithFormat:@"%d",(int)myControl.value/2];
    _option5_display.text = string;
}
- (IBAction)ModeSelection:(id)sender {
    currentChoice = (UISegmentedControl *)sender;
    if(currentChoice.selectedSegmentIndex == 0){
        _option1.text = @"GW";
        _option2.text = @"WW";
        _option3.text = @"Red";
        _option4.text = @"Green";
        _option5.text = @"Blue";
    }
    else if(currentChoice.selectedSegmentIndex == 1){
        _option1.text = @"850nm";
        _option2.text = @"940nm";
        _option3.text = @"830nm";
        _option4.text = @"660nm";
        _option5.text = @"630nm";
    }
}
- (IBAction)startTreatment:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if([mySwitch isOn]){
        _ModeChoice.enabled = NO;
        Recording = TRUE;
        [self upload_request:@"START" atIndex:0];
    }
    else{
        _ModeChoice.enabled = YES;
        Recording = FALSE;
        [self upload_request:@"STOP" atIndex:0];
    }
}
- (IBAction)FrequencyUpdate:(id)sender {
    UISlider *myControl = (UISlider *)sender;
    myControl.value = round(myControl.value);
    NSLog(@"%f",myControl.value);
    [self upload_request:@"FREQUENCY" atIndex:myControl.value];
}

@synthesize selectedDevice;


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return choices.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    userDecision = row;
    return choices[row];
}

-(NSString *)upload_request:(NSString*)options atIndex:(int)brightness{
    
    NSString *url = [NSString stringWithFormat:@"https://api.particle.io/v1/devices/%@/led?access_token=%@",device_ID,[ParticleCloud sharedInstance].accessToken];
    NSString *post;
    
    if ([options isEqualToString:@"_630nm"] && Recording == TRUE){
        post = [NSString stringWithFormat:@"param=%01d630nm%04d%@",currentChoice.selectedSegmentIndex, brightness,@"T"];
        NSLog(post);
    }
    else if([options isEqualToString:@"_630nm"] && Recording == FALSE){
        post = [NSString stringWithFormat:@"param=%01d630nm%04d%@",currentChoice.selectedSegmentIndex, brightness,@"F"];
    }
    else if([options isEqualToString:@"_660nm"] && Recording == TRUE){
        post = [NSString stringWithFormat:@"param=%01d660nm%04d%@",currentChoice.selectedSegmentIndex, brightness,@"T"];
    }
    else if([options isEqualToString:@"_660nm"] && Recording == FALSE){
        post = [NSString stringWithFormat:@"param=%01d660nm%04d%@",currentChoice.selectedSegmentIndex, brightness,@"F"];
    }
    else if([options isEqualToString: @"_850nm"] && Recording == TRUE){
        post = [NSString stringWithFormat:@"param=%01d850nm%04d%@",currentChoice.selectedSegmentIndex, brightness,@"T"];
    }
    else if([options isEqualToString: @"_850nm"] && Recording == FALSE){
        post = [NSString stringWithFormat:@"param=%01d850nm%04d%@",currentChoice.selectedSegmentIndex, brightness,@"F"];
    }
    else if([options isEqualToString: @"_940nm"] && Recording == TRUE){
        post = [NSString stringWithFormat:@"param=%01d940nm%04d%@",currentChoice.selectedSegmentIndex, brightness, @"T"];
    }
    else if([options isEqualToString: @"_940nm"] && Recording ==FALSE){
        post = [NSString stringWithFormat:@"param=%01d940nm%04d%@",currentChoice.selectedSegmentIndex, brightness, @"F"];
    }
    else if([options isEqualToString: @"_830nm"] && Recording == TRUE){
        post = [NSString stringWithFormat:@"param=%01d830nm%04d%@",currentChoice.selectedSegmentIndex, brightness,@"T"];
    }
    else if([options isEqualToString: @"_830nm"] && Recording == FALSE){
        post = [NSString stringWithFormat:@"param=%01d830nm%04d%@",currentChoice.selectedSegmentIndex, brightness,@"F"];
    }
    else if([options isEqualToString: @"_GWGWG"] && Recording == TRUE){
        post = [NSString stringWithFormat:@"param=%01dWGWGW%04d%@",currentChoice.selectedSegmentIndex, brightness, @"T"];
    }
    else if([options isEqualToString: @"_GWGWG"] && Recording == FALSE){
        post = [NSString stringWithFormat:@"param=%01dWGWGW%04d%@",currentChoice.selectedSegmentIndex, brightness, @"F"];
    }
    else if([options isEqualToString: @"_WWWWW"] && Recording == TRUE){
        post = [NSString stringWithFormat:@"param=%01dWWWWW%04d%@",currentChoice.selectedSegmentIndex, brightness, @"T"];
    }
    else if([options isEqualToString: @"_WWWWW"] && Recording == FALSE){
        post = [NSString stringWithFormat:@"param=%01dWWWWW%04d%@",currentChoice.selectedSegmentIndex, brightness, @"F"];
    }
    else if([options isEqualToString: @"_RRRRR"] && Recording == TRUE){
        post = [NSString stringWithFormat:@"param=%01dRRRRR%04d%@",currentChoice.selectedSegmentIndex, brightness, @"T"];
    }
    else if([options isEqualToString: @"_RRRRR"] && Recording == FALSE){
        post = [NSString stringWithFormat:@"param=%01dRRRRR%04d%@",currentChoice.selectedSegmentIndex, brightness, @"F"];
    }
    else if([options isEqualToString: @"_GGGGG"] && Recording == TRUE){
        post = [NSString stringWithFormat:@"param=%01dGGGGG%04d%@",currentChoice.selectedSegmentIndex, brightness,@"T"];
    }
    else if([options isEqualToString: @"_GGGGG"] && Recording == FALSE){
        post = [NSString stringWithFormat:@"param=%01dGGGGG%04d%@",currentChoice.selectedSegmentIndex, brightness,@"F"];
    }
    else if([options isEqualToString: @"_BBBBB"] && Recording == TRUE){
        post = [NSString stringWithFormat:@"param=%01dBBBBB%04d%@",currentChoice.selectedSegmentIndex, brightness,@"T"];
    }
    else if([options isEqualToString: @"_BBBBB"] && Recording == FALSE){
        post = [NSString stringWithFormat:@"param=%01dBBBBB%04d%@",currentChoice.selectedSegmentIndex, brightness,@"F"];
    }
    else if([options isEqualToString: @"START"]){
        post = [NSString stringWithFormat:@"param=%01dSTARTRECI%@",currentChoice.selectedSegmentIndex,@"T"];
    }
    else if([options isEqualToString: @"STOP"]){
        post = [NSString stringWithFormat:@"param=%01dTERMINATE%@",currentChoice.selectedSegmentIndex,@"F"];
    }
    else if([options isEqualToString:@"FREQUENCY"] && Recording == TRUE){
        post = [NSString stringWithFormat:@"param=%01dFREUPDATE%@%01d",currentChoice.selectedSegmentIndex,@"T", brightness]; //here use brightness to represent current frequency choice
    }
    else if([options isEqualToString:@"FREQUENCY"] && Recording == FALSE){
        post = [NSString stringWithFormat:@"param=%01dFREUPDATE%@%01d",currentChoice.selectedSegmentIndex,@"F", brightness]; //here use brightness to represent current frequency choice
    }
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setURL:[NSURL URLWithString:url]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", url, (long)[responseCode statusCode]);
        return nil;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Response" message:[[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    //[alert show];
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

//- (NSString *) grabFromRequest{
//    NSString * url = [NSString stringWithFormat:@"https://api.particle.io/v1/devices/440032000947363339343638/analogValue?access_token=76ece3d063930304250dc72065676649c905a4e7"];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setHTTPMethod:@"GET"];
//    [request setURL:[NSURL URLWithString:url]];
//
//    NSError *error = nil;
//    NSHTTPURLResponse *responseCode = nil;
//
//    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
//
//    if([responseCode statusCode] != 200){
//        NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
//        return nil;
//    }
//    NSLog([[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding]);
//    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
//}

-(NSString *) checkDeviceID{
//        NSString * url = [NSString stringWithFormat:@"http://192.168.0.1/device-id"];
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//        [request setHTTPMethod:@"GET"];
//        [request setURL:[NSURL URLWithString:url]];
//
//        NSError *error = nil;
//        NSHTTPURLResponse *responseCode = nil;
//
//        NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
//
//        if([responseCode statusCode] != 200){
//            NSString *errorstr = [NSString stringWithFormat:@"Error getting device ID"];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error message" message:errorstr delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alert show];
//            return nil;
//        }
//        else{
//        NSString *output = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
//            output = [output substringWithRange:NSMakeRange(7, 24)];
//            NSLog(output);
////            for (int i = 0; i < output.length;i++){
////                if(!(48<=(int)[output substringWithRange:NSMakeRange(i,i+1)] && (int)[output substringWithRange:NSMakeRange(i,i+1)] <=57)){
////                    NSString *errorstr = [NSString stringWithFormat:@"Error getting device ID. Please connect to WLAN network named Photon and try again. "];
////                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error message" message:errorstr delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
////                    [alert show];
////                    return output;
////                }
////            }
//            NSString *astr = [NSString stringWithFormat:@"Your device ID has been obtained! You can start controlling the device now! "];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your device ID has been obtained!" message:astr delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alert show];
//            return output;
//        }
    NSString *output = @"3d003e000747363339343638";
    NSLog(@"Succeed");
    return output;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateUI];
    
    choices = @[@"Your most frequent choice", @"Common choice from big data",@"I want to decide by myself"];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    //_TempDisplay.text = [self grabFromRequest];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    //if we leave this view, we make sure to unsubscribe from the events stream
//    [self unsubscribeFromEvents];
    self.selectedDevice = nil;
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//    switch (indexPath.section) {
//        case 0:
//            //Cloud
//            switch (indexPath.row) {
//                case 0:
//                    [self listDevices];
//                    break;
//                case 1:
//                    [self selectRandomDevice];
//                    break;
//                case 2:
//                    [self selectDeviceWithName:DEVICE_NAME];
//                    break;
//                case 3:
//                    [self selectDeviceWithID:device_ID];
//                    break;
//                case 4:
//                    [self claimDevice:device_ID];
//                    break;
//            }
//            break;
//        case 1:
//            //Device
//            switch (indexPath.row) {
//                case 0:
//                    [self refreshDevice];
//                    break;
//                case 1:
//                    [self listVariables];
//                    break;
//                case 2:
//                    [self listFunctions];
//                    break;
//                case 3:
//                    [self getVariable:VARIABLE_NAME];
//                    break;
//                case 4:
//                    [self callFunction];
//                    break;
//                case 5:
//                    [self renameDevice:DEVICE_RENAME_NAME];
//                    break;
//                case 6:
//                    [self unclaimDevice];
//                    break;
//            }
//            break;
//        case 2:
//            //Events
//            if (_eventListenerID) {
//                [self unsubscribeFromEvents];
//            } else {
//                [self subscribeToEvents];
//            }
//            break;
//        case 3:
//            //Control different functions
//            switch (indexPath.row) {
//                case 0:
//                    [self refreshDevice];
//                    break;
//                case 1:
//                    [self listVariables];
//                    break;
//                case 2:
//                    [self listFunctions];
//                    break;
//            }
//            break;
//    }
//}

#pragma mark Helpers

- (void)updateUI {
    //    [_small_angleControl setOn:NO animated:YES];
    //    [_large_angleControl setOn:NO animated:YES];
    //
    //    [_wave660nmControl setOn:NO animated:YES];
    //    [_wave940nmControl setOn:NO animated:YES];
    //    [_wave410nmControl setOn:NO animated:YES];
    
    _opt1.userInteractionEnabled = NO;
    _opt1.alpha = 0.5;
    _opt2.userInteractionEnabled = NO;
    _opt2.alpha = 0.5;
    _opt3.userInteractionEnabled = NO;
    _opt3.alpha = 0.5;
    _opt4.userInteractionEnabled = NO;
    _opt4.alpha = 0.5;
    _opt5.userInteractionEnabled = NO;
    _opt5.alpha = 0.5;
    _opt6.userInteractionEnabled = NO;
    _opt6.alpha = 0.5;
    _opt7.userInteractionEnabled = NO;
    _opt7.alpha = 0.5;
    
    currentChoice.selectedSegmentIndex = 0;
 
    _option1_display.enabled = NO;
    [_option1_display resignFirstResponder];
    _option2_display.enabled = NO;
    [_option2_display resignFirstResponder];
    _option3_display.enabled = NO;
    [_option3_display resignFirstResponder];
    _option4_display.enabled = NO;
    [_option4_display resignFirstResponder];
    _option5_display.enabled = NO;
    [_option5_display resignFirstResponder];
    [_startSwtich setOn:NO animated:YES];
    _option1_display.text = @"0";
    _option2_display.text = @"0";
    _option3_display.text = @"0";
    _option4_display.text = @"0";
    _option5_display.text = @"0";
}


- (void)listFunctions {
    if (!self.selectedDevice) {
        NSLog(@"Error trying to list device functions. You must first select a device using one of the cloud actions.");
        return;
    }
    
    NSLog(@"Particle device functions available: %u", self.selectedDevice.functions.count);
    for (NSString* name in self.selectedDevice.functions) {
        NSLog(@"%@", name);
    }
}


#pragma mark Particle Events

- (void)subscribeToEvents {
    if (_eventListenerID) {
        [self unsubscribeFromEvents];
    }
    
    _eventListenerID = [[ParticleCloud sharedInstance] subscribeToMyDevicesEventsWithPrefix:nil handler:^(ParticleEvent *event, NSError *error) {
        if (!error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Got event with name %@ and data %@", event.event, event.data);
            });
        }
        else
        {
            NSLog(@"Error occurred: %@", error.localizedDescription);
        }
    }];
    
    if (_eventListenerID) {
        //Update UI state
        [self updateUI];
        NSLog(@"Successfully subscribed to device events. Will receive all public and private events sent by your device fleet.");
    }
}


- (void)unsubscribeFromEvents {
    if (_eventListenerID) {
        [[ParticleCloud sharedInstance] unsubscribeFromEventWithID:_eventListenerID];
        _eventListenerID = nil;
        
        NSLog(@"Successfully unsubscribed from device events. Will no longer receive events sent by your device fleet.");
    }
    
    //Update UI state
    [self updateUI];
    
}


@end

