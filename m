Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F88436492
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 16:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhJUOpF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 10:45:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50798 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230072AbhJUOpE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634827368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SmEzbXtfEVt2BpM7wSrp23JreLNUFM7GXMWeh1u9ztI=;
        b=NFjey+Rp3UFB62KQxXMPHItRcF96+7DSEXbGiw0H+O9h+ncRJKEOXlRh+domfAFeEZ47UK
        Zj6cOZeKsUNYle2RH9SJwAcwxpFDe7KlG64PBi8kMgqwkHmZHo7GdJyXGCULOXcT49XWvx
        FsXgSAR+dq/rNd32WRKOc6za0yZR5WA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-1Mu7Ng4MNmmykmEITcgGIA-1; Thu, 21 Oct 2021 10:42:46 -0400
X-MC-Unique: 1Mu7Ng4MNmmykmEITcgGIA-1
Received: by mail-wm1-f70.google.com with SMTP id z137-20020a1c7e8f000000b0030cd1800d86so331212wmc.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 07:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmEzbXtfEVt2BpM7wSrp23JreLNUFM7GXMWeh1u9ztI=;
        b=6eObOg76baur8W6Qva5VKe9RR3yIWiZ5ZJppzqYJ3h1Lt0gaTG7b73mtKdjGpmI4QD
         SHLEQ/yzDPpLRAC56kyLR4Cviw8Qhg1xh+Z4TMcN3WpL6xoVk3pX479FJN5wpeNcX1Oq
         Jdv3Y/UC9rmQwYqau0nIl/xRZdNabp0WJJ9dmt046biGwKwmRj7JDnADJk6Za5voZs+8
         b6WCvJrLZY0UBD7y/hAnnAPfd7hvsBdBHm9SRwy8vvlc6NcDKW5zXA1qfZy8Dsq6D5af
         HQQUdssUSCupwekxkyp6Q7J5S7jBaF1gRja0ASUQIDGKnQ2C7aMKKZNReEiOvdSTdCXR
         i8IQ==
X-Gm-Message-State: AOAM533MNbMmVE7LdxCcv5AP7i+rNqUqnrIlFpaXGZiBI852m/Sovbo/
        9Wjluskk3Jh9DreCulFm3GqMl7o1ecuYzkZlu4+g5H6b5IpgeD8BOQyC9ZCdijEBC0vJGWDzPyO
        XKa4jxtbUE9NYUON0w+RDkelbTHZzbFuQ4Sc9ahhjXw==
X-Received: by 2002:adf:c78d:: with SMTP id l13mr7544010wrg.134.1634827364924;
        Thu, 21 Oct 2021 07:42:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe9FbtIjQkoQAdC+TPuURhpm/wOA+DZOJl2uKRFfWKCj35F5i6OVE+TEzdARceI4I8WSyqjU9LUZpNOmPkJLM=
X-Received: by 2002:adf:c78d:: with SMTP id l13mr7543974wrg.134.1634827364652;
 Thu, 21 Oct 2021 07:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk> <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSqOUb7yZ7kBoKRY@zeniv-ca.linux.org.uk> <YS40qqmXL7CMFLGq@arm.com>
 <YS5KudP4DBwlbPEp@zeniv-ca.linux.org.uk> <YWR2cPKeDrc0uHTK@arm.com>
 <CAHk-=wjvQWj7mvdrgTedUW50c2fkdn6Hzxtsk-=ckkMrFoTXjQ@mail.gmail.com>
 <YWSnvq58jDsDuIik@arm.com> <CAHk-=wiNWOY5QW5ZJukt_9pHTWvrJhE2=DxPpEtFHAWdzOPDTg@mail.gmail.com>
 <CAHc6FU7bpjAxP+4dfE-C0pzzQJN1p=C2j3vyXwUwf7fF9JF72w@mail.gmail.com> <YXE7fhDkqJbfDk6e@arm.com>
