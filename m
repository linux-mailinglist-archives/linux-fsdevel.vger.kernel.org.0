Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07366424BE3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 04:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhJGCtD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 22:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbhJGCtC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 22:49:02 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB97C061753
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Oct 2021 19:47:09 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id n65so9948442ybb.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Oct 2021 19:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Cs1bvfp4Te/cba1+QGm30Xc9WLtpDndPuoyLtYCfOA=;
        b=MygceOBt27vyNNGEqPQPWKuRkZ869tZRG97KZw+qF6zk5ZcPjKugxuSYijToTNPHb5
         sHYurBA8Cs8YtaARlyaAoqTpa7S+RaQKEyZK2TfBlzx3raE+YsEFnvEW9WCnztTk7uS4
         xyO8HfreUzXFQ89tkC5GhWeCknXB/iFJgrrZ2woMGXTROFMluFEDsfpNEZUIvw+FZhwx
         7YDdAIbzbggvSGe9ECRQzEDbTH8tssZN0dIbBCp0AvIJSGh15x8jhsHnCejypdbRR3fy
         QMVBSDQOooJ62cKwgaSWNKYGs9M4VIVuFE5ruEV6hBdVPbtYWbXhzsSTt+tY8bNNh0ZK
         /bfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Cs1bvfp4Te/cba1+QGm30Xc9WLtpDndPuoyLtYCfOA=;
        b=WJQp2EVfQcPCUco5AYOYZ0e7gKSQLx85nyIVkWfpJvmuf4zmKD73u4jnrFuHguAw5m
         z27LEbZfxQoCm/vISbLzADmwf+fHrRcFx9BE38sLhJI0s8QejnBHVrpfHAr58YaTXtsC
         VZHOdJZQDmKYyKdDBPCWSFgYuc/0gpj9DNX2KffpLgLScMw1AcahXNeI3/5ShLYEke/W
         M6aqu7Dk8cN+8Gz121Z4YcZZGX3tVtT8XstcT+K2OefvDX20+HEgLkcNj4Dm7+iKV34C
         5bZNYsWUnpvcrVoBfob2pGEzAbiKX79UJwyxBOzbPXVFkvCLTPhvGhqyEsbYJo7Mnzin
         lFJg==
X-Gm-Message-State: AOAM530nHqaNwQpO/Yd0BVtYzF0NRLy5zLducEaPF4/T8XnMshSpDub5
        GGF220yWgwHc0WExq9NMBgv8wHYfIaP25iCji0C0PA==
X-Google-Smtp-Source: ABdhPJxLU8MGnE5SoLyGYG5TTI2jtt2gBV2C+wxkDDL0PUeP0WMegid6aYDJmZhvRMGMzbnJu/NSWMskp6PX5qCRqOQ=
X-Received: by 2002:a25:d1d3:: with SMTP id i202mr2002703ybg.487.1633574828693;
 Wed, 06 Oct 2021 19:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211001205657.815551-1-surenb@google.com> <20211001205657.815551-3-surenb@google.com>
 <20211005184211.GA19804@duo.ucw.cz> <CAJuCfpE5JEThTMhwKPUREfSE1GYcTx4YSLoVhAH97fJH_qR0Zg@mail.gmail.com>
 <20211005200411.GB19804@duo.ucw.cz> <CAJuCfpFZkz2c0ZWeqzOAx8KFqk1ge3K-SiCMeu3dmi6B7bK-9w@mail.gmail.com>
 <efdffa68-d790-72e4-e6a3-80f2e194d811@nvidia.com> <YV1eCu0eZ+gQADNx@dhcp22.suse.cz>
 <6b15c682-72eb-724d-bc43-36ae6b79b91a@redhat.com> <CAJuCfpEPBM6ehQXgzp=g4SqtY6iaC8wuZ-CRE81oR1VOq7m4CA@mail.gmail.com>
 <192438ab-a095-d441-6843-432fbbb8e38a@redhat.com> <CAJuCfpH4KT=fOAWsYhaAb_LLg-VwPvL4Bmv32NYuUtZ3Ceo+PA@mail.gmail.com>
 <20211006192927.f7a735f1afe4182bf4693838@linux-foundation.org>
