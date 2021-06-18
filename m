Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8823AC0C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 04:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhFRCY7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 22:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhFRCY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 22:24:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCADC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 19:22:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id df12so3961597edb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 19:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5MrKqcoUD2bFgMHKKi9UvPEcBdyK3/kttZuW4uAAXbI=;
        b=mPM63ot7vyPElLGPC+fpfKkYCNIUqmOyWIJZCEl03dWhPYe69UO0LGUww7EJGrTBRT
         jxe4+fPVMsEVzGLeYvbDF5SHUI8/cNPGnfEr4LTv1WEPG/zXYA8GnuUwgBZMKHV/pVp4
         +4Kcsc8hNniL8Ss+vGGDHrB+ATewk0dwUq+qCP8EuOMY6zPfolhCy0VnYL3ojmownklD
         YR+6FumEUoVfWco0XKeLgj77ic3gJK5fJLIpb8SnfIpNqA9qkBdLCpjd2MbUmTE/0afM
         MldH78mgKQVlbLZ0/1mOF3GndnnF8LgctRC380zqvvwktZDVvnRXl60zIUspP5v/ZPr2
         txUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5MrKqcoUD2bFgMHKKi9UvPEcBdyK3/kttZuW4uAAXbI=;
        b=cmujmXDgv5+Tsnm9t+2mcSOzgGt1jqTzf+EtlikuHc+4fxTjZAEz81IPzRA30ENxtc
         l8b+wyF9lElXY0ZFBqt2pVYrBqWTf9ZiyKdmz8Ew73byFSHNS00R05qll3UxSh7A3Wcl
         F9rujElMEq3RUlPlA1sVKwR4fojweOWajtvt84POt0ZhOe9c9Ji+P+srTwm6lBjY+sLg
         2ikhiHh4hv9LvO55m1BkfZwtIWJZx35om/25u4JBHDYph6yZfJevzl0FHHjaDEuqo8SH
         6r6QJwVOHymae2y0VgKOjjgUmKQGjbSPiNeshJPSwP99i7A1npyCHaH8HA5N8jFDieSs
         EZGQ==
X-Gm-Message-State: AOAM531yGokoqoFgU8iHvM9UgoKtBWJnosMapwTknbohgaViqEQqNFMK
        G8OZHzZJlD1X5V3lBvKe0SByJaOtwDXoVCHCqQ==
X-Google-Smtp-Source: ABdhPJwSG4d4QyElMozMioWs7y/57qCLiHzMCxhocAQXRFJ86XPzEemzMJkqsoh2C9chzcM/G2ve4/nWRSLvNRTsRg8=
X-Received: by 2002:a05:6402:cb1:: with SMTP id cn17mr1864047edb.42.1623982968176;
 Thu, 17 Jun 2021 19:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAB5KdOat4A7ZP1MDKHuXra7YN8cZ1J_K5W4M+G_Ye44un79_BQ@mail.gmail.com>
 <20210617170922.GA158165@locust>
