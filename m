Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F85F27A19F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Sep 2020 17:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgI0PTu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Sep 2020 11:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0PTu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Sep 2020 11:19:50 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F00C0613CE;
        Sun, 27 Sep 2020 08:19:50 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 60so7145152otw.3;
        Sun, 27 Sep 2020 08:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=bVyHJ1WqJaco64wTAhvSr/X/1cmhmFXEMUJwpriFCpM=;
        b=R3aWreYfqBW6rUh5eXN2DL21YoiTrOqx5PDRWHvEnxiAG9u6PghdH13MEPoiZ+xzkr
         IQbszGD2P3wFktMs97uZ5L1Fw/SYcG1SW4ZmeNy9eONViaG72Jl4xqws/Dm5FF5VAoTL
         +MOgwMjOrY4cLGGeyLHenHr0+UPoFb9Pviva+oa1cnsLyjSGBzV79GD731kvsfwk4xtu
         phALG547Ky3NYSVP8AfUzJVY1uCAhFdPPwkgQbhqjdr4RT2q2KTrShAp4XPGmjbYdGrG
         bbp6kLC3ddoqDrBNcR0UvZmtp3U3VTBoKjz60wAytEhhCbg458Epfryn0z5zEAZSIxLX
         4AiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=bVyHJ1WqJaco64wTAhvSr/X/1cmhmFXEMUJwpriFCpM=;
        b=RH6QVA1dP/Mghoxx29VZn4yeaa98dgKesq6b3xwwctwh+B1Bef1CZyIM6grMfQ99Kt
         v1Q/x/XJg6kClf3G1tK6nWydAHEZ5eRbO/ZKRScN4y36FF/w6tNbDvW2DqR5PcN1C4x1
         0eKG9oYCX4IqCSjSS2kGz2J7eN2tJ7i6yGbcjA7CCXZGEn1pQhBJdvdTb3h6z5neTyrt
         32T4MFodtwklAVr2qsNeBU+jiBoODG1IsOEr5p/uPpeMTpbxCNTYFLc4SJN7au5xhyV/
         pecedDnC9SKXWwM8T5aSo5hHtyNfBgjBdkDJDuogNbNPx3NBcJdPCY82lj27ZAdCDTFA
         7l6A==
X-Gm-Message-State: AOAM532ooF1cRjaBDKn/ndSEnoIh+GgBAcIdRsc9H3kXkGft/RLLAwiO
        7JrXrjaWoH9o8QCwjEGEB3VskQKYDprCbPiwbRkiIJqVB3Q=
X-Google-Smtp-Source: ABdhPJwojeeQHjzJ9jC3tJdoiSwLrTCf6KpPWyqyxj2CITdfSgOS0+KbKQBua4PPcEb+wufhbxJ5BWNP5ZudOJe4OTI=
X-Received: by 2002:a05:6830:13da:: with SMTP id e26mr6597714otq.28.1601219989545;
 Sun, 27 Sep 2020 08:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUV3aL_7MptHbradtnd8P6X9VO-=Pi2gBezWaZXgeZFMpg@mail.gmail.com>
 <20200924235756.GD32101@casper.infradead.org> <CA+icZUWcx5hBjU35tfY=7KXin7cA5AAY8AMKx-pjYnLCsQywGw@mail.gmail.com>
 <CA+icZUWMs5Xz5vMP370uUBCqzgjq6Aqpy+krZMNg-5JRLxaALA@mail.gmail.com>
 <20200925134608.GE32101@casper.infradead.org> <CA+icZUV9tNMbTC+=MoKp3rGmhDeO9ScW7HC+WUTCCvSMpih7DA@mail.gmail.com>
 <20200925155340.GG32101@casper.infradead.org> <CA+icZUWmF_7P7r-qmxzR7oz36u_Wy5HA6fh5zFFZd1D-aZiwkQ@mail.gmail.com>
 <20200927120435.GC7714@casper.infradead.org> <CA+icZUWSHf9YbkuEYeG4azSrPt=GYu-MmHxj3+uGvxPW-HHjjQ@mail.gmail.com>
 <20200927135421.GD7714@casper.infradead.org> <CA+icZUVnZ2KoG28G2Lw+gr5-Hg4keFHtzzJ2oyb1mYqEgp3M2Q@mail.gmail.com>
