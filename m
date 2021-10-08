Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8703426E6C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 18:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhJHQMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 12:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhJHQMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:12:22 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEE3C061764
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Oct 2021 09:10:26 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id i84so22113588ybc.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Oct 2021 09:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G33pHw0ueNt5fMw+IeGu7bQcs55JybN6lDQyIbd7GiQ=;
        b=Bv7ZpFLyYPApZxpHNAgAUvso133HjrOBFL6hqMdB+IrVyL/rHGAOU/y+005qkEd0nu
         ZA5PlXGDWJ2Oy1ZLhPo2KEUzS+ThRbdjQdMeRAA9WpFraOCBVrlry8zMBToM1RUBboE3
         oFia/EYFHpnczvwhehgCq2Sry06QgR/xMNSmDGcjYnj6SRqQjyqqIrHj+cKXq871uvd1
         GbC91qH7oND33Xt1APC2G4qAdHiZb1fgN7SnJgNXjtbZMyZTbybzZtPoc/PK13IDvWmZ
         FkAucL5pN+akLtMwvcAkApQv0AUabZqXSsvJl2QYJeLcTOSME8Ak4XCwwK7RUdavPe+E
         a8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G33pHw0ueNt5fMw+IeGu7bQcs55JybN6lDQyIbd7GiQ=;
        b=JchdIW1Y0Y4lz3/4d5QX4l02qCssgL9g6L6vnnj6PS3uxamObcyBXi93ZDCKjQBKSU
         KL2B9W+zYH6eDkR8wHCrv4CzA2NrEgjideGDDBQjdTmU2YX8ZRxuJ2Q6t3qFof7FuVHh
         UkWM4UIURWhgl5A6QUje9fzcKUhIL6+aNhkde+IypClSIBO1fNW1VeO0IZ54UDIaodUY
         UQU7a0UVCbPLIbDEElgG+rnTZGwczgeVoCzaOb9e1mpvo2Hi3JBoE+7IeaHbPFbNNUI9
         nMBt8i2bGHIJttUg+PlTW6ybY/YYzz2ewf79KSwZK0oVg4c/BImiMd8/jLJt7xC/kcWH
         9isg==
X-Gm-Message-State: AOAM532D0UXbBJcAwkzuqoXAuvn3GWsCkyu5FB5OMr5zn2FAb8QEXCWf
        GVr2t5/de2Ga3QyVYZcqb3USFTA7GkMPJ8KkbfLPPQ==
X-Google-Smtp-Source: ABdhPJxCL/oJpeRH39HJsnbtpduvh2CejVR6+QmWEnNfuUXcZUpgiTakWbEdOxd31P0xMuAIf32tWZVuGngf1ObyV/M=
X-Received: by 2002:a05:6902:120e:: with SMTP id s14mr4989108ybu.161.1633709425599;
 Fri, 08 Oct 2021 09:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
 <20211007101527.GA26288@duo.ucw.cz> <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
 <YV8jB+kwU95hLqTq@dhcp22.suse.cz> <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz> <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
 <202110071111.DF87B4EE3@keescook> <YV/mhyWH1ZwWazdE@dhcp22.suse.cz>
 <4a1dd04f-eda3-5c71-4772-726fd6fa2a38@intel.com> <YWBcXPZh9pYr0AHm@dhcp22.suse.cz>
In-Reply-To: <YWBcXPZh9pYr0AHm@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 8 Oct 2021 09:10:14 -0700
Message-ID: <CAJuCfpFdZeirEERAvM6X26qcoC5runpWQhmPrQ97RYk-HawwJg@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
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
        kernel-team <kernel-team@android.com>, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 8, 2021 at 7:57 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 08-10-21 07:14:58, Dave Hansen wrote:
> > On 10/7/21 11:34 PM, Michal Hocko wrote:
> > >> Yes, please. It really seems like the folks that are interested in this
> > >> feature want strings. (I certainly do.)
> > > I am sorry but there were no strong arguments mentioned for strings so
> > > far.
> >
> > The folks who want this have maintained an out-of-tree patch using
> > strings.  They've maintained it for the better part of a decade.  I
> > don't know how widely this shipped in the Android ecosystem, but I
> > suspect we're talking about billions of devices.  Right?

Correct.

> >
> > This is a feature that, if accepted into mainline, will get enabled and
> > used on billions of devices.  If we dumb this down to integers, it's not
> > 100% clear that it _will_ get used.

Not as is and not with some major changes in the userspace, which
relied on a simple interface: set a name to a vma, observe that name
in the /proc/$pid/maps.

> >
> > That's a pretty strong argument in my book, even if the contributors
> > have difficulty articulating exactly why they want strings.
>
> I would agree that if integers would make this unusable then this would
> be a strong argument. But I haven't really heard any arguments like that
> so far. I have heard about IPC overhead and other speculations that do
> not seem really convincing. We shouldn't hand wave concerns regarding
> the implementation complexity and resource handling just by "somebody
> has been using this for decates", right?
>
> Do not get me wrong. This is going to become a user interface and we
> will have to maintain it for ever. As such an extra scrutiny has to be
> applied.

I don't know how to better articulate this. IPC transactions on
Android cannot be scheduled efficiently. We're going to have to stall
after mmap, make binder transaction, schedule a new process, get the
ID, make binder reply, schedule back to the original thread, resume.
Doing this potentially for every mmap is a non-starter. Deferring this
job is possible but we still have to do all this work, so it still
requires cpu cycles and power, not mentioning the additional
complexity in the userspace. I'm adding a rep from the performance
team, maybe Tim can explain this better.

There were a couple suggestions on using filesystem/memfd for naming
purposes which I need to explore but if that works the approach will
likely not involve any IDs. We want human-readable names in the maps
file, not a number.

Thanks for all the feedback and ideas!

> --
> Michal Hocko
> SUSE Labs
