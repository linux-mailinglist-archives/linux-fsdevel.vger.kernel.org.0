Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CD94600D8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Nov 2021 19:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355997AbhK0SLO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Nov 2021 13:11:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239935AbhK0SJK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Nov 2021 13:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638036355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+BwIW85KhvXySZsPUP6FJMZbiOq5atqcsMhwNjrDCOQ=;
        b=LuD6O5tq9NSwZrAYJPeJnOcKle1toVB8LMBTGbYIWyLSLCCs18Ly9yfDIyeBuSfMKDO28+
        ODGbIWymv6zHDe5XWLK0N8AET1D8ygCzumG8WwuXibz6Rtx0VNHKxJasJNY9Ytg+GEM83f
        PaxMebsj/qpMFhYQ197HUYgnmi2R36E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-1ZquPiviMGCt_TrYHm1NjQ-1; Sat, 27 Nov 2021 13:05:54 -0500
X-MC-Unique: 1ZquPiviMGCt_TrYHm1NjQ-1
Received: by mail-wm1-f72.google.com with SMTP id l6-20020a05600c4f0600b0033321934a39so7346175wmq.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Nov 2021 10:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+BwIW85KhvXySZsPUP6FJMZbiOq5atqcsMhwNjrDCOQ=;
        b=c2nQqZBrP6kFqvrYJ0s/x5q2jCB+NY4/9AWBokzrUMDKREahgUyNoewXsZzIexhjwg
         smSdogDjvv2GHz9HH2T7liQMdLQLJyGMZ1GVb0oNlawrTVN0F8ztz2n6AQBHoUiQ2j6T
         cxBZPuqflA5St7M/3GyrOnKpIKveNTdeqiq3s23ZeE7zgDWCq8frYJWtaa0QD2iYBleg
         YhzRFcoN3fbpkLlkz0kZfijsRg+uz7G5NLJsLe8tBPgmN/N4PbM0AhJ0hn2rWtrcncZt
         Tg21Ddfrz6774/c3eMR2jwtogSI4JkmtVAAZE9uw9ckK/eKRBZ4JuEtI/EB7sdjBiJOn
         kPYQ==
X-Gm-Message-State: AOAM532jkXLoG/jxZCYmu29dbbemBbgkLPU0f++CinJ1DAw3tszWYSFb
        EuEheQi+7BDTWa9ARr6X+IJDdZHhu2vtXLYX/OMXltw+QY5NfPR7zbvUjjC4r8i+tC/i6Ks7iKj
        qMQKp+HsMt9HCGWpDWTskOl/SrgAM82SiT32DtRktOQ==
X-Received: by 2002:a1c:f005:: with SMTP id a5mr25342574wmb.19.1638036352651;
        Sat, 27 Nov 2021 10:05:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwb4kGFI4QmQ7+Cdh6OUi7N8oAx3K/VJeig9Qm7BzUKFdOwNTlZ64ftwSlmxskh3nck5MM6jmuV5H04VfdiGME=
X-Received: by 2002:a1c:f005:: with SMTP id a5mr25342540wmb.19.1638036352374;
 Sat, 27 Nov 2021 10:05:52 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU53gdXR4VjSQJUtUigVkgDY6yfRkNBYuBj4sv3eT=MBSQ@mail.gmail.com>
 <YaAROdPCqNzSKCjh@arm.com> <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com> <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <YZ6idVy3zqQC4atv@arm.com> <CAHc6FU4-P9sVexcNt5CDQxROtMAo=kH8hEu==AAhZ_+Zv53=Ag@mail.gmail.com>
 <20211127123958.588350-1-agruenba@redhat.com> <YaJM4n31gDeVzUGA@arm.com>
