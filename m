Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCDD3E2EF0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 19:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbhHFRmT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 13:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhHFRmS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 13:42:18 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D7DC0613CF;
        Fri,  6 Aug 2021 10:42:02 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y12so14108242edo.6;
        Fri, 06 Aug 2021 10:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WM8262vn+lmKFFIbpe3Pl05b0K+86wXg1e1fI17ViY4=;
        b=AJ/dafNd/fGnNdzTsrGALMC1ppJIDa1ETSbNpAtVQPmCk8gSnKcrSChv/nmltQrGRB
         4KZgPX10ZGSPJh0PuALQYIsqzjte6Td/6nGeBZHhBqKHyo3IQ2XoKDCZHOjHsNgJZJ7g
         VGCEIhhZBmeZ8EuHVZKCDmWy2IpM6kGAwwpQk0q6+JCdKb97G5pjePdw+1PR8LKlOaZT
         r6Lz/I5kGbrUkRqFKSaH+YP6lkUd3z6x5wDyJHB0/VB92FxvOE6rV5osn5jIgxZ4/s+e
         YsKptXGbhf4IYGbfMlNq+QQKxVqWil4GFmMjcikc1rZyaNNw9R4bftcGtL/wnxfQGwDP
         y29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WM8262vn+lmKFFIbpe3Pl05b0K+86wXg1e1fI17ViY4=;
        b=oujuUXDgbqylLY2nOj++NCMxvQ2XPSzgfwaa8ydx/aeDkKbfYGg9A4vM7kL9EMhE5Q
         WM6NRvdzJKnyeP0H24yeW2cmYN8QJmx1XwIZ8RCzIGLY9NdGlp9YwVCUfU9DKuCiBl5J
         a0frNM33W9i2Pmw35DcQ1XdVRepgEr1SD09wcfJtpCCGNuTjFZtTXTUhkOp7zvDNhAFo
         ghRec4EORURgVMJVc4Wdf10Md6emN457JRuJ1CYGQJ83DbOoWWNn3i/nRvM1c3V1b8py
         pOOgrcJmUZoghKW+HBWDvAa8q0aZn052ap5u0H4I20NAbFdWRL2VqXczB0uyjf/nKRxl
         RxsQ==
X-Gm-Message-State: AOAM5313mHbBCbv3em+vvkdo1KcbpBKIXXXW9YD1TrQv7a6u4MlqrEwC
        dJq5NjjlA35GhEnM/xNdki0fro++bq9/ckZU+fo=
X-Google-Smtp-Source: ABdhPJyV7fJS76Tp9PwQ6sfhrCr5CbXvsvm83jzMnP/O6w1bqoLPiQwFuOcPbl8qxv4mdUXP3HpEkCeqxPohGyxg3L4=
X-Received: by 2002:a05:6402:386:: with SMTP id o6mr14486287edv.294.1628271721056;
 Fri, 06 Aug 2021 10:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
 <dae523ab-c75b-f532-af9d-8b6a1d4e29b@google.com> <CAHbLzkoKZ9OdUfP5DX81CKOJWrRZ0GANrmenNeKWNmSOgUh0bQ@mail.gmail.com>
 <e7374d7e-4773-aba1-763-8fa2c953f917@google.com> <CAHbLzko_wg4mx-LTbJ6JcJo-6VzMh5BAcuMV8PXKPsFXOBVASw@mail.gmail.com>
 <8baad8b2-8f7a-2589-ce21-4135a59c5dc6@google.com> <CAHbLzkrvOCCbN3EcDeKwfqWrtU6kH0+7fuSv7aahyjpKtsHn3g@mail.gmail.com>
 <5add2467-3b23-f8b8-e07b-82d8a573ecb7@google.com>
In-Reply-To: <5add2467-3b23-f8b8-e07b-82d8a573ecb7@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 6 Aug 2021 10:41:49 -0700
Message-ID: <CAHbLzkre9PS_sSo6nQGu5rpsNW=FQ2jvXCMpzmB0OBMT46m87g@mail.gmail.com>
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