In-Reply-To: <CA+icZUVnZ2KoG28G2Lw+gr5-Hg4keFHtzzJ2oyb1mYqEgp3M2Q@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 27 Sep 2020 17:19:37 +0200
Message-ID: <CA+icZUVrvvneFi+3ihL0+UBs9NjTHXaVWDDJwgwnYy=JE7NQ1w@mail.gmail.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qian Cai <cai@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 27, 2020 at 4:02 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sun, Sep 27, 2020 at 3:54 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sun, Sep 27, 2020 at 03:48:39PM +0200, Sedat Dilek wrote:
> > > With your patch and assertion diff I hit the same issue like with Ext4-FS...
> > >
> > > [So Sep 27 15:40:18 2020] run fstests generic/095 at 2020-09-27 15:40:19
> > > [So Sep 27 15:40:26 2020] XFS (sdb1): Mounting V5 Filesystem
> > > [So Sep 27 15:40:26 2020] XFS (sdb1): Ending clean mount
> > > [So Sep 27 15:40:26 2020] xfs filesystem being mounted at /mnt/scratch
> > > supports timestamps until 2038 (0x7fffffff)
> > > [So Sep 27 15:40:28 2020] Page cache invalidation failure on direct
> > > I/O.  Possible data corruption due to collision with buffered I/O!
> > > [So Sep 27 15:40:28 2020] File: /mnt/scratch/file1 PID: 12 Comm: kworker/0:1
> > > [So Sep 27 15:40:29 2020] Page cache invalidation failure on direct
> > > I/O.  Possible data corruption due to collision with buffered I/O!
> > > [So Sep 27 15:40:29 2020] File: /mnt/scratch/file1 PID: 73 Comm: kworker/0:2
> > > [So Sep 27 15:40:30 2020] Page cache invalidation failure on direct
> > > I/O.  Possible data corruption due to collision with buffered I/O!
> > > [So Sep 27 15:40:30 2020] File: /mnt/scratch/file2 PID: 12 Comm: kworker/0:1
> > > [So Sep 27 15:40:30 2020] Page cache invalidation failure on direct
> > > I/O.  Possible data corruption due to collision with buffered I/O!
> > > [So Sep 27 15:40:30 2020] File: /mnt/scratch/file2 PID: 3271 Comm: fio
> > > [So Sep 27 15:40:30 2020] Page cache invalidation failure on direct
> > > I/O.  Possible data corruption due to collision with buffered I/O!
> > > [So Sep 27 15:40:30 2020] File: /mnt/scratch/file2 PID: 3273 Comm: fio
> > > [So Sep 27 15:40:31 2020] Page cache invalidation failure on direct
> > > I/O.  Possible data corruption due to collision with buffered I/O!
> > > [So Sep 27 15:40:31 2020] File: /mnt/scratch/file1 PID: 3308 Comm: fio
> > > [So Sep 27 15:40:36 2020] Page cache invalidation failure on direct
> > > I/O.  Possible data corruption due to collision with buffered I/O!
> > > [So Sep 27 15:40:36 2020] File: /mnt/scratch/file1 PID: 73 Comm: kworker/0:2
> > > [So Sep 27 15:40:43 2020] Page cache invalidation failure on direct
> > > I/O.  Possible data corruption due to collision with buffered I/O!
> > > [So Sep 27 15:40:43 2020] File: /mnt/scratch/file1 PID: 73 Comm: kworker/0:2
> > > [So Sep 27 15:40:52 2020] Page cache invalidation failure on direct
> > > I/O.  Possible data corruption due to collision with buffered I/O!
> > > [So Sep 27 15:40:52 2020] File: /mnt/scratch/file2 PID: 73 Comm: kworker/0:2
> > > [So Sep 27 15:40:56 2020] Page cache invalidation failure on direct
> > > I/O.  Possible data corruption due to collision with buffered I/O!
> > > [So Sep 27 15:40:56 2020] File: /mnt/scratch/file2 PID: 12 Comm: kworker/0:1
> > >
> > > Is that a different issue?
> >
> > The test is expected to emit those messages; userspace has done something
> > so utterly bonkers (direct I/O to an mmaped, mlocked page) that we can't
> > provide the normal guarantees of data integrity.
>
> Thanks for the explanations.
>
> Will run 25 iterations with your iomap patch and assertion-diff using
> XFS and your MKFS_OPTIONS="-m reflink=1,rmapbt=1 -i sparse=1 -b
> size=1024"...
>
> $ sudo ./check -i 25 generic/095
>
> ...and report later.
>

Hi Matthew,

After one hour all 25 iterations passed fine - no issues.

If you send a patch for Linux v5.9 feel free to add my...

     Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

Thanks for your patience and all the background information.

Regards,
- Sedat -
