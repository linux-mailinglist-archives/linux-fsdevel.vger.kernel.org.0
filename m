Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3FC44C620
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 18:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhKJRp3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 12:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhKJRp1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 12:45:27 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284E7C061766
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 09:42:39 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so5323532wme.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 09:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BmJmTnzPfpqvgfeS3ZzzZ3LIV2vZGhaQGUrN4OQ9GVc=;
        b=A7oSaQ/R3coHeHC40rJ1CdryOdtv8cF/yEknlJz/6t2IQ9dnili9EARfpQDCBm28ji
         +wyP8Y4NxaIga5rYkU9newjPK83r3XxBCUjtZFwOW/TvYSLyjyj+BCBKGQ1IGfRjvLI8
         2bECtGd3vIUMuWU3wVJSqgwLGQZUAMpg38XCzAk9lIWGt7kzaxFdOuGOsCLoEz1YLXcz
         FbsqZ6pCB+WNLHTk5aAH5wn6EMrs4x60kSWI9cwwRUcg6kgOoVefgrL+ipnZsugspW4J
         yV0/8taOfuVhsurV1P76C8PWRMlnTr9vtgqt8XYUynssRc4DoF4uB61vyljyljf85GDs
         0/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BmJmTnzPfpqvgfeS3ZzzZ3LIV2vZGhaQGUrN4OQ9GVc=;
        b=4mawB9GojFfOEBLBv8LV6CAf29pUKt7rAUOsAd0qpDILRbYkY39AoY5iOHk/ZVAfMQ
         OX/22/1nWTaloQIow5fAcilcj+pgEov4Qj9LRX5fYdupduVG3XpFGCfCKyFHt333VBxu
         Dv93qKh2ZTeqPYjJPSB+NBpp7RA2ckcdRbGR4Sf2sPp8i/mH3cmFuSsZO34HrmQKhmA0
         2i7wzX4yJmv6QJxck5cN+6ScxU1hyZtkbgqBivwUyirlrB0x54Yu/06CrHTEmb8PMYpU
         1GfQkcbo5P/jkx2Fpwm4jaxJysm/g3a2bLvS42l/LGJ+clS0kQKf2CAvxcdSOuHNNrl9
         rpiw==
X-Gm-Message-State: AOAM533DsErUe3BhKU+qi93Fr+9WY0066oN3oC9cYEPSxQHi4INO/jbb
        J9UES2hYmyD7Rd7wmOZWzgHYWQ66uTtA/LsoZCSRaA==
X-Google-Smtp-Source: ABdhPJzaIRfLIlvC2xdnSw40WJRg4en26VatfTndhl34g3jZs25Ylo2D5RvkxNkOG3tMYShQ+X6yeP3O+PNjG70M6HA=
X-Received: by 2002:a05:600c:190b:: with SMTP id j11mr1023411wmq.112.1636566157490;
 Wed, 10 Nov 2021 09:42:37 -0800 (PST)
MIME-Version: 1.0
References: <20211107235754.1395488-1-almasrymina@google.com>
 <YYtuqsnOSxA44AUX@t490s> <c5ed86d0-8af6-f54f-e352-8871395ad62e@redhat.com>
 <YYuCaNXikls/9JhS@t490s> <793685d2-be3f-9a74-c9a3-65c486e0ef1f@redhat.com>
 <YYuJd9ZBQiY50dVs@xz-m1.local> <8032a24c-3800-16e5-41b7-5565e74d3863@redhat.com>
In-Reply-To: <8032a24c-3800-16e5-41b7-5565e74d3863@redhat.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 10 Nov 2021 09:42:25 -0800
Message-ID: <CAHS8izPKN96M2GbHBC6_-XCr1pYy7uA-vNw2FHe01XbYMVdKUQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Add PM_HUGE_THP_MAPPING to /proc/pid/pagemap
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
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

On Wed, Nov 10, 2021 at 12:57 AM Peter Xu <peterx@redhat.com> wrote:
>
>
> This also reminded me that we've got issue with smaps being too slow, and in
> many cases we're only interested in a small portion of the whole memory.  This
> made me wonder how about a new smaps interface taking memory range as input.
>

Does a patch like I'm providing here address the perf issues you're seeing?

> Thanks,
>
> --
> Peter Xu
>

