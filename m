Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D6142412B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 17:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbhJFPWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 11:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbhJFPWY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:22:24 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE53C061746
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Oct 2021 08:20:32 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id s4so6209476ybs.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Oct 2021 08:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ToWLSh1nym/rn5R/pSIAH+olMraiA1xkOFeogqJaaLs=;
        b=f9kn9JCx2oUBAwY8E2iW/mbf7AvxnjIXVRaac9UV50eeIWLqUTCWu0BV3L74owunwZ
         T8+Ksi5PO1UrZo7J2XqHRGiNW3/QgmcjUvcNnegrQMOjspJwLlWRfGdXHYBbE3rWHFYT
         S5HR7U+eS+bLsWztsK+kURy3vTEiXFEwh+pGSta6oNHQNPLwhb44AARlY/BokOnZ8PT3
         fRkA+WKzmNJyGLRRzch90e6kNwJ0x5Tb1XAfePiZXDH+a5NenIaapda/NDaFLES+s62d
         5T0tvNJCfu0HEP2gi7mvJw5gLrUCYZCyQ+xFv77F6JuWgCYj94+gOqouoXSP/PgcHZFX
         3xtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ToWLSh1nym/rn5R/pSIAH+olMraiA1xkOFeogqJaaLs=;
        b=rsOxEC+aMIA6KDdgUbM0jPAxX+mgNbQYD+mIT1gH1x1FqD2O0cimE41Jiei1QkAVKg
         cS0qZxkD6+ODaBjl2JGUPKgHSoX4mqDcYvruNmgomCZx1CmULU94z1muaSFrBw75/5zM
         YQoNBFK6I3BE5sjhwlF/aFPvvIRAVOJnII1qkrorNDG41ekiDMq2eMorZQ6A12qqzDjj
         RxNo8psWPbEDV6/rWsgKVQaxBtcWETiG40BXTl0ERUNBWlNgZ41ZPtFASe5ytmiq/VUc
         R61ucGRWz9dCfVBEHWL7qlNQQ47lCK7Kmlnyz40XYJ5FozBkHZNY6jo49U1Kvan3yKlr
         o19A==
X-Gm-Message-State: AOAM5305X3C/NQWf6xzZ7i7VOcNu9FLL2MYLZaqvKkcR4IxZBe20tSml
        GX58Gnb2vPp54TcPUNZ8YklyLiZh/i9dapTI9271GQ==
X-Google-Smtp-Source: ABdhPJznFIkWV5cysIjYInnizr+OQ6ABZBYR0C1kpMgLSGjmxpkDb2Dph4kHq6ZH+DZeHiU/+bV2NT5qG2v6pWR5drM=
X-Received: by 2002:a25:3:: with SMTP id 3mr29846057yba.418.1633533631382;
 Wed, 06 Oct 2021 08:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211001205657.815551-1-surenb@google.com> <20211001205657.815551-3-surenb@google.com>
 <20211005184211.GA19804@duo.ucw.cz> <CAJuCfpE5JEThTMhwKPUREfSE1GYcTx4YSLoVhAH97fJH_qR0Zg@mail.gmail.com>
 <20211005200411.GB19804@duo.ucw.cz> <CAJuCfpFZkz2c0ZWeqzOAx8KFqk1ge3K-SiCMeu3dmi6B7bK-9w@mail.gmail.com>
 <efdffa68-d790-72e4-e6a3-80f2e194d811@nvidia.com> <YV1eCu0eZ+gQADNx@dhcp22.suse.cz>
 <6b15c682-72eb-724d-bc43-36ae6b79b91a@redhat.com> <CAJuCfpEPBM6ehQXgzp=g4SqtY6iaC8wuZ-CRE81oR1VOq7m4CA@mail.gmail.com>
 <192438ab-a095-d441-6843-432fbbb8e38a@redhat.com>
In-Reply-To: <192438ab-a095-d441-6843-432fbbb8e38a@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 6 Oct 2021 08:20:20 -0700
Message-ID: <CAJuCfpH4KT=fOAWsYhaAb_LLg-VwPvL4Bmv32NYuUtZ3Ceo+PA@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, John Hubbard <jhubbard@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
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
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 6, 2021 at 8:08 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 06.10.21 17:01, Suren Baghdasaryan wrote:
> > On Wed, Oct 6, 2021 at 2:27 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 06.10.21 10:27, Michal Hocko wrote:
> >>> On Tue 05-10-21 23:57:36, John Hubbard wrote:
> >>> [...]
> >>>> 1) Yes, just leave the strings in the kernel, that's simple and
> >>>> it works, and the alternatives don't really help your case nearly
> >>>> enough.
> >>>
> >>> I do not have a strong opinion. Strings are easier to use but they
> >>> are more involved and the necessity of kref approach just underlines
> >>> that. There are going to be new allocations and that always can lead
> >>> to surprising side effects.  These are small (80B at maximum) so the
> >>> overall footpring shouldn't all that large by default but it can grow
> >>> quite large with a very high max_map_count. There are workloads which
> >>> really require the default to be set high (e.g. heavy mremap users). So
> >>> if anything all those should be __GFP_ACCOUNT and memcg accounted.
> >>>
> >>> I do agree that numbers are just much more simpler from accounting,
> >>> performance and implementation POV.
> >>
> >> +1
> >>
> >> I can understand that having a string can be quite beneficial e.g., when
> >> dumping mmaps. If only user space knows the id <-> string mapping, that
> >> can be quite tricky.
> >>
> >> However, I also do wonder if there would be a way to standardize/reserve
> >> ids, such that a given id always corresponds to a specific user. If we
> >> use an uint64_t for an id, there would be plenty room to reserve ids ...
> >>
> >> I'd really prefer if we can avoid using strings and instead using ids.
> >
> > I wish it was that simple and for some names like [anon:.bss] or
> > [anon:dalvik-zygote space] reserving a unique id would work, however
> > some names like [anon:dalvik-/system/framework/boot-core-icu4j.art]
> > are generated dynamically at runtime and include package name.
>
> Valuable information

Yeah, I should have described it clearer the first time around.

>
> > Packages are constantly evolving, new ones are developed, names can
> > change, etc. So assigning a unique id for these names is not really
> > feasible.
>
> So, you'd actually want to generate/reserve an id for a given string at
> runtime, assign that id to the VMA, and have a way to match id <->
> string somehow?

If we go with ids then yes, that is what we would have to do.

> That reservation service could be inside the kernel or even (better?) in
> user space. The service could for example de-duplicates strings.

Yes but it would require an IPC call to that service potentially on
every mmap() when we want to name a mapped vma. This would be
prohibitive. Even on consumption side, instead of just dumping
/proc/$pid/maps we would have to parse the file and convert all
[anon:id] into [anon:name] with each conversion requiring an IPC call
(assuming no id->name pair caching on the client side).

> My question would be, if we really have to expose these strings to the
> kernel, or if an id is sufficient. Sure, it would move complexity to
> user space, but keeping complexity out of the kernel is usually a good idea.

My worry here is not the additional complexity on the userspace side
but the performance hit we would have to endure due to these
conversions.

> --
> Thanks,
>
> David / dhildenb
>
