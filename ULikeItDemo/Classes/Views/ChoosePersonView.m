#import "ChoosePersonView.h"
#import "ImageLabelView.h"
#import "Person.h"

static const CGFloat ChoosePersonViewImageLabelWidth = 42.f;

@interface ChoosePersonView ()
@property (nonatomic, strong) UIView *informationView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *ageLabel;
@end

@implementation ChoosePersonView

#pragma mark - Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
                       person:(Person *)person
                      options:(MDCSwipeToChooseViewOptions *)options {
    self = [super initWithFrame:frame options:options];
    if (self) {
        _person = person;
        self.imageView.image = _person.image;

        self.autoresizingMask = UIViewAutoresizingFlexibleHeight |
                                UIViewAutoresizingFlexibleWidth |
                                UIViewAutoresizingFlexibleBottomMargin;
        self.imageView.autoresizingMask = self.autoresizingMask;

        [self constructInformationView];
    }
    return self;
}

#pragma mark - Internal Methods

- (void)constructInformationView {
    CGFloat bottomHeight = 60.f;
    CGRect bottomFrame = CGRectMake(0,
                                    CGRectGetHeight(self.bounds) - bottomHeight,
                                    CGRectGetWidth(self.bounds),
                                    bottomHeight);
    _informationView = [[UIView alloc] initWithFrame:bottomFrame];
    _informationView.backgroundColor = [UIColor clearColor];
    _informationView.clipsToBounds = NO;
    _informationView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
                                        UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:_informationView];
    [self constructNameLabel];
}

- (void)constructNameLabel {
    CGFloat leftPadding = 19.f;
    CGFloat topPadding = 17.f;
    CGRect frame = CGRectMake(leftPadding,
                              topPadding,
                              floorf(CGRectGetWidth(_informationView.frame)/2),
                              CGRectGetHeight(_informationView.frame) - topPadding);
    _nameLabel = [[UILabel alloc] initWithFrame:frame];
    _nameLabel.font = [UIFont boldSystemFontOfSize: 18];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.text = [NSString stringWithFormat:@"%@", _person.name];
    [_nameLabel sizeToFit];
    [_informationView addSubview:_nameLabel];
    

    frame = CGRectMake(_nameLabel.frame.origin.x + _nameLabel.frame.size.width + 8,
                              6,
                              floorf(CGRectGetWidth(_informationView.frame)/2),
                              CGRectGetHeight(_informationView.frame) - topPadding);
    _ageLabel = [[UILabel alloc] initWithFrame:frame];
    _ageLabel.font = [UIFont fontWithName: @"Arial" size: 16];
    _ageLabel.textColor = [UIColor whiteColor];
    _ageLabel.text = [NSString stringWithFormat:@"| %@",@(_person.age)];
    [_informationView addSubview:_ageLabel];
}


@end
