Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7876D45FC7D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Nov 2021 04:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhK0D5p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 22:57:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21517 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239249AbhK0Dzo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 22:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637985150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YBu0TKYMlDzNfaw4nFRDjKWkibjxrtPGawGYuWjQVLU=;
        b=ZUhsFK98+PqNMn8QhcDP3VtVTd5tBpMTE1OzedYmnM0W59VdeRq0bkZxXf5sQViNlgaPXZ
        OFZGWkSUhA33n4I8dLFgmDhmURozi0JiwOM8E0zPDU9aHC5pzERUlZwdyo2ziMjn6gkv9K
        bvLi/+Vz8FxUxwu2p3SG0tDpdHeyRh4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-Iz3uOrAXN8e57mxeOyQ2DQ-1; Fri, 26 Nov 2021 22:52:29 -0500
X-MC-Unique: Iz3uOrAXN8e57mxeOyQ2DQ-1
Received: by mail-wm1-f72.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso7980632wms.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Nov 2021 19:52:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBu0TKYMlDzNfaw4nFRDjKWkibjxrtPGawGYuWjQVLU=;
        b=3r2dRqd0hs4XR3qDWZhx0Sz5bocvIlBa1KrfHRTSnBNxkjNYI1YwUAg26wIlLCBxj8
         h87Lp0iqFoomDcacjfB9ioNfGN+0cZpkofMsIxJPoxh64iI7Dq7u4LdpvCikteKXLyzz
         mHGFbR3iJL22dQHVEGs1gXSpkWsR7oCVRHieokmMvoWPSVd0N+pmRL7hQ2l9U1GPtlEu
         lFrTdY0/+pkRKK2DqTOD1NsbJpWhwVDEBvA5BCZA2utTpwIz7Qg+bSP/saY3Z14Osq2o
         rWnpjTcl2v5KywMBpBxWlWfY3kWUe182d4dqbrAzase8p2WFZfEDqxynt5Kn1wHGWVZ3
         Hf1Q==
X-Gm-Message-State: AOAM531AHF85zSU6KcSPzsIF9RPZTShdjVzY5RMjxVz1kp/7YnOPzydJ
        SjC8BEvnlZo2FTM775j7Ch8QIpzUL9LNzcDYc7/HlwSFjbJyoeo/OZFh+k6T+9tnyqdjczuq8t/
        XUU0/yX+mOEmA/KBRVx+ZfvzpyxFrnzqFbn848dCe9g==
X-Received: by 2002:adf:e984:: with SMTP id h4mr18926641wrm.149.1637985147909;
        Fri, 26 Nov 2021 19:52:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyj5ejF2MTJuOBwknZH7cs+IbWSpXM0GIc+4jvarthQmIS7p0k4t7IBSL1W9v++oZhg83W8N2CiFY3kykhMSD4=
X-Received: by 2002:adf:e984:: with SMTP id h4mr18926613wrm.149.1637985147635;
 Fri, 26 Nov 2021 19:52:27 -0800 (PST)
MIME-Version: 1.0
References: <YaAROdPCqNzSKCjh@arm.com> <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com> <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <YZ6idVy3zqQC4atv@arm.com> <CAHc6FU4-P9sVexcNt5CDQxROtMAo=kH8hEu==AAhZ_+Zv53=Ag@mail.gmail.com>
 <20211126222945.549971-1-agruenba@redhat.com> <YaFmaJqyie6KZ2bY@arm.com>
In-Reply-To: <YaFmaJqyie6KZ2bY@arm.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sat, 27 Nov 2021 04:52:16 +0100
Message-ID: <CAHc6FU53gdXR4VjSQJUtUigVkgDY6yfRkNBYuBj4sv3eT=MBSQ@mail.gmail.com>
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

On Sat, Nov 27, 2021 at 12:06 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Fri, Nov 26, 2021 at 11:29:45PM +0100, Andreas Gruenbacher wrote:
> > On Thu, Nov 25, 2021 at 11:42 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > As per Linus' reply, we can work around this by doing
> > > a sub-page fault_in_writable(point_of_failure, align) where 'align'
> > > should cover the copy_to_user() impreciseness.
> > >
> > > (of course, fault_in_writable() takes the full size argument but behind
> > > the scene it probes the 'align' prefix at sub-page fault granularity)
> >
> > That doesn't make sense; we don't want fault_in_writable() to fail or
> > succeed depending on the alignment of the address range passed to it.
>
> If we know that the arch copy_to_user() has an error of say maximum 16
> bytes (or 15 rather on arm64), we can instead get fault_in_writeable()
> to probe the first 16 bytes rather than 1.

That isn't going to help one bit: [raw_]copy_to_user() is allowed to
copy as little or as much as it wants as long as it follows the rules
documented in include/linux/uaccess.h:

[] If copying succeeds, the return value must be 0.  If some data cannot be
[] fetched, it is permitted to copy less than had been fetched; the only
[] hard requirement is that not storing anything at all (i.e. returning size)
[] should happen only when nothing could be copied.  In other words, you don't
[] have to squeeze as much as possible - it is allowed, but not necessary.

When fault_in_writeable() tells us that an address range is accessible
in principle, that doesn't mean that copy_to_user() will allow us to
access it in arbitrary chunks. It's also not the case that
fault_in_writeable(addr, size) is always followed by
copy_to_user(addr, ..., size) for the exact same address range, not
even in this case.

These alignment restrictions have nothing to do with page or sub-page faults.

I'm also fairly sure that passing in an unaligned buffer will send
search_ioctl into an endless loop on architectures with copy_to_user()
alignment restrictions; there don't seem to be any buffer alignment
checks.

> > Have a look at the below code to see what I mean.  Function
> > copy_to_user_nofault_unaligned() should be further optimized, maybe as
> > mm/maccess.c:copy_from_kernel_nofault() and/or per architecture
> > depending on the actual alignment rules; I'm not sure.
> [...]
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -2051,13 +2051,30 @@ static noinline int key_in_sk(struct btrfs_key *key,
> >       return 1;
> >  }
> >
> > +size_t copy_to_user_nofault_unaligned(void __user *to, void *from, size_t size)
> > +{
> > +     size_t rest = copy_to_user_nofault(to, from, size);
> > +
> > +     if (rest) {
> > +             size_t n;
> > +
> > +             for (n = size - rest; n < size; n++) {
> > +                     if (copy_to_user_nofault(to + n, from + n, 1))
> > +                             break;
> > +             }
> > +             rest = size - n;
> > +     }
> > +     return rest;
>
> That's what I was trying to avoid. That's basically a fall-back to byte
> at a time copy (we do this in copy_mount_options(); at some point we
> even had a copy_from_user_exact() IIRC).

We could try 8/4/2 byte chunks if both buffers are 8/4/2-byte aligned.
It's just not clear that it's worth it.

> Linus' idea (if I got it correctly) was instead to slightly extend the
> probing in fault_in_writeable() for the beginning of the buffer from 1
> byte to some per-arch range.
>
> I attempted the above here and works ok:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=devel/btrfs-live-lock-fix
>
> but too late to post it this evening, I'll do it in the next day or so
> as an alternative to this series.
>
> --
> Catalin
>

Thanks,
Andreas

