#import "L0PickerCell.h"

@implementation L0PickerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        _picker = [[UIPickerView alloc] initWithFrame:CGRectZero];

        [_picker setDelegate:self];
        [_picker setDataSource:self];

        UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];

        [bar setItems:@[
           [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                         target:self
                                                         action:@selector(dismissPicker)],
        ]];

        [[self field] setInputView:_picker];
        [[self field] setInputAccessoryView:bar];
        [[self field] setTintColor:[UIColor clearColor]];
    }

    return self;
}

- (bool)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
    return NO;
}

- (void)dismissPicker {
    [[self field] setText:[self options][[[self picker] selectedRowInComponent:0]]];
    [[self field] endEditing:YES];
    [[self delegate] textFieldDidChange:[self field]];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView { return 1; }

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    return [[self options] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    return [self options][row];
}

@end
