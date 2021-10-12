Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B756D429AF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 03:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbhJLBWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 21:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbhJLBWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 21:22:37 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB91C061570
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Oct 2021 18:20:37 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id s4so42993083ybs.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Oct 2021 18:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0rvH8tccG1GCW1xVscvfSQVrt0Y/dmYu+9N0LqR3IU=;
        b=ozWNgkyPQ6g2Pb6GhDQaCx4ZxPKDrBt5s2ggV9Ns3aDuMRwgN/pb8qCCc75VBqb19f
         OghPvT9NZ3DJ8gXsGqPKYt6+SQFN/ApQF6XXqcBQDxiC5rgqd0w20vWV7y/3n/HBX73A
         mYHYuTI/yuzdz6aA8LJWPIynztB+pp8z1VmlcJSARvWWwH3sjX/rD1nXx/GWDMfJbRiY
         onfCMl0VsmdBL4rZnW+ek3I+1+Sk62K28tZE0iSXgGlhh5683azjY2imwUSYEYfhUaqE
         8T9k1TImgSZOiUTnlqCMBWhndlrEIqEIpm5qjv40lClFReap2zuQBi62mOwgtVEqrVGk
         z2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0rvH8tccG1GCW1xVscvfSQVrt0Y/dmYu+9N0LqR3IU=;
        b=d7uwcsIBUttcU89xZD8dKAoVBHoqEPgp8/WrMLqhBHO+EaejQ7+s4bqTVVL12R1CRq
         WowY/n6Rvb5fZSD5O4wzIqt8odyL/Bgd6tSUYc7MzS24uXNBbiY3wuWGDg9sD/UdlLGd
         08O1fRTKLJIay9xaO0oNAbJvmGUztE7vsEbCh6b6j6+FqJP51PEZ5K6gTpsG/cWt6WAn
         kEQDDInVvN1T2gzpVMkOOaPoZaKMA1MqR+HMISNrUmcLDFKEXeY84wlvvkD2lBi6qWS2
         9y+sXcftGIelDhwU0QYeoVs00vjMPeSPTTdnQa7hGk7N+iYUNob2Uohz8brnCIwwK22z
         1rmQ==
X-Gm-Message-State: AOAM533PS1LFOggyJeMU2SHpcfIze/yPfPbIUwAuZDVdwhA5YY738n6e
        qTKkjOAMt0mlmeF/BSAugc3TpHXXGaBvADC9VpvntA==
X-Google-Smtp-Source: ABdhPJyHvt4aySXDLkg2z+6x0kGcvsx1rVoezM+PTBjUy0+IBRYK/uij8JJWNi9p7n7FF7CAOZG+U+VrGupgEfmgznE=
X-Received: by 2002:a25:8411:: with SMTP id u17mr25321543ybk.376.1634001636162;
 Mon, 11 Oct 2021 18:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
 <20211007101527.GA26288@duo.ucw.cz> <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
 <YV8jB+kwU95hLqTq@dhcp22.suse.cz> <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz> <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
 <202110071111.DF87B4EE3@keescook> <YV/mhyWH1ZwWazdE@dhcp22.suse.cz>
 <202110081344.FE6A7A82@keescook> <YWP3c/bozz5npQ8O@dhcp22.suse.cz> <CAJuCfpHQVMM4+6Lm_EnFk06+KrOjSjGA19K2cv9GmP3k9LW5vg@mail.gmail.com>
In-Reply-To: <CAJuCfpHQVMM4+6Lm_EnFk06+KrOjSjGA19K2cv9GmP3k9LW5vg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 11 Oct 2021 18:20:25 -0700
Message-ID: <CAJuCfpHaF1e0V=wAoNO36nRL2A5EaNnuQrvZ2K3wh6PL6FrwZQ@mail.gmail.com>
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

On Mon, Oct 11, 2021 at 6:18 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Mon, Oct 11, 2021 at 1:36 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 08-10-21 13:58:01, Kees Cook wrote:
> > > - Strings for "anon" specifically have no required format (this is good)
> > >   it's informational like the task_struct::comm and can (roughly)
> > >   anything. There's no naming convention for memfds, AF_UNIX, etc. Why
> > >   is one needed here? That seems like a completely unreasonable
> > >   requirement.
> >
> > I might be misreading the justification for the feature. Patch 2 is
> > talking about tools that need to understand memeory usage to make
> > further actions. Also Suren was suggesting "numbering convetion" as an
> > argument against.
> >
> > So can we get a clear example how is this being used actually? If this
> > is just to be used to debug by humans than I can see an argument for
> > human readable form. If this is, however, meant to be used by tools to
> > make some actions then the argument for strings is much weaker.
>
> The simplest usecase is when we notice that a process consumes more
> memory than usual and we do "cat /proc/$(pidof my_process)/maps" to
> check which area is contributing to this growth. The names we assign
> to anonymous areas are descriptive enough for a developer to get an
> idea where the increased consumption is coming from and how to proceed
> with their investigation.
> There are of course cases when tools are involved, but the end-user is
> always a human and the final report should contain easily
> understandable data.
>
> IIUC, the main argument here is whether the userspace can provide
> tools to perform the translations between ids and names, with the
> kernel accepting and reporting ids instead of strings. Technically
> it's possible, but to be practical that conversion should be fast
> because we will need to make name->id conversion potentially for each
> mmap. On the consumer side the performance is not as critical, but the
> fact that instead of dumping /proc/$pid/maps we will have to parse the
> file, do id->name conversion and replace all [anon:id] with
> [anon:name] would be an issue when we do that in bulk, for example
> when collecting system-wide data for a bugreport.
>
> I went ahead and implemented the proposed userspace solution involving
> tmpfs as a repository for name->id mapping (more precisely
> filename->inode mapping). Profiling shows that open()+fstat()+close()
> takes:
> - roughly 15 times longer than mmap() with 1000 unique names each
> being reused 50 times.
> - roughly 3 times longer than mmap() with 100 unique names each being
> reused 500 times. This is due to lstat() optimization suggested by
> Rasmus which avoids open() and close().
> For comparison, proposed prctl() takes roughly the same amount of time
> as mmap() and does not depend on the number of unique names.
>
> I'm still evaluating the proposal to use memfds but I'm not sure if
> the issue that David Hildenbrand mentioned about additional memory
> consumed in pagecache (which has to be addressed) is the only one we
> will encounter with this approach. If anyone knows of any potential
> issues with using memfds as named anonymous memory, I would really
> appreciate your feedback before I go too far in that direction.
> Thanks,
> Suren.

Just noticed that timmurray@ was dropped from the last reply. Adding him back.

>
> > --
> > Michal Hocko
> > SUSE Labs