In-Reply-To: <YXE7fhDkqJbfDk6e@arm.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 21 Oct 2021 16:42:33 +0200
Message-ID: <CAHc6FU5xTMOxuiEDyc9VO_V98=bvoDc-0OFi4jsGPgWJWjRJWQ@mail.gmail.com>
Subject: Re: [RFC][arm64] possible infinite loop in btrfs search_ioctl()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 12:06 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Thu, Oct 21, 2021 at 02:46:10AM +0200, Andreas Gruenbacher wrote:
> > On Tue, Oct 12, 2021 at 1:59 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > > On Mon, Oct 11, 2021 at 2:08 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > >
> > > > +#ifdef CONFIG_ARM64_MTE
> > > > +#define FAULT_GRANULE_SIZE     (16)
> > > > +#define FAULT_GRANULE_MASK     (~(FAULT_GRANULE_SIZE-1))
> > >
> > > [...]
> > >
> > > > If this looks in the right direction, I'll do some proper patches
> > > > tomorrow.
> > >
> > > Looks fine to me. It's going to be quite expensive and bad for caches, though.
> > >
> > > That said, fault_in_writable() is _supposed_ to all be for the slow
> > > path when things go south and the normal path didn't work out, so I
> > > think it's fine.
> >
> > Let me get back to this; I'm actually not convinced that we need to
> > worry about sub-page-size fault granules in fault_in_pages_readable or
> > fault_in_pages_writeable.
> >
> > From a filesystem point of view, we can get into trouble when a
> > user-space read or write triggers a page fault while we're holding
> > filesystem locks, and that page fault ends up calling back into the
> > filesystem. To deal with that, we're performing those user-space
> > accesses with page faults disabled.
>
> Yes, this makes sense.
>
> > When a page fault would occur, we
> > get back an error instead, and then we try to fault in the offending
> > pages. If a page is resident and we still get a fault trying to access
> > it, trying to fault in the same page again isn't going to help and we
> > have a true error.
>
> You can't be sure the second fault is a true error. The unlocked
> fault_in_*() may race with some LRU scheme making the pte not accessible
> or a write-back making it clean/read-only. copy_to_user() with
> pagefault_disabled() fails again but that's a benign fault. The
> filesystem should re-attempt the fault-in (gup would correct the pte),
> disable page faults and copy_to_user(), potentially in an infinite loop.
> If you bail out on the second/third uaccess following a fault_in_*()
> call, you may get some unexpected errors (though very rare). Maybe the
> filesystems avoid this problem somehow but I couldn't figure it out.

Good point, we can indeed only bail out if both the user copy and the
fault-in fail.

But probing the entire memory range in fault domain granularity in the
page fault-in functions still doesn't actually make sense. Those
functions really only need to guarantee that we'll be able to make
progress eventually. From that point of view, it should be enough to
probe the first byte of the requested memory range, so when one of
those functions reports that the next N bytes should be accessible,
this really means that the first byte surely isn't permanently
inaccessible and that the rest is likely accessible. Functions
fault_in_readable and fault_in_writeable already work that way, so
this only leaves function fault_in_safe_writeable to worry about.

> > We're clearly looking at memory at a page
> > granularity; faults at a sub-page level don't matter at this level of
> > abstraction (but they do show similar error behavior). To avoid
> > getting stuck, when it gets a short result or -EFAULT, the filesystem
> > implements the following backoff strategy: first, it tries to fault in
> > a number of pages. When the read or write still doesn't make progress,
> > it scales back and faults in a single page. Finally, when that still
> > doesn't help, it gives up. This strategy is needed for actual page
> > faults, but it also handles sub-page faults appropriately as long as
> > the user-space access functions give sensible results.
>
> As I said above, I think with this approach there's a small chance of
> incorrectly reporting an error when the fault is recoverable. If you
> change it to an infinite loop, you'd run into the sub-page fault
> problem.

Yes, I see now, thanks.

> There are some places with such infinite loops: futex_wake_op(),
> search_ioctl() in the btrfs code. I still have to get my head around
> generic_perform_write() but I think we get away here because it faults
> in the page with a get_user() rather than gup (and copy_from_user() is
> guaranteed to make progress if any bytes can still be accessed).

Thanks,
Andreas

