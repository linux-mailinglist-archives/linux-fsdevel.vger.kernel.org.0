Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DECAD31320
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 18:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfEaQyb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 12:54:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43422 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfEaQyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 12:54:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so4351313pgv.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2019 09:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ewcGqWlUBcj2vqMYoRe6naWn0ch2H9NatgzRlftrcRk=;
        b=dsSiR0iX8IRiaRnHiz4HUjVVfH95XJ9+SAK74ltcEyxeIZBGj00ENrsPfCw7QBEr6Z
         m+dM/Jofgy5G1lY7RJl4/XB5TuTZyk90/+czFJ+LyySgqOsabTGMOpjpPETc5KTvXY0J
         RC5vvGCMvJkTtWJLiChIhCU6H1u9O5vwH+FphQs8kyGQPBeuc1gs0okjv+AbeODs0p41
         r6MWrdd1FVRjEvnMP27s3F3cuFQFqPiaN0v21LSPUm3+uwmXE6VxGtDqgSLKTI6t69wD
         0ifEoXVRC7PfmFwCsgdRzloUY1f8BEr8Qdi9pNmxYXgjESRHH4SF62KYuNy3rpUXcW5I
         9Msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ewcGqWlUBcj2vqMYoRe6naWn0ch2H9NatgzRlftrcRk=;
        b=Aj9waDNdUZLM9YZQ1U7GgGDewrjGSOOIi2EA5/aAozOvtPLuJG2MGUzuAJLTBjB71m
         93bVVedqc/LADWyfAbOPHrtIoQVt/rEb9xJadrAZt5R+UMIqMc5/a0D2uE7h2q9kLQT8
         Y+x1oj+p0LdmGhLDKZmPrucTsmWfASOAb66yScX+RwNwsxAdSf8ztM8FE58c9rVuNQ75
         HGjIBqU1WJVHUG8tFq1pDZkWAHcVdSa2nhFgXqRwEE9hfnB1R2mKbtWs8wN5Iz5wDtpL
         FLBnWa5AZnelRzJpaISW3aIHuX5rCIKZw7/nvduBL3UH+jkM/Njqe5iUUi/VEDTCixMU
         Kq+w==
X-Gm-Message-State: APjAAAXXU/UIP59qlGVAUicO/6UEIokxC2YmqcpFq2WUD5VRdpuBbXQO
        fvG4wWO9XZbjM18IQaiVSklwNQ==
X-Google-Smtp-Source: APXvYqxGIh35Zxt7m3aRCLWgwOGKSXYPqlQpyG1chG5dHGeF9RcVEQBttdji5lICXmoEwiIhQ38uWg==
X-Received: by 2002:a63:484f:: with SMTP id x15mr7517829pgk.162.1559321670176;
        Fri, 31 May 2019 09:54:30 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id t2sm5583345pjr.31.2019.05.31.09.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 09:54:29 -0700 (PDT)
Subject: Re: [PATCH v3 00/13] epoll: support pollable epoll from userspace
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Azat Khuzhin <azat@libevent.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <a2a88f4f-d104-f565-4d6e-1dddc7f79a05@kernel.dk>
 <1d47ee76735f25ae5e91e691195f7aa5@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e552262b-2069-075e-f7db-cec19a12a363@kernel.dk>
Date:   Fri, 31 May 2019 10:54:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1d47ee76735f25ae5e91e691195f7aa5@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/31/19 10:02 AM, Roman Penyaev wrote:
> On 2019-05-31 16:48, Jens Axboe wrote:
>> On 5/16/19 2:57 AM, Roman Penyaev wrote:
>>> Hi all,
>>>
>>> This is v3 which introduces pollable epoll from userspace.
>>>
>>> v3:
>>>    - Measurements made, represented below.
>>>
>>>    - Fix alignment for epoll_uitem structure on all 64-bit archs except
>>>      x86-64. epoll_uitem should be always 16 bit, proper BUILD_BUG_ON
>>>      is added. (Linus)
>>>
>>>    - Check pollflags explicitly on 0 inside work callback, and do
>>> nothing
>>>      if 0.
>>>
>>> v2:
>>>    - No reallocations, the max number of items (thus size of the user
>>> ring)
>>>      is specified by the caller.
>>>
>>>    - Interface is simplified: -ENOSPC is returned on attempt to add a
>>> new
>>>      epoll item if number is reached the max, nothing more.
>>>
>>>    - Alloced pages are accounted using user->locked_vm and limited to
>>>      RLIMIT_MEMLOCK value.
>>>
>>>    - EPOLLONESHOT is handled.
>>>
>>> This series introduces pollable epoll from userspace, i.e. user
>>> creates
>>> epfd with a new EPOLL_USERPOLL flag, mmaps epoll descriptor, gets
>>> header
>>> and ring pointers and then consumes ready events from a ring, avoiding
>>> epoll_wait() call.  When ring is empty, user has to call epoll_wait()
>>> in order to wait for new events.  epoll_wait() returns -ESTALE if user
>>> ring has events in the ring (kind of indication, that user has to
>>> consume
>>> events from the user ring first, I could not invent anything better
>>> than
>>> returning -ESTALE).
>>>
>>> For user header and user ring allocation I used vmalloc_user().  I
>>> found
>>> that it is much easy to reuse remap_vmalloc_range_partial() instead of
>>> dealing with page cache (like aio.c does).  What is also nice is that
>>> virtual address is properly aligned on SHMLBA, thus there should not
>>> be
>>> any d-cache aliasing problems on archs with vivt or vipt caches.
>>
>> Why aren't we just adding support to io_uring for this instead? Then we
>> don't need yet another entirely new ring, that's is just a little
>> different from what we have.
>>
>> I haven't looked into the details of your implementation, just curious
>> if there's anything that makes using io_uring a non-starter for this
>> purpose?
> 
> Afaict the main difference is that you do not need to recharge an fd
> (submit new poll request in terms of io_uring): once fd has been added
> to
> epoll with epoll_ctl() - we get events.  When you have thousands of fds
> -
> that should matter.
> 
> Also interesting question is how difficult to modify existing event
> loops
> in event libraries in order to support recharging (EPOLLONESHOT in terms
> of epoll).
> 
> Maybe Azat who maintains libevent can shed light on this (currently I
> see
> that libevent does not support "EPOLLONESHOT" logic).

In terms of existing io_uring poll support, which is what I'm guessing
you're referring to, it is indeed just one-shot. But there's no reason
why we can't have it persist until explicitly canceled with POLL_REMOVE.

-- 
Jens Axboe

