Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0EB440EA5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Oct 2021 14:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhJaNZb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Oct 2021 09:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJaNZb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Oct 2021 09:25:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8133DC061570;
        Sun, 31 Oct 2021 06:22:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v17so24207704wrv.9;
        Sun, 31 Oct 2021 06:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Jf6SDTWkMqXzv0QqQSCH2GQMbJgZyWWXdFXwIRei+eA=;
        b=gRl4NUUm+ZjWcPR6a1WSH7orW20Fy105Gy38h+d1NIaoQURLOgTDo61OOXdXFVyHO7
         vs43vfSzhyRoR/vGKgWiDNv/KNAkGN7obYDDsYPrasHvv84VIbJKMnLBUiDawF4HUtRc
         sR2syMI1dn9QBhjJRuaBaxxn8waiROWktV13D+oAAKSBx8xC2BKt2NCFJagksddbMU4g
         tsytzz6dDckC5oSYrMzPnY38LJbg2Dxm+ewCY5fxHs31nZEAp3Y+H0GMKwgb+PQKB1K2
         jpuTkmjS61DwHAeg7yU1Z6czYQDJlPeKZ3eIA7EcWN5/43eJbr/JkpEG/NHMoOknJrVI
         IoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Jf6SDTWkMqXzv0QqQSCH2GQMbJgZyWWXdFXwIRei+eA=;
        b=6e/H4N5y1DydzF2NEZya80jOlB3AqMJjhLmpLSxhN9JFQdBH3QZzwsW2gxGAWoyTlr
         jSEGJH5pFyfqv6U69vmyjlDw0nvflw8IfYI86YkDT0qeeo3+XxvGje7TiyehCNXOI/H9
         0exrKcXiqxPGaETypd2IdOzNmfkPIba5rgDj+lqp4O/eH+DsUkTMrfraqrs+QD+RV2eV
         tYtgDEtlC3BzfmzBVl+2OkJS/dN1RgkNH+6oHEQu0zhBJXXQXrm5vehnxrLNFToNfdHg
         OTYcwGFXiSgQrLLxpuw1il4eRXLwPMuy6gYcnsjN4Nec0BHiTbGqtCR8goJnSmxalICr
         uikg==
X-Gm-Message-State: AOAM5326EQERCAn0owwQmY8Zrew3ZF1vqVekIm9BpiB7gvrv9cXdTfio
        4HVHaZujeV2BxxcTg2yj4+Y=
X-Google-Smtp-Source: ABdhPJwe81NiP2m6SZsYCxtthQKFwaV9/lqDLxmxy8VMxp0zyRIKyCnNwIjAhtz/toMYpXnKWoP/Ug==
X-Received: by 2002:a05:6000:15c6:: with SMTP id y6mr29561346wry.382.1635686578008;
        Sun, 31 Oct 2021 06:22:58 -0700 (PDT)
Received: from [192.168.8.198] ([85.255.232.29])
        by smtp.gmail.com with ESMTPSA id a4sm9477733wmb.39.2021.10.31.06.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 06:22:57 -0700 (PDT)
Message-ID: <1a76314d-9b62-82a3-2787-96e6b83720fc@gmail.com>
Date:   Sun, 31 Oct 2021 13:19:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with RWF_RECOVERY_DATA
 flag
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
 <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
 <YXj2lwrxRxHdr4hb@infradead.org> <20211028002451.GB2237511@magnolia>
 <20211028225955.GA449541@dread.disaster.area>
 <22255117-52de-4b2d-822e-b4bc50bbc52b@gmail.com>
 <20211029223233.GB449541@dread.disaster.area>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20211029223233.GB449541@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/29/21 23:32, Dave Chinner wrote:
> On Fri, Oct 29, 2021 at 12:46:14PM +0100, Pavel Begunkov wrote:
>> On 10/28/21 23:59, Dave Chinner wrote:
>> [...]
>>>>> Well, my point is doing recovery from bit errors is by definition not
>>>>> the fast path.  Which is why I'd rather keep it away from the pmem
>>>>> read/write fast path, which also happens to be the (much more important)
>>>>> non-pmem read/write path.
>>>>
>>>> The trouble is, we really /do/ want to be able to (re)write the failed
>>>> area, and we probably want to try to read whatever we can.  Those are
>>>> reads and writes, not {pre,f}allocation activities.  This is where Dave
>>>> and I arrived at a month ago.
>>>>
>>>> Unless you'd be ok with a second IO path for recovery where we're
>>>> allowed to be slow?  That would probably have the same user interface
>>>> flag, just a different path into the pmem driver.
>>>
>>> I just don't see how 4 single line branches to propage RWF_RECOVERY
>>> down to the hardware is in any way an imposition on the fast path.
>>> It's no different for passing RWF_HIPRI down to the hardware *in the
>>> fast path* so that the IO runs the hardware in polling mode because
>>> it's faster for some hardware.
>>
>> Not particularly about this flag, but it is expensive. Surely looks
>> cheap when it's just one feature, but there are dozens of them with
>> limited applicability, default config kernels are already sluggish
>> when it comes to really fast devices and it's not getting better.
>> Also, pretty often every of them will add a bunch of extra checks
>> to fix something of whatever it would be.
>>
>> So let's add a bit of pragmatism to the picture, if there is just one
>> user of a feature but it adds overhead for millions of machines that
>> won't ever use it, it's expensive.
> 
> Yup, you just described RWF_HIPRI! Seriously, Pavel, did you read
> past this?  I'll quote what I said again, because I've already
> addressed this argument to point out how silly it is:

