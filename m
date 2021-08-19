Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAAD3F20BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 21:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhHSTlr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 15:41:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36954 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234085AbhHSTlo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629402067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N3r+VfJqTouzOa7Rijd4hTG7Toub9ezhbqH/xKVtdmY=;
        b=e6nbjl68n1YnBi8pTzOaFo5+7Sc4JmPYEJ71oYBiz3o6Kwvkq8FabquqcWe90PJO8xaYu+
        LSk1tllcDTZ/hb4Ze3hX8Of0i72jjbj2gKk3WSfvUBtyUruw5a+HzsqD26csmOJA0Vz9Q8
        zPdykeN4Y6hPaAOMynfYN88f0kFVuW8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-jIVfVZydP4GFS5ntU8aNyQ-1; Thu, 19 Aug 2021 15:41:02 -0400
X-MC-Unique: jIVfVZydP4GFS5ntU8aNyQ-1
Received: by mail-wm1-f69.google.com with SMTP id g70-20020a1c20490000b02902e6753bf473so3894428wmg.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 12:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N3r+VfJqTouzOa7Rijd4hTG7Toub9ezhbqH/xKVtdmY=;
        b=DlDu42wbqTS0FLyDT6wjQV2g/mLVC8AF+vN98LAQ9RPP0ZEzuq7ZSk+ldpbSHfYIB8
         GfkvEegqusdErWE0fWkLEEWeKQY9s4TBQ9ubgfknE0cCTUEfgPA6w0QlzG0KYaKBd6HU
         tRHwzkQIkhBtFeuBDdicqtMPgqSh054rfonDx6LT/s1paRPjyBCTNOBPu16j7kbjBeTp
         5fq1gzVBjADmW5rMtWUzt9Omi7DAPY6d1q4i+7u8zlstHhrQWN24QRzknNKCu1vRG8Lf
         qD6AG/4vjqa2A6bnPJzmiVELNT6/snJ3VgkjWSNeIx3ziFFFxtk50DCf1CZMaEoHUGXO
         y24Q==
X-Gm-Message-State: AOAM531r6WKd+RnWCSkXBDHFNcYxnrXUenDHk66ocwVTSfsezUnWVLXe
        IYOz7pOYoAWYOVTMBcv3Qq4TAE4n3Oy6aEc1SQ1ER8clXmKdioyO9Gfdu1UEd/+3sZ2ZilZcKDN
        R7WWrS3IC8nxuBWqqOND6hDKcVPCwYsqz6sXncVeBAw==
X-Received: by 2002:a7b:c106:: with SMTP id w6mr296748wmi.152.1629402060758;
        Thu, 19 Aug 2021 12:41:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkJcXH65FWnZ1dP5/HoDmwcsHFn3hPhEUkK7xHddEwx16hWpY7f72bzjUNxESwyU+qX2gMS5ZSiNzWhC/qsKM=
X-Received: by 2002:a7b:c106:: with SMTP id w6mr296733wmi.152.1629402060505;
 Thu, 19 Aug 2021 12:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210803191818.993968-1-agruenba@redhat.com> <CAHk-=wj+_Y7NQ-NhhE0jk52c9ZB0VJbO1AjtMJFB8wP=PO+bdw@mail.gmail.com>
 <CAHc6FU6H5q20qiQ5FX1726i0FJHyh=Y46huWkCBZTR3sk+3Dhg@mail.gmail.com> <CAHk-=whBCm3G5yibbvQsTn00fA16a688NTU_geQV158DnRy+bQ@mail.gmail.com>
In-Reply-To: <CAHk-=whBCm3G5yibbvQsTn00fA16a688NTU_geQV158DnRy+bQ@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 19 Aug 2021 21:40:49 +0200
Message-ID: <CAHc6FU5HHFwuJBCNuU0e_N0ehaFrzbUrCuTJyaLNC4qxwfazYA@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] gfs2: Fix mmap + page fault deadlocks
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 18, 2021 at 11:49 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> [ Sorry for the delay, I was on the road and this fell through the cracks ]

No harm done, I was busy enough implementing your previous suggestions.

> On Mon, Aug 16, 2021 at 12:14 PM Andreas Gruenbacher
> <agruenba@redhat.com> wrote:
> >
> > On Tue, Aug 3, 2021 at 9:45 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > Hmm. Have you tried to figure out why that "still returns 0" happens?
> >
> > The call stack is:
> >
> > gup_pte_range
> > gup_pmd_range
> > gup_pud_range
> > gup_p4d_range
> > gup_pgd_range
> > lockless_pages_from_mm
> > internal_get_user_pages_fast
> > get_user_pages_fast
> > iov_iter_get_pages
> > __bio_iov_iter_get_pages
> > bio_iov_iter_get_pages
> > iomap_dio_bio_actor
> > iomap_dio_actor
> > iomap_apply
> > iomap_dio_rw
> > gfs2_file_direct_write
> >
> > In gup_pte_range, pte_special(pte) is true and so we return 0.
>
> Ok, so that is indeed something that the fast-case can't handle,
> because some of the special code wants to have the mm_lock so that it
> can look at the vma flags (eg "vm_normal_page()" and friends.
>
> That said, some of these cases even the full GUP won't ever handle,
> simply because a mapping doesn't necessarily even _have_ a 'struct
> page' associated with it if it's a VM_IO mapping.
>
> So it turns out that you can't just always do
> fault_in_iov_iter_readable() and then assume that you can do
> iov_iter_get_pages() and repeat until successful.
>
> We could certainly make get_user_pages_fast() handle a few more cases,
> but I get the feeling that we need to have separate error cases for
> EFAULT - no page exists - and the "page exists, but cannot be mapped
> as a 'struct page'" case.

Hmm, what if GUP is made to skip VM_IO vmas without adding anything to
the pages array? That would match fault_in_iov_iter_writeable, which
is modeled after __mm_populate and which skips VM_IO and VM_PFNMAP
vmas.

The other strategy I've added is to scale back the page fault windows
to a single page if faulting in multiple pages didn't help, and to
give up if the I/O operation still fails after that. So pathological
cases won't loop indefinitely anymore at least.

> I also do still think that even regardless of that, we want to just
> add a FOLL_NOFAULT flag that just disables calling handle_mm_fault(),
> and then you can use the regular get_user_pages().
>
> That at least gives us the full _normal_ page handling stuff.

And it does fix the generic/208 failure.

Thanks,
Andreas

