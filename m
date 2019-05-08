Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3CDC16DFE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 02:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfEHAH5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 20:07:57 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44369 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfEHAH5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 20:07:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id w25so2269912qkj.11;
        Tue, 07 May 2019 17:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=K67W2ncVkgN/WdL+xIhgZCYeVI5UJCoiCkCAOkT5tCA=;
        b=G1yhm3pdOMzayJFGL3fBlDi0SY2p9q34BAGNaDVG/fuoWoXKm7X2MreSJybNmwOizo
         phfrtaCV10BnT6QzeKDFGm53G+SRt3ssB7+7uPKghPZKAiXsOmmlW0O12m7RvcQ/sdag
         fogHEwMkqnHuPWbP/mWMvazqCiftNFn52tOfQ95i72KKseXihS358weuba9Qdc8rWTpv
         8muEtgxLrZRO2tayGwBcvF5TpgYjCDFKKH0WP+1fw3ZIQ+IKqr+39fV48+8GInTOOL7D
         x2CFDkwGLQWPUVzEi9oBbrq64eHUlOTBybQ5a7QS4qfNlC7rL4vYMo/XH+bEEBVMz9Oj
         R8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=K67W2ncVkgN/WdL+xIhgZCYeVI5UJCoiCkCAOkT5tCA=;
        b=F1GQg9juJZFCseL+UXTH3oII3NKHejWdgqE94sNU70sM41bSZpoZWoOrpTj50xFoMj
         PMEaI3QmPh/+sj8rmVhGjoQboptyvcNWWyRp01vVLU0mq37oxoBpCRvn2RN/UAQJnah5
         OHyVk2M+OkIpa/uViFz8lhB32/gOFDylePbGn4IJsLfYiuOWkVFPGnLsnN1IalmmUAGr
         wn6FTkF96oCjOqx0ANrsqY2G3wceYLXUtnnGgEV7ynqw30WqOdmBxAjl8ETi1OdWU1Ii
         W38ls4DDgFspjF7CPEQJxkY9ws7bD4MKEpM3IToLoQmbemwLDx0J3hsY5MwtJ35l8wSQ
         iswA==
X-Gm-Message-State: APjAAAU41LTNK92thMK824EWZ4Abfh92TBd+JNit1V/C5Ao83YcekwOI
        xby1PkpaLTd8C7/DAkmthzmhvLvHhHw=
X-Google-Smtp-Source: APXvYqyglMjwbqFhVLZ4ThMiDfO9bu6NT/8MNzkI+d829YfKJnMIY8gSx63P18U8yRMB0lBbhIUYCQ==
X-Received: by 2002:a37:7381:: with SMTP id o123mr26136727qkc.96.1557274075682;
        Tue, 07 May 2019 17:07:55 -0700 (PDT)
Received: from [192.168.1.204] (pool-108-20-37-130.bstnma.fios.verizon.net. [108.20.37.130])
        by smtp.gmail.com with ESMTPSA id o64sm1266666qke.61.2019.05.07.17.07.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 17:07:54 -0700 (PDT)
Subject: Re: Testing devices for discard support properly
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        lczerner@redhat.com
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
 <20190507220449.GP1454@dread.disaster.area>
From:   Ric Wheeler <ricwheeler@gmail.com>
Message-ID: <a409b3d1-960b-84a4-1b8d-1822c305ea18@gmail.com>
Date:   Tue, 7 May 2019 20:07:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190507220449.GP1454@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/7/19 6:04 PM, Dave Chinner wrote:
> On Mon, May 06, 2019 at 04:56:44PM -0400, Ric Wheeler wrote:
>> (repost without the html spam, sorry!)
>>
>> Last week at LSF/MM, I suggested we can provide a tool or test suite to test
>> discard performance.
>>
>> Put in the most positive light, it will be useful for drive vendors to use
>> to qualify their offerings before sending them out to the world. For
>> customers that care, they can use the same set of tests to help during
>> selection to weed out any real issues.
>>
>> Also, community users can run the same tools of course and share the
>> results.
> My big question here is this:
>
> - is "discard" even relevant for future devices?


Hard to tell - current devices vary greatly.

Keep in mind that discard (or the interfaces you mention below) are not specific 
to SSD devices on flash alone, they are also useful for letting us free up space 
on software block devices. For example, iSCSI targets backed by a file, dm thin 
devices, virtual machines backed by files on the host, etc.

>
> i.e. before we start saying "we want discard to not suck", perhaps
> we should list all the specific uses we ahve for discard, what we
> expect to occur, and whether we have better interfaces than
> "discard" to acheive that thing.
>
> Indeed, we have fallocate() on block devices now, which means we
> have a well defined block device space management API for clearing
> and removing allocated block device space. i.e.:
>
> 	FALLOC_FL_ZERO_RANGE: Future reads from the range must
> 	return zero and future writes to the range must not return
> 	ENOSPC. (i.e. must remain allocated space, can physically
> 	write zeros to acheive this)
>
> 	FALLOC_FL_PUNCH_HOLE: Free the backing store and guarantee
> 	future reads from the range return zeroes. Future writes to
> 	the range may return ENOSPC. This operation fails if the
> 	underlying device cannot do this operation without
> 	physically writing zeroes.
>
> 	FALLOC_FL_PUNCH_HOLE | FALLOC_FL_NO_HIDE_STALE: run a
> 	discard on the range and provide no guarantees about the
> 	result. It may or may not do anything, and a subsequent read
> 	could return anything at all.
>
> IMO, trying to "optimise discard" is completely the wrong direction
> to take. We should be getting rid of "discard" and it's interfaces
> operations - deprecate the ioctls, fix all other kernel callers of
> blkdev_issue_discard() to call blkdev_fallocate() and ensure that
> drive vendors understand that they need to make FALLOC_FL_ZERO_RANGE
> and FALLOC_FL_PUNCH_HOLE work, and that FALLOC_FL_PUNCH_HOLE |
> FALLOC_FL_NO_HIDE_STALE is deprecated (like discard) and will be
> going away.
>
> So, can we just deprecate blkdev_issue_discard and all the
> interfaces that lead to it as a first step?


In this case, I think you would lose a couple of things:

* informing the block device on truncate or unlink that the space was freed up 
(or we simply hide that under there some way but then what does this really 
change?). Wouldn't this be the most common source for informing devices of freed 
space?

* the various SCSI/ATA commands are hints - the target device can ignore them - 
so we still need to be able to do clean up passes with something like fstrim I 
think occasionally.

Regards,

Ric


>
> Cheers,
>
> Dave.


