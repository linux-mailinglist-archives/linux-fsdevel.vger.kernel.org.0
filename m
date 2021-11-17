Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C810D454E2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 20:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbhKQTxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 14:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239106AbhKQTxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 14:53:34 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0220DC061764
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 11:50:35 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id e144so4825511iof.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 11:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87/aCIYRViE4sqAqPWWehJIW8qss9o3shFfDpFVgLYk=;
        b=fp2OhtiS0fXO2pOUqVzeeQXECteP/WGOKq2Vv2DaHOcupDqecq6vkULti9AEHtuGz2
         3oE5AMlLykZjhKgcyXVDh99m/ylPGzuAIN7B7BPiagMntY8aN7GIds+frKyYN1GvslJM
         Y9e0EERuBpDsvC/ULXf1jy/PImABK53n0jVxAjQr4h/s1YGqRI3qgjM0rK7OO90QBr0G
         vnqxkGAwG7KgsvXZjNQGMmIUQuP1kad/KxyFqy1wJeMFy4/gmsLcBpAAv0pfhMNiVOL5
         7uOiHaUFuuK6AvD3s3Dn2+FWcIqUxEc3dSseWVE1WACU9gSNEHFsoACw12ltrmju3nGx
         uYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87/aCIYRViE4sqAqPWWehJIW8qss9o3shFfDpFVgLYk=;
        b=l1H9lWIRVobwRUS4pLqwY9yxqNmGBRuTneSA3+gULFJs5ccUQLy/M/4GRWbKRtEjhp
         pNom3doBDTMq8tuCxt5iLsdXnmi1hMA4mnn3aEfGjzNqMZomFA5VOz7FYbhKZeEay1uv
         rEf6hMJCkaf+eV0TTm1d6LYoa8Y9N95fQ5rxxWu2xowoqKzdqfrws5fBeY165jc//1gh
         2DZQyQD6T4BkjoDjJ6JSoi55Q03Olw7OUnfTj3HqMYswVRGO6WzPz1OGSspU8Ko7eyBd
         8Otd1db872YnNB2VqTN1GIjtJsFMWU6FS/CFpo7Bl2EKi5HVFpC38pRLUHdhrmm6uP6K
         Qv7A==
X-Gm-Message-State: AOAM532kCnFwTfBgrZyg+xqrFR7MTym0ctsg+ypiYhqVBrIV65wo1Dx9
        ldq5q8jCB4f4Fjuz+R6GmQIKAz5l6vrPF6oTZXS2IQ==
X-Google-Smtp-Source: ABdhPJwKxkjTGO1T/S5ZPZGTSMMo0deomcO62FYkNj+OiRO2YyBIWst5MD6HCKGcbYrw5W9Rpjt5YbQ/PdpE1YSDBGs=
X-Received: by 2002:a05:6638:160c:: with SMTP id x12mr15414855jas.60.1637178634261;
 Wed, 17 Nov 2021 11:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20211107235754.1395488-1-almasrymina@google.com>
 <YYtuqsnOSxA44AUX@t490s> <CAHS8izP9zJYfqmDouA1otnD-CsQtWJSta0KhOQq81qLSTOHB4Q@mail.gmail.com>
 <YY4bFPkfUhlpUqvo@xz-m1.local> <CAHS8izP7_BBH9NGz3XoL2=xVniH6REor=biqDSZ4wR=NaFS-8A@mail.gmail.com>
 <YZMQbiV9JQWd0EM+@xz-m1.local>
