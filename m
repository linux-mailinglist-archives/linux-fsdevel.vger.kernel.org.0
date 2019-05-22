Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1FD925F8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 10:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfEVIcQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 04:32:16 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54105 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbfEVIcQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 04:32:16 -0400
Received: by mail-it1-f194.google.com with SMTP id m141so2176230ita.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 01:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KGwuyacZfR4OXC4z2/bF6wr7bYcoXFk+vCtqOI6dRKU=;
        b=KhWN6OliHE1tjLiwkjVa0VNqheJo67lS4fx/I6PUwUUMbY81HOCYRC77Y4goXgdMZq
         +uLyzrqywL/Q7UzsboUozgN/7prMrA1iGuDeYv5e8dGTcqWSNTlBU3/EMmG32IlEbkZV
         LNJiHjy0EExzRFh17TWPPcQvp3rt+tk4yLc0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KGwuyacZfR4OXC4z2/bF6wr7bYcoXFk+vCtqOI6dRKU=;
        b=YjkPkqjYNo4LlsD1WExL0R2tzhchPPD6FRQZJGYozG24fmocBCRSZGRbI6DJAQnqjA
         ///xqsC3tRzzVNjGgqgUPi1lqrkwR2Qb8THgM8QGEvIbB7DLT8FzA8EcELG0IpbZlDgf
         pSDIwmrd8Ad3vMLUHRKJFLuqm3dGy4P3vssYKWk7hfbgG22vD8jX0vUmfyBo6nHtvT8s
         +n0E/KtyhVQ4HWH+x68fbP/03O7h2gA4TBW2bpstobn9X+ZhTNLJScBviOk0/bJoYUyE
         73bR3VwoFxH0io4ELODNpDlKkycaEFQlYfYmYG167DugAGPoZX5PjChF7gKEN9cYl2lD
         xtLg==
X-Gm-Message-State: APjAAAVhpIt5IyE8X5eBJhDxn3BMX0gswUWkcXdgw5vr2ZLluaP0vPuF
        mwGOr8864f2jD1MFcHDJtcAOwW3y/3UsGV5kpJdHfw==
X-Google-Smtp-Source: APXvYqxweNYxM9V4spnqBJw8urA4f0gKh+9Vfwb37uPYgnMgGRuAMhzIhxBlMXU9wxfGhw4ED2j3WpCHHtd08TBGGc0=
X-Received: by 2002:a24:9d8b:: with SMTP id f133mr7819647itd.118.1558513935631;
 Wed, 22 May 2019 01:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com> <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
 <20190502131034.GA25007@mit.edu> <20190502132623.GU23075@ZenIV.linux.org.uk>
 <CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com>
 <CAOQ4uxhDYvBOLBkyYXRC6aS_me+Q=1sBAtzOSkdqbo+N-Rtx=Q@mail.gmail.com>
 <CAK8JDrGRzA+yphpuX+GQ0syRwF_p2Fora+roGCnYqB5E1eOmXA@mail.gmail.com>
 <CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com>
 <CAK8JDrEQnXTcCtAPkb+S4r4hORiKh_yX=0A0A=LYSVKUo_n4OA@mail.gmail.com> <CAJeUaNCvr=X-cc+B3rsunKcdC6yHSGGa4G+8X+n8OxGKHeE3zQ@mail.gmail.com>
