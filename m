Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6439B41B887
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 22:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242806AbhI1Ung (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 16:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57556 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242761AbhI1Unf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 16:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632861715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3jBAm38dwxejV13EKa37YtYOLD3eWnXj6fegh8i3dws=;
        b=TCmNhzhJIDp+RWK9J8D/uuY8feQCBW1SvyGxCHTs4rMZfSGqu9x+aH0Sbp6CdeUWKSxa0W
        UZABLG6CF72QbbtPrvwQfyrgYBtcNYe/ul0OtzSf7ZLcz1k0w7VjNCEXk6NE3ycfFu7AX0
        unU1PKimeWN1hGyoiypXABXtOPIMVY4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-K0jF_v5oPTeLO_aegFDgAA-1; Tue, 28 Sep 2021 16:41:54 -0400
X-MC-Unique: K0jF_v5oPTeLO_aegFDgAA-1
Received: by mail-wr1-f69.google.com with SMTP id w2-20020a5d5442000000b0016061c95fb7so99792wrv.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 13:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jBAm38dwxejV13EKa37YtYOLD3eWnXj6fegh8i3dws=;
        b=ArE7Zw+1UVUQb6chbwdx5X5LGH2fVuNoqGWAbG66LxOw0VoQ9gwbIi2KhtmO0GqoKM
         78dD4iaZVmDLXP2x4X85nuOMsa3FW9xG+0r3V2KloAR/FMNWNpMD1L7od/gxU1u3FlqP
         PH5nSj1wvLjLwZQZF3WRDaOrZ/iKzYk8HL11qB43J0BE0vvEW3Pc4p5EWMcsRnXli/+s
         c/Y3DLhHoAja9c4poAeb7EOjCvvgmiGhIuZcVWgNxLG5WQehDXypsQZbCtDT5l3elboY
         ZtP/joeU0GHgixLCX5xkTRh+vn+Zi037Kd0K1uZVUhCAn5jd7+Uw3snr0GP2H51C8XXz
         YxJQ==
X-Gm-Message-State: AOAM531MSZxhOMpcqB42hkJsKntxW8hqnv33cq8VDfzFVQ2cyeluUnVB
        FZbsfYizxGkJ301GiOZBb3CebqYzd/i3GcAc34lAfFitjya0CddSVoWiINg217jOQ7FzSBh85dn
        5ECrl0zVTvUPFsfAigb0iMaLrWe8KbsfffbuBTMSCjg==
X-Received: by 2002:adf:fe11:: with SMTP id n17mr2531992wrr.134.1632861712995;
        Tue, 28 Sep 2021 13:41:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJ3DYdqCR9Z5PcqKHy1xm32GHNEUBLV2gDJNFBOzxHyUdTS2vH5aXkMEboVTXvHTdpTp6sggiL9+bBSwcUm1A=
X-Received: by 2002:adf:fe11:: with SMTP id n17mr2531978wrr.134.1632861712811;
 Tue, 28 Sep 2021 13:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-4-agruenba@redhat.com>
 <CAL3q7H7PdBTuK28tN=3fGUyTP9wJU8Ydrq35YtNsfA_3xRQhzQ@mail.gmail.com>
 <CAHc6FU7rbdJxeuvoz0jov5y_GH_B4AtjkDnbNyOxeeNc1Zw5+A@mail.gmail.com> <YVNE4HGKPb7bw+En@casper.infradead.org>
In-Reply-To: <YVNE4HGKPb7bw+En@casper.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 28 Sep 2021 22:41:41 +0200
Message-ID: <CAHc6FU47kX=P2VhjAxk-7hqiKoEHUMMzbC-8vRYfWXUVs9zAtQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/19] gup: Turn fault_in_pages_{readable,writeable}
 into fault_in_{readable,writeable}
To:     Matthew Wilcox <willy@infradead.org>
Cc:     fdmanana@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Willy,

On Tue, Sep 28, 2021 at 6:40 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, Sep 28, 2021 at 05:02:43PM +0200, Andreas Gruenbacher wrote:
> > On Fri, Sep 3, 2021 at 4:57 PM Filipe Manana <fdmanana@gmail.com> wrote:
> > > On Fri, Aug 27, 2021 at 5:52 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > > > +size_t fault_in_writeable(char __user *uaddr, size_t size)
> > > > +{
> > > > +       char __user *start = uaddr, *end;
> > > > +
> > > > +       if (unlikely(size == 0))
> > > > +               return 0;
> > > > +       if (!PAGE_ALIGNED(uaddr)) {
> > > > +               if (unlikely(__put_user(0, uaddr) != 0))
> > > > +                       return size;
> > > > +               uaddr = (char __user *)PAGE_ALIGN((unsigned long)uaddr);
> > > > +       }
> > > > +       end = (char __user *)PAGE_ALIGN((unsigned long)start + size);
> > > > +       if (unlikely(end < start))
> > > > +               end = NULL;
> > > > +       while (uaddr != end) {
> > > > +               if (unlikely(__put_user(0, uaddr) != 0))
> > > > +                       goto out;
> > > > +               uaddr += PAGE_SIZE;
> > >
> > > Won't we loop endlessly or corrupt some unwanted page when 'end' was
> > > set to NULL?
> >
> > What do you mean? We set 'end' to NULL when start + size < start
> > exactly so that the loop will stop when uaddr wraps around.
>
> But think about x86-64.  The virtual address space (unless you have 5
> level PTs) looks like:
>
> [0, 2^47)               userspace
> [2^47, 2^64 - 2^47)     hole
> [2^64 - 2^47, 2^64)     kernel space
>
> If we try to copy from the hole we'll get some kind of fault (I forget
> the details).  We have to stop at the top of userspace.

If you look at the before and after state of this patch,
fault_in_pages_readable and fault_in_pages_writeable did fail an
attempt to fault in a range that wraps with -EFAULT. That's sensible
for a function that returns an all-or-nothing result. We now want to
return how much of the range was (or wasn't) faulted in. We could do
that and still reject ranges that wrap outright. Or we could try to
fault in however much we reasonably can even if the range wraps. The
patch tries the latter, which is where the stopping at NULL is coming
from: when the range wraps, we *definitely* don't want to go any
further.

If the range extends into the hole, we'll get a failure from
__get_user or __put_user where that happens. That's entirely the
expected result, isn't it?

Thanks,
Andreas

