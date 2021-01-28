Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B7C3078E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 16:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhA1O6s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 09:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbhA1O6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:58:25 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7C5C0613ED
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 06:57:44 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id q12so7944242lfo.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 06:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6JeWN8a5WUkyxnK36YoF5ECUYQ0YQQyZ8/Qna1NsShQ=;
        b=As0f3ZjdzvdCwifWZLl1QKfjKa8UOgbj+P2sZklA3JeJHRBFMWu0H5wiflr7/g1HdC
         3EjIecN6Px4mzk2ZBILkQfelKQTbnGwSzIocfdSMYIkirHo9CBbLzSIMXutUiAf6vvRc
         O/x3qpP8hsiEOTbNWqSjQJEQy2deXqGIeKK1Eiy110fgfCnqxwFB41oeOrAJr2xWvT1q
         RtaTVjDEtI0m7Z5lSQoJRTOt4f3/Vop3rVyNg7HaTwp/ta+UInes3JfxoRBzhApQcJVC
         zRX0Gbp2enO00BN0CoZKSrEiJpykCEajRuhij0lcxoYUBrveBZExa8KzS9ylf7cYTei3
         czvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6JeWN8a5WUkyxnK36YoF5ECUYQ0YQQyZ8/Qna1NsShQ=;
        b=GAUsx7Uyer6MtTIvyoxtEjKcDgW3MYACmlDzKWvF/je3cA+kGL++sGkoYa3fClEbmu
         r1oiC6b4HOH/nb/RuDfIz0eD+SBIS6FEVEHmXVmgo/k1x1iQmR6oHu8V9xvDZvxtz4mL
         wvktW75IpqBYcgyjr0Gg8hoJRyNoCCtQZsI/PYVJPkC1eT/OgX+/oWStcqp3nXHP7JnL
         Mm6wm7aid2LRvBYunOlKdca7APP1thpakUbZqDuRbE3I89Z4DuFCOTAY2QIBEBTZyzbZ
         FAQNjVv5Fyh6MoXv9wolevSiOLGTwOJyIzsqFc0wStmKHuv9pczv9WnCAkkn07E86bh6
         dCIA==
X-Gm-Message-State: AOAM531UpaNbIz/2UoNVtNmTHjz/PPEsGInAFH1CcmuObeEDw7o9HhNa
        1vln0XzxyusqLCONoCIk9/cb0ljZHITUOpfU8cAv5g==
X-Google-Smtp-Source: ABdhPJwnMPNGU3TqSk70s7k7l99wJrsKfvMYfSXuKIgpScpKrS2rUc1hXzqqY/mlKLeMfqPqurVK8/4c/RV2TUlC8OE=
X-Received: by 2002:ac2:4c26:: with SMTP id u6mr7622497lfq.347.1611845862683;
 Thu, 28 Jan 2021 06:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20210121122723.3446-1-rppt@kernel.org> <20210121122723.3446-9-rppt@kernel.org>
 <20210125165451.GT827@dhcp22.suse.cz> <20210125213817.GM6332@kernel.org>
 <20210126144838.GL308988@casper.infradead.org> <20210126150555.GU827@dhcp22.suse.cz>
 <20210127184213.GA919963@carbon.dhcp.thefacebook.com> <YBJuwqItjCemDN5L@dhcp22.suse.cz>
 <CALvZod7YjXvaYoZ7HXq2sDkwvpjpLBA-jhrzxa48jEuBt6zLNQ@mail.gmail.com> <YBLInhns9ysc4wNF@dhcp22.suse.cz>
