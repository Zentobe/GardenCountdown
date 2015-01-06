//
//  ViewController.m
//  GardenCountdown
//
//  Created by Dabid Nguyen on 11/9/14.
//  Copyright (c) 2014 David Nguyen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

@synthesize timer;
@synthesize daysText;
@synthesize hoursText;
@synthesize minutesText;
@synthesize timerLabel;
@synthesize pauseButton;
@synthesize startButton;
@synthesize resetButton;
@synthesize editButton;
- (void)viewDidLoad{
    [super viewDidLoad];
    [pauseButton setEnabled:NO];
    [resetButton setEnabled:NO];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)runScheduledTask: (NSTimer *) runningTimer {
    int days, hours, minutes;
    secondsLeft--;
    days = secondsLeft / 86400;
    hours = secondsLeft / 3600;
    minutes = (secondsLeft % 3600) / 60;
    if (secondsLeft > 86400){
        hours = hours - (days*24);
        timerLabel.text =[NSString stringWithFormat:@"Time Remaining %02d:%02d:%02d", days, hours, minutes];
    }
    else{
    timerLabel.text =[NSString stringWithFormat:@"Time Remaining %02d:%02d:%02d", days, hours, minutes];
    if (secondsLeft==0) {
        [timer invalidate];
        timerLabel.text = @"Time up!!";
    }
}
}
- (IBAction)edit:(id)sender {
}

- (IBAction)startTimer:(id)sender {
    int sDays, sHours, sMinutes;
    [pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    daysLeft = [daysText.text intValue];
    hoursLeft = [hoursText.text intValue];
    minutesLeft = [minutesText.text intValue];
    sDays = daysLeft*86400;
    sHours = hoursLeft*3600;
    sMinutes = minutesLeft*60;
    secondsLeft = sDays + sHours + sMinutes;
    // This will allow 10,000 Hours Timer Limits
    if (secondsLeft >0) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runScheduledTask:) userInfo:nil repeats:YES];
        [startButton setEnabled:NO];
        [pauseButton setEnabled:YES];
        [resetButton setEnabled:YES];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please! enter valid timer value" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)stopTimer:(id)sender {
    if ([@"Pause" isEqualToString:[pauseButton titleForState:UIControlStateNormal]]) {
        NSLog(@"Paused");
        [pauseButton setTitle:@"Resume" forState:UIControlStateNormal];
        [startButton setEnabled:NO];
        [pauseButton setEnabled:YES];
        [resetButton setEnabled:NO];
        if (timer != nil) {
            [timer invalidate];
            int days, hours, minutes;
            days = secondsLeft / 86400;
            hours = secondsLeft / 3600;
            minutes = (secondsLeft % 3600) / 60;
            if (secondsLeft > 86400){
                hours = hours - (days*24);
                timerLabel.text =[NSString stringWithFormat:@"Time Remaining %02d:%02d:%02d", days, hours, minutes];
            }
            else{
                timerLabel.text =[NSString stringWithFormat:@"Time Remaining %02d:%02d:%02d", days, hours, minutes];
            }}}
    else{
        NSLog(@"Resumed");
        [pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        [startButton setEnabled:NO];
        [pauseButton setEnabled:YES];
        [resetButton setEnabled:YES];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runScheduledTask:) userInfo:nil repeats:YES];
        if (secondsLeft==0) {
            NSLog(@"Water your plant");
            [timer invalidate];
            timerLabel.text = @"Time up!!";
        }
    }
}

- (IBAction)resetTimer:(id)sender {
    [startButton setEnabled:YES];
    [pauseButton setEnabled:NO];
    [resetButton setEnabled:NO];
    [pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    if (timer != nil) {
        [timer invalidate];
        timerLabel.text = @"Timer got reset!!";
    }else{
        NSLog(@"timer is nil");
    }
    daysText.text=@"";
    hoursText.text=@"";
    minutesText.text=@"";
}

-(IBAction)keypadGoBack:(id)sender{
    [daysText resignFirstResponder];
    [hoursText resignFirstResponder];
    [minutesText resignFirstResponder];
}
- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
@end