In-Reply-To: <20210617170922.GA158165@locust>
From:   Haiwei Li <lihaiwei.kernel@gmail.com>
Date:   Fri, 18 Jun 2021 10:22:36 +0800
Message-ID: <CAB5KdOY8i-9-kS_xYHTVcvx_KL2BTznnf884HZ7AjEnK1q3faw@mail.gmail.com>
Subject: Re: Problem with xfs in an old version
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 1:09 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Fri, Jun 18, 2021 at 12:06:40AM +0800, Haiwei Li wrote:
> > Hi,
> >
> > Sorry to bother. I get a xfs error on kernel 3.10.x. And i don't know how to
> > debug. I got nothing useful from search engines. So I sent an e-mail
> > here. If there
> > are other more suitable ways to discuss the problem, please let me know, thanks!
> >
> > I have gotten a message on the console.
> >
> > '-bash: /data/.my_history: Input/output error'
> >
> > I tried:
> >
> > # ls -l / | grep data
> > ls: cannot access /data: Input/output error
> > d?????????    ? ?    ?        ?            ? data
> >
> > The mount point info is:
> >
> > '/dev/vdb on /data type xfs (rw,noatime,attr2,inode64,prjquota)'
> >
> > System log messages as below:
> >
> > ffff882b86a34000: 31 38 38 32 30 31 36 0a 00 00 00 00 00 00 00 00
> > 1882016.........
> > ffff882b86a34010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ................
> > ffff882b86a34020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ................
> > ffff882b86a34030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ................
> > XFS (vdb): Internal error xfs_inode_buf_verify at line 410 of file
> > XXXX/fs/x[2021-06-17 18:28:51]fs/xfs_inode.c.  Caller
> > 0xffffffffa04d410e
> >
> > CPU: 0 PID: 7715 Comm: kworker/0:1H Tainted: G     U     O
> > 3.10.107-1-tlinux2_kvm_guest-0051 #1
> > Hardware name: Smdbmds KVM, BIOS seabios-1.9.1-qemu-project.org 04/01/2014
> > Workqueue: xfslogd xfs_buf_iodone_work [xfs]
> >  ffff882ec52d9000 000000001a1ab7e6 ffff882efa97fd50 ffffffff819f1d23
> >  ffff882efa97fd68 ffffffffa047da9b ffffffffa04d410e ffff882efa97fda0
> >  ffffffffa047daf5 0000019a00000001 0000000000000001 ffff882b86a34000
> > Call Trace:
> >  [<ffffffff819f1d23>] dump_stack+0x19/0x1b
> >  [<ffffffffa047da9b>] xfs_error_report+0x3b/0x40 [xfs]
> >  [<ffffffffa04d410e>] ? xfs_inode_buf_read_verify+0xe/0x10 [xfs]
> >  [<ffffffffa047daf5>] xfs_corruption_error+0x55/0x80 [xfs]
> >  [<ffffffffa04d40a4>] xfs_inode_buf_verify+0x94/0xe0 [xfs]
> >  [<ffffffffa04d410e>] ? xfs_inode_buf_read_verify+0xe/0x10 [xfs]
> >  [<ffffffffa04d410e>] xfs_inode_buf_read_verify+0xe/0x10 [xfs]
> >  [<ffffffffa047b305>] xfs_buf_iodone_work+0xa5/0xd0 [xfs]
> >  [<ffffffff8106c00c>] process_one_work+0x17c/0x450
> >  [<ffffffff8106cebb>] worker_thread+0x11b/0x3a0
> >  [<ffffffff8106cda0>] ? manage_workers.isra.26+0x2a0/0x2a0
> >  [<ffffffff810737cf>] kthread+0xcf/0xe0
> >  [<ffffffff81073700>] ? insert_kthread_work+0x40/0x40
> >  [<ffffffff81ad5908>] ret_from_fork+0x58/0x90
> >  [<ffffffff81073700>] ? insert_kthread_work+0x40/0x40
> > XFS (vdb): Corruption detected. Unmount and run xfs_repair
> > ffff882b86a34100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ................
> > ffff882b86a34110: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ................
> > ffff882b86a34120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ................
> > ffff882b86a34130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ................
> >
> > I reboot and remount. It works normally. No error again. I guess data from the
> > wrong blocks was returned to XFS.
> >
> > I have no idea how to reproduce. Our workload sometimes triggers the problem.
> > To data, the problem only occurs on 3.10.x in three versions 3.10.x, 4.14.x and
> > 5.4.x.
> >
> > Environment: Containers with workload are running in a kvm vm. The problem
> > occurs in the kvm vm.
> >
> > Any ideas on how to debug? Thanks!
>
> Uh, does xfs_repair -n on the unmounted filesystem complain about this
> corrupt inode?

Output as below:

# xfs_repair -n /dev/vdb
Phase 1 - find and verify superblock...
Phase 2 - using internal log
        - scan filesystem freespace and inode maps...
        - found root inode chunk
Phase 3 - for each AG...
        - scan (but don't clear) agi unlinked lists...
        - process known inodes and perform inode discovery...
        - agno = 0
directory flags set on non-directory inode 64
directory flags set on non-directory inode 69
directory flags set on non-directory inode 72
directory flags set on non-directory inode 75
directory flags set on non-directory inode 81
directory flags set on non-directory inode 83
directory flags set on non-directory inode 91
directory flags set on non-directory inode 112
directory flags set on non-directory inode 125
directory flags set on non-directory inode 64
would fix bad flags.
directory flags set on non-directory inode 69
would fix bad flags.
directory flags set on non-directory inode 72
would fix bad flags.
directory flags set on non-directory inode 75
would fix bad flags.
directory flags set on non-directory inode 81
would fix bad flags.
directory flags set on non-directory inode 83
......
directory flags set on non-directory inode 3242233222
would fix bad flags.
        - process newly discovered inodes...
Phase 4 - check for duplicate blocks...
        - setting up duplicate extent list...
        - check for inodes claiming duplicate blocks...
        - agno = 0
directory flags set on non-directory inode 64
would fix bad flags.
        - agno = 2
        - agno = 3
directory flags set on non-directory inode 69
would fix bad flags.
        - agno = 1
directory flags set on non-directory inode 2149531806
would fix bad flags.
......
directory flags set on non-directory inode 3242233222
would fix bad flags.
No modify flag set, skipping phase 5
Phase 6 - check inode connectivity...
        - traversing filesystem ...
        - traversal finished ...
        - moving disconnected inodes to lost+found ...
Phase 7 - verify link counts...
No modify flag set, skipping filesystem flush and exiting.

Any suggestions on how to debug? Thanks a lot.

--
Haiwei
