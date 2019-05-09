Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7B518AE3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 15:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfEINkL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 09:40:11 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34011 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfEINkK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 09:40:10 -0400
Received: by mail-qk1-f194.google.com with SMTP id n68so1464761qka.1;
        Thu, 09 May 2019 06:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pao+2nZGFvbzzBtE2KjGUp9nBnW/rJP39aiQpVyqOWY=;
        b=kWt8j+pWqb6TJGqZfAjeV/BOlIj8E7ONnDmxgOcAFu186JRng7BiFS44pbkIFNsnPO
         ORmdYoge/LXDEHvKb32Lwt3QqJkkq5QN5tsuUNAtgh4lDxxwfo9NkCcEC8MZ1cAKHkHS
         2ZxN52r0NV559TYK5R1+KDDMrMS7WnhycWHJ7QjTZ2gWDis/PufdwwRjAVMMm8MWJ21W
         ZRqUuq+HGiXcMAu6sEXf8/WPNgqne0Xhb/gZcn0R3PJQ1xJx+M9C1fKBs3Rw421RUP3A
         CG/QicrswKf7x1naLRc3m5f9if+nyXCkdCEK2MY2P0w5DZ9elJfwEUnP0QCs1D+TKQa0
         fREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pao+2nZGFvbzzBtE2KjGUp9nBnW/rJP39aiQpVyqOWY=;
        b=JjkHEwOf7dUK5inrbHWkNzMMpCDH3YVgxY5+euVdiIGEdXJaNxnsAPAgLKoDPCI8sr
         NBvMgtdPlxnGcbkM0+fMtca9oSKygJQwWrAuGP980djZgUoTXQlqO3ktTPyJVPosFWUY
         dQcMqK3CxxXVOkz50KHtrsFIyXXxBakkQwjOWPcIYO1QVJ0D9ENT4/jZANRQJDDJp812
         vKajDusmwZ5MT3p8IPFWJPjYyW3qzG821Pa42oZMQmfodRuwiIiA7IqBUM/uRq5TF0TP
         dVMfK8wDTbde/VeSQmO5aODcbdRlooYsH9CEEyEY3AQFWqmkq5TKEBvYtRm2o3akX2mc
         b5vA==
X-Gm-Message-State: APjAAAX5g/ZSofRETnOsMprb6GkYEl6lvDBa0MR/U0O+ZhzV3LnIzKYX
        GrK6+nY+YlGjRFEJpuWFqchtgKjJShg=
X-Google-Smtp-Source: APXvYqyL6xpM4wf+laUpB2BeyV5GJuYNjYWk8eY2OywcekwUrJwv50Ji8VQCItJRHS+k7LxL7GQ6sw==
X-Received: by 2002:a37:7982:: with SMTP id u124mr3408015qkc.79.1557409208933;
        Thu, 09 May 2019 06:40:08 -0700 (PDT)
Received: from localhost.localdomain ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id p27sm1097866qte.25.2019.05.09.06.40.07
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 06:40:07 -0700 (PDT)
Subject: Re: Testing devices for discard support properly
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dave Chinner <david@fromorbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        lczerner@redhat.com
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
 <20190507220449.GP1454@dread.disaster.area> <yq1ef58ly5j.fsf@oracle.com>
 <20190508223157.GS1454@dread.disaster.area> <yq1h8a4i8ng.fsf@oracle.com>
