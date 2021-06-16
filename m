Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816023A971A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 12:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhFPKWn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 06:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhFPKWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:22:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04990C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 03:20:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id z26so1828961pfj.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 03:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zugj66qP6/9cvxf00sWAzaxFnaPr9yghFoXot2unGiM=;
        b=Ix12m1P9tbaO8m1YoaSPm7lpddgXfHstpXgsxH7NLWXjq6rByi02w7ikzuRs6hR0IF
         DaP2CQnxZ7khjZjwcWOmfRyi5RMExTWJ0uslJq6vYMGZda9DYiDs9tLzYyW1Dwk5ZjdM
         ENW4ioSV2CPTrN3V3mldm+oEBEvbEeLAj+qv/L04aZvP1SLxPeJUZpWl+haWLyZVMDdR
         yyWAw3VJdXxdXVm5mIK5YPWTFBUEERZETcxpDUT/B/rFGNOrD4nPjj0sgZoppwfwkE5j
         WcZj+BHb/Ukuxii1k0z28bhCa7lSQx41ria+7yvCBZEE2ByiRC9DbHluIZ7vVzk3T4eq
         kSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zugj66qP6/9cvxf00sWAzaxFnaPr9yghFoXot2unGiM=;
        b=Nx+8irlEvcq/6VHYwu4IHrfnZADaV+A5IG7so9x7/D6sj0mfcmPywzNUbJBeRrIWts
         iHvCo9axnXw3lVyPsASNYinGaKQ/fMs++zvpsylCJriRKbibAjTQsaP7+vGtnJFIriKa
         gL546aWDVVZ40xSQhQxL5vJE306i2ymJJO85NjbS451Qf+6RBhUv3wWbGcEHKPiDNFvg
         g2V4MTfCgu/vddy4fnhlMTrw7MyS6o1klUhFG6m83qcnsRXmBZzI0n5hdmEoSkJwjgbT
         gxjW32QEjuCMQFCORNs2BwXZpAUmwNiOSFw7WybJ5cZp4fD3Jo/1LPViG6YneJttnq59
         IENQ==
X-Gm-Message-State: AOAM531YlvXFWnMbEspk4rUufXlmTF99N305idmuD2OJs8BAc/AOyHVp
        WTXgJ+YM3wnAnSdtWfQ/Ej6qdhftNnmT3mFlk60=
X-Google-Smtp-Source: ABdhPJx3yvRY0hiZae+pbmH/Ktyeapy4QgPfVwAXV9xzVcTZMrn79OT0SI5ZzcXfY2ecuzzPhWj+iJE/Vf1bhLLhpD4=
X-Received: by 2002:a65:6481:: with SMTP id e1mr4210774pgv.140.1623838825455;
 Wed, 16 Jun 2021 03:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <1622537906-54361-1-git-send-email-tao.peng@linux.alibaba.com>
 <YLeoucLiMOSPwn4U@google.com> <244309bf-4f2e-342e-dd98-755862c643b8@metux.net>
 <CA+a=Yy5moy0Bv=mhsrC9FrY+cEYt8+YJL8TvXQ=N7pNyktccRQ@mail.gmail.com>
 <429fc51b-ece0-b5cb-9540-2e7f5b472d73@metux.net> <CA+a=Yy6k3k2iFb+tBMuBDMs8E8SsBKce9Q=3C2zXTrx3-B7Ztg@mail.gmail.com>
 <295cfc39-a820-3167-1096-d8758074452d@metux.net> <CA+a=Yy7DDrMs6R8qRF6JMco0VOBWCKNoX7E-ga9W2Omn=+QUrQ@mail.gmail.com>
 <e70a444e-4716-1020-4afa-fec6799e4a10@metux.net>
In-Reply-To: <e70a444e-4716-1020-4afa-fec6799e4a10@metux.net>
From:   Peng Tao <bergwolf@gmail.com>
Date:   Wed, 16 Jun 2021 18:20:13 +0800
Message-ID: <CA+a=Yy4iyMNK=8KxZ2PvB+zs8fbYNchEOyjcreWx4NEYopbtAg@mail.gmail.com>
Subject: Re: [PATCH RFC] fuse: add generic file store
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Alessio Balsini <balsini@android.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 2:53 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 11.06.21 14:46, Peng Tao wrote:
>
> >>
> >> * it just stores fd's I don't see anything where it is actually returned
> >>     to some open() operation.
> > The FUSE_DEV_IOC_RESTORE_FD ioctl returns the opened fd to a different process.
>
> So, just open() a file on a fuse fs can't restore the fd directly
> (instead of opening a new file) ? If that's the case, that would mean,
> userland has to take very special actions in order to get it. Right ?
Yes.

>
> >> * the store is machine wide global - everybody uses the same number
> >>     space, dont see any kind of access conrol ... how about security ?
> >>
> > The idea is that anyone capable of opening /dev/fuse can retrieve the FD.
> >
> >> I don't believe that just storing the fd's somewhere is really helpful
> >> for that purpose - the fuse server shall be able to reply the open()
> >> request with an fd, which then is directly transferred to the client.
> >>
> > Could you describe your use case a bit? How does your client talk to
> > your server? Through open syscall or through some process-to-process
> > RPC calls?
>
> I'd like to write synthetic file systems (file servers) that allows
> certain unprivileged processes (in some confined environment) directly
> open()ing prepared file descriptors (e.g. devices, sockets, etc) that it
> isn't allowed to open directly (but the server obviously is). Those fds
> could be prepared in any ways (eg. sealed, seek'ed, already connected
> sockets, etc).
>
> The client thinks it just open()'s a normal file, but actually gets some
> fd prepared elsewhere.
>
Oh, nop, that is not how the current RFC works. I see two gaps:
1. /dev/fuse is not accessible to all processes by default
2. open() syscall doesn't take enough arguments to tell the kernel
which file's fd it wants.

It seems that a proper solution to your use case is to:
1. extend the open() syscall to take a flag like FOPEN_FUSE_OPEN_FD (I
agree it's a bad name;)
2. FUSE kernel passes such a flag to fuse daemon
3. FUSE userspace daemon opens the file in the underlying file system,
store it to a kernel FD store, then return its IDR in the reply to
FUSE_OPEN API
4. FUSE kernel looks up underlying FD with the IDR, install it in the
calling process FD table, and return the new FD to the application

Is it what you want? It looks doable and is indeed an extension to the
current RFC.

Cheers,
Tao
-- 
Into Sth. Rich & Strange
