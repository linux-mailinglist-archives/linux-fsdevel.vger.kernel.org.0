Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DE327A158
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Sep 2020 16:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgI0OCW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Sep 2020 10:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgI0OCW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Sep 2020 10:02:22 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B23EC0613CE;
        Sun, 27 Sep 2020 07:02:22 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id c2so6996197otp.7;
        Sun, 27 Sep 2020 07:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ZC+LMO9yAE5IA1UKPoYNK24lDnc3Osi8zSYrlh4qZkM=;
        b=A+vClrFHzrT1BGbxlBLezL4k1n41U4VS4CJ7MbA3DNBA1kNoh0TEhZdw6lFA8TrRqJ
         X6K4oEVdEzRvIUyG5/M5rHZXkbjTOm++gVU2f4Ro4M04BlDISLhbQIkQmyFVNdJxauJz
         ZdfM0IdswgvWyQbJWhCHbPO2TLmpd1p94LYv4Cena6cUMmqCGz/t1wgu1HDFQCEH19OG
         aaeFEoEv9Rj4pTOkQgAjKPk8m8WPYMjyidQHY5GiyzrfFKi/N0df7jHHcPDftrC3ECdS
         W6ukK9hZ97uZESjKN+2ePHU4HCHaWre/cfxrUP4x5+cW3Ce7D4PcR999iruiB6E7v4ma
         A4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ZC+LMO9yAE5IA1UKPoYNK24lDnc3Osi8zSYrlh4qZkM=;
        b=VQ5jBU92BaP7MJzl4//dOhZTCsK/mSmY/Lpz36ahLItxaDZ79Wg9hDN1irgT/VTbXR
         1cEOxHLGurVAOmQiPblOQpWh11FSiLFmhiV14nMOZN3TgCOFS4PNoGqHhIYJRw0tnYg6
         EYdwm+VkWYpBbtAhntY22LsCauOTfcp309dp4skxS6P1jSVcwgWaBM+lGe9erK8NRwJw
         lGTBZWKTzevMYXuVRYmJo0c604XDZnQOa0epifUEcDEkaZz5sCvr+izifTQebNUyQyAx
         zapF4Rf0laWCstH4fzmTTFLE0qMQrW03epoQiBfWUPbbhWdLyUZTKl4hiNet7U/kMP14
         JhRg==
X-Gm-Message-State: AOAM530OikoUBTiYWPPo01qrHtsAEZ0dSZii66wD26p/6HHGdUOMp8LN
        1AFg0eFqymsus6rQuGa7MRMxZ0+lYNwOO+ioed/K/AUWLj+KUQ==
X-Google-Smtp-Source: ABdhPJx0T0svivHAMCCXOCTSHIe/yDC32GeGLP8GHlKdP/Qxvrtnq776vG/PumbitXkbDzC4C+z9UZOdYlS9CRJnqTc=
X-Received: by 2002:a05:6830:110b:: with SMTP id w11mr5757492otq.109.1601215341689;
 Sun, 27 Sep 2020 07:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUV3aL_7MptHbradtnd8P6X9VO-=Pi2gBezWaZXgeZFMpg@mail.gmail.com>
 <20200924235756.GD32101@casper.infradead.org> <CA+icZUWcx5hBjU35tfY=7KXin7cA5AAY8AMKx-pjYnLCsQywGw@mail.gmail.com>
 <CA+icZUWMs5Xz5vMP370uUBCqzgjq6Aqpy+krZMNg-5JRLxaALA@mail.gmail.com>
 <20200925134608.GE32101@casper.infradead.org> <CA+icZUV9tNMbTC+=MoKp3rGmhDeO9ScW7HC+WUTCCvSMpih7DA@mail.gmail.com>
 <20200925155340.GG32101@casper.infradead.org> <CA+icZUWmF_7P7r-qmxzR7oz36u_Wy5HA6fh5zFFZd1D-aZiwkQ@mail.gmail.com>
 <20200927120435.GC7714@casper.infradead.org> <CA+icZUWSHf9YbkuEYeG4azSrPt=GYu-MmHxj3+uGvxPW-HHjjQ@mail.gmail.com>
 <20200927135421.GD7714@casper.infradead.org>
