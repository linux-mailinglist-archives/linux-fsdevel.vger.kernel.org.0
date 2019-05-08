Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59C4917CC8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 17:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfEHPFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 11:05:40 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44078 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfEHPFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 11:05:40 -0400
Received: by mail-qk1-f193.google.com with SMTP id w25so3512647qkj.11;
        Wed, 08 May 2019 08:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ok+RHemf8x1ihXi2/0irPfZeg125Qy0TI0yjQrNelmQ=;
        b=XyR2bWmNRyfC6JWHETPaf152RU34wMrM/C4Z6ViFLIhznrw4cZGivF2gTHmmGEoZiv
         50GoFXYMU8DBY+qCwGrhABd8bJpxRjHMEiHdVsbWCe1A/YV6XTmQE9d0eIF/EKJnNuvn
         y9l3IEfkvrxJK+D085xdgWKk+n5oGgqiOU3RxM6TlCSw5rhRCMwKCXIZijnm+LFIrCEH
         QHEE2XodjWKLfGEqvkoUuHpz1RtWWd5FakLo250RJRMUFc/GOULQEPPzakuvr96Hk8O0
         AGUzHesvEBkE9tMvlcigpmr4UJge2xCJvpLKeGtUp04l9RwlngIpiK+HmFNvdCUDAj1n
         MQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ok+RHemf8x1ihXi2/0irPfZeg125Qy0TI0yjQrNelmQ=;
        b=cjIyUnkoT4nZIu3bJQmYSSKpWlBsyFbniHnEjxK7XhaSWu60U+H9dA9Dfur2+csygh
         QSAdXVcfXL7qimUM0iw2E4NDFDV7is69dpbeUAK+p9zvG71uTwVkmfWGkfQ3L9BG8+y6
         v1Clmmpz3C1ImjGqNoxIex5WjU4YaIOAnPtX5hMt/D+hjvDvI6sRLFIwI3m6gWJ03AAH
         HbxbLnqg/I2TiGx39zt9oOK5SePCyjBLybpMdxjJvv/4jtz0WGvIaXXvqPt7qHjjmb5w
         9mTVkw6Yp5i4WWX04TWabFpl3PxLf0yL09myADdmnC+eOxTTttens1F5hDldiJB2+eWp
         48VA==
X-Gm-Message-State: APjAAAUDShv+Q59mMKj2jodNCwJ+SI3dGVxkBuNrOIcH36h8HqCliiN6
        FqIZinENKOfHopsoUFBnbRU=
X-Google-Smtp-Source: APXvYqysbLgj56z9SvVGBsCWStDBetQJrLZi64OrUOEPgLu1I01D5/UoreoCKSKU8geHi2ovHUnwsg==
X-Received: by 2002:a37:ea06:: with SMTP id t6mr29402612qkj.66.1557327938192;
        Wed, 08 May 2019 08:05:38 -0700 (PDT)
Received: from localhost.localdomain ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id 46sm10702195qto.57.2019.05.08.08.05.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:05:36 -0700 (PDT)
Subject: Re: Testing devices for discard support properly
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        lczerner@redhat.com
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
 <20190507220449.GP1454@dread.disaster.area>
 <a409b3d1-960b-84a4-1b8d-1822c305ea18@gmail.com>
 <20190508011407.GQ1454@dread.disaster.area>
