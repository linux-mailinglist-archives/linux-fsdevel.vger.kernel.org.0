Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6446B3FD630
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 11:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243410AbhIAJIu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 05:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50583 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243401AbhIAJIt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 05:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630487272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pC5DFZzc9UewsBvUzJjXQABLpwkycaRX2qmvMdvRQvg=;
        b=RI15EVFEjUgWbkqwtdyNbBu9F8gxydws/cFpnA7nK12tnoEckrz7c4BgWk8YVHM464dQ7o
        buF2cjsrKh/6I5eUD2NMLwQt7eOSYYCzgPtZA0SJBTQAIu2IIvs6KbawwFPkJ/ZYaRKrDa
        uBZDBn9/GN42s7urRmI69w37VPcTqG8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-nK70RbnZNYK_X3ugeA7EWA-1; Wed, 01 Sep 2021 05:07:51 -0400
X-MC-Unique: nK70RbnZNYK_X3ugeA7EWA-1
Received: by mail-lf1-f71.google.com with SMTP id v137-20020a19488f000000b003e39263a61bso804076lfa.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Sep 2021 02:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pC5DFZzc9UewsBvUzJjXQABLpwkycaRX2qmvMdvRQvg=;
        b=sD20W85CcLdXGaWqkg65c8C4tw+dTlDtGTD2mNW6hyP1HoCfnelulHNL6WeGor/s/P
         Siu3QlshUUkcvj0nMmzIa6lqJ4hIHKQxZRthbYs6jKrNvRMiXbJrgXzMY9xenyLThuWM
         AkL2ViBRbXczPvSKgBXM3HuAgMPKZJ74FrX8rpHjVe4MciCAgXpnhYDlc1WT6Vjd6I3L
         ZDAYP2cqZo/KsKBZtGn/e26i49CFVBTE6mQU3gorZ1oqfvwRjnpAZu5eNB6AaoRlg+tV
         2GtooFu0aS9I3FwvPwh308WUpnWR93wqtt9ZaMDP9iQrQHemCfn6hhxZIrZQsl4xB4vp
         1wiQ==
X-Gm-Message-State: AOAM530z7gHN+c1MWY5nLIxoSnSVmTg881TEY1eI80+ixuK8rpYSuYSX
        4nJMXPAsAAzMj+849rMBq6O5qstfC8xc1GlrsbFbubBICaSV/79sIPitzOVVFkn2n49tTdIAggG
        +3lhs38u6K/QwaNJQoMJ+FWqNseIDCB0K6brz+GdAfw==
X-Received: by 2002:ac2:5f99:: with SMTP id r25mr24899366lfe.119.1630487269827;
        Wed, 01 Sep 2021 02:07:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCjlIr93XXbKArF0PJ73dglUAoKTqvfHM73COi+OYKKLISM5JVJXEYtGbt4lUK6eOmo4eqSWzqXe6z3Flhvvc=
X-Received: by 2002:ac2:5f99:: with SMTP id r25mr24899355lfe.119.1630487269593;
 Wed, 01 Sep 2021 02:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210825051710.GA5358@xsang-OptiPlex-9020> <cf358b73cbda90fd6c023f3a59a8df94698cf0bc.camel@kernel.org>
 <20210901030357.GD14661@xsang-OptiPlex-9020>
In-Reply-To: <20210901030357.GD14661@xsang-OptiPlex-9020>
From:   Murphy Zhou <xzhou@redhat.com>
Date:   Wed, 1 Sep 2021 17:07:38 +0800
Message-ID: <CALWRkkhxg7pyL7yagJzdBarfkEc70q8te-xy2-LAAqrJu3Lw+w@mail.gmail.com>
Subject: Re: [LTP] [fs] f7e33bdbd6: ltp.ftruncate04_64.fail
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Jeff Layton <jlayton@kernel.org>, lkp@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>, ltp@lists.linux.it,
        lkp@intel.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In my test, CONFIG_MANDATORY_FILE_LOCKING is not set.

# mount(NULL, MNTPOINT, NULL, MS_REMOUNT|MS_MANDLOCK, NULL);

But the mount call in setup() returns 0, with setting errno to EFAULT.

This testcase needs some tweaking to have an accurate verdict about manlock.

The kernel return value for mount looks buggy too.

On Wed, Sep 1, 2021 at 10:46 AM Oliver Sang <oliver.sang@intel.com> wrote:
>
> Hi Jeff,
>
> On Wed, Aug 25, 2021 at 06:32:38AM -0400, Jeff Layton wrote:
> > On Wed, 2021-08-25 at 13:17 +0800, kernel test robot wrote:
> > >
> > > Greeting,
> > >
> > > FYI, we noticed the following commit (built with gcc-9):
> > >
> > > commit: f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3 ("fs: remove mandatory file locking support")
> > > https://git.kernel.org/cgit/linux/kernel/git/jlayton/linux.git locks-next
> > >
> > >
> > > in testcase: ltp
> > > version: ltp-x86_64-14c1f76-1_20210821
> > > with following parameters:
> > >
> > >     disk: 1HDD
> > >     fs: ext4
> > >     test: syscalls-07
> > >     ucode: 0xe2
> > >
> > > test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> > > test-url: http://linux-test-project.github.io/
> > >
> > >
> > > on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
> > >
> > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > >
> > >
> > >
> >
> > [...]
> >
> > > <<<test_start>>>
> > > tag=ftruncate04_64 stime=1629792639
> > > cmdline="ftruncate04_64"
> > > contacts=""
> > > analysis=exit
> > > <<<test_output>>>
> > > tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
> > > tst_test.c:916: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> > > mke2fs 1.44.5 (15-Dec-2018)
> > > tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
> > > ftruncate04.c:116: TINFO: Child locks file
> > > ftruncate04.c:49: TFAIL: ftruncate() offset before lock succeeded unexpectedly
> > > ftruncate04.c:49: TFAIL: ftruncate() offset in lock succeeded unexpectedly
> > > ftruncate04.c:84: TPASS: ftruncate() offset after lock succeded
> > > ftruncate04.c:127: TINFO: Child unlocks file
> > > ftruncate04.c:84: TPASS: ftruncate() offset in lock succeded
> > > ftruncate04.c:84: TPASS: ftruncate() offset before lock succeded
> > > ftruncate04.c:84: TPASS: ftruncate() offset after lock succeded
> > >
> > > Summary:
> > > passed   4
> > > failed   2
> > > broken   0
> > > skipped  0
> > > warnings 0
> >
> > I think this failed because of the above, which is expected now that we
> > ignore the "mand" mount option (and mandatory locking support is gone).
> >
> > Oliver, you may need to update the expected test output for this test.
>
> Thanks for the information! we will do the corresponding change ASAP
>
> >
> > Thanks,
> > --
> > Jeff Layton <jlayton@kernel.org>
> >
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>