On Thu, Aug 5, 2021 at 10:21 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Wed, 4 Aug 2021, Yang Shi wrote:
> > On Wed, Aug 4, 2021 at 1:28 AM Hugh Dickins <hughd@google.com> wrote:
> > >
> > > Thanks, but despite us agreeing that the race is too unlikely to be worth
> > > optimizing against, it does still nag at me ever since you questioned it:
> > > silly, but I can't quite be convinced by my own dismissals.
> > >
> > > I do still want to get rid of SGP_HUGE and SGP_NOHUGE, clearing up those
> > > huge allocation decisions remains the intention; but now think to add
> > > SGP_NOALLOC for collapse_file() in place of SGP_NOHUGE or SGP_CACHE -
> > > to rule out that possibility of mischarge after racing hole-punch,
> > > no matter whether it's huge or small.  If any such race occurs,
> > > collapse_file() should just give up.
> > >
> > > This being the "Stupid me" SGP_READ idea, except that of course would
> > > not work: because half the point of that block in collapse_file() is
> > > to initialize the !Uptodate pages, whereas SGP_READ avoids doing so.
> > >
> > > There is, of course, the danger that in fixing this unlikely mischarge,
> > > I've got the code wrong and am introducing a bug: here's what a 17/16
> > > would look like, though it will be better inserted early.  I got sick
> > > of all the "if (page "s, and was glad of the opportunity to fix that
> > > outdated "bring it back from swap" comment - swap got done above.
> > >
> > > What do you think? Should I add this in or leave it out?
> >
> > Thanks for keeping investigating this. The patch looks good to me. I
> > think we could go this way. Just a nit below.
>
> Thanks, I'll add it into the series, a patch before SGP_NOHUGE goes away;
> but I'm not intending to respin the series until there's more feedback
> from others - fcntl versus fadvise is the main issue so far.

Thanks, yeah, no hurry to repost.

>
> > > --- a/include/linux/shmem_fs.h
> > > +++ b/include/linux/shmem_fs.h
> > > @@ -108,6 +108,7 @@ extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
> > >  /* Flag allocation requirements to shmem_getpage */
> > >  enum sgp_type {
> > >         SGP_READ,       /* don't exceed i_size, don't allocate page */
> > > +       SGP_NOALLOC,    /* like SGP_READ, but do use fallocated page */
> >
> > The comment looks misleading, it seems SGP_NOALLOC does clear the
> > Uptodate flag but SGP_READ doesn't. Or it is fine not to distinguish
> > this difference?
>
> I think you meant to say, SGP_NOALLOC does *set* the Uptodate flag but
> SGP_READ doesn't.  And a more significant difference, as coded to suit
> collapse_file(), is that SGP_NOALLOC returns failure on hole, whereas
> SGP_READ returns success: I should have mentioned that.

Yes, I mean "set". Sorry for the confusion.

>
> When I wrote "like SGP_READ" there, I just meant "like what's said in
> the line above": would "ditto" be okay with you, and I say
>         SGP_NOALLOC,    /* ditto, but fail on hole, or use fallocated page */
>
> I don't really want to get into the "Uptodate" business there.
> And I'm afraid someone is going to ask me to write multi-line comments
> on each of those SGP_flags, and I'm going to plead "read the source"!

OK, I'm fine as is.

>
> Oh, now I see why you said SGP_NOALLOC does clear the Uptodate flag:
> "goto clear", haha: when we clear the page we set the Uptodate flag.
>
> And I may have another patch to slot in: I was half expecting you to
> question why SGP_READ behaves as it does, so in preparing its defence
> I checked, and found it was not doing quite what I remembered: changes
> were made a long time ago, which have left it slightly suboptimal.
> But that really has nothing to do with the rest of this series,
> and I don't need to run it past you before reposting.
>
> I hope that some of the features in this series can be useful to you.

Thanks, I will see.

>
> Thanks,
> Hugh
