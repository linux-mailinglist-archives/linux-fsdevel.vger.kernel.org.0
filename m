Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD3B16414
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 14:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfEGM5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 08:57:13 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:41560 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfEGM5N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 08:57:13 -0400
Received: by mail-qt1-f182.google.com with SMTP id c13so18818592qtn.8;
        Tue, 07 May 2019 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hYe3aJ9hX77v/3irsRXMzIWEx2j595RXPSkwBIf7F18=;
        b=RINy+PEYl5RijAggnLDKS54T9pas+ufxa4dqSjkrp13dEbf5nlsRfBTiG2Hd2BIIk2
         xjcFHg8miKoLsYqbNmYddbsvbP/rDzy9QVaWQ3IrwTf2CZ65tRo9khWiK+k5Yiw4SPWt
         ziYOXQyyKdtaRx+sIWMJT/azWOI++YYOt37eMGgH1I8s9ftx7TU3pIi207osGO5QvyEZ
         +ZDczfJ8VLz5eho3SVCNV4vmv4LRqPB38FuMBz2zfq4cfYob0dqIc/YA5KbLfaNwclie
         s/ikrlnnXTNv9zdLT2Wv2q5BSefRyLZX4Hnj5a6YaktJbbeTB+RMDd/Wask+jFXS99Vd
         OwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hYe3aJ9hX77v/3irsRXMzIWEx2j595RXPSkwBIf7F18=;
        b=fE83Th97XAEu9DyysHPV0oZLhqCsfgYYAaJ7JU58lcnimtUjBjYHWR8vH7GXUFSAgW
         OxfPoGP9+/hDZpf7EyMR9B0ChJNIZVFe2NbSZs9FRhe7hPq3xDNPnMSHSe2fNJtJ5NfE
         IdRJS19t51E71/oEqA1cppM2RE0izD/OzKF5if09QHj9tsu9OOXgdNNYizQctzL0k+ON
         UAAOx6YPC6qdgGSrrAbiYXUNYQX2z8mrU2cQc/PrcOwH64zPca4nXGcAmZWcsFBzR+Po
         XEDNwHvOh4Bn/wOMlBRl8cU10bMKvUZi4w53t0HxBQecYEMXIwfUjNRjjT5jdGiFS6I6
         M8YQ==
X-Gm-Message-State: APjAAAV4YP77W+FW7r+YyKvCzFN4dLBJf3QXTuRzcn1dlM+6qC01AzVO
        PHVAi6iGoJURCkn7KKaVrpg=
X-Google-Smtp-Source: APXvYqyUipHEaFB+5oUMvWmIUPyvzku/UuBXyLVLiz9ezIwF8Z8IDWc4VCXE+uzFeaHtkUSrSUX0qQ==
X-Received: by 2002:aed:3a0a:: with SMTP id n10mr6784140qte.145.1557233831560;
        Tue, 07 May 2019 05:57:11 -0700 (PDT)
Received: from localhost.localdomain ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id k190sm6910039qkd.28.2019.05.07.05.57.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 05:57:10 -0700 (PDT)
Subject: Re: Testing devices for discard support properly
To:     Lukas Czerner <lczerner@redhat.com>, Jan Tulak <jtulak@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
 <20190507071021.wtm25mxx2as6babr@work>
 <CACj3i71HdW0ys_YujGFJkobMmZAZtEPo7B2tgZjEY8oP_T9T6g@mail.gmail.com>
 <20190507094015.hb76w3rjzx7shxjp@work>
From:   Ric Wheeler <ricwheeler@gmail.com>
Message-ID: <09953ba7-e4f2-36e9-33b7-0ddbbb848257@gmail.com>
Date:   Tue, 7 May 2019 08:57:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507094015.hb76w3rjzx7shxjp@work>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/7/19 5:40 AM, Lukas Czerner wrote:
> On Tue, May 07, 2019 at 10:48:55AM +0200, Jan Tulak wrote:
>> On Tue, May 7, 2019 at 9:10 AM Lukas Czerner <lczerner@redhat.com> wrote:
>>> On Mon, May 06, 2019 at 04:56:44PM -0400, Ric Wheeler wrote:
>> ...
>>>> * Whole device discard at the block level both for a device that has been
>>>> completely written and for one that had already been trimmed
>>> Yes, usefull. Also note that a long time ago when I've done the testing
>>> I noticed that after a discard request, especially after whole device
>>> discard, the read/write IO performance went down significanly for some
>>> drives. I am sure things have changed, but I think it would be
>>> interesting to see how does it behave now.


My understanding of how drives (not just SSD's but they are the main 
target here) can handle a discard can vary a lot, including:

* just ignore it for any reason and not return a failure - it is just a 
hint by spec.

* update metadata to mark that region as unused and then defer any real 
work to later (like doing wear level stuff, pre-erase for writes, etc). 
This can have a post-discard impact. I think of this kind of like 
updating page table entries for virtual memory - low cost update now, 
all real work deferred.

* do everything as part of the command - this can be relatively slow, 
most of the cost of a write I would guess (i.e., go in and over-write 
the region with zeros or just do the erase of the flash block under the 
region).

Your earlier work supports the need to test IO performance after doing 
the trims/discards - we might want to test it right away, then see if 
waiting 10 minutes, 30 minutes, etc helps?

>>>
>>>> * Discard performance at the block level for 4k discards for a device that
>>>> has been completely written and again the same test for a device that has
>>>> been completely discarded.
>>>>
>>>> * Same test for large discards - say at a megabyte and/or gigabyte size?
>>>  From my testing (again it was long time ago and things probably changed
>>> since then) most of the drives I've seen had largely the same or similar
>>> timing for discard request regardless of the size (hence, the conclusion
>>> was the bigger the request the better). A small variation I did see
>>> could have been explained by kernel implementation and discard_max_bytes
>>> limitations as well.
>>>
>>>> * Same test done at the device optimal discard chunk size and alignment
>>>>
>>>> Should the discard pattern be done with a random pattern? Or just
>>>> sequential?
>>> I think that all of the above will be interesting. However there are two
>>> sides of it. One is just pure discard performance to figure out what
>>> could be the expectations and the other will be "real" workload
>>> performance. Since from my experience discard can have an impact on
>>> drive IO performance beyond of what's obvious, testing mixed workload
>>> (IO + discard) is going to be very important as well. And that's where
>>> fio workloads can come in (I actually do not know if fio already
>>> supports this or not).
>>>

Really good points. I think it is probably best to test just at the 
block device level to eliminate any possible file system interactions 
here.  The lessons learned though might help file systems handle things 
more effectively?

>> And:
>>
>> On Tue, May 7, 2019 at 10:22 AM Nikolay Borisov <nborisov@suse.com> wrote:
>>> I have some vague recollection this was brought up before but how sure
>>> are we that when a discard request is sent down to disk and a response
>>> is returned the actual data has indeed been discarded. What about NCQ
>>> effects i.e "instant completion" while doing work in the background. Or
>>> ignoring the discard request altogether?
>>
>> As Nikolay writes in the other thread, I too have a feeling that there
>> have been a discard-related discussion at LSF/MM before. And if I
>> remember, there were hints that the drives (sometimes) do asynchronous
>> trim after returning a success. Which would explain the similar time
>> for all sizes and IO drop after trim.
> Yes, that was definitely the case  in the past. It's also why we've
> seen IO performance drop after a big (whole device) discard as the
> device was busy in the background.

For SATA specifically, there was a time when the ATA discard command was 
not queued so we had to drain all other pending requests, do the 
discard, and then resume. This was painfully slow then (not clear that 
this was related to the performance impact you saw - it would be an 
impact I think for the next few dozen commands?).

The T13 people (and most drives I hope) fixed this years back to be a 
queued command so we don't have that same concern now I think.

>
> However Nikolay does have a point. IIRC device is free to ignore discard
> requests, I do not think there is any reliable way to actually tell that
> the data was really discarded. I can even imagine a situation that the
> device is not going to do anything unless it's pass some threshold of
> free blocks for wear leveling. If that's the case our tests are not
> going to be very useful unless they do stress such corner cases. But
> that's just my speculation, so someone with a better knowledge of what
> vendors are doing might tell us if it's something to worry about or not.


The way I think of it is our "nirvana" state for discard would be:

* all drives have very low cost discard commands with minimal 
post-discard performance impact on the normal workload which would let 
us issue the in-band discards (-o discard mount option)

* drives might still (and should be expected to) ignore some of these 
commands so freed and "discarded" space might still not be really discarded.

* we will still need to run a periodic (once a day? a week?) fstrim to 
give the drive a chance to clean up anything even when using "mount -o 
discard". Of course, the fstrim size is bigger I expect than the size 
from inband discard so testing larger sizes will be important.

Does this make sense?

Ric


>
>> So, I think that the mixed workload (IO + discard) is a pretty
>> important part of the whole topic and a pure discard test doesn't
>> really tell us anything, at least for some drives.
> I think both are important especially since mixed IO tests are going to
> be highly workload specific.
>
> -Lukas
>
>> Jan
>>
>>
>>
>> -- 
>> Jan Tulak