On Wed, Nov 10, 2021 at 2:24 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 10.11.21 09:57, Peter Xu wrote:
> > On Wed, Nov 10, 2021 at 09:30:50AM +0100, David Hildenbrand wrote:
> >> On 10.11.21 09:27, Peter Xu wrote:
> >>> On Wed, Nov 10, 2021 at 09:14:42AM +0100, David Hildenbrand wrote:
> >>>> On 10.11.21 08:03, Peter Xu wrote:
> >>>>> Hi, Mina,
> >>>>>
> >>>>> Sorry to comment late.
> >>>>>
> >>>>> On Sun, Nov 07, 2021 at 03:57:54PM -0800, Mina Almasry wrote:
> >>>>>> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
> >>>>>> index fdc19fbc10839..8a0f0064ff336 100644
> >>>>>> --- a/Documentation/admin-guide/mm/pagemap.rst
> >>>>>> +++ b/Documentation/admin-guide/mm/pagemap.rst
> >>>>>> @@ -23,7 +23,8 @@ There are four components to pagemap:
> >>>>>>      * Bit  56    page exclusively mapped (since 4.2)
> >>>>>>      * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
> >>>>>>        :ref:`Documentation/admin-guide/mm/userfaultfd.rst <userfaultfd>`)
> >>>>>> -    * Bits 57-60 zero
> >>>>>> +    * Bit  58    page is a huge (PMD size) THP mapping
> >>>>>> +    * Bits 59-60 zero
> >>>>>>      * Bit  61    page is file-page or shared-anon (since 3.5)
> >>>>>>      * Bit  62    page swapped
> >>>>>>      * Bit  63    page present
> >>>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >>>>>> index ad667dbc96f5c..6f1403f83b310 100644
> >>>>>> --- a/fs/proc/task_mmu.c
> >>>>>> +++ b/fs/proc/task_mmu.c
> >>>>>> @@ -1302,6 +1302,7 @@ struct pagemapread {
> >>>>>>  #define PM_SOFT_DIRTY           BIT_ULL(55)
> >>>>>>  #define PM_MMAP_EXCLUSIVE       BIT_ULL(56)
> >>>>>>  #define PM_UFFD_WP              BIT_ULL(57)
> >>>>>> +#define PM_HUGE_THP_MAPPING     BIT_ULL(58)
> >>>>>
> >>>>> The ending "_MAPPING" seems redundant to me, how about just call it "PM_THP" or
> >>>>> "PM_HUGE" (as THP also means HUGE already)?
> >>>>>
> >>>>> IMHO the core problem is about permission controls, and it seems to me we're
> >>>>> actually trying to workaround it by duplicating some information we have.. so
> >>>>> it's kind of a pity.  Totally not against this patch, but imho it'll be nicer
> >>>>> if it's the permission part that to be enhanced, rather than a new but slightly
> >>>>> duplicated interface.
> >>>>
> >>>> It's not a permission problem AFAIKS: even with permissions "changed",
> >>>> any attempt to use /proc/kpageflags is just racy. Let's not go down that
> >>>> path, it's really the wrong mechanism to export to random userspace.
> >>>
> >>> I agree it's racy, but IMHO that's fine.  These are hints for userspace to make
> >>> decisions, they cannot be always right.  Even if we fetch atomically and seeing
> >>> that this pte is swapped out, it can be quickly accessed at the same time and
> >>> it'll be in-memory again.  Only if we can freeze the whole pgtable but we
> >>> can't, so they can only be used as hints.
> >>
> >> Sorry, I don't think /proc/kpageflags (or exporting the PFNs to random
> >> users via /proc/self/pagemap) is the way to go.
> >>
> >> "Since Linux 4.0 only users with the CAP_SYS_ADMIN capability can get
> >> PFNs. In 4.0 and 4.1 opens by unprivileged fail with -EPERM.  Starting
> >> from 4.2 the PFN field is zeroed if the user does not have
> >> CAP_SYS_ADMIN. Reason: information about PFNs helps in exploiting
> >> Rowhammer vulnerability."
> >
> > IMHO these are two problems that you mentioned.  That's also what I was
> > wondering about: could the app be granted with CAP_SYS_ADMIN then?
> >
> > I am not sure whether that'll work well with /proc/kpage* though, as it's by
> > default 0400.  So perhaps we need to manual adjust the file permission too to
> > make sure the app can both access PFNs (with SYS_ADMIN) and the flags.  Totally
> > no expert on the permissions..
>
> Me too :)
>
> IIRC changing permissions that was not an option -- which is why the
> first approach suggested a new /proc/self/pageflags. But I guess Mina
> can remind us (and eventually document all that in the patch description
> :) ).
>

Sorry, yes I should update the commit message with this info. The
issues with smaps are:
1. Performance: I've pinged our network service folks to obtain a
rough perf comparison but I haven't been able to get one. I can try to
get a performance measurement myself but Peter seems to be also seeing
this.
2. smaps output is human readable and a bit convoluted for userspace to parse.

>
> --
> Thanks,
>
> David / dhildenb
>