In-Reply-To: <20200927135421.GD7714@casper.infradead.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 27 Sep 2020 16:02:10 +0200
Message-ID: <CA+icZUVnZ2KoG28G2Lw+gr5-Hg4keFHtzzJ2oyb1mYqEgp3M2Q@mail.gmail.com>
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

On Sun, Sep 27, 2020 at 3:54 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Sep 27, 2020 at 03:48:39PM +0200, Sedat Dilek wrote:
> > With your patch and assertion diff I hit the same issue like with Ext4-FS...
> >
> > [So Sep 27 15:40:18 2020] run fstests generic/095 at 2020-09-27 15:40:19
> > [So Sep 27 15:40:26 2020] XFS (sdb1): Mounting V5 Filesystem
> > [So Sep 27 15:40:26 2020] XFS (sdb1): Ending clean mount
> > [So Sep 27 15:40:26 2020] xfs filesystem being mounted at /mnt/scratch
> > supports timestamps until 2038 (0x7fffffff)
> > [So Sep 27 15:40:28 2020] Page cache invalidation failure on direct
> > I/O.  Possible data corruption due to collision with buffered I/O!
> > [So Sep 27 15:40:28 2020] File: /mnt/scratch/file1 PID: 12 Comm: kworker/0:1
> > [So Sep 27 15:40:29 2020] Page cache invalidation failure on direct
> > I/O.  Possible data corruption due to collision with buffered I/O!
> > [So Sep 27 15:40:29 2020] File: /mnt/scratch/file1 PID: 73 Comm: kworker/0:2
> > [So Sep 27 15:40:30 2020] Page cache invalidation failure on direct
> > I/O.  Possible data corruption due to collision with buffered I/O!
> > [So Sep 27 15:40:30 2020] File: /mnt/scratch/file2 PID: 12 Comm: kworker/0:1
> > [So Sep 27 15:40:30 2020] Page cache invalidation failure on direct
> > I/O.  Possible data corruption due to collision with buffered I/O!
> > [So Sep 27 15:40:30 2020] File: /mnt/scratch/file2 PID: 3271 Comm: fio
> > [So Sep 27 15:40:30 2020] Page cache invalidation failure on direct
> > I/O.  Possible data corruption due to collision with buffered I/O!
> > [So Sep 27 15:40:30 2020] File: /mnt/scratch/file2 PID: 3273 Comm: fio
> > [So Sep 27 15:40:31 2020] Page cache invalidation failure on direct
> > I/O.  Possible data corruption due to collision with buffered I/O!
> > [So Sep 27 15:40:31 2020] File: /mnt/scratch/file1 PID: 3308 Comm: fio
> > [So Sep 27 15:40:36 2020] Page cache invalidation failure on direct
> > I/O.  Possible data corruption due to collision with buffered I/O!
> > [So Sep 27 15:40:36 2020] File: /mnt/scratch/file1 PID: 73 Comm: kworker/0:2
> > [So Sep 27 15:40:43 2020] Page cache invalidation failure on direct
> > I/O.  Possible data corruption due to collision with buffered I/O!
> > [So Sep 27 15:40:43 2020] File: /mnt/scratch/file1 PID: 73 Comm: kworker/0:2
> > [So Sep 27 15:40:52 2020] Page cache invalidation failure on direct
> > I/O.  Possible data corruption due to collision with buffered I/O!
> > [So Sep 27 15:40:52 2020] File: /mnt/scratch/file2 PID: 73 Comm: kworker/0:2
> > [So Sep 27 15:40:56 2020] Page cache invalidation failure on direct
> > I/O.  Possible data corruption due to collision with buffered I/O!
> > [So Sep 27 15:40:56 2020] File: /mnt/scratch/file2 PID: 12 Comm: kworker/0:1
> >
> > Is that a different issue?
>
> The test is expected to emit those messages; userspace has done something
> so utterly bonkers (direct I/O to an mmaped, mlocked page) that we can't
> provide the normal guarantees of data integrity.

Thanks for the explanations.

Will run 25 iterations with your iomap patch and assertion-diff using
XFS and your MKFS_OPTIONS="-m reflink=1,rmapbt=1 -i sparse=1 -b
size=1024"...

$ sudo ./check -i 25 generic/095

...and report later.

- Sedat -
