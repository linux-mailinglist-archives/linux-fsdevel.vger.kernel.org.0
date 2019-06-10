Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E37F53B1BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 11:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388937AbfFJJNV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 05:13:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45352 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388552AbfFJJNU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 05:13:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id a14so11629020edv.12;
        Mon, 10 Jun 2019 02:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XUO2prDNG3Z4+bvBu/kgUEo+gh5mp6CPVrZuoACghm0=;
        b=RqKP5bUpTLIi02Ol2JERk2hNja6L7hZ+UONPawOJjcEv+KkuuiuDH8N3NXrpNED93T
         5khn2IZrUmNNKEarXO7S+XR/Wz+VhjruxgmnKClbj1bXAdU7pwJMHmwH9WPdUFFIU4IJ
         4grz9jUiAkwaoHRBrMEMsrRXHXm18mAyQOk7Z/JnetzXzjC9sK88Tl1jBJ7XYi1diWoQ
         GSwzutxZPf9I5j7XfmOf5LvPZdqoimUPUsug3DTTygAN9Y/PCpJAUMPc9fqh2M35auns
         5xSWFu7p2E5g5ReniEyOM9zu0c57D3voIp4y1JWACUOG3R7XP7mdJZ2Jr3BAKDxKcaMH
         T3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XUO2prDNG3Z4+bvBu/kgUEo+gh5mp6CPVrZuoACghm0=;
        b=uI9sw50VoHQbRl5Sfj2hAoPUbTp71YZO46Vi38WEf8dkZpkTfGAzBF8L/tcKb9m9dS
         Ss9Ei95eGl6lpyIRpGCE7CV+rzYFXj3BcMRHZocXeyGASN62s8EZwYLBuQWAxbkGLClA
         cGPkQfaZu/wJYngqaBgldiLkjR6gcsDYEwL7kpkiWbAYbcYW4tRQnhLZzhw30ArNptFr
         o69rKwrBrh6oopFvY07yZMEmvo+wF+H7r0X9yMXIzKO3ZZM8rPO/D7jbsizUAFrB31Tw
         bb6WHEUcdHaGoAznKg61yFgkiTSzZM1x61EJohZ3LTal9nWDjpY4vv3K4s9lhef6gjIb
         Akew==
X-Gm-Message-State: APjAAAU9KTf9Rne6RhxCfY10YP063yzrya2eMtlAyAbfml/COD6ffpTA
        XRAU8RdF/RzQQNEq2gWsUjA=
X-Google-Smtp-Source: APXvYqzWVB5mD/4eZUxThXmVtZ0X+RmcMWys7gMWWyd7blFIHEOzjCk0nK2NcnObBLWxPACL6RQb6w==
X-Received: by 2002:a17:906:4e92:: with SMTP id v18mr2175109eju.57.1560157997895;
        Mon, 10 Jun 2019 02:13:17 -0700 (PDT)
Received: from [192.168.8.116] ([194.230.158.99])
        by smtp.gmail.com with ESMTPSA id d16sm2699502edx.85.2019.06.10.02.13.16
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 02:13:16 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        amir73il@gmail.com, jack@suse.cz
Subject: Re: [PATCH v3] fanotify.7, fanotify_init.2, fanotify_mark.2: Document
 FAN_REPORT_FID and directory modification events
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
References: <20190606094756.GA4351@poseidon.Home>
 <1d07e65b-8c32-b7ca-b69f-d5582c26ed1c@gmail.com>
 <20190609084425.GA5601@poseidon.Home>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <53ecd7bb-cfbe-90b5-9b47-2f2571dc79fe@gmail.com>
Date:   Mon, 10 Jun 2019 11:13:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190609084425.GA5601@poseidon.Home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Matthew,

On 6/9/19 10:44 AM, Matthew Bobrowski wrote:
> Hi Michael,
> 
> On Sat, Jun 08, 2019 at 01:58:00PM +0200, Michael Kerrisk (man-pages) wrote:

[...]

