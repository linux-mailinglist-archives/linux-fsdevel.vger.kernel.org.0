Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D6C396907
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 May 2021 22:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhEaUgp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 May 2021 16:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231907AbhEaUgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 May 2021 16:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622493301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eIPtoH3V1uRSKTYJIeUQjqM9k7RxE6f0M/KOCbORxjo=;
        b=R+BfCx6wWZBBcsQ++WCP9qx1LX1glOlH2mRtb6k5egbEKUFDOzhvyhXjQTT6peJSpAZqty
        3vAnDt2m0n7j5uiob3upi57a1q/RkpFdNZJc2TE+9hG7I+TgdUUx2idXtnPJeAO6lTil7P
        N1U3kcQP1j29vCnMLCuHQojSUAYQK9Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-HBsuMfuLO7-B12VmkU56lQ-1; Mon, 31 May 2021 16:32:40 -0400
X-MC-Unique: HBsuMfuLO7-B12VmkU56lQ-1
Received: by mail-wm1-f70.google.com with SMTP id o82-20020a1ca5550000b029019ae053d508so357661wme.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 May 2021 13:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIPtoH3V1uRSKTYJIeUQjqM9k7RxE6f0M/KOCbORxjo=;
        b=HcQhMPfBfYUogxwmfjbn5GGRiVlvY+McuasSjN77mNfxu3ozcjO+FnYpFyBn2WkZGn
         vPmN4ev+0fyGCzZ6JlFXMULREOgDjfiertFpBPFLGq/EVf3lkvfGEGl5SvuukuOQV7DI
         nUmt7gnww696wNjH6eeiSWkt+AdrB8ZKwwzAvDJTwJCwzUFXNEI7ocveP5tfwUyOhoVl
         /XoDYMNbI5QOOU3j1hfDJeXhGVXJYwTaSJEEtZd9UkdYoxzRKDHXKuMznYLgzQpaaUFs
         mZFDd4MkZAT0QU0/PNhyWTib5Exsd7maMGWiNO/3eo0dC/Tt+RwezebQgILpeEwMooXv
         r4Uw==
X-Gm-Message-State: AOAM533npWXZQ+CU5JAXDkM2Rq0+e08+3JbIdGaUEXhEOdNlRjHujRLD
        k8cXGOfaEQESDKAspxd4iZwlLnm1vw/cL0tZ20dgXeYYbSI9zdhTiJB9a9YVHsf6yMPA/BtuW3L
        cKm+Wj1LZb9SxY04PRkrZtSN9JTLCIwMD1lr+nkxODg==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr742491wmi.132.1622493159733;
        Mon, 31 May 2021 13:32:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuUP4NISItoptr6oKYfry3Adwhj9c5n6SHwj4ZPOi4fGsXEBkf39U4RUlwoOP+qpxNp07En9r9I5ue0x82AUU=
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr742477wmi.132.1622493159526;
 Mon, 31 May 2021 13:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210531105606.228314-1-agruenba@redhat.com> <CAHk-=wj8EWr_D65i4oRSj2FTbrc6RdNydNNCGxeabRnwtoU=3Q@mail.gmail.com>
