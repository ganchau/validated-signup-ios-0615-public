//
//  FISViewController.m
//  validatedSignUp
//
//  Created by Joe Burgess on 7/2/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"

@interface FISViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.firstName.delegate = self;
    self.lastName.delegate = self;
    self.email.delegate = self;
    self.userName.delegate = self;
    self.password.delegate = self;
    
    [self.firstName becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"Text field should return");
    
    NSString *errorMessage;
    
    if (textField.tag == 0) {
        if ([self checkEntryIsNotEmptyAndNotNumbers:textField]) {
            [textField resignFirstResponder];
            self.lastName.enabled = YES;
            [self.lastName becomeFirstResponder];
            return YES;
        } else {
            errorMessage = @"Input can't be empty or numbers";
        }
    } else if (textField.tag == 1) {
        if ([self checkEntryIsNotEmptyAndNotNumbers:textField]) {
            [textField resignFirstResponder];
            self.email.enabled = YES;
            [self.email becomeFirstResponder];
            return YES;
        } else {
            errorMessage = @"Input can't be empty or numbers";
        }
    } else if (textField.tag == 2) {
        if ([self checkEntryIsValidEmail:textField]) {
            [textField resignFirstResponder];
            self.userName.enabled = YES;
            [self.userName becomeFirstResponder];
            return YES;
        } else {
            errorMessage = @"Email is not valid";
        }
    } else if (textField.tag == 3) {
        if ([self checkEntryIsNotEmptyAndNotNumbers:textField]) {
            [textField resignFirstResponder];
            self.password.enabled = YES;
            [self.password becomeFirstResponder];
            return YES;
        } else {
            errorMessage = @"Input can't be empty or numbers";
        }
    } else if (textField.tag == 4) {
        if ([self checkEntryIsAtLeastSixCharacters:textField]) {
            self.submitButton.enabled = YES;
            [textField resignFirstResponder];
            return YES;
        } else {
            errorMessage = @"Password must be at least 6 characters";
        }
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Entry"
                                                                   message:errorMessage
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *clear = [UIAlertAction actionWithTitle:@"Clear"
                                                    style:UIAlertActionStyleDestructive
                                                  handler:^(UIAlertAction *action) {
                                                      textField.text = @"";
                                                      NSLog(@"Clear Action");
                                                  }];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *action) {
                                                   NSLog(@"OK Action");
                                               }];
    [alert addAction:clear];
    [alert addAction:ok];
    
    NSLog(@"CALLING ALERT ACTION!");
    [self presentViewController:alert animated:YES completion:nil];
    
    return NO;
}

- (BOOL)checkEntryIsValidEmail:(UITextField *)textField
{
    if (textField.text.length > 0)
    {
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        
        if ([emailTest evaluateWithObject:textField.text] == YES)
        {
            return YES;
        }
    }
    return NO;
}

- (BOOL)checkEntryIsAtLeastSixCharacters:(UITextField *)textField
{
    if (textField.text.length > 5)
    {
        return YES;
    }
    return NO;
}

- (BOOL)checkEntryIsNotEmptyAndNotNumbers:(UITextField *)textField
{
    NSLog(@"Check entry if valid");
    
        if (textField.text.length > 0 && [textField.text rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location == NSNotFound) {
            return YES;
        }
    return NO;
}

@end
