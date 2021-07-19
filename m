Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04513CE296
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 18:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348452AbhGSPa4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 11:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348920AbhGSPZM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:25:12 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544FBC08008F
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 08:17:38 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id p202so17065972qka.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jul 2021 08:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c/B7bNcE9Phu7269FlyezAjEUnJf0M11TkizgrrFZ/c=;
        b=a/sTjqQEnCS7lyyy2OXazSYpOjCRbSVrYJ2YSiyIVw1upkLd6aRWClL1jfGmW4H16r
         LhksSaPDwU0QjDLDlIv8x84KMmWOGlwPaPFi55YR/l2FKurhkXwteiyP9SCNsZaTjqOW
         37blyGzj/CcpW0qiUpTBcarFCp3J5IIia7/JZTZrWSyfL7SB1dwCwijbIehAuPxmsXwk
         HlGBZMPdGgb7dqB8El9Ap6uO/SaO9uv48ccnRzfUXchET4jmU70cPYTcd06aeh58sKiI
         WqMFuWGycYoclwpXRSQ6NuAwrzD1KTtMGnoUNRuSB9AEDMjNeEdpW1Aij7bbIoHHglNG
         qzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c/B7bNcE9Phu7269FlyezAjEUnJf0M11TkizgrrFZ/c=;
        b=sIcbc71o6yK1HlfX18592cF7bvkq35ReCmnQ7iRy5MyD2riz5gdMkmnAQRU/EoZkH0
         hV/6Tnx/oJTh81bq+C6DcwM3eKyP/qnBC/gwY/Ut+1TRy1mDugZqwoGZ8eT8jIORBnkw
         T15ZpBvkPUIG8RfI4Y2WHMmKcz6PvY/QOQiw0AbeGIuMbClMM9Mhe1MmdYJHofWlpnh/
         yr36bNAt641Cvnf/vqFZomfCjKy0fWlTC6WVHGYlbyFFuD40Ilpj9JPogmLfPiHowR57
         u1aoE9+c3DyX3LK4ehNPtUYb0xJQeZ/DRQhcKO24UAqTgDkU6HkD7VMGr+ixFs8K9sTg
         t/Bg==
X-Gm-Message-State: AOAM532LxpRuf2yTXtuo775sYqFe+JcBW0wIcY2YlOqjfGOgOPw8WUJ1
        2fJ49Bjn0cc5QnVgzF+ZuLcghQ==
X-Google-Smtp-Source: ABdhPJwRpLwx/aqwRX8tty8BvuxvF3O4THl7l9vegQx2FFn4OVc23smYTG/RD8ZrpzFqZMIHrE4Q7A==
X-Received: by 2002:a05:620a:893:: with SMTP id b19mr13964751qka.487.1626709496981;
        Mon, 19 Jul 2021 08:44:56 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v4sm3437785qkf.52.2021.07.19.08.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 08:44:55 -0700 (PDT)
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
To:     Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Chinner <dchinner@redhat.com>
References: <YNOuiMfRO51kLcOE@relinquished.localdomain>
 <YNPnRyasHVq9NF79@casper.infradead.org>
 <YNQi3vgCLVs/ExiK@relinquished.localdomain>
 <CAHk-=whmRQWm_gVek32ekPqBi3zAKOsdK6_6Hx8nHp3H5JAMew@mail.gmail.com>
 <YNTO1T6BEzmG6Uj5@relinquished.localdomain>
 <CAHk-=wi37_ccWmq1EKTduS8ms_=KpyY2LwJV7roD+s=ZkBkjCw@mail.gmail.com>
 <yq1tulmoqxf.fsf@ca-mkp.ca.oracle.com>
 <YNVPp/Pgqshami3U@casper.infradead.org>
 <CAHk-=wgH5pUbrL7CM5v6TWyNzDYpVM9k1qYCEgmY+b3Gx9nEAA@mail.gmail.com>
 <YNZFr7oJj1nkrwJY@relinquished.localdomain>
 <YOXrmbi81Fr14fUV@relinquished.localdomain>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <84e667ce-0a26-3a2f-0fe8-4a56bfa43006@toxicpanda.com>
Date:   Mon, 19 Jul 2021 11:44:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YOXrmbi81Fr14fUV@relinquished.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/7/21 1:59 PM, Omar Sandoval wrote:
> On Fri, Jun 25, 2021 at 02:07:59PM -0700, Omar Sandoval wrote:
>> On Fri, Jun 25, 2021 at 09:16:15AM -0700, Linus Torvalds wrote:
>>> On Thu, Jun 24, 2021 at 8:38 PM Matthew Wilcox <willy@infradead.org> wrote:
>>>>
>>>> Does it make any kind of sense to talk about doing this for buffered I/O,
>>>> given that we can't generate them for (eg) mmaped files?
>>>
>>> Sure we can.
>>>
>>> Or rather, some people might very well like to do it even for mutable
>>> data. In fact, _especially_ for mutable data.
>>>
>>> You might want to do things like "write out the state I verified just
>>> a moment ago", and if it has changed since then, you *want* the result
>>> to be invalid because the checksums no longer match - in case somebody
>>> else changed the data you used for the state calculation and
>>> verification in the meantime. It's very much why you'd want a separate
>>> checksum in the first place.
>>>
>>> Yeah, yeah,  you can - and people do - just do things like this with a
>>> separate checksum. But if you know that the filesystem has internal
>>> checksumming support _anyway_, you might want to use it, and basically
>>> say "use this checksum, if the data doesn't match when I read it back
>>> I want to get an IO error".
>>>
>>> (The "data doesn't match" _could_ be just due to DRAM corruption etc,
>>> of course. Some people care about things like that. You want
>>> "verified" filesystem contents - it might not be about security, it
>>> might simply be about "I have validated this data and if it's not the
>>> same data any more it's useless and I need to re-generate it").
>>>
>>> Am I a big believer in this model? No. Portability concerns (across
>>> OS'es, across filesystems, even just across backups on the same exact
>>> system) means that even if we did this, very few people would use it.
>>>
>>> People who want this end up using an external checksum instead and do
>>> it outside of and separately from the actual IO, because then they can
>>> do it on existing systems.
>>>
>>> So my argument is not "we want this". My argument is purely that some
>>> buffered filesystem IO case isn't actually any different from the
>>> traditional "I want access to the low-level sector hardware checksum
>>> data". The use cases are basically exactly the same.
>>>
>>> Of course, basically nobody does that hw sector checksum either, for
>>> all the same reasons, even if it's been around for decades.
>>>
>>> So my "checksum metadata interface" is not something I'm a big
>>> believer in, but I really don't think it's really all _that_ different
>>> from the whole "compressed format interface" that this whole patch
>>> series is about. They are pretty much the same thing in many ways.
>>
>> I see the similarity in the sense that we basically want to pass some
>> extra metadata down with the read or write. So then do we want to add
>> preadv3/pwritev3 for encoded I/O now so that checksums can use it in the
>> future? The encoding metadata could go in this "struct io_how", either
>> directly or in a separate structure with a pointer in "struct io_how".
>> It could get messy with compat syscalls.
> 
> Ping. What's the path forward here? At this point, it seems like an
> ioctl is the path of least resistance.
> 

At this point we've been deadlocked on this for too long.  Put it in a btrfs 
IOCTL, if somebody wants to extend it generically in the future then godspeed, 
we can tie into that interface after the fact.  Thanks,

Josef
