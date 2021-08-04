Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758DA3E0870
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 21:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbhHDTBp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 15:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbhHDTBo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 15:01:44 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D74C0613D5;
        Wed,  4 Aug 2021 12:01:30 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id yk17so5197429ejb.11;
        Wed, 04 Aug 2021 12:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbU1nMAg1/m/aTssZKwY5AqkPjZxoSO16wFG91KgTCI=;
        b=WoXf7bFiWXmCu/49MeP2Vy1C1pYpaCf01mrfK3qzQXJDpqLB15rcbR9PRLtu/KatvF
         f2J25cFHDyRW/KhJe6zLOd/rgFh4LZDz6/0Iz26Lo4MsFj0eekFH2NwJUyLWYObuV/Dq
         ZhwsO8MMaf586Z1ls1uAG+nXNmxethbeqW/XyGjUk0m+2JSDMLMkNvm8k55+k88wASW6
         HEDeiWTN9LuzmT0MDuhB5JmkDXVN/8+wXo4awFziTLUYkcixfhHg2+Kc75z8c79MkTrS
         SuRNvi+TvDSh/Jk2Inj9h0Ju3sVltXcxnMui0kEcPPu362v6/zOuDeccfuOuuTf5EoIa
         5W1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbU1nMAg1/m/aTssZKwY5AqkPjZxoSO16wFG91KgTCI=;
        b=mWW7bABLklKXCSbXZkNqyhbsvHwZOFgDd4T+AqwDkBEeD8/2Wrt0v1eZpmftZbzcFq
         AObTYzOZc8f5/mrYXNLjpHQXxOYUgHybaLvj38GKZBKm2QY/3V8na5dAlrV3q1kSkbOc
         EeEX33OVOEIDLZNYl/d4ppH6KlBXQT/Sr0vuofzQCPR0dWGgQKz/7JOEYh7aEL53TeIy
         iEI1n+CIjOKNd6lQYjYdCpzDqOhV9oixtSsdmTZ9jRcQ0Z1KsWKQI8mDpDEdexMfMt5L
         RCYkTagxz+gn4j5JkPBm9a9ssDSChcBkaggjJ1AijJKjih5SAJdTcq8/DSHzxjIZ4qa0
         24UQ==
X-Gm-Message-State: AOAM532mti7A/v7Ai9Jop31NL+TUQpEupKV/WA8uHfzwR8faH1WGqQhr
        /Tt7bbv3VkcVDe1OEYEZpW2AiAuT1nfsBNoa+fM=
X-Google-Smtp-Source: ABdhPJxxgQji8Kg4yYQJwAnZXHMVu9qb2lW1Vk0hXVbvoYHS97fQ97CiPIYFc7SX9m8q+BKyB2v1vOzvjWd/LzccDAA=
X-Received: by 2002:a17:906:31d4:: with SMTP id f20mr592086ejf.383.1628103689156;
 Wed, 04 Aug 2021 12:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
 <dae523ab-c75b-f532-af9d-8b6a1d4e29b@google.com> <CAHbLzkoKZ9OdUfP5DX81CKOJWrRZ0GANrmenNeKWNmSOgUh0bQ@mail.gmail.com>
 <e7374d7e-4773-aba1-763-8fa2c953f917@google.com> <CAHbLzko_wg4mx-LTbJ6JcJo-6VzMh5BAcuMV8PXKPsFXOBVASw@mail.gmail.com>
 <8baad8b2-8f7a-2589-ce21-4135a59c5dc6@google.com>