In-Reply-To: <20211006192927.f7a735f1afe4182bf4693838@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 6 Oct 2021 19:46:57 -0700
Message-ID: <CAJuCfpGLQK5aVe5zQfdkP=K4NBZXPjtG=ycjk3E4D64CAvVPsg@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Colin Cross <ccross@google.com>,
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
        Chinwen Chang <chinwen.chang@mediatek.com>,
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
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 6, 2021 at 7:29 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 6 Oct 2021 08:20:20 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > On Wed, Oct 6, 2021 at 8:08 AM David Hildenbrand <david@redhat.com> wrote:
> > >
> > > On 06.10.21 17:01, Suren Baghdasaryan wrote:
> > > > On Wed, Oct 6, 2021 at 2:27 AM David Hildenbrand <david@redhat.com> wrote:
> > > >>
> > > >> On 06.10.21 10:27, Michal Hocko wrote:
> > > >>> On Tue 05-10-21 23:57:36, John Hubbard wrote:
> > > >>> [...]
> > > >>>> 1) Yes, just leave the strings in the kernel, that's simple and
> > > >>>> it works, and the alternatives don't really help your case nearly
> > > >>>> enough.
> > > >>>
> > > >>> I do not have a strong opinion. Strings are easier to use but they
> > > >>> are more involved and the necessity of kref approach just underlines
> > > >>> that. There are going to be new allocations and that always can lead
> > > >>> to surprising side effects.  These are small (80B at maximum) so the
> > > >>> overall footpring shouldn't all that large by default but it can grow
> > > >>> quite large with a very high max_map_count. There are workloads which
> > > >>> really require the default to be set high (e.g. heavy mremap users). So
> > > >>> if anything all those should be __GFP_ACCOUNT and memcg accounted.
> > > >>>
> > > >>> I do agree that numbers are just much more simpler from accounting,
> > > >>> performance and implementation POV.
> > > >>
> > > >> +1
> > > >>
> > > >> I can understand that having a string can be quite beneficial e.g., when
> > > >> dumping mmaps. If only user space knows the id <-> string mapping, that
> > > >> can be quite tricky.
> > > >>
> > > >> However, I also do wonder if there would be a way to standardize/reserve
> > > >> ids, such that a given id always corresponds to a specific user. If we
> > > >> use an uint64_t for an id, there would be plenty room to reserve ids ...
> > > >>
> > > >> I'd really prefer if we can avoid using strings and instead using ids.
> > > >
> > > > I wish it was that simple and for some names like [anon:.bss] or
> > > > [anon:dalvik-zygote space] reserving a unique id would work, however
> > > > some names like [anon:dalvik-/system/framework/boot-core-icu4j.art]
> > > > are generated dynamically at runtime and include package name.
> > >
> > > Valuable information
> >
> > Yeah, I should have described it clearer the first time around.
>
> If it gets this fancy then the 80 char limit is likely to become a
> significant limitation and the choice should be explained & justified.
>
> Why not 97?  1034?  Why not just strndup_user() and be done with it?

The original patch from 8 years ago used 256 as the limit but Rasmus
argued that the string content should be human-readable, so 80 chars
seems to be a reasonable limit (see:
https://lore.kernel.org/all/d8619a98-2380-ca96-001e-60fe9c6204a6@rasmusvillemoes.dk),
which makes sense to me. We should be able to handle the 80 char limit
by trimming it before calling prctl().

>
> > > My question would be, if we really have to expose these strings to the
> > > kernel, or if an id is sufficient. Sure, it would move complexity to
> > > user space, but keeping complexity out of the kernel is usually a good idea.
> >
> > My worry here is not the additional complexity on the userspace side
> > but the performance hit we would have to endure due to these
> > conversions.
>
> Has the performance hit been quantified?

I'll try to get the data that was collected or at least an estimate. I
imagine collecting such data would require considerable userspace
redesign.

> I've seen this many times down the ages.  Something which *could* be
> done in userspace is instead done in the kernel because coordinating
> userspace is Just So Damn Hard.  I guess the central problem is that
> userspace isn't centrally coordinated.  I wish we were better at this.

It's not just hard, it's also inefficient. And for our usecase
performance is important.

>
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
