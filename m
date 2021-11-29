Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFAF4616AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 14:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377972AbhK2NjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 08:39:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377879AbhK2NhP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638192837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CFjxye30orMI7i89fFT7gDDtQnI0xfPiALwP4O76QSI=;
        b=ccQAJfvZ3khCKzN+YyaTgxPB+87tmn9ESuATvpXro/UQ7Ck+rlw61iv+TN2lfvJNqSTB7D
        3Xy+UKHb2O06ffhdMZyMFql3Y3+FR2jewz38vj1rz1z6v5RbDcTbiK5LVIs5+KfnoE3mvJ
        kLOa2k4Uwnipe4/I3tNsCOtmp3r8W/M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-X1uAvUgyM4KMl3jYLO7PuA-1; Mon, 29 Nov 2021 08:33:55 -0500
X-MC-Unique: X1uAvUgyM4KMl3jYLO7PuA-1
Received: by mail-wm1-f69.google.com with SMTP id 69-20020a1c0148000000b0033214e5b021so8597128wmb.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 05:33:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CFjxye30orMI7i89fFT7gDDtQnI0xfPiALwP4O76QSI=;
        b=rVO5JptxhcyrQZE7qobdnWfOyoye6fKQvHPbpYFZ1EhHRdCTIAi3g2VCneEGx91+6C
         5higKqQKTDog/rMoCULsiJJvCyqchXtsaK0QwL2EdlHD7AAO4i6RpoJKuTbwBC2GEpWC
         67SebmXqxcZTTSZBTbDuFTXynjQuRSpxfg4Qs9TiCxRzNpxkoXGuTWLk6Q234c347hon
         Wk87bDI+jfro3uHE2Vu/drbDLZJmzaDkx7Zue4xOGrCkXMItKEFMXZ7rZuwTCaebxN0c
         PWEVtU8z7MUb5IjOHF9USbJwUomVs5lLDMcuoUDI6sKA9UpeyiSgsOy5X5RcTGF33yKM
         Gbig==
X-Gm-Message-State: AOAM530UNwW0vYMqIXi1Vq4drzjP4Wowzqi6bHid9Vh5eDxLAdF0uPn+
        dp7TslCCoWD3/oxtBvoh6OVtC3ekwZC2dpKp5EO7mmZdh0WlZ9VRygc/nKFnlXI55tMZCVwqy/1
        PSJlUu5xHmUagswUiAX0Gy5ZcMLw/O/uhrKGa1KCKDg==
X-Received: by 2002:a5d:45c4:: with SMTP id b4mr33673332wrs.222.1638192834379;
        Mon, 29 Nov 2021 05:33:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyE+OPNlvNuS41ipScxbexU0H/eOprmV9W8IL1xapCUHlkoUBHlCidfnJeg1zWR4MrdMtFwIrb2f23/wIndXyg=
X-Received: by 2002:a5d:45c4:: with SMTP id b4mr33673296wrs.222.1638192834063;
 Mon, 29 Nov 2021 05:33:54 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU53gdXR4VjSQJUtUigVkgDY6yfRkNBYuBj4sv3eT=MBSQ@mail.gmail.com>
 <YaAROdPCqNzSKCjh@arm.com> <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com> <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <YZ6idVy3zqQC4atv@arm.com> <CAHc6FU4-P9sVexcNt5CDQxROtMAo=kH8hEu==AAhZ_+Zv53=Ag@mail.gmail.com>
 <20211127123958.588350-1-agruenba@redhat.com> <YaJM4n31gDeVzUGA@arm.com>
 <CAHc6FU7BSL58GVkOh=nsNQczRKG3P+Ty044zs7PjKPik4vzz=Q@mail.gmail.com> <YaTEkAahkCwuQdPN@arm.com>
In-Reply-To: <YaTEkAahkCwuQdPN@arm.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 29 Nov 2021 14:33:42 +0100
Message-ID: <CAHc6FU6zVi9A2D3V3T5zE71YAdkBiJTs0ao1Q6ysSuEp=bz8fQ@mail.gmail.com>
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

