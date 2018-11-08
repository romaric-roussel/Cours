//
//  ViewController.m
//  PickerView
//
//  Created by lpiem on 08/11/2018.
//  Copyright © 2018 lpiem. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong) NSArray<NSString *> *activities;
@property(nonatomic,strong) NSArray<NSString *> *moods;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.activities = @[@"dors",@"mange",@"suis en cours",@"galère",@"cours",@"poireaute"];
    self.moods = @[@";)", @":)", @":(", @":O", @"8)", @":o", @":D", @"mdr", @"lol"];
}

-(IBAction)dissmissKeyboard {
    [self.view endEditing:YES];

}


- (IBAction)tweetbuttonpressed:(id)sender {
    NSInteger row = [self.picker selectedRowInComponent:0];
    NSString *activity = [self.activities objectAtIndex:row];
    NSString *text = self.textField.text;

    
    row = [self.picker selectedRowInComponent:1];
    NSString *mood = [self.moods objectAtIndex:row];
    
    NSString *msg = [NSString stringWithFormat:@" %@ %@ et se sens %@ ",text,activity,mood];
    NSLog(@"%@",msg);
}

#pragma mark -Picker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return self.activities.count;
    } else {
        return self.moods.count;
    }
}

#pragma mark -Picker view delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if(component == 0){
        return self.activities[row];
    } else {
        //return self.moods[row];
        return [[self moods] objectAtIndex:row];

        
    }
    
}


@end
