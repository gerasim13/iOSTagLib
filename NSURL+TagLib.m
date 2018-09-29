//
//  NSURL+TagLib.m
//  Loopseque Twins
//
//  Created by Павел Литвиненко on 25.09.14.
//  Copyright (c) 2014 Casual Underground. All rights reserved.
//

//_______________________________________________________________________________________________________________

#import "NSURL+TagLib.h"
#import "TagLib+CoverArt.h"
#import "tag_c.h"

//_______________________________________________________________________________________________________________

@implementation NSURL (TagLib)
@dynamic artwork;
@dynamic artistName;
@dynamic trackTitle;
@dynamic trackLength;

//_______________________________________________________________________________________________________________

#pragma mark - Getters

- (NSString*)artistName
{
    TagLib_File *file = taglib_file_new([self.path UTF8String]);
    NSString    *str  = nil;
    // Check opened file
    if (file && taglib_file_is_valid(file))
    {
        TagLib_Tag *tag = taglib_file_tag(file);
        char       *val = taglib_tag_artist(tag);
        str = [NSString stringWithUTF8String:val];
        // Free taglib string
        taglib_free(val);
    }
    // Close file
    taglib_file_free(file);
    // Return string
    return str;
}

- (NSString*)trackTitle
{
    TagLib_File *file = taglib_file_new([self.path UTF8String]);
    NSString    *str  = nil;
    // Check opened file
    if (file && taglib_file_is_valid(file))
    {
        TagLib_Tag *tag = taglib_file_tag(file);
        char       *val = taglib_tag_title(tag);
        str = [NSString stringWithUTF8String:val];
        // Free taglib string
        taglib_free(val);
    }
    // Close file
    taglib_file_free(file);
    // Return string
    return str;
}

- (UIImage*)artwork
{
    CFStringRef _path = (__bridge CFStringRef)(self.path);
    CFDataRef   _data = NULL;
    UIImage    *_img  = nil;
    // Get data from file
    if (!CopyCoverArtDataFromFileAtPath(_path, &_data))
    {
        goto exit;
    }
exit:
    // Init image with data and release fata
    if (_data)
    {
        _img = [UIImage imageWithData:(__bridge NSData *)(_data)];
        CFRelease(_data);
    }
    // Return image
    return _img;
}

- (NSUInteger)trackLength
{
    TagLib_File *file = taglib_file_new([self.path UTF8String]);
    NSUInteger   length = 0;
    // Check opened file
    if (file && taglib_file_is_valid(file))
    {
        const TagLib_AudioProperties *props = taglib_file_audioproperties(file);
        if (props)
        {
            length = taglib_audioproperties_length(props);
        }
    }
    // Close file
    taglib_file_free(file);
    return length;
}

//_______________________________________________________________________________________________________________

#pragma mark - Setters

- (void)setArtistName:(NSString*)artist
{
    TagLib_File *file = taglib_file_new([self.path UTF8String]);
    // Check opened file
    if (file && taglib_file_is_valid(file))
    {
        TagLib_Tag *tag = taglib_file_tag(file);
        taglib_tag_set_artist(tag, [artist UTF8String]);
    }
    // Close file
    taglib_file_save(file);
    taglib_file_free(file);
}

- (void)setTrackTitle:(NSString*)title
{
    TagLib_File *file = taglib_file_new([self.path UTF8String]);
    // Check opened file
    if (file && taglib_file_is_valid(file))
    {
        TagLib_Tag *tag = taglib_file_tag(file);
        taglib_tag_set_title(tag, [title UTF8String]);
    }
    // Close file
    taglib_file_save(file);
    taglib_file_free(file);
}

- (void)setArtwork:(UIImage*)artwork
{
    CFStringRef _path = (__bridge CFStringRef)(self.path);
    CFDataRef   _data = (__bridge CFDataRef)(UIImageJPEGRepresentation(artwork, 1.0));
    // Set artwork
    if (!SetCoverArtDataToFileAtPath(_path, _data))
    {
        NSLog(@"Failed to write cover art image for file at path: %@", self.relativePath);
    }
}

@end

//_______________________________________________________________________________________________________________