In-Reply-To: <YBLInhns9ysc4wNF@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 28 Jan 2021 06:57:31 -0800
Message-ID: <CALvZod4G3ipt84pQVHYT921hmXQTswivcrU0iqpTof4tO91GxA@mail.gmail.com>
Subject: Re: [PATCH v16 08/11] secretmem: add memcg accounting
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <guro@fb.com>, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 6:22 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 28-01-21 06:05:11, Shakeel Butt wrote:
> > On Wed, Jan 27, 2021 at 11:59 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 27-01-21 10:42:13, Roman Gushchin wrote:
> > > > On Tue, Jan 26, 2021 at 04:05:55PM +0100, Michal Hocko wrote:
> > > > > On Tue 26-01-21 14:48:38, Matthew Wilcox wrote:
> > > > > > On Mon, Jan 25, 2021 at 11:38:17PM +0200, Mike Rapoport wrote:
> > > > > > > I cannot use __GFP_ACCOUNT because cma_alloc() does not use gfp.
> > > > > > > Besides, kmem accounting with __GFP_ACCOUNT does not seem
> > > > > > > to update stats and there was an explicit request for statistics:
> > > > > > >
> > > > > > > https://lore.kernel.org/lkml/CALo0P13aq3GsONnZrksZNU9RtfhMsZXGWhK1n=xYJWQizCd4Zw@mail.gmail.com/
> > > > > > >
> > > > > > > As for (ab)using NR_SLAB_UNRECLAIMABLE_B, as it was already discussed here:
> > > > > > >
> > > > > > > https://lore.kernel.org/lkml/20201129172625.GD557259@kernel.org/
> > > > > > >
> > > > > > > I think that a dedicated stats counter would be too much at the moment and
> > > > > > > NR_SLAB_UNRECLAIMABLE_B is the only explicit stat for unreclaimable memory.
> > > > > >
> > > > > > That's not true -- Mlocked is also unreclaimable.  And doesn't this
> > > > > > feel more like mlocked memory than unreclaimable slab?  It's also
> > > > > > Unevictable, so could be counted there instead.
> > > > >
> > > > > yes, that is indeed true, except the unreclaimable counter is tracking
> > > > > the unevictable LRUs. These pages are not on any LRU and that can cause
> > > > > some confusion. Maybe they shouldn't be so special and they should live
> > > > > on unevistable LRU and get their stats automagically.
> > > > >
> > > > > I definitely do agree that this would be a better fit than NR_SLAB
> > > > > abuse. But considering that this is somehow even more special than mlock
> > > > > then a dedicated counter sounds as even better fit.
> > > >
> > > > I think it depends on how large these areas will be in practice.
> > > > If they will be measured in single or double digits MBs, a separate entry
> > > > is hardly a good choice: because of the batching the displayed value
> > > > will be in the noise range, plus every new vmstat item adds to the
> > > > struct mem_cgroup size.
> > > >
> > > > If it will be measured in GBs, of course, a separate counter is preferred.
> > > > So I'd suggest to go with NR_SLAB (which should have been named NR_KMEM)
> > > > as now and conditionally switch to a separate counter later.
> > >
> > > I really do not think the overall usage matters when it comes to abusing
> > > other counters. Changing this in future will be always tricky and there
> > > always be our favorite "Can this break userspace" question. Yes we dared
> > > to change meaning of some counters but this is not generally possible.
> > > Just have a look how accounting shmem as a page cache has turned out
> > > being much more tricky than many like.
> > >
> > > Really if a separate counter is a big deal, for which I do not see any
> > > big reason, then this should be accounted as unevictable (as suggested
> > > by Matthew) and ideally pages of those mappings should be sitting in the
> > > unevictable LRU as well unless there is a strong reason against.
> > >
> >
> > Why not decide based on the movability of these pages? If movable then
> > unevictable LRU seems like the right way otherwise NR_SLAB.
>
> I really do not follow. If the page is unevictable then why movability
> matters?

My point was if these pages are very much similar to our existing
definition of unevictable LRU pages then it makes more sense to
account for these pages into unevictable stat.

> I also fail to see why NR_SLAB is even considered considering
> this is completely outside of slab proper.
>
> Really what is the point? What are we trying to achieve by stats? Do we
> want to know how much secret memory is used because that is an
> interesting/important information or do we just want to make some
> accounting?
>
> Just think at it from a practical point of view. I want to know how much
> slab memory is used because it can give me an idea whether kernel is
> consuming unexpected amount of memory. Now I have to subtract _some_
> number to get that information. Where do I get that some number?
>
> We have been creative with counters and it tends to kick back much more
> often than it helps.
>
> I really do not want this to turn into an endless bike shed but either
> this should be accounted as a general type of memory (unevictable would
> be a good fit because that is a userspace memory which is not
> reclaimable) or it needs its own counter to tell how much of this
> specific type of memory is used for this purpose.
>

I suggested having a separate counter in the previous version but got
shot down based on the not-yet-clear benefit of a separate stat for
it.

There is also an option to not add new or use existing stat at this
moment. As there will be more clear use-cases and usage of secretmem,
adding a new stat at that time would be much simpler than changing the
definition of existing stats.
