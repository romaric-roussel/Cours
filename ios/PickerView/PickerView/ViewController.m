//
//  ViewController.m
//  PickerView
//
//  Created by lpiem on 08/11/2018.
//  Copyright © 2018 lpiem. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, UIDatePickerviewComponentId){
    ACTIVIES =0,
    MOOD= 1
};

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
    NSInteger row = [self.picker selectedRowInComponent:ACTIVIES];
    NSString *activity = [self.activities objectAtIndex:row];
    NSString *text = self.textField.text;
    

    
    row = [self.picker selectedRowInComponent:MOOD];
    NSString *mood = [self.moods objectAtIndex:row];
    
    NSString *msg = [NSString stringWithFormat:@" %@ %@ et se sens %@ ",text,activity,mood];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[msg] applicationActivities:nil];
    NSArray *excludedActivities = @[UIActivityTypeAddToReadingList,
                                    UIActivityTypeAirDrop,
                                    UIActivityTypeAssignToContact,
                                    UIActivityTypeOpenInIBooks,
                                    UIActivityTypePrint,
                                    UIActivityTypeSaveToCameraRoll,
                                    UIActivityTypeMarkupAsPDF];
    
    [activityVC setExcludedActivityTypes:excludedActivities];
    activityVC.completionWithItemsHandler = ^(UIActivityType activityType,BOOL completed, NSArray *returnedItems, NSError *activityError){
        NSString *message;
        if(completed){
            message = @"Partage terminer";
        }else {
            message = @"Partage annuler";
        }
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Partage" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil ];
    };
    
    [self presentViewController:activityVC animated:YES completion:nil];
    //NSLog(@"%@",msg);
}

#pragma mark -Picker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == ACTIVIES){
        return self.activities.count;
    } else {
        return self.moods.count;
    }
}

#pragma mark -Picker view delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if(component == ACTIVIES){
        return self.activities[row];
    } else {
        //return self.moods[row];
        return [[self moods] objectAtIndex:row];

        
    }
    
}


@end
