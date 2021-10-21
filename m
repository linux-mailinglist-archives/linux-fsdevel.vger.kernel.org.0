Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411114357E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 02:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhJUAsn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 20:48:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27991 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhJUAsk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 20:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634777184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GgRzGZvlhKco4vdRDM+mmGlMh4qaw7uLRwsJYM91KRo=;
        b=IQBwYGfQK15ThPucqyFYj/HScJ3ZaZm3RSKyA7gSM11/++fCdCiDHjp3v606wsWv6jwlCQ
        EXa2Ux/r/k6c7RIRLeDQ9HkY5gHLg168cNmX/mXtUNi6h5aZYz4VbgW+XFMM8kQOqRhMsO
        sz3ASGnR2J16cK3fnkpTef5JjMaJHcE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-KI4Gbn8pNXqbUPH3xKKfcg-1; Wed, 20 Oct 2021 20:46:23 -0400
X-MC-Unique: KI4Gbn8pNXqbUPH3xKKfcg-1
Received: by mail-wm1-f72.google.com with SMTP id q203-20020a1ca7d4000000b0030dcdcd37c5so1125914wme.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 17:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GgRzGZvlhKco4vdRDM+mmGlMh4qaw7uLRwsJYM91KRo=;
        b=VhY47BZkx282hSLkNF7mbM7+ak1FmHq+TE3Wjs6X/oSTZHMYQvsjr5ON4kGzH6qMHg
         X5JknPfNpb4OhixSaOiVq4TqAZZa1tAwq7lONHWJ/yvYXPZ0jy4LZnEa7hPpUmY/ZNWT
         nw8NE8nQZhnfIhNRwNhtD+4PIbntKybp72p7aZW5xp6vBZ86dHtcKNTEGKdOmYR7WfeS
         3PJI0B4/GPuo37cg73HDr9Ovbc2CSQG5HA6ihaVYyZ4r+TVMb5F+pGdSaD0D8Rlpp2Zu
         hGZVwoh4axC3dfv3ncqxuDabHSVh3skvpIqtLrzppo4HshtqOlFDOePGGbxf0rBtfP8R
         2ctg==
X-Gm-Message-State: AOAM532++qYzlFDDCZGTm1+/CIBhsXI4U6Ug+KN1YwADkAVeyX4VbZhN
        9Crftg0iQ9vG4xAUqgvRHoMRmA0TKtd5LLzwo2MHKAbfqCH6oaE91/SHRpT01UzYgkDECjeUlVA
        bt66q6zPIWVGP020YrVXH6wNhLqY8IgmBkh1jOvcdYQ==
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr588678wmh.128.1634777182189;
        Wed, 20 Oct 2021 17:46:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRGyQwuX0RWsnHGQyYi/ngKg0rwoZsofzx0FO8yb5Tm0XYCRffyxkRLT6pbnH1pATha3ETgfDhMtMfli9BWdA=
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr588649wmh.128.1634777181923;
 Wed, 20 Oct 2021 17:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
 <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk> <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk> <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSqOUb7yZ7kBoKRY@zeniv-ca.linux.org.uk> <YS40qqmXL7CMFLGq@arm.com>
 <YS5KudP4DBwlbPEp@zeniv-ca.linux.org.uk> <YWR2cPKeDrc0uHTK@arm.com>
 <CAHk-=wjvQWj7mvdrgTedUW50c2fkdn6Hzxtsk-=ckkMrFoTXjQ@mail.gmail.com>
 <YWSnvq58jDsDuIik@arm.com> <CAHk-=wiNWOY5QW5ZJukt_9pHTWvrJhE2=DxPpEtFHAWdzOPDTg@mail.gmail.com>
In-Reply-To: <CAHk-=wiNWOY5QW5ZJukt_9pHTWvrJhE2=DxPpEtFHAWdzOPDTg@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 21 Oct 2021 02:46:10 +0200
Message-ID: <CAHc6FU7bpjAxP+4dfE-C0pzzQJN1p=C2j3vyXwUwf7fF9JF72w@mail.gmail.com>
Subject: Re: [RFC][arm64] possible infinite loop in btrfs search_ioctl()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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

On Tue, Oct 12, 2021 at 1:59 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Oct 11, 2021 at 2:08 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > +#ifdef CONFIG_ARM64_MTE
> > +#define FAULT_GRANULE_SIZE     (16)
> > +#define FAULT_GRANULE_MASK     (~(FAULT_GRANULE_SIZE-1))
>
> [...]
>
> > If this looks in the right direction, I'll do some proper patches
> > tomorrow.
>
> Looks fine to me. It's going to be quite expensive and bad for caches, though.
>
> That said, fault_in_writable() is _supposed_ to all be for the slow
> path when things go south and the normal path didn't work out, so I
> think it's fine.

Let me get back to this; I'm actually not convinced that we need to
worry about sub-page-size fault granules in fault_in_pages_readable or
fault_in_pages_writeable.

From a filesystem point of view, we can get into trouble when a
user-space read or write triggers a page fault while we're holding
filesystem locks, and that page fault ends up calling back into the
filesystem. To deal with that, we're performing those user-space
accesses with page faults disabled. When a page fault would occur, we
get back an error instead, and then we try to fault in the offending
pages. If a page is resident and we still get a fault trying to access
it, trying to fault in the same page again isn't going to help and we
have a true error. We're clearly looking at memory at a page
granularity; faults at a sub-page level don't matter at this level of
abstraction (but they do show similar error behavior). To avoid
getting stuck, when it gets a short result or -EFAULT, the filesystem
implements the following backoff strategy: first, it tries to fault in
a number of pages. When the read or write still doesn't make progress,
it scales back and faults in a single page. Finally, when that still
doesn't help, it gives up. This strategy is needed for actual page
faults, but it also handles sub-page faults appropriately as long as
the user-space access functions give sensible results.

What am I missing?

Thanks,
Andreas

> I do wonder how the sub-page granularity works. Is it sufficient to
> just read from it? Because then a _slightly_ better option might be to
> do one write per page (to catch page table writability) and then one
> read per "granule" (to catch pointer coloring or cache poisoning
> issues)?
>
> That said, since this is all preparatory to us wanting to write to it
> eventually anyway, maybe marking it all dirty in the caches is only
> good.
>
>                 Linus
>

