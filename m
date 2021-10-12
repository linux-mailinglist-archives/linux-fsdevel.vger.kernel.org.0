Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A69E42A9F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 18:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhJLQws (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 12:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhJLQwr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 12:52:47 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11485C061745
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 09:50:46 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id w10so48066561ybt.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 09:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ar09QrWZPbtZ1MPFu1DvBkyuuQRpZh8UgkauKcNPOAM=;
        b=YaK6rwZTq4aRgarlqFIa1o4IaxOiXPj3qbCjvidENvw68SISlHG+ig7WWufPr7cyyc
         iLYpsHU9CVkCr3SrnNEDIABH0Rvvra4Y1Toyq7J1Hw07pRZXvbD3xXZu6kqc1t/0riCj
         XixP30thoEdXn7Fkf4PxSST9mYIrZ9voaWm4ID3wWTwToLSCDjdFU/NMr5IDC54RW4C7
         GD6zFsvDMeMJ5L4mc1VIn6D0XScIOUYxYtsXyV2PD9x4hnEfH/EPSldRjaHYwQnzJeD6
         ds9Pe3GqsmSNwVDVfAhhG+AElXJLhzNGpKcnTmrpxin8D6FZvzDX5HXboNHhFNyKmoP4
         oSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ar09QrWZPbtZ1MPFu1DvBkyuuQRpZh8UgkauKcNPOAM=;
        b=udQ/ryI0ebgGWuchWoGsVgNjNGjT0WyDyfvHv6nUK0cRejV5kkNMQ/kYUG3lxcyZpZ
         lr/NvmRT6G8YF4NxDHVrxVXOGMHCiTkL2j8dp9zmVdi96vT9+reJ2Ka611dl9b2JPIeh
         gIuAFA4VZpKdWyqEJViHXcAHDMR47bvtua3DaZDEo8GlS7bCVny/pbjlc+6m96CszOqF
         Aw5zpIFnbmf0TAt4BV/8ZX47BHSoYV/B8uuzBHjh+dC3hisTHlJWWtmQr78kz95o4tdN
         SHQKHbHHGmzkrRv4papE8PtDsUHdiXbVs2DG+XitxPiWdnpPjEIqir+n7uIQTdwyyCCw
         xmtw==
X-Gm-Message-State: AOAM532OHTAiCh7wZCjFNiqeqDWuFlX7YKC2igL6JZZ/iA/BSuurjQQo
        laplkwBI1kEv9p3wOV8baWbOCIrOAUwu2VAsnM9IPg==
X-Google-Smtp-Source: ABdhPJz2dtiPou9PSUcVJPjWtl1ZS5oxDJf/t7tSJdJJSiEPO2SLzNa3EVK7YV+ElEwQ813Mhr+Eyk+va9mwyNRAxsc=
X-Received: by 2002:a25:d1d3:: with SMTP id i202mr31604897ybg.487.1634057444798;
 Tue, 12 Oct 2021 09:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <YV8jB+kwU95hLqTq@dhcp22.suse.cz> <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz> <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
 <202110071111.DF87B4EE3@keescook> <YV/mhyWH1ZwWazdE@dhcp22.suse.cz>
 <202110081344.FE6A7A82@keescook> <YWP3c/bozz5npQ8O@dhcp22.suse.cz>
 <CAJuCfpHQVMM4+6Lm_EnFk06+KrOjSjGA19K2cv9GmP3k9LW5vg@mail.gmail.com>
 <CAJuCfpHaF1e0V=wAoNO36nRL2A5EaNnuQrvZ2K3wh6PL6FrwZQ@mail.gmail.com> <YWU7FELcxIFmr9uz@dhcp22.suse.cz>
In-Reply-To: <YWU7FELcxIFmr9uz@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 12 Oct 2021 09:50:33 -0700
Message-ID: <CAJuCfpESeM_Xd8dhCj_okNggtDUXx3Nn9FpL_f9qsKXKZzCKpA@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     Michal Hocko <mhocko@suse.com>
Cc:     Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 12, 2021 at 12:37 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 11-10-21 18:20:25, Suren Baghdasaryan wrote:
> > On Mon, Oct 11, 2021 at 6:18 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Mon, Oct 11, 2021 at 1:36 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Fri 08-10-21 13:58:01, Kees Cook wrote:
> > > > > - Strings for "anon" specifically have no required format (this is good)
> > > > >   it's informational like the task_struct::comm and can (roughly)
> > > > >   anything. There's no naming convention for memfds, AF_UNIX, etc. Why
> > > > >   is one needed here? That seems like a completely unreasonable
> > > > >   requirement.
> > > >
> > > > I might be misreading the justification for the feature. Patch 2 is
> > > > talking about tools that need to understand memeory usage to make
> > > > further actions. Also Suren was suggesting "numbering convetion" as an
> > > > argument against.
> > > >
> > > > So can we get a clear example how is this being used actually? If this
> > > > is just to be used to debug by humans than I can see an argument for
> > > > human readable form. If this is, however, meant to be used by tools to
> > > > make some actions then the argument for strings is much weaker.
> > >
> > > The simplest usecase is when we notice that a process consumes more
> > > memory than usual and we do "cat /proc/$(pidof my_process)/maps" to
> > > check which area is contributing to this growth. The names we assign
> > > to anonymous areas are descriptive enough for a developer to get an
> > > idea where the increased consumption is coming from and how to proceed
> > > with their investigation.
> > > There are of course cases when tools are involved, but the end-user is
> > > always a human and the final report should contain easily
> > > understandable data.
>
> OK, it would have been much more preferable to be explicit about this
> main use case from the very beginning. Just to make sure we are at the
> same page. Is the primary usecase usage and bug reporting?

Sorry, I should have spent more time on patch #2 description. Yes,
debugging memory issues is the primary usecase. In fact that's the
only usecase in Android AFAIK.

>
> My initial understanding was that at userspace managed memory management
> could make an educated guess about targeted reclaim (e.g. MADV_{FREE,COLD,PAGEOUT}
> for cached data in memory like uncompressed images/data). Such a usecase
> would clearly require a standardized id/naming convention to be
> application neutral.

Ah, now I understand your angle. Our prior work on process_madvise()
probably helped in leading your thoughts in this direction :) Sorry
about the confusion.