From:   Ric Wheeler <ricwheeler@gmail.com>
Message-ID: <984ef2fe-132a-4074-290d-5ec43c0bcad9@gmail.com>
Date:   Thu, 9 May 2019 09:40:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <yq1h8a4i8ng.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/8/19 11:55 PM, Martin K. Petersen wrote:
> 
> Dave,
> 
>> Only when told to do PUNCH_HOLE|NO_HIDE_STALE which means "we don't
>> care what the device does" as this fallcoate command provides no
>> guarantees for the data returned by subsequent reads. It is,
>> esssentially, a get out of gaol free mechanism for indeterminate
>> device capabilities.
> 
> Correct. But the point of discard is to be a lightweight mechanism to
> convey to the device that a block range is no longer in use. Nothing
> more, nothing less.
> 
> Not everybody wants the device to spend resources handling unwritten
> extents. I understand the importance of that use case for XFS but other
> users really just need deallocate semantics.
> 
>> People used to make that assertion about filesystems, too. It took
>> linux filesystem developers years to realise that unwritten extents
>> are actually very simple and require very little extra code and no
>> extra space in metadata to implement. If you are already tracking
>> allocated blocks/space, then you're 99% of the way to efficient
>> management of logically zeroed disk space.
> 
> I don't disagree. But since "discard performance" checkmark appears to
> be absent from every product requirements document known to man, very
> little energy has been devoted to ensuring that discard operations can
> coexist with read/write I/O without impeding the performance.
> 
> I'm not saying it's impossible. Just that so far it hasn't been a
> priority. Even large volume customers have been unable to compel their
> suppliers to produce a device that doesn't suffer one way or the other.
> 
> On the SSD device side, vendors typically try to strike a suitable
> balance between what's handled by the FTL and what's handled by
> over-provisioning.
> 
>>> 2. Our expectation for the allocating REQ_ZEROOUT (FL_ZERO_RANGE), which
>>>     gets translated into NVMe WRITE ZEROES, SCSI WRITE SAME, is that the
>>>     command executes in O(n) but that it is faster -- or at least not
>>>     worse -- than doing a regular WRITE to the same block range.
>>
>> You're missing the important requirement of fallocate(ZERO_RANGE):
>> that the space is also allocated and ENOSPC will never be returned
>> for subsequent writes to that range. i.e. it is allocated but
>> "unwritten" space that contains zeros.
> 
> That's what I implied when comparing it to a WRITE.
> 
>>> 3. Our expectation for the deallocating REQ_ZEROOUT (FL_PUNCH_HOLE),
>>>     which gets translated into ATA DSM TRIM w/ whitelist, NVMe WRITE
>>>     ZEROES w/ DEAC, SCSI WRITE SAME w/ UNMAP, is that the command will
>>>     execute in O(1) for any portion of the block range described by the
>>
>> FL_PUNCH_HOLE has no O(1) requirement - it has a "all possible space
>> must be freed" requirement. The larger the range, to longer it will
>> take.
> 
> OK, so maybe my O() notation lacked a media access moniker. What I meant
> to convey was that no media writes take place for the properly aligned
> multiple of the internal granularity. The FTL update takes however long
> it takes, but the only potential media accesses would be the head and
> tail pieces. For some types of devices, these might be handled in
> translation tables. But for others, zeroing blocks on the media is the
> only way to do it.
> 
>> That's expected, and exaclty what filesystems do for sub-block punch
>> and zeroing ranges.
> 
> Yep.
> 
>> What I'm saying is that we should be pushing standards to ensure (3)
>> is correctly standardise, certified and implemented because that is
>> what the "Linux OS" requires from future hardware.
> 
> That's well-defined for both NVMe and SCSI.
> 
> However, I do not agree that a deallocate operation has to imply
> zeroing. I think there are valid use cases for pure deallocate.
> 
> In an ideal world the performance difference between (1) and (3) would
> be negligible and make this distinction moot. However, we have to
> support devices that have a wide variety of media and hardware
> characteristics. So I don't see pure deallocate going away. Doesn't mean
> that I am not pushing vendors to handle (3) because I think it is very
> important. And why we defined WRITE ZEROES in the first place.
> 

All of this makes sense to me.

I think that we can get value out of measuring how close various devices 
come to realizing the above assumptions.  Clearly, file systems (as 
Chris mentioned) do have to adapt to varying device performance issues, 
but I think today the variation can be orders of magnitude for large 
(whole device) discards and that it not something that is easy to 
tolerate....

ric