>>> +.BR FAN_REPORT_FID " (since Linux 5.1)"
>>> +.\" commit a8b13aa20afb69161b5123b4f1acc7ea0a03d360
>>> +This value allows the receipt of events which contain additional information
>>> +about the underlying object correlated to an event.
>>
>> In a few places, I changed "object" to "filesystem object", just to
>> reduce the chance of ambiguity a little.
> 
> Good thought. This does read better.

Okay.

[...]

>>> diff --git a/man2/fanotify_mark.2 b/man2/fanotify_mark.2
>>> index 3c6e9565a..ce7aa9804 100644
>>> --- a/man2/fanotify_mark.2
>>> +++ b/man2/fanotify_mark.2

[...]

>>> +Depending on whether
>>> +.BR FAN_REPORT_FID
>>> +is supplied as one of the flags when calling
>>> +.BR fanotify_init (2)
>>> +determines what structure(s) are returned for an event within the read
>>> +buffer.
>>
>> The wording here in the preceding sentence is a bit off:
>>
>>       "Depending on... determines"
>>
>> Can you clarify?
> 
> OK. So, if FAN_REPORT_FID is provided as a flag to fanotify_init(), then
> the use of this flag influences what data structure(s) an event listener
> can expect to receive for each event i.e.
> 
> - For an event listener that does _not_ make use of the FAN_REPORT_FID
>    flag should expect to _only_ receive the data structure of type
>    fanotify_event_metadata used to describe a single event.
> 
> However, on the other hand.
> 
> - For an event listener that _does_ make use of the FAN_REPORT_FID flag
>    should expect to receive data structures of type
>    fanotify_event_metadata and fanotify_event_info_fid used to describe a
>    single event.
> 
> With that being said, depending on whether FAN_REPORT_FID is, or is not
> specified, determines the type of data structures that an event
> listener can expect to receive for a single event.
> 
> I'm happy to reword this if necessary.


Okay -- if you could send a patch against current Git, that would
be great.

[...]

>>> -The following output was recorded while editing the file
>>> +The second program (fanotify_fid.c) is an example of fanotify being used
>>> +with
>>> +.B FAN_REPORT_FID
>>> +enabled.
>>> +It attempts to mark the object that is passed as a command-line argument
>>
>> Why the wording "It attempts to mark the" vs "It marks"?
>>
>> Your wording implies that the attempt may fail, but if that
>> is the case, I thing some further words are needed here.
> 
> That's correct. I was in fact implying that this could fail and that's
> certainly the reality. However, for the sake of illustration, I do think
> it can be changed to "It marks" as oppose to "It attempts to mark". I
> don't really have any strong points as to why it can't be changed "It
> marks".

Okay -- changed.

>>> +and waits until an event of type
>>> +.B FAN_CREATE
>>> +has occurred.
>>> +Depending on whether a file or directory is created depends on what mask
>>> +is returned in the event mask.
>>
>> That last sentence is not quite right. Is one of these alternatives
>> correct?
>>
>> "Whether or not a filesystem object (a file or directory) was created
>> depends on what mask is returned in the event mask."
>>
>> "The event mask indicates which type of filesystem object--either
>> a file or a directory--was created".
> 
> This ^ is more accurate. Let's go with that.

Okay. Changed.

[...]


>>> +        /* metadata->fd is set to FAN_NOFD when FAN_REPORT_FID is enabled.
>>> +         * To obtain a file descriptor for the file object corresponding to
>>> +         * an event you can use the struct file_handle that's provided
>>> +         * within the fanotify_event_info_fid in conjunction with the
>>> +         * open_by_handle_at(2) system call. A check for -ESTALE is done
>>> +         * to accommodate for the situation where the file handle was
>>> +         * deleted for the object prior to this system call.
>>
>> Would that last sentence read better as:
>>
>> "... where the file handle for the object was deleted prior to
>> this system call."
>>
>> ?
> 
> Yes, that's definitely better.

Okay -- changed.

Cheers,

Michael
