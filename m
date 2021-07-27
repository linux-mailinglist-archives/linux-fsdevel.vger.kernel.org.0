Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BF93D7411
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhG0LOD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 07:14:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235837AbhG0LOC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627384441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=afrSbaGGjeeVykwqXymNzbcEw/D8kWccnFVpP7E5Guw=;
        b=O0IReZVeupqktJ6+h8i790yZeak/1EkGtnXYWOQL4UGGa+hpJLFBoeVsrzdE1bjzXrayov
        LTv0fKjqe7x/ZZHoD4RzjLbRqlHiKuNdA5l0SL7GdaCWM983qMzP2xv26RvHQ8bBL4y3NJ
        2wH8B1OmLT+P2zNLds3P/3NBbl1yRwc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-q1ZwdKvvN4SKITaYdIWh6Q-1; Tue, 27 Jul 2021 07:14:00 -0400
X-MC-Unique: q1ZwdKvvN4SKITaYdIWh6Q-1
Received: by mail-wm1-f71.google.com with SMTP id o26-20020a05600c511ab0290252d0248251so1230606wms.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jul 2021 04:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afrSbaGGjeeVykwqXymNzbcEw/D8kWccnFVpP7E5Guw=;
        b=bT5rcOpKTux3AXkl79yu9MA7hfyKQFuM3jVoBabRFM4iNADrqODJQhyQgVL8tzqJP7
         B2ZYcRhYiyah4QoaXCAoauWmhRH5eIvUCnp7TBqp4tA8LPl8hOW2AjZuYTXgB8IpaN5v
         MPAOKlHVz3Wt+bd0l3acfoFbh1f6p/+JsLAY8N0I8ObKaWhKxw+idh+WsTNB4bI2td5D
         fzsOwIV1BU6dj/M4zgnWVlGmf1R+3XW4TOJszvE2xO09FQZ0FBYEoqH9yFsoFXP/BbwR
         I0Q9AKtaAtNrSUOys563hIHWuVneTPAb18a0cT3i2A0GgB1sMxcTozsQfQViYXj8bk0G
         zFqw==
X-Gm-Message-State: AOAM533Hof4VcWgiema+IGEhA2Zm4ZbtS2Um0gKPyWwuECtUdpmmRdq4
        R171F6oRX/Pqt39eFCy8Jc87NqRREhhlb57i3stsVHtgKeA0+I4qkqUivsSZELdcL9m5zOMaByQ
        U9WEPu9Gg5eGIU4iNGBTJMIDKeE1SExoIrMIcQVEDiQ==
X-Received: by 2002:a1c:2282:: with SMTP id i124mr21633321wmi.166.1627384439576;
        Tue, 27 Jul 2021 04:13:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzfklfZGsBuVC9rf1FJG+V3aLBjS+SfsovPyqckWGhLMBFH25HVSmfqV0mFgBo9h9VeIN01a4/gyJ0JOvSo60=
X-Received: by 2002:a1c:2282:: with SMTP id i124mr21633303wmi.166.1627384439403;
 Tue, 27 Jul 2021 04:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210724193449.361667-1-agruenba@redhat.com> <20210724193449.361667-2-agruenba@redhat.com>
 <CAHk-=whodi=ZPhoJy_a47VD+-aFtz385B4_GHvQp8Bp9NdTKUg@mail.gmail.com> <03e0541400e946cf87bc285198b82491@AcuMS.aculab.com>
In-Reply-To: <03e0541400e946cf87bc285198b82491@AcuMS.aculab.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 27 Jul 2021 13:13:47 +0200
Message-ID: <CAHc6FU4N7vz+jfoUSa45Mr_F0Ht0_PXroWoc5UNkMgFmpKLaNw@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] iov_iter: Introduce iov_iter_fault_in_writeable helper
To:     David Laight <David.Laight@aculab.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 11:30 AM David Laight <David.Laight@aculab.com> wrote:
> From: Linus Torvalds
> > Sent: 24 July 2021 20:53
> >
> > On Sat, Jul 24, 2021 at 12:35 PM Andreas Gruenbacher
> > <agruenba@redhat.com> wrote:
> > >
> > > +int iov_iter_fault_in_writeable(const struct iov_iter *i, size_t bytes)
> > > +{
> > ...
> > > +                       if (fault_in_user_pages(start, len, true) != len)
> > > +                               return -EFAULT;
> >
> > Looking at this once more, I think this is likely wrong.
> >
> > Why?
> >
> > Because any user can/should only care about at least *part* of the
> > area being writable.
> >
> > Imagine that you're doing a large read. If the *first* page is
> > writable, you should still return the partial read, not -EFAULT.
>
> My 2c...
>
> Is it actually worth doing any more than ensuring the first byte
> of the buffer is paged in before entering the block that has
> to disable page faults?

We definitely do want to process as many pages as we can, especially
if allocations are involved during a write.

> Most of the all the pages are present so the IO completes.

That's not guaranteed. There are cases in which none of the pages are
present, and then there are cases in which only the first page is
present (for example, because of a previous access that wasn't page
aligned).

> The pages can always get unmapped (due to page pressure or
> another application thread unmapping them) so there needs
> to be a retry loop.
> Given the cost of actually faulting in a page going around
> the outer loop may not matter.
> Indeed, if an application has just mmap()ed in a very large
> file and is then doing a write() from it then it is quite
> likely that the pages got unmapped!
>
> Clearly there needs to be extra code to ensure progress is made.
> This might actually require the use of 'bounce buffers'
> for really problematic user requests.

I'm not sure if repeated unmapping of the pages that we've just
faulted in is going to be a problem (in terms of preventing progress).
But a suitable heuristic might be to shrink the fault-in "window" on
each retry until it's only one page.

> I also wonder what actually happens for pipes and fifos.
> IIRC reads and write of up to PIPE_MAX (typically 4096)
> are expected to be atomic.
> This should be true even if there are page faults part way
> through the copy_to/from_user().
>
> It has to be said I can't see any reference to PIPE_MAX
> in the linux man pages, but I'm sure it is in the POSIX/TOG
> spec.
>
>         David

Thanks,
Andreas

