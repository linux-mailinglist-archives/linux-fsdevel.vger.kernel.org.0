Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2628445E2FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 23:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhKYWbV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 17:31:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31175 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238595AbhKYW3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 17:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637879168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xvc3zGd9A6N70PYavs8v14MUAysdA26AzLBZjQY97Rk=;
        b=DizmRzrcpPWVJgwAmstknBe1rOUoMGSCVPk7sPRAzDR8Y3g7yNbH2DOuYbt/KYBr3uS+fS
        HvCu6M5yjMteU3Sr6ZewZD3qJdiem+Ru//EL9JzWlhGT6T1pzGSlARzoRqP0QZqsNYTngw
        sHn8eL8ETbT0QtnYPp+9Qz0b7wjUKwg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-431-G5R1cdnHNqmKp8uc1rn9TQ-1; Thu, 25 Nov 2021 17:26:07 -0500
X-MC-Unique: G5R1cdnHNqmKp8uc1rn9TQ-1
Received: by mail-wm1-f71.google.com with SMTP id p12-20020a05600c1d8c00b0033a22e48203so4205778wms.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Nov 2021 14:26:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xvc3zGd9A6N70PYavs8v14MUAysdA26AzLBZjQY97Rk=;
        b=ZkAzaghqtoh67dLYFK1Ezq/alI6Ee5OcxKgLTqWG5LSplWJOiDUEAAMhxeroEERqIx
         sB79NsVLyj7krkS+dPkNP3HBYKEZ/aGdjJDBBdAT15DbCZxzHDrSyOBdCxaWEWs85Amb
         fI120hCpbtNoiUDRPJdmdyPMkXWnv04pbTukBdPV/CWCddHe55vRhyhALkQfd38xt+qz
         ZR+DjX9STqx36PJ+2VZrKMCZ/Ar/Bw6EnEswljpQgSLxaS6XTfiKdhEkFD7oQyLMb+/z
         yPMWaLx53MH3tNq32xceebSTh+nbfH+blrifaM6QeGptD+tN/NQLVYdzEF1J2TftWRbd
         ji4w==
X-Gm-Message-State: AOAM530frdtQQqFRFMSPOgi2SD5lPDbhX4noxQhQqaTeujkYCrsIRlOQ
        POrvY8ocmSNdvFykuPUrEXnmuiQRtZptaSA1k83L0+KHISn1yxnKUycX34H5q1R0aovcZDsC0x8
        zuZVuw5qkrzqoCxeuRzFts9x/DvSbAEN8xpsApWREIw==
X-Received: by 2002:a05:600c:1e26:: with SMTP id ay38mr11666948wmb.14.1637879166224;
        Thu, 25 Nov 2021 14:26:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzElpyiHqN8B087XvNvMwsaHt66EKeeavNDF+WupxZtaSvqoI5p05EFSHOWJtK1OxGhKffrbgeZ8zsd0CVGku8=
X-Received: by 2002:a05:600c:1e26:: with SMTP id ay38mr11666928wmb.14.1637879166053;
 Thu, 25 Nov 2021 14:26:06 -0800 (PST)
MIME-Version: 1.0
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com> <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <YZ6idVy3zqQC4atv@arm.com>
In-Reply-To: <YZ6idVy3zqQC4atv@arm.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 25 Nov 2021 23:25:54 +0100
Message-ID: <CAHc6FU4-P9sVexcNt5CDQxROtMAo=kH8hEu==AAhZ_+Zv53=Ag@mail.gmail.com>
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

On Wed, Nov 24, 2021 at 9:37 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Nov 24, 2021 at 08:03:58PM +0000, Matthew Wilcox wrote:
> > On Wed, Nov 24, 2021 at 07:20:24PM +0000, Catalin Marinas wrote:
> > > +++ b/fs/btrfs/ioctl.c
> > > @@ -2223,7 +2223,8 @@ static noinline int search_ioctl(struct inode *inode,
> > >
> > >     while (1) {
> > >             ret = -EFAULT;
> > > -           if (fault_in_writeable(ubuf + sk_offset, *buf_size - sk_offset))
> > > +           if (fault_in_exact_writeable(ubuf + sk_offset,
> > > +                                        *buf_size - sk_offset))
> > >                     break;
> > >
> > >             ret = btrfs_search_forward(root, &key, path, sk->min_transid);
> >
> > Couldn't we avoid all of this nastiness by doing ...
>
> I had a similar attempt initially but I concluded that it doesn't work:
>
> https://lore.kernel.org/r/YS40qqmXL7CMFLGq@arm.com
>
> > @@ -2121,10 +2121,9 @@ static noinline int copy_to_sk(struct btrfs_path *path,
> >                  * problem. Otherwise we'll fault and then copy the buffer in
> >                  * properly this next time through
> >                  */
> > -               if (copy_to_user_nofault(ubuf + *sk_offset, &sh, sizeof(sh))) {
> > -                       ret = 0;
> > +               ret = __copy_to_user_nofault(ubuf + *sk_offset, &sh, sizeof(sh));
> > +               if (ret)
>
> There is no requirement for the arch implementation to be exact and copy
> the maximum number of bytes possible. It can fail early while there are
> still some bytes left that would not fault. The only requirement is that
> if it is restarted from where it faulted, it makes some progress (on
> arm64 there is one extra byte).
>
> >                         goto out;
> > -               }
> >
> >                 *sk_offset += sizeof(sh);
> > @@ -2196,6 +2195,7 @@ static noinline int search_ioctl(struct inode *inode,
> >         int ret;
> >         int num_found = 0;
> >         unsigned long sk_offset = 0;
> > +       unsigned long next_offset = 0;
> >
> >         if (*buf_size < sizeof(struct btrfs_ioctl_search_header)) {
> >                 *buf_size = sizeof(struct btrfs_ioctl_search_header);
> > @@ -2223,7 +2223,8 @@ static noinline int search_ioctl(struct inode *inode,
> >
> >         while (1) {
> >                 ret = -EFAULT;
> > -               if (fault_in_writeable(ubuf + sk_offset, *buf_size - sk_offset))
> > +               if (fault_in_writeable(ubuf + sk_offset + next_offset,
> > +                                       *buf_size - sk_offset - next_offset))
> >                         break;
> >
> >                 ret = btrfs_search_forward(root, &key, path, sk->min_transid);
> > @@ -2235,11 +2236,12 @@ static noinline int search_ioctl(struct inode *inode,
> >                 ret = copy_to_sk(path, &key, sk, buf_size, ubuf,
> >                                  &sk_offset, &num_found);
> >                 btrfs_release_path(path);
> > -               if (ret)
> > +               if (ret > 0)
> > +                       next_offset = ret;
>
> So after this point, ubuf+sk_offset+next_offset is writeable by
> fault_in_writable(). If copy_to_user() was attempted on
> ubuf+sk_offset+next_offset, all would be fine, but copy_to_sk() restarts
> the copy from ubuf+sk_offset, so it returns exacting the same ret as in
> the previous iteration.

So this means that after a short copy_to_user_nofault(), copy_to_sk()
needs to figure out the actual point of failure. We'll have the same
problem elsewhere, so this should probably be a generic helper. The
alignment hacks are arch specific, so maybe we can have a generic
version that assumes no alignment restrictions, with arch-specific
overrides.

Once we know the exact point of failure, a
fault_in_writeable(point_of_failure, 1) in search_ioctl() will tell if
the failure is pertinent. Once we know that the failure isn't
pertinent, we're safe to retry the original fault_in_writeable().

Thanks,
Andreas

