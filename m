Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E08D5224B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 21:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiEJTZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 15:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiEJTZu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 15:25:50 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E5A26FA62;
        Tue, 10 May 2022 12:25:48 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j10-20020a17090a94ca00b001dd2131159aso2852665pjw.0;
        Tue, 10 May 2022 12:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yMEahIlZJnX2qJHRkWVg84giIMfL6Y07yKJTD4dXB+w=;
        b=Xzcsc1mLMNPTCdNaf1Djr8YqMPmcC3uj0nMVv4+EsTkDK91NwRdqQiTAxakLP3pMCj
         eMCsaklblgnZ5lUnJErcy1VchQ3HGrB/0gUnUPLhQF0YVqF2I+PLikpjVNsj5/Aad+lX
         xhEKH4HNVqI7/TCf4g4uawz4v7s6/u0VChDnQFWcVceSPhFtCOgoENlexFipoVgrZv6q
         VQNIOBh8KXoTZpBtA7WJy8DdQjzkSi8AmrGTkW6Jq1IVFZp0613I3I4fwJsg63CExV6e
         eqHRycV/UkXUZ+n/rk7gSEJ2UgjEyO+/51usz4TE0QhRFLehItkKjI6fR7/myGhIFMh5
         UAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMEahIlZJnX2qJHRkWVg84giIMfL6Y07yKJTD4dXB+w=;
        b=LA06It6ybq8UK0HF/XACdi+ocag9Bi+R67ZnWGwgkjvo7tBdm8Owhut2iTURY0LJ3z
         nlXTDdajzWu7tZBnxjps27Dq0yFS0LBKFVUenDX8bawYhuifZnV3i3eBDSFYVQ5BjtfL
         ZlVEr8SU1orQo1ssndLXQ/xP4ML5BdUVRgUYaJ9Dd5jpLtTAo606WJTz4m4G46ytzRe3
         mmYMr+hGGlwNu5NiffUKPafMm5LpBCIrOY0AdwSoskEufHWzC3eNyPHGYjZlo0xI6TKM
         vyKYD7WR+pdrQ591SoPmANJA5UIyaKWqvImy97LFvhn6/r/uiuHUXs5LSJlhZnXMYCk4
         UBXA==
X-Gm-Message-State: AOAM532Y7eghCZDxeI6o5Y+xHGzRROsJkD/D7/ZTMegVTbPMNBObbFXs
        h3BAIggjuoJ0ipIcbjtuPZhAPNkupmY+7P3MIkg=
X-Google-Smtp-Source: ABdhPJyFJGBMBEJyMlqEm7L9jqhfh1Y3xS2u11ojgQUvUMdqPAQdjdzEINUAC22Whn0cRtR66FXEuz/4zGvxQi9hCGQ=
X-Received: by 2002:a17:903:32c6:b0:15e:c1cc:2405 with SMTP id
 i6-20020a17090332c600b0015ec1cc2405mr22473563plr.117.1652210747881; Tue, 10
 May 2022 12:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220404200250.321455-1-shy828301@gmail.com> <627a71f8-e879-69a5-ceb3-fc8d29d2f7f1@suse.cz>
 <CAHbLzkrZb6r1r6xFaEFvvJzwvVgDgeZWfjhq-SFu_mQZ0j5tTQ@mail.gmail.com> <0da1c63b-5cc3-7fc9-1fb4-fdc385539bbc@suse.cz>
