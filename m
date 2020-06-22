Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697E1202FCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 08:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgFVGhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 02:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgFVGhr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 02:37:47 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E7FC061794
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2020 23:37:47 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y5so18163931iob.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2020 23:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=df+V+gsHVZZlfJaulEQ1Oh5nR/4WdLuTcsk0Vdms43Y=;
        b=EJvmdcv2VIOdcgAKYjPJbTK5mIX0J2PujTJrYPES0kz90UOhfkM89JllNzKUEV0Rbg
         duw5VlgRfLTh/E6ezn70i/hfTIn4Mg1va160BammJk4iRcHnwVGLWi3pidOTTRXBod67
         PEQuq8hQEPCBNeQUlf4MW3yOYbRdWYb/p8VSl644AWr/c8LGiY0LEYUochTfsaLbdUmu
         OafjKVcvpEfYjlijJwmEwoMnT/Pq2X+AAWSFeUKyCWy6B21MNKpU6v2H1JbtZMv9P1NR
         aVeLVpgax0lk4LNm0fjkKWRJ7GCi0q9FPsBkBBfZVvFN+atabHoazNwLbrJxW8kb7t12
         Vk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=df+V+gsHVZZlfJaulEQ1Oh5nR/4WdLuTcsk0Vdms43Y=;
        b=RwEmVQ3/8eYUHkehefOYZReXzigOh2DqvetryEIY2XHxLXBV0qHLjOHzAWjqvq10WC
         trupHI36aSR6Z5wvo2orQ9uMid+HJQTskTfXrIEJUSX1L1TEjnorVlc7yv2C7L3qkyhx
         vny0zoaWGxEk//dLbpa1PrRJ+tTSZfairKUK93KjgylvJ8/h8ZhxOAYxO52RbQ+rWc6S
         lbWcDVIYr7Z6qrFEBsfh5vAaq3ESXmAa8AUUoU3RjNm19xlp4vbsLzRgkL4PshaehkYP
         oOwxzj4744SRU0GvoZ5jm6geUbKh+ue1jEp4ZUAYvjX/QPiK+lewsjFm2CZfFGmfoyRY
         0bdA==
X-Gm-Message-State: AOAM532CtSoY+sda7niGIU+KhtbgWYfYxxqnAtnBkCgzOMK8uixOZ8q8
        H9zqUqjFsDekzd0kDMyIzyjb/GQyXE/44OOb7Mo=
X-Google-Smtp-Source: ABdhPJxCW8HlmypD8xNcLajB5gknM9yHtgTKTLM3H6LRc9eLRdmzj9iaiHuFYRq5XyoxKjAhGuVbfTZN5TZoX8uw8sQ=
X-Received: by 2002:a05:6638:a0a:: with SMTP id 10mr16547706jan.30.1592807867146;
 Sun, 21 Jun 2020 23:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAMHtQmP_TVR8QA+noWQk04Nj_8AxMXfjCj1K_k0Zf6BN-Bq9sg@mail.gmail.com>
 <87bllhh7mg.fsf@vostro.rath.org> <CAMHtQmPcADq0WSAY=uFFyRgAeuCCAo=8dOHg37304at1SRjGBg@mail.gmail.com>
 <877dw0g0wn.fsf@vostro.rath.org> <CAJfpegs3xthDEuhx_vHUtjJ7BAbVfoDu9voNPPAqJo4G3BBYZQ@mail.gmail.com>
 <87sgensmsk.fsf@vostro.rath.org>
In-Reply-To: <87sgensmsk.fsf@vostro.rath.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 22 Jun 2020 09:37:35 +0300
Message-ID: <CAOQ4uxiYG3Z9rnXB6F+fnRtoV1e3k=WP5-mgphgkKsWw+jUK=Q@mail.gmail.com>
Subject: Re: [fuse-devel] 512 byte aligned write + O_DIRECT for xfstests
To:     fuse-devel <fuse-devel@lists.sourceforge.net>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[+CC fsdevel folks]

On Mon, Jun 22, 2020 at 8:33 AM Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> On Jun 21 2020, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >> I am not sure that is correct. At step 6, the write() request from
> >> userspace is still being processed. I don't think that it is reasonable
> >> to expect that the write() request is atomic, i.e. you can't expect to
> >> see none or all of the data that is *currently being written*.
> >
> > Apparently the standard is quite clear on this:
> >
> >   "All of the following functions shall be atomic with respect to each
> > other in the effects specified in POSIX.1-2017 when they operate on
> > regular files or symbolic links:
> >
> > [...]
> > pread()
> > read()
> > readv()
> > pwrite()
> > write()
> > writev()
> > [...]
> >
> > If two threads each call one of these functions, each call shall
> > either see all of the specified effects of the other call, or none of
> > them."[1]
> >
> > Thanks,
> > Miklos
> >
> > [1]
> > https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_09_07
>
> Thanks for digging this up, I did not know about this.
>
> That leaves FUSE in a rather uncomfortable place though, doesn't it?
> What does the kernel do when userspace issues a write request that's
> bigger than FUSE userspace pipe? It sounds like either the request must
> be splitted (so it becomes non-atomic), or you'd have to return a short
> write (which IIRC is not supposed to happen for local filesystems).
>

What makes you say that short writes are not supposed to happen?
and what is the definition of "local filesystem" in that claim?

FYI, a similar discussion is also happening about XFS "atomic rw" behavior [1].

Seems like the options for FUSE are:
- Take shared i_rwsem lock on read like XFS and regress performance of
  mixed rw workload
- Do the above only for non-direct and writeback_cache to minimize the
  damage potential
- Return short read/write for direct IO if request is bigger that FUSE
buffer size
- Add a FUSE mode that implements direct IO internally as something like
  RWF_UNCACHED [2] - this is a relaxed version of "no caching" in client or
  a stricter version of "cache write-through"  in the sense that
during an ongoing
  large write operation, read of those fresh written bytes only is served
  from the client cache copy and not from the server.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20200622010234.GD2040@dread.disaster.area/
[2] https://lore.kernel.org/linux-fsdevel/20191217143948.26380-1-axboe@kernel.dk/