In-Reply-To: <CAHk-=wj8EWr_D65i4oRSj2FTbrc6RdNydNNCGxeabRnwtoU=3Q@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 31 May 2021 22:32:28 +0200
Message-ID: <CAHc6FU51=5cNZX9hdDHj3AJ6fy4bK7nH1qwAi2m2wB45WPoq8Q@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fixes for v5.13-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 31, 2021 at 6:30 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> [ Adding fsdevel, because this is not limited to gfs2 ]
>
> On Mon, May 31, 2021 at 12:56 AM Andreas Gruenbacher
> <agruenba@redhat.com> wrote:
> >
> > Andreas Gruenbacher (2):
> >       gfs2: Fix mmap locking for write faults
>
> This is bogus.
>
> I've pulled it, but this is just wrong.
>
> A write fault on a mmap IS NOT A WRITE to the filesystem.
>
> It's a read.
>
> Yes, it will later then allow writes to the page, but that's entirely
> immaterial - because the write is going to happen not at fault time,
> but long *after* the fault, and long *after* the filesystem has
> installed the page.
>
> The actual write will happen when the kernel returns from the user space.
>
> And no, the explanation in that commit makes no sense either:
>
>    "When a write fault occurs, we need to take the inode glock of the underlying
>     inode in exclusive mode.  Otherwise, there's no guarantee that the
> dirty page
>     will be written back to disk"
>
> the thing is, FAULT_FLAG_WRITE only says that the *currently* pending
> access that triggered the fault was a write. That's entirely
> irrelevant to a filesystem, because
>
>  (a) it might be a private mapping, and a write to a page will cause a
> COW by the VM layer, and it's not actually a filesystem write at all
>
> AND
>
>  (b) if it's a shared mapping, the first access that paged things in
> is likely a READ, and the page will be marked writable (because it's a
> shared mapping!) and subsequent writes will not cause any faults at
> all.
>
> In other words, a filesystem that checks for FAULT_FLAG_WRITE is
> _doubly_ wrong. It's absolutely never the right thing to do. It
> *cannot* be the right thing to do.
>
> And yes, some other filesystems do this crazy thing too. If your
> friends jumped off a bridge, would you jump too?
>
> The xfs and ext3/ext4 cases are wrong too - but at least they spent
> five seconds (but no more) thinking about it, and they added the check
> for VM_SHARED. So they are only wrong for reason (b)
>
> But wrong is wrong. The new code is not right in gfs2, and the old
> code in xfs/ext4 is not right either.
>
> Yeah, yeah, you can - and people do - do things like "always mark the
> page readable on initial page fault, use mkwrite to catch when it
> becomes writable, and do timestamps carefully, at at least have full
> knowledge of "something might become dirty"
>
> But even then it is ENTIRELY BOGUS to do things like write locking.
>
> Really.
>
> Because the actual write HASN'T HAPPENED YET, AND YOU WILL RELEASE THE
> LOCK BEFORE IT EVER DOES! So the lock? It does nothing. If you think
> it protects anything at all, you're wrong.
>
> So don't do write locking. At an absolute most, you can do things like
>
>  - update file times (and honestly, that's quite questionable -
> because again - THE WRITE HASN'T HAPPENED YET - so any tests that
> depend on exact file access times to figure out when the last write
> was done is not being helped by your extra code, because you're
> setting the WRONG time.
>
>  - set some "this inode will have dirty pages" flag just for some
> possible future use. But honestly, if this is about consistency etc,
> you need to do it not for a fault, but across the whole mmap/munmap.
>
> So some things may be less bogus - but still very very questionable.
>
> But locking? Bogus. Reads and writes aren't really any different from
> a timestamp standpoint (if you think you need to mtime for write
> accesses, you should do atime for reads, so from a filesystem
> timestamp standpoint read and write faults are exactly the same - and
> both are bogus, because by definition for a mmap both the reads and
> the writes can then happen long long long afterwards, and repeatedly).
>
> And if that "set some flag" thing needs a write lock, but a read
> doesn't, you're doing something wrong and odd.
>
> Look at the VM code. The VM code does this right. The mmap_sem is
> taken for writing for mmap and for munmap. But a page fault is always
> a read lock, even if the access that caused the page fault is a write.
>
> The actual real honest-to-goodness *write* happens much later, and the
> only time the filesystem really knows when it is done is at writeback
> time. Not at fault time. So if you take locks, logically you should
> take them when the fault happens, and release them when the writeback
> is done.
>
> Are you doing that? No. So don't do the write lock over the read
> portion of the page fault. It is not a sensible operation.

Thanks for the detailed explanation. I'll work on a fix.

Andreas