In-Reply-To: <YaJM4n31gDeVzUGA@arm.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sat, 27 Nov 2021 19:05:39 +0100
Message-ID: <CAHc6FU7BSL58GVkOh=nsNQczRKG3P+Ty044zs7PjKPik4vzz=Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware
 with sub-page faults
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 27, 2021 at 4:21 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Sat, Nov 27, 2021 at 01:39:58PM +0100, Andreas Gruenbacher wrote:
> > On Sat, Nov 27, 2021 at 4:52 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > > On Sat, Nov 27, 2021 at 12:06 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > If we know that the arch copy_to_user() has an error of say maximum 16
> > > > bytes (or 15 rather on arm64), we can instead get fault_in_writeable()
> > > > to probe the first 16 bytes rather than 1.
> > >
> > > That isn't going to help one bit: [raw_]copy_to_user() is allowed to
> > > copy as little or as much as it wants as long as it follows the rules
> > > documented in include/linux/uaccess.h:
> > >
> > > [] If copying succeeds, the return value must be 0.  If some data cannot be
> > > [] fetched, it is permitted to copy less than had been fetched; the only
> > > [] hard requirement is that not storing anything at all (i.e. returning size)
> > > [] should happen only when nothing could be copied.  In other words, you don't
> > > [] have to squeeze as much as possible - it is allowed, but not necessary.
> > >
> > > When fault_in_writeable() tells us that an address range is accessible
> > > in principle, that doesn't mean that copy_to_user() will allow us to
> > > access it in arbitrary chunks. It's also not the case that
> > > fault_in_writeable(addr, size) is always followed by
> > > copy_to_user(addr, ..., size) for the exact same address range, not
> > > even in this case.
> > >
> > > These alignment restrictions have nothing to do with page or sub-page faults.
> > >
> > > I'm also fairly sure that passing in an unaligned buffer will send
> > > search_ioctl into an endless loop on architectures with copy_to_user()
> > > alignment restrictions; there don't seem to be any buffer alignment
> > > checks.
> >
> > Let me retract that ...
> >
> > The description in include/linux/uaccess.h leaves out permissible
> > reasons for fetching/storing less than requested. Thinking about it, if
> > the address range passed to one of the copy functions includes an
> > address that faults, it kind of makes sense to allow the copy function
> > to stop short instead of copying every last byte right up to the address
> > that fails.
> >
> > If that's the only reason, then it would be great to have that included
> > in the description.  And then we can indeed deal with the alignment
> > effects in fault_in_writeable().
>
> Ah, I started replying last night, sent it today without seeing your
> follow-up.
>
> > > > I attempted the above here and works ok:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=devel/btrfs-live-lock-fix
> > > >
> > > > but too late to post it this evening, I'll do it in the next day or so
> > > > as an alternative to this series.
> >
> > I've taken a quick look.  Under the assumption that alignment effects
> > are tied to page / sub-page faults, I think we can really solve this
> > generically as Willy has proposed.
>
> I think Willy's proposal stopped at the page boundary, it should go
> beyond.
>
> > Maybe as shown below; no need for arch-specific code.
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 2c51e9748a6a..a9b3d916b625 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1658,6 +1658,8 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
> >  }
> >  #endif /* !CONFIG_MMU */
> >
> > +#define SUBPAGE_FAULT_SIZE 16
> > +
> >  /**
> >   * fault_in_writeable - fault in userspace address range for writing
> >   * @uaddr: start of address range
> > @@ -1673,8 +1675,19 @@ size_t fault_in_writeable(char __user *uaddr, size_t size)
> >       if (unlikely(size == 0))
> >               return 0;
> >       if (!PAGE_ALIGNED(uaddr)) {
> > +             if (SUBPAGE_FAULT_SIZE &&
> > +                 !IS_ALIGNED((unsigned long)uaddr, SUBPAGE_FAULT_SIZE)) {
> > +                     end = PTR_ALIGN(uaddr, SUBPAGE_FAULT_SIZE);
> > +                     if (end - uaddr < size) {
> > +                             if (unlikely(__put_user(0, uaddr) != 0))
> > +                                     return size;
> > +                             uaddr = end;
> > +                             if (unlikely(!end))
> > +                                     goto out;
> > +                     }
> > +             }
> >               if (unlikely(__put_user(0, uaddr) != 0))
> > -                     return size;
> > +                     goto out;
> >               uaddr = (char __user *)PAGE_ALIGN((unsigned long)uaddr);
> >       }
> >       end = (char __user *)PAGE_ALIGN((unsigned long)start + size);
>
> That's similar, somehow, to the arch-specific probing in one of my
> patches: [1]. We could do the above if we can guarantee that the maximum
> error margin in copy_to_user() is smaller than SUBPAGE_FAULT_SIZE. For
> arm64 copy_to_user(), it is fine, but for copy_from_user(), if we ever
> need to handle fault_in_readable(), it isn't (on arm64 up to 64 bytes
> even if aligned: reads of large blocks are done in 4 * 16 loads, and if
> one of them fails e.g. because of the 16-byte sub-page fault, no write
> is done, hence such larger than 16 delta).
>
> If you want something in the generic fault_in_writeable(), we probably
> need a loop over UACCESS_MAX_WRITE_ERROR in SUBPAGE_FAULT_SIZE
> increments. But I thought I'd rather keep this in the arch-specific code.

I see, that's even crazier than I'd thought. The looping / probing is
still pretty generic, so I'd still consider putting it in the generic
code.

We also still have fault_in_safe_writeable which is more difficult to
fix, and fault_in_readable which we don't want to leave behind broken,
either.

> Of course, the above fault_in_writeable() still needs the btrfs
> search_ioctl() counterpart to change the probing on the actual fault
> address or offset.

Yes, but that change is relatively simple and it eliminates the need
for probing the entire buffer, so it's a good thing. Maybe you want to
add this though:

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2202,3 +2202,3 @@ static noinline int search_ioctl(struct inode *inode,
        unsigned long sk_offset = 0;
-       char __user *fault_in_addr;
+       char __user *fault_in_addr, *end;

@@ -2230,6 +2230,6 @@ static noinline int search_ioctl(struct inode *inode,
        fault_in_addr = ubuf;
+       end = ubuf + *buf_size;
        while (1) {
                ret = -EFAULT;
-               if (fault_in_writeable(fault_in_addr,
-                                      *buf_size - (fault_in_addr - ubuf)))
+               if (fault_in_writeable(fault_in_addr, end - fault_in_addr))
                        break;

> In the general case (uaccess error margin larger), I'm not entirely
> convinced we can skip the check if PAGE_ALIGNED(uaddr).

Yes, the loop can span multiple sub-page error domains, at least in
the read case, so it needs to happen even for page-aligned addresses.

> I should probably get this logic through CBMC (or TLA+), I can't think it
> through.
>
> Thanks.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=devel/btrfs-live-lock-fix&id=af7e96d9e9537d9f9cc014f388b7b2bb4a5bc343
>
> --
> Catalin
>

Thanks,
Andreas