In-Reply-To: <YZMQbiV9JQWd0EM+@xz-m1.local>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 17 Nov 2021 11:50:23 -0800
Message-ID: <CAHS8izPwQidVLAEApJ4vnERwwK6iJ8phfedA0d4_NPwumzRFcw@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Add PM_HUGE_THP_MAPPING to /proc/pid/pagemap
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 15, 2021 at 5:41 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 10 Nov 2021 14:11:20 -0800 Mina Almasry <almasrymina@google.com> wrote:
>
> > Add PM_HUGE_THP MAPPING to allow userspace to detect whether a given virt
> > address is currently mapped by a transparent huge page or not.  Example
> > use case is a process requesting THPs from the kernel (via a huge tmpfs
> > mount for example), for a performance critical region of memory.  The
> > userspace may want to query whether the kernel is actually backing this
> > memory by hugepages or not.
> >
> > PM_HUGE_THP_MAPPING bit is set if the virt address is mapped at the PMD
> > level and the underlying page is a transparent huge page.
> >
> > A few options were considered:
> > 1. Add /proc/pid/pageflags that exports the same info as
> >    /proc/kpageflags.  This is not appropriate because many kpageflags are
> >    inappropriate to expose to userspace processes.
> > 2. Simply get this info from the existing /proc/pid/smaps interface.
> >    There are a couple of issues with that:
> >    1. /proc/pid/smaps output is human readable and unfriendly to
> >       programatically parse.
> >    2. /proc/pid/smaps is slow.  The cost of reading /proc/pid/smaps into
> >       userspace buffers is about ~800us per call, and this doesn't
> >       include parsing the output to get the information you need. The
> >       cost of querying 1 virt address in /proc/pid/pagemaps however is
> >       around 5-7us.
> >
> > Tested manually by adding logging into transhuge-stress, and by
> > allocating THP and querying the PM_HUGE_THP_MAPPING flag at those
> > virtual addresses.
> >
> > --- a/tools/testing/selftests/vm/transhuge-stress.c
> > +++ b/tools/testing/selftests/vm/transhuge-stress.c
> > @@ -16,6 +16,12 @@
> >  #include <string.h>
> >  #include <sys/mman.h>
> >
> > +/*
> > + * We can use /proc/pid/pagemap to detect whether the kernel was able to find
> > + * hugepages or no. This can be very noisy, so is disabled by default.
> > + */
> > +#define NO_DETECT_HUGEPAGES
> > +
> >
> > ...
> >
> > +#ifndef NO_DETECT_HUGEPAGES
> > +             if (!PAGEMAP_THP(ent[0]))
> > +                     fprintf(stderr, "WARNING: detected non THP page\n");
> > +#endif
>
> This looks like a developer thing.  Is there any point in leaving it in
> the mainline code?

I used this to test locally and I thought it may be useful, but on
second thought probably not worth it. Removed in v6 I just sent.

On Mon, Nov 15, 2021 at 5:59 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Nov 15, 2021 at 02:50:26PM -0800, Mina Almasry wrote:
> > PM_THP_MAPPED sounds good to me.
> >
> > TBH I think I still prefer this approach because it's a very simple 2
> > line patch which addresses the concrete use case I have well. I'm not
> > too familiar with the smaps code to be honest but I think adding a
> > range-based smaps API will be a sizeable patch to add a syscall,
> > handle a stable interface, and handle cases where the memory range
> > doesn't match a VMA boundary. I'm not sure the performance benefit
> > would justify this patch and I'm not sure the extra info from smaps
> > would be widely useful. However if you insist and folks believe this
> > is the better approach I can prototype a range-based smaps and test
> > its performance to see if it works for us as well, just let me know
> > what kind of API you're envisioning.
>
> Yeah indeed I haven't yet thought enough on such a new interface, it's just
> that I think it'll be something that solves a broader range of requests
> including the thp-aware issue, so I raised it up.
>
> That shouldn't require a lot code change either afaiu, as smap_gather_stats()
> already takes a "start" and I think what's missing is another end where we just
> pass in 0 when we want the default vma->vm_end as the end of range.
>
> I don't have a solid clue on other use case to ask for that more generic
> interface, so please feel free to move on with it.  If you'll need a repost to
> address the comment from Andrew on removing the debugging lines, please also
> consider using the shorter PM_THP_MAPPED then it looks good to me too.
>

Awesome, thanks! PM_THP_MAPPED sounds good to me and I just sent v6
with these changes.

> Thanks!
>
> --
> Peter Xu
>