And you almost got to the initial point in your penult paragraph. A
single if for a single flag is not an issue, what is the problem is
when there are dozens of them and the overhead for it is not isolated,
so the kernel has to jump through dozens of those.

And just to be clear I'll outline again, that's a general problem,
I have no relation to the layers touched and it's up to relevant
people, obviously. Even though I'd expect but haven't found the flag
being rejected in other places, but well I may have missed something.


>>> IOWs, saying that we shouldn't implement RWF_RECOVERY because it
>>> adds a handful of branches to the fast path is like saying that we
>>> shouldn't implement RWF_HIPRI because it slows down the fast path
>>> for non-polled IO....
> 
>   RWF_HIPRI functionality represents a *tiny* niche in the wider
> Linux ecosystem, so by your reasoning it is too expensive to
> implement because millions (billions!) of machines don't need or use
> it. Do you now see how silly your argument is?
> 
> Seriously, this "optimise the IO fast path at the cost of everything
> else" craziness has gotten out of hand. Nobody in the filesystem or
> application world cares if you can do 10M IOPS per core when all the
> CPU is doing is sitting in a tight loop inside the kernel repeatedly
> overwriting data in the same memory buffers, essentially tossing the
> old away the data without ever accessing it or doing anything with
> it.  Such speed racer games are *completely meaningless* as an
> optimisation goal - it's what we've called "benchmarketing" for a
> couple of decades now.

10M you mentioned is just a way to measure, there is nothing wrong
with it. And considering that there are enough of users considering
or already switching to spdk because of performance, the approach
is not wrong. And it goes not only for IO polling, normal irq IO
suffers from the same problems.

A related story is that this number is for a pretty reduced config,
it'll go down with a more default-ish kernel.

> If all we focus on is bragging rights because "bigger number is
> always better", then we'll end up with iand IO path that looks like
> the awful mess that the fs/direct-io.c turned into. That ended up
> being hyper-optimised for CPU performance right down to single
> instructions and cacheline load orders that the code became
> extremely fragile and completely unmaintainable.
> 
> We ended up *reimplementing the direct IO code from scratch* so that
> XFS could build and submit direct IO smarter and faster because it
> simply couldn't be done to the old code.  That's how iomap came
> about, and without *any optimisation at all* iomap was 20-30% faster
> than the old, hyper-optimised fs/direct-io.c code.  IOWs, we always
> knew we could do direct IO faster than fs/direct-io.c, but we
> couldn't make the fs/direct-io.c faster because of the
> hyper-optimisation of the code paths made it impossible to modify
> and maintain.> The current approach of hyper-optimising the IO path for maximum
> per-core IOPS at the expensive of everything else has been proven in
> the past to be exactly the wrong approach to be taking for IO path
> development. Yes, we need to be concerned about performance and work
> to improve it, but we should not be doing that at the cost of
> everything else that the IO stack needs to be able to do.

And iomap is great, what you described is a good typical example
of unmaintainable code. I may get wrong what you exactly refer
to, but I don't see maintainability not being considered.

Even more interesting to notice that more often than not extra
features (and flags) almost always hurt maintainability of the
kernel, but then other benefits outweigh (hopefully).

> Fundamentally, optimisation is something we do *after* we provide
> the functionality that is required; using "fast path optimisation"
> as a blunt force implement to prevent new features from being
> implemented is just ...  obnoxious.
> 
>> This one doesn't spill yet into paths I care about, but in general
>> it'd be great if we start thinking more about such stuff instead of
>> throwing yet another if into the path, e.g. by shifting the overhead
>> from linear to a constant for cases that don't use it, for instance
>> with callbacks or bit masks.
> 
> This is orthogonal to providing data recovery functionality.
> If the claims that flag propagation is too expensive are true, then
> fixing this problem this will also improve RWF_HIPRI performance
> regardless of whether RWF_DATA_RECOVERY exists or not...
> 
> IOWs, *if* there is a fast path performance degradation as a result
> of flag propagation, then *go measure it* and show us how much
> impact it has on _real world applications_.  *Show us the numbers*
> and document how much each additional flag propagation actually
> costs so we can talk about whether it is acceptible, mitigation
> strategies and/or alternative implementations.  Flag propagation
> overhead is just not a valid reason for preventing us adding new
> flags to the IO path. Fix the flag propagation overhead if it's a
> problem for you, don't use it as an excuse for preventing people
> from adding new functionality that uses flag propagation...

-- 
Pavel Begunkov