In-Reply-To: <0da1c63b-5cc3-7fc9-1fb4-fdc385539bbc@suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 10 May 2022 12:25:35 -0700
Message-ID: <CAHbLzkq188TOkUw5uawq81LHoxfdKSHeu3UiVvx=ZMo_o9GWMA@mail.gmail.com>
Subject: Re: [v3 PATCH 0/8] Make khugepaged collapse readonly FS THP more consistent
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 10, 2022 at 12:35 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 5/9/22 22:34, Yang Shi wrote:
> > On Mon, May 9, 2022 at 9:05 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> On 4/4/22 22:02, Yang Shi wrote:
> >> >  include/linux/huge_mm.h        | 14 ++++++++++++
> >> >  include/linux/khugepaged.h     | 59 ++++++++++++---------------------------------------
> >> >  include/linux/sched/coredump.h |  3 ++-
> >> >  kernel/fork.c                  |  4 +---
> >> >  mm/huge_memory.c               | 15 ++++---------
> >> >  mm/khugepaged.c                | 76 +++++++++++++++++++++++++++++++++++++-----------------------------
> >> >  mm/mmap.c                      | 14 ++++++++----
> >> >  mm/shmem.c                     | 12 -----------
> >> >  8 files changed, 88 insertions(+), 109 deletions(-)
> >>
> >> Resending my general feedback from mm-commits thread to include the
> >> public ML's:
> >>
> >> There's modestly less lines in the end, some duplicate code removed,
> >> special casing in shmem.c removed, that's all good as it is. Also patch 8/8
> >> become quite boring in v3, no need to change individual filesystems and also
> >> no hook in fault path, just the common mmap path. So I would just handle
> >> patch 6 differently as I just replied to it, and acked the rest.
> >>
> >> That said it's still unfortunately rather a mess of functions that have
> >> similar names. transhuge_vma_enabled(vma). hugepage_vma_check(vma),
> >> transparent_hugepage_active(vma), transhuge_vma_suitable(vma, addr)?
> >> So maybe still some space for further cleanups. But the series is fine as it
> >> is so we don't have to wait for it now.
> >
> > Yeah, I agree that we do have a lot thp checks. Will find some time to
> > look into it deeper later.
>
> Thanks.
>
> >>
> >> We could also consider that the tracking of which mm is to be scanned is
> >> modelled after ksm which has its own madvise flag, but also no "always"
> >> mode. What if for THP we only tracked actual THP madvised mm's, and in
> >> "always" mode just scanned all vm's, would that allow ripping out some code
> >> perhaps, while not adding too many unnecessary scans? If some processes are
> >
> > Do you mean add all mm(s) to the scan list unconditionally? I don't
> > think it will scale.
>
> It might be interesting to find out how many mm's (percentage of all mm's)
> are typically in the list with "always" enabled. I wouldn't be surprised if
> it was nearly all of them. Having at least one large enough anonymous area
> sounds like something all processes would have these days?

Just did a simple test on my Fedora VM with "always", which is almost idle.

The number of user processes (excluding kernel thread) is:
[yangs@localhost ~]$ ps -aux --no-headers | awk '{if ($5 > 0) print $5}' | wc -l
113

The number of mm on khugepaged scan list counted by a simple drgn
script is 56. The below is the drgn script:
>>> i = 0
>>> mm_list = prog['khugepaged_scan'].mm_head.address_of_()
>>> for mm in list_for_each(mm_list):
...     i = i + 1
...
>>> print(i)

So 50% processes on the list. For busy machines, the percentage may be
higher. And the most big enough processes (with large anon mapping)
should be on the list.

>
> >> being scanned without any effect, maybe track success separately, and scan
> >> them less frequently etc. That could be ultimately more efficinet than
> >> painfully tracking just *eligibility* for scanning in "always" mode?
> >
> > Sounds like we need a couple of different lists, for example, inactive
> > and active? And promote or demote mm(s) between the two lists? TBH I
> > don't see too many benefits at the moment. Or I misunderstood you?
>
> Yeah, something like that. It would of course require finding out whether
> khugepaged is consuming too much cpu uselessly these days while not
> processing fast enough mm's where it succeeds more.

Yeah, currently we don't have such statistics at mm or vma
granularity. But we may be able to get some stats by some
post-processing with trace events.

>
> >>
> >> Even more radical thing to consider (maybe that's a LSF/MM level topic, too
> >> bad :) is that we scan pagetables in ksm, khugepaged, numa balancing, soon
> >> in MGLRU, and I probably forgot something else. Maybe time to think about
> >> unifying those scanners?
> >
> > We do have pagewalk (walk_page_range()) which is used by a couple of
> > mm stuff, for example, mlock, mempolicy, mprotect, etc. I'm not sure
> > whether it is feasible for khugepaged, ksm, etc, or not since I didn't
> > look that hard. But I agree it should be worth looking at.
>
> pagewalk is a framework to simplify writing code that processes page tables
> for a given one-off task, yeah. But this would be something a bit different,
> e.g. a kernel thread that does the sum of what khugepaged/ksm/etc do. Numa
> balancing uses task_work instead of kthread so that would require
> consideration on which mechanism the unified daemon would use.

Aha, OK, you mean consolidate khugepaged, ksmd, etc into one kthread.
TBH I don't know whether that will work out or not. Maybe the first
step is to use the same page table walk framework for all of them?

>
> >>
> >>
>