In-Reply-To: <8baad8b2-8f7a-2589-ce21-4135a59c5dc6@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 4 Aug 2021 12:01:17 -0700
Message-ID: <CAHbLzkrvOCCbN3EcDeKwfqWrtU6kH0+7fuSv7aahyjpKtsHn3g@mail.gmail.com>
Subject: Re: [PATCH 06/16] huge tmpfs: shmem_is_huge(vma, inode, index)
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 4, 2021 at 1:28 AM Hugh Dickins <hughd@google.com> wrote:
>
> On Mon, 2 Aug 2021, Yang Shi wrote:
> > On Sat, Jul 31, 2021 at 10:22 PM Hugh Dickins <hughd@google.com> wrote:
> > > On Fri, 30 Jul 2021, Yang Shi wrote:
> > > > On Fri, Jul 30, 2021 at 12:42 AM Hugh Dickins <hughd@google.com> wrote:
> > > > >
> > > > > Extend shmem_huge_enabled(vma) to shmem_is_huge(vma, inode, index), so
> > > > > that a consistent set of checks can be applied, even when the inode is
> > > > > accessed through read/write syscalls (with NULL vma) instead of mmaps
> > > > > (the index argument is seldom of interest, but required by mount option
> > > > > "huge=within_size").  Clean up and rearrange the checks a little.
> > > > >
> > > > > This then replaces the checks which shmem_fault() and shmem_getpage_gfp()
> > > > > were making, and eliminates the SGP_HUGE and SGP_NOHUGE modes: while it's
> > > > > still true that khugepaged's collapse_file() at that point wants a small
> > > > > page, the race that might allocate it a huge page is too unlikely to be
> > > > > worth optimizing against (we are there *because* there was at least one
> > > > > small page in the way), and handled by a later PageTransCompound check.
> > > >
> > > > Yes, it seems too unlikely. But if it happens the PageTransCompound
> > > > check may be not good enough since the page allocated by
> > > > shmem_getpage() may be charged to wrong memcg (root memcg). And it
> > > > won't be replaced by a newly allocated huge page so the wrong charge
> > > > can't be undone.
> > >
> > > Good point on the memcg charge: I hadn't thought of that.  Of course
> > > it's not specific to SGP_CACHE versus SGP_NOHUGE (this patch), but I
> > > admit that a huge mischarge is hugely worse than a small mischarge.
> >
> > The small page could be collapsed to a huge page sooner or later, so
> > the mischarge may be transient. But huge page can't be replaced.
>
> You're right, if all goes well, the mischarged small page could be
> collapsed to a correctly charged huge page sooner or later (but all
> may not go well), whereas the mischarged huge page is stuck there.
>
> >
> > >
> > > We could fix it by making shmem_getpage_gfp() non-static, and pointing
> > > to the vma (hence its mm, hence its memcg) here, couldn't we?  Easily
> > > done, but I don't really want to make shmem_getpage_gfp() public just
> > > for this, for two reasons.
> > >
> > > One is that the huge race it just so unlikely; and a mischarge to root
> > > is not the end of the world, so long as it's not reproducible.  It can
> > > only happen on the very first page of the huge extent, and the prior
> >
> > OK, if so the mischarge is not as bad as what I thought in the first place.
> >
> > > "Stop if extent has been truncated" check makes sure there was one
> > > entry in the extent at that point: so the race with hole-punch can only
> > > occur after we xas_unlock_irq(&xas) immediately before shmem_getpage()
> > > looks up the page in the tree (and I say hole-punch not truncate,
> > > because shmem_getpage()'s i_size check will reject when truncated).
> > > I don't doubt that it could happen, but stand by not optimizing against.
> >
> > I agree the race is so unlikely and it may be not worth optimizing
> > against it right now, but a note or a comment may be worth.
>
> Thanks, but despite us agreeing that the race is too unlikely to be worth
> optimizing against, it does still nag at me ever since you questioned it:
> silly, but I can't quite be convinced by my own dismissals.
>
> I do still want to get rid of SGP_HUGE and SGP_NOHUGE, clearing up those
> huge allocation decisions remains the intention; but now think to add
> SGP_NOALLOC for collapse_file() in place of SGP_NOHUGE or SGP_CACHE -
> to rule out that possibility of mischarge after racing hole-punch,
> no matter whether it's huge or small.  If any such race occurs,
> collapse_file() should just give up.
>
> This being the "Stupid me" SGP_READ idea, except that of course would
> not work: because half the point of that block in collapse_file() is
> to initialize the !Uptodate pages, whereas SGP_READ avoids doing so.
>
> There is, of course, the danger that in fixing this unlikely mischarge,
> I've got the code wrong and am introducing a bug: here's what a 17/16
> would look like, though it will be better inserted early.  I got sick
> of all the "if (page "s, and was glad of the opportunity to fix that
> outdated "bring it back from swap" comment - swap got done above.
>
> What do you think? Should I add this in or leave it out?

Thanks for keeping investigating this. The patch looks good to me. I
think we could go this way. Just a nit below.

>
> Thanks,
> Hugh
>
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -108,6 +108,7 @@ extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
>  /* Flag allocation requirements to shmem_getpage */
>  enum sgp_type {
>         SGP_READ,       /* don't exceed i_size, don't allocate page */
> +       SGP_NOALLOC,    /* like SGP_READ, but do use fallocated page */

The comment looks misleading, it seems SGP_NOALLOC does clear the
Uptodate flag but SGP_READ doesn't. Or it is fine not to distinguish
this difference?

>         SGP_CACHE,      /* don't exceed i_size, may allocate page */
>         SGP_WRITE,      /* may exceed i_size, may allocate !Uptodate page */
>         SGP_FALLOC,     /* like SGP_WRITE, but make existing page Uptodate */
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1721,7 +1721,7 @@ static void collapse_file(struct mm_struct *mm,
>                                 xas_unlock_irq(&xas);
>                                 /* swap in or instantiate fallocated page */
>                                 if (shmem_getpage(mapping->host, index, &page,
> -                                                 SGP_CACHE)) {
> +                                                 SGP_NOALLOC)) {
>                                         result = SCAN_FAIL;
>                                         goto xa_unlocked;
>                                 }
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1903,26 +1903,27 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>                 return error;
>         }
>
> -       if (page)
> +       if (page) {
>                 hindex = page->index;
> -       if (page && sgp == SGP_WRITE)
> -               mark_page_accessed(page);
> -
> -       /* fallocated page? */
> -       if (page && !PageUptodate(page)) {
> +               if (sgp == SGP_WRITE)
> +                       mark_page_accessed(page);
> +               if (PageUptodate(page))
> +                       goto out;
> +               /* fallocated page */
>                 if (sgp != SGP_READ)
>                         goto clear;
>                 unlock_page(page);
>                 put_page(page);
> -               page = NULL;
> -               hindex = index;
>         }
> -       if (page || sgp == SGP_READ)
> -               goto out;
> +
> +       *pagep = NULL;
> +       if (sgp == SGP_READ)
> +               return 0;
> +       if (sgp == SGP_NOALLOC)
> +               return -ENOENT;
>
>         /*
> -        * Fast cache lookup did not find it:
> -        * bring it back from swap or allocate.
> +        * Fast cache lookup and swap lookup did not find it: allocate.
>          */
>
>         if (vma && userfaultfd_missing(vma)) {