In-Reply-To: <CAJeUaNCvr=X-cc+B3rsunKcdC6yHSGGa4G+8X+n8OxGKHeE3zQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 22 May 2019 10:32:03 +0200
Message-ID: <CAJfpegvmFJ63F2h_gFVPJeEgWS8UmxAYCUgA-4=j9iCNXaXARA@mail.gmail.com>
Subject: Re: Initial patches for Incremental FS
To:     Yurii Zubrytskyi <zyy@google.com>
Cc:     Eugene Zemtsov <ezemtsov@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 21, 2019 at 3:32 AM Yurii Zubrytskyi <zyy@google.com> wrote:
>
> On Thu, May 9, 2019 at 1:15 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > I think you have made the right choice for you and for the product you are
> > working on to use an isolated module to provide this functionality.
> >
> > But I assume the purpose of your posting was to request upstream inclusion,
> > community code review, etc. This is not likely to happen when the
> > implementation and design choices are derived from Employer needs vs.
> > the community needs. Sure, you can get high level design review, which is
> > what *this* is, but I recon not much more.
> >
> > This discussion has several references to community projects that can benefit
> > from this functionality, but not in its current form.
> >
> > This development model has worked well in the past for Android and the Android
> > user base leverage could help to get you a ticket to staging, but eventually,
> > those modules (e.g. ashmem) often do get replaced with more community oriented
> > APIs.
> >
>
> Hi fsdevel
> I'm Yurii, and I work with Eugene on the same team and the same project.
>
> I want to explain how we ended up with a custom filesystem instead of
> trying to improve FUSE for everyone, and
> why we think (maybe incorrectly) that it may be still pretty useful
> for the community.
> As the project goal was to allow instant (-ish) deployment of apps
> from the dev environment to Android phone, we were hoping to
> stick with plain FUSE filesystem, and that's what we've done at first.
> But it turned out that even with the best tuning it was still
> really slow and battery-hungry (phones spent energy faster than they
> were charging over the cord).
> At this point we've already collected the profiles for the filesystem
> usage, and also figured out what features are essential
> to make it usable for streaming:
> 1. Random reads are the most common -> 4kb-sized read is the size we
> have to support, and may not go to usermode on each of those
> 2. Android tends to list the app directory and stat files in it often
> -> these operations need to be cached in kernel as well
> 3. Because of *random* reads streaming files sequentially isn't
> optimal -> need to be able to collect read logs from first deployment
>     and stream in that order next time on incremental builds
> 4. Devices have small flash cards, need to deploy uncompressed game
> images for speed and mmap access ->
>     support storing 4kb blocks compressed
> 4.1. Host computer is much better at compression -> support streaming
> compressed blocks into the filesystem storage directly, without
>        recompression on the phone
> 5. Android has to verify app signature for installation -> need to
> support per-block signing and lazy verification
> 5.1. For big games even per-block signature data can be huge, so need
> to stream even the signatures
> 6. Development cycle is usually edit-build-try-edit-... -> need to
> support delta-patches from existing files
> 7. File names for installed apps are standard and different from what
> they were on the host ->
>     must be able to store user-supplied 'key' next to each file to identify it
> 8. Files never change -> no need to have complex code for mutable data
> in the filesystem
>
> In the end, we saw only two ways how to make all of this work: either
> take sdcardfs as a base and extend it, or change FUSE to
> support cache in kernel; and as you can imagine, sdcardfs route got
> thrown out of the window immediately after looking at the code.
> But after learning some FUSE internals and its code what we found out
> is that to make it do all the listed things we'd basically have
> to implement a totally new filesystem inside of it. The only real use
> of FUSE that remained was to send FUSE_INIT, and occasional
> read requests. Everything else required, first of all, making a cache
> object inside FUSE intercept every message before it goes to the
> user mode, and also adding new specialized commands initiated by the
> usermode (e.g. prefetching data that hasn't been requested
> yet, or streaming hashes in). Some things even didn't make sense for a
> generic usecase (e.g. having a limited circular buffer of read
> blocks in kernel that user can ask for and flush).

Hang on, fuse does use caches in the kernel (page cache,
dcache/icache).  The issue is probably not lack of cache, it's how the
caches are primed and used.  Did you disable these caches?  Did you
not disable invalidation for data, metadata and dcache?  In recent
kernels we added caching readdir as well.  The only objects not cached
are (non-acl) xattrs.   Do you have those?     Re prefetching data:
there's the NOTIFY_STORE message.

Thanks,
Miklos