>
> > > IIUC, the main argument here is whether the userspace can provide
> > > tools to perform the translations between ids and names, with the
> > > kernel accepting and reporting ids instead of strings. Technically
> > > it's possible, but to be practical that conversion should be fast
> > > because we will need to make name->id conversion potentially for each
> > > mmap. On the consumer side the performance is not as critical, but the
> > > fact that instead of dumping /proc/$pid/maps we will have to parse the
> > > file, do id->name conversion and replace all [anon:id] with
> > > [anon:name] would be an issue when we do that in bulk, for example
> > > when collecting system-wide data for a bugreport.
>
> Whether you use ids or human readable strings you still have to
> understand the underlying meaning to make any educated guess. Let me
> give you an example. Say I have an application with a memory leak. Right
> now I can only tell that it is anonymous memory growing but it is not
> clear who uses that anonymous. You are adding a means to tell different
> users appart. That is really helpful. Now I know this is an anon
> user 1234 or MySuperAnonMemory. Neither of the will not tell me more
> without a id/naming convention or reading the code. A convention can be
> useful for the most common users (e.g. a specific allocator) but I am
> rather dubious there are many more that would be _generally_ recognized
> without some understanding of the said application.

I guess an example would be better to clarify this. Here are some vma
names from Google maps app:

[anon:dalvik-main space (region space)]
[anon:dalvik-/apex/com.android.art/javalib/boot.art]
[anon:dalvik-/apex/com.android.art/javalib/boot-apache-xml.art]
[anon:.bss]
[anon:dalvik-zygote space]
[anon:dalvik-non moving space]
[anon:dalvik-free list large object space]
[anon:dalvik-/product/app/Maps/oat/arm64/Maps.art]
[anon:stack_and_tls:20792]
[anon:stack_and_tls:20791]
[anon:dalvik-LinearAlloc]
[anon:dalvik-CompilerMetadata]
[anon:dalvik-indirect ref table]
[anon:dalvik-live stack]
[anon:dalvik-allocation stack]
[anon:dalvik-large object free list space allocation info map]
[anon:scudo:primary]
[anon:scudo:secondary]
[anon:bionic_alloc_small_objects]

Most of them have names standard for Android and can be recognized by
developers and even Android framework (example where "anon:dalvik-main
space" and other standard names are being parsed:
https://cs.android.com/android/platform/superproject/+/master:frameworks/base/core/jni/android_os_Debug.cpp;l=340).
Names like "anon:dalvik-/apex/com.android.art/javalib/boot.art" help
the developer to recognize the component responsible for the memory.
Names like "anon:stack_and_tls:20792" include the TID of the thread
which uses this memory. All this information can help in narrowing
down memory consumption investigation. Hopefully these examples
clarify the usage a bit better?

>
> Maybe the situation in Android is different because the runtime is more
> coupled but is it reasonable to expect any common naming conventions for
> general Linux platforms?

Well, to be useful the system would have to agree to *some* convention I guess.

>
> I am slightly worried that we have spent way too much time talking
> specifics about id->name translation rather than the actual usability
> of the token.

Agree. I'll try to avoid further confusions.
Thanks!

> --
> Michal Hocko
> SUSE Labs
