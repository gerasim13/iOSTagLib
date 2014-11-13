//
//  TagLib+AIFFCoverArt.cpp
//  Loopseque Twins
//
//  Created by Павел Литвиненко on 23.10.14.
//  Copyright (c) 2014 Casual Underground. All rights reserved.
//

//_______________________________________________________________________________________________________________

#include "TagLib+CoverArt.h"
#include <id3v2tag.h>
#include <tag.h>
#include <aifffile.h>
#include <attachedpictureframe.h>

//_______________________________________________________________________________________________________________

static const char *kArtworkId = "APIC";

//_______________________________________________________________________________________________________________

Boolean get_attached_picture_frame(TagLib::ID3v2::Tag *tag, TagLib::ID3v2::AttachedPictureFrame **frame)
{
    // Check if tag is exists
    if (tag != NULL)
    {
        TagLib::ID3v2::FrameList list = tag->frameListMap()[kArtworkId];
        TagLib::ID3v2::AttachedPictureFrame *_frame;
        if (!list.isEmpty())
        {
            for(TagLib::ID3v2::FrameList::ConstIterator it = list.begin(); it != list.end(); ++it)
            {
                _frame = (TagLib::ID3v2::AttachedPictureFrame *)(*it);
                if (_frame->picture().size() > 0)
                {
                    *frame = _frame;
                    return TRUE;
                }
            }
        }
    }
    return FALSE;
}

//_______________________________________________________________________________________________________________

Boolean CopyCoverArtDataFromFileAtPath(CFStringRef path, CFDataRef *data)
{
    // Open file
    const char *cString = CFStringGetCStringPtr(path, kCFStringEncodingUTF8);
    TagLib::RIFF::AIFF::File audioFile(cString);
    // Get file tag
    TagLib::ID3v2::Tag *tag = audioFile.tag();
    // Check if tag is exists
    if (tag != NULL)
    {
        TagLib::ID3v2::AttachedPictureFrame *frame;
        if (get_attached_picture_frame(tag, &frame))
        {
            // Init data
            *data = CFDataCreate(kCFAllocatorDefault,
                                 (const UInt8*)frame->picture().data(),
                                 frame->picture().size());
        }
        return *data != NULL;
    }
    return FALSE;
}

Boolean SetCoverArtDataToFileAtPath(CFStringRef path, CFDataRef data)
{
    // Open file
    const char *cString = CFStringGetCStringPtr(path, kCFStringEncodingUTF8);
    TagLib::RIFF::AIFF::File audioFile(cString);
    // Get attached picture frame
    TagLib::ID3v2::Tag *tag = audioFile.tag();
    TagLib::ID3v2::AttachedPictureFrame *frame;
    // Set data
    if (tag != NULL)
    {
        const UInt8 *bytes = CFDataGetBytePtr(data);
        TagLib::ByteVector imageData((const char *)bytes, (uint)CFDataGetLength(data));
        // Create new frame
        if (!get_attached_picture_frame(tag, &frame))
        {
            frame = new TagLib::ID3v2::AttachedPictureFrame;
            frame->setMimeType("image/jpeg");
            frame->setPicture(imageData);
            tag->addFrame(frame);
        }
        // Update picture frame
        else
        {
            frame->setMimeType("image/jpeg");
            frame->setPicture(imageData);
        }
    }
    return audioFile.save();
}

//_______________________________________________________________________________________________________________