On Mon, Nov 29, 2021 at 1:22 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Sat, Nov 27, 2021 at 07:05:39PM +0100, Andreas Gruenbacher wrote:
> > On Sat, Nov 27, 2021 at 4:21 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > That's similar, somehow, to the arch-specific probing in one of my
> > > patches: [1]. We could do the above if we can guarantee that the maximum
> > > error margin in copy_to_user() is smaller than SUBPAGE_FAULT_SIZE. For
> > > arm64 copy_to_user(), it is fine, but for copy_from_user(), if we ever
> > > need to handle fault_in_readable(), it isn't (on arm64 up to 64 bytes
> > > even if aligned: reads of large blocks are done in 4 * 16 loads, and if
> > > one of them fails e.g. because of the 16-byte sub-page fault, no write
> > > is done, hence such larger than 16 delta).
> > >
> > > If you want something in the generic fault_in_writeable(), we probably
> > > need a loop over UACCESS_MAX_WRITE_ERROR in SUBPAGE_FAULT_SIZE
> > > increments. But I thought I'd rather keep this in the arch-specific code.
> >
> > I see, that's even crazier than I'd thought. The looping / probing is
> > still pretty generic, so I'd still consider putting it in the generic
> > code.
>
> In the arm64 probe_subpage_user_writeable(), the loop is skipped if
> !system_supports_mte() (static label). It doesn't make much difference
> for search_ioctl() in terms of performance but I'd like the arch code to
> dynamically decide when to probe. An arch_has_subpage_faults() static
> inline function would solve this.
>
> However, the above assumes that the only way of probing is by doing a
> get_user/put_user(). A non-destructive probe with MTE would be to read
> the actual tags in memory and compare them with the top byte of the
> pointer.
>
> There's the CHERI architecture as well. Although very early days for
> arm64, we do have an incipient port (https://www.morello-project.org/).
> The void __user * pointers are propagated inside the kernel as 128-bit
> capabilities. A fault_in() would check whether the address (bottom
> 64-bit) is within the range and permissions specified in the upper
> 64-bit of the capability. There is no notion of sub-page fault
> granularity here and no need to do a put_user() as the check is just
> done on the pointer/capability.
>
> Given the above, my preference is to keep the probing arch-specific.
>
> > We also still have fault_in_safe_writeable which is more difficult to
> > fix, and fault_in_readable which we don't want to leave behind broken,
> > either.
>
> fault_in_safe_writeable() can be done by using get_user() instead of
> put_user() for arm64 MTE and probably SPARC ADI (an alternative is to
> read the in-memory tags and compare them with the pointer).

So we'd keep the existing fault_in_safe_writeable() logic for the
actual fault-in and use get_user() to check for sub-page faults? If
so, then that should probably also be hidden in arch code.

> For CHERI, that's different again since the fault_in_safe_writeable capability
> encodes the read/write permissions independently.
>
> However, do we actually want to change the fault_in_safe_writeable() and
> fault_in_readable() functions at this stage? I could not get any of them
> to live-lock, though I only tried btrfs, ext4 and gfs2. As per the
> earlier discussion, normal files accesses are guaranteed to make
> progress. The only problematic one was O_DIRECT which seems to be
> alright for the above filesystems (the fs either bails out after several
> attempts or uses GUP to read which skips the uaccess altogether).

Only gfs2 uses fault_in_safe_writeable(). For buffered reads, progress
is guaranteed because failures are at a byte granularity.

O_DIRECT reads and writes happen in device block size granularity, but
the pages are grabbed with get_user_pages() before the copying
happens. So by the time the copying happens, the pages are guaranteed
to be resident, and we don't need to loop around fault_in_*().

You've mentioned before that copying to/from struct page bypasses
sub-page fault checking. If that is the case, then the checking
probably needs to happen in iomap_dio_bio_iter and dio_refill_pages
instead.

> Happy to address them if there is a real concern, I just couldn't trigger it.

Hopefully it should now be clear why you couldn't. One way of
reproducing with fault_in_safe_writeable() would be to use that in
btrfs instead of fault_in_writeable(), of course.

We're not doing any chunked reads from user space with page faults
disabled as far as I'm aware right now, so we probably don't have a
reproducer for fault_in_readable(). It would still be worth fixing
fault_in_readable() to prevent things from blowing up very
unexpectedly later, though.

Thanks,
Andreas

> > > Of course, the above fault_in_writeable() still needs the btrfs
> > > search_ioctl() counterpart toget_user_pages change the probing on the actual fault
> > > address or offset.
> >
> > Yes, but that change is relatively simple and it eliminates the need
> > for probing the entire buffer, so it's a good thing. Maybe you want to
> > add this though:
> >
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -2202,3 +2202,3 @@ static noinline int search_ioctl(struct inode *inode,
> >         unsigned long sk_offset = 0;
> > -       char __user *fault_in_addr;
> > +       char __user *fault_in_addr, *end;
> >
> > @@ -2230,6 +2230,6 @@ static noinline int search_ioctl(struct inode *inode,
> >         fault_in_addr = ubuf;
> > +       end = ubuf + *buf_size;
> >         while (1) {
> >                 ret = -EFAULT;
> > -               if (fault_in_writeable(fault_in_addr,
> > -                                      *buf_size - (fault_in_addr - ubuf)))
> > +               if (fault_in_writeable(fault_in_addr, end - fault_in_addr))
> >                         break;
>
> Thanks, I'll add it.
>
> --
> Catalin
>