From:   Ric Wheeler <ricwheeler@gmail.com>
Message-ID: <13b63de0-18bc-eb24-63b4-3c69c6a007b3@gmail.com>
Date:   Wed, 8 May 2019 11:05:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508011407.GQ1454@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/7/19 9:14 PM, Dave Chinner wrote:
> On Tue, May 07, 2019 at 08:07:53PM -0400, Ric Wheeler wrote:
>> On 5/7/19 6:04 PM, Dave Chinner wrote:
>>> On Mon, May 06, 2019 at 04:56:44PM -0400, Ric Wheeler wrote:
>>>> (repost without the html spam, sorry!)
>>>>
>>>> Last week at LSF/MM, I suggested we can provide a tool or test suite to test
>>>> discard performance.
>>>>
>>>> Put in the most positive light, it will be useful for drive vendors to use
>>>> to qualify their offerings before sending them out to the world. For
>>>> customers that care, they can use the same set of tests to help during
>>>> selection to weed out any real issues.
>>>>
>>>> Also, community users can run the same tools of course and share the
>>>> results.
>>> My big question here is this:
>>>
>>> - is "discard" even relevant for future devices?
>>
>> Hard to tell - current devices vary greatly.
>>
>> Keep in mind that discard (or the interfaces you mention below) are not
>> specific to SSD devices on flash alone, they are also useful for letting us
>> free up space on software block devices. For example, iSCSI targets backed
>> by a file, dm thin devices, virtual machines backed by files on the host,
>> etc.
> Sure, but those use cases are entirely covered by ithe well defined
> semantics of FALLOC_FL_ALLOC, FALLOC_FL_ZERO_RANGE and
> FALLOC_FL_PUNCH_HOLE.
>
>>> i.e. before we start saying "we want discard to not suck", perhaps
>>> we should list all the specific uses we ahve for discard, what we
>>> expect to occur, and whether we have better interfaces than
>>> "discard" to acheive that thing.
>>>
>>> Indeed, we have fallocate() on block devices now, which means we
>>> have a well defined block device space management API for clearing
>>> and removing allocated block device space. i.e.:
>>>
>>> 	FALLOC_FL_ZERO_RANGE: Future reads from the range must
>>> 	return zero and future writes to the range must not return
>>> 	ENOSPC. (i.e. must remain allocated space, can physically
>>> 	write zeros to acheive this)
>>>
>>> 	FALLOC_FL_PUNCH_HOLE: Free the backing store and guarantee
>>> 	future reads from the range return zeroes. Future writes to
>>> 	the range may return ENOSPC. This operation fails if the
>>> 	underlying device cannot do this operation without
>>> 	physically writing zeroes.
>>>
>>> 	FALLOC_FL_PUNCH_HOLE | FALLOC_FL_NO_HIDE_STALE: run a
>>> 	discard on the range and provide no guarantees about the
>>> 	result. It may or may not do anything, and a subsequent read
>>> 	could return anything at all.
>>>
>>> IMO, trying to "optimise discard" is completely the wrong direction
>>> to take. We should be getting rid of "discard" and it's interfaces
>>> operations - deprecate the ioctls, fix all other kernel callers of
>>> blkdev_issue_discard() to call blkdev_fallocate() and ensure that
>>> drive vendors understand that they need to make FALLOC_FL_ZERO_RANGE
>>> and FALLOC_FL_PUNCH_HOLE work, and that FALLOC_FL_PUNCH_HOLE |
>>> FALLOC_FL_NO_HIDE_STALE is deprecated (like discard) and will be
>>> going away.
>>>
>>> So, can we just deprecate blkdev_issue_discard and all the
>>> interfaces that lead to it as a first step?
>>
>> In this case, I think you would lose a couple of things:
>>
>> * informing the block device on truncate or unlink that the space was freed
>> up (or we simply hide that under there some way but then what does this
>> really change?). Wouldn't this be the most common source for informing
>> devices of freed space?
> Why would we lose that? The filesytem calls
> blkdev_fallocate(FALLOC_FL_PUNCH_HOLE) (or a better, async interface
> to the same functionality) instead of blkdev_issue_discard().  i.e.
> the filesystems use interfaces with guaranteed semantics instead of
> "discard".


That all makes sense, but I think it is orthogonal in large part to the 
need to get a good way to measure performance.

>
>> * the various SCSI/ATA commands are hints - the target device can ignore
>> them - so we still need to be able to do clean up passes with something like
>> fstrim I think occasionally.
> And that's the problem we need to solve - as long as the hardware
> can treat these operations as hints (i.e. as "discards" rather than
> "you must free this space and return zeroes") then there is no
> motivation for vendors to improve the status quo.
>
> Nobody can rely on discard to do anything. Even ignoring the device
> performance/implementation problems, it's an unusable API from an
> application perspective. The first step to fixing the discard
> problem is at the block device API level.....
>
> Cheers,
>
> Dave.

For some protocols, there are optional bits that require the device to 
return all zero data on subsequent reads, so there in that case, it is 
not optional now (we just don't use that much I think). In T13 and NVME, 
I think it could be interesting to add those tests specifically. For 
SCSI, I think the "WRITE_SAME" command *might* do discard internally or 
just might end up re-writing large regions of slow, spinning drives so I 
think it is less interesting.

I do think all of the bits you describe seem quite reasonable and 
interesting, but still see use in having simple benchmarks for us (and 
vendors) to use to measure all of this. We do this for drives today for 
write and read, just adding another dimension that needs to be routinely 
measured...

Regards,

Ric



