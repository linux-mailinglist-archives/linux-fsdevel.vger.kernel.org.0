Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E9256D70E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 09:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiGKHuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 03:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiGKHuT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:50:19 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890991CB12
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 00:50:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t3so4948806edd.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 00:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSqEx710a/dVEa0ZY3sqIrplA+wvP7kZvKBSjYsRL+0=;
        b=g3AjwPVuCmFuH2Z2Krvx4nORro3p2TISC2aa45lo3zMi465zLZGOVxZqMQVkNjT9a5
         slk5dFjFnAXMeBdcBe/HEb5YmQm3EeHMeaD5BMZHR0Z5RCbYPswpRy+mauB17WaGWJDW
         9pMDEWFVb2b1dGF297V/frM7nSpXYp2ENTuKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSqEx710a/dVEa0ZY3sqIrplA+wvP7kZvKBSjYsRL+0=;
        b=XV3lN8H5Rn8WmDCQmodhe0wlsdFYIOFoCamaWNCb7/JyzUWm8Bp6tNhh24wNJPwTuQ
         2pMdwrBHWxA7zYsaL5raYW3g7nECzqMlcanzgAIEcUjVX4ZZFc5Q2cNfaHEJwtztdw5D
         YABI/4HyFM534X1W2JzeYLFEQyEFVLRFWyciu5ip3pfplxMUmtMTa2i8dXBHWeKNe4LU
         r1PJU1CDlcwLtmAKaQCBzOMy4DReGMKUaIicXnz3JkJWc6ojSEUd3bd52uZDvE6jepLC
         7iqlH0mRbBLaZ7SslVhgDiKyTtrSxN3axSkU9ISWL6C+1zI1o8r3+KEcIiX8TftFzN6J
         +8NQ==
X-Gm-Message-State: AJIora/gbZqF1TNgXDcIqTMocJfKgW7ESKtBmz8kFB6Tb1Hj6RXtLKg4
        BQ+gWftpgFLjcrX3T045jIEd7rZVD3bv3wz0Hnx3wA==
X-Google-Smtp-Source: AGRyM1vF54zPBUlQATEp+E2C1DXyhmVx30QVsruomgLtrYIxOCRiML3DWfAHfwJ2JjmBWg+Kr9La04lJap4WM3jsFlg=
X-Received: by 2002:a05:6402:2b8d:b0:43a:5410:a9fc with SMTP id
 fj13-20020a0564022b8d00b0043a5410a9fcmr22881125edb.99.1657525810007; Mon, 11
 Jul 2022 00:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210603125242.31699-1-chenguanyou@xiaomi.com>
 <CAJfpegsEkRnU26Vvo4BTQUmx89Hahp6=RTuyEcPm=rqz8icwUQ@mail.gmail.com>
 <1fabb91167a86990f4723e9036a0e006293518f4.camel@mediatek.com>
 <CAJfpegsOSWZpKHqDNE_B489dGCzLr-RVAhimVOsFkxJwMYmj9A@mail.gmail.com>
 <07c5f2f1e10671bc462f88717f84aae9ee1e4d2b.camel@mediatek.com>
 <CAJfpegvAJS=An+hyAshkNcTS8A2TM28V2UP4SYycXUw3awOR+g@mail.gmail.com>
 <YVMz8E1Lg/GZQcjw@miu.piliscsaba.redhat.com> <SI2PR03MB5545E0B76E54013678B9FEEC8BA99@SI2PR03MB5545.apcprd03.prod.outlook.com>
 <07ad7d51d15c7ffc708b55066ded653a4b2c5c98.camel@mediatek.com>
 <CAJfpegsw3NpH6oTU9nxJLPUYMJVmfWhAa6yB8vnDZctP9vHc0g@mail.gmail.com> <490be4e0b984e146c93586507442de3dad8694bb.camel@mediatek.com>
In-Reply-To: <490be4e0b984e146c93586507442de3dad8694bb.camel@mediatek.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 11 Jul 2022 09:49:59 +0200
Message-ID: <CAJfpegsShacuTHvWUnWbdvnN_WcoKGzynsrSnkibAmphsr2kXg@mail.gmail.com>
Subject: Re: [PATCH] [fuse] alloc_page nofs avoid deadlock
To:     Ed Tsai <ed.tsai@mediatek.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        chenguanyou <chenguanyou9338@gmail.com>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?UTF-8?B?WW9uZy14dWFuIFdhbmcgKOeOi+ipoOiQsSk=?= 
        <Yong-xuan.Wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 13 Jun 2022 at 11:29, Ed Tsai <ed.tsai@mediatek.com> wrote:
>
> On Mon, 2022-06-13 at 16:45 +0800, Miklos Szeredi wrote:
> > On Fri, 10 Jun 2022 at 09:48, Ed Tsai <ed.tsai@mediatek.com> wrote:
> >
> > > Recently, we get this deadlock issue again.
> > > fuse_flush_time_update()
> > > use sync_inode_metadata() and it only write the metadata, so the
> > > writeback worker could still be blocked becaused of file data.
> > >
> > > I try to use write_inode_now() instead of sync_inode_metadata() and
> > > the
> > > writeback thread will not be blocked anymore. I don't think this is
> > > a
> > > good solution, but this confirm that there is still a potential
> > > deadlock because of file data. WDYT.
> >
> > I'm not sure how that happens.  Normally writeback doesn't
> > block.  Can
> > you provide the stack traces of all related tasks in the deadlock?
> >
> > Thanks,
> > Miklos
>
> The writeback worker
> ppid=22915 pid=22915 S cpu=6 prio=120 wait=3614s kworker/u16:21
> vmlinux  request_wait_answer + 64
> vmlinux  __fuse_request_send + 328
> vmlinux  fuse_request_send + 60
> vmlinux  fuse_simple_request + 376
> vmlinux  fuse_flush_times + 276
> vmlinux  fuse_write_inode + 104 (inode=0xFFFFFFD516CC4780, ff=0)
> vmlinux  write_inode + 384
> vmlinux  __writeback_single_inode + 960
> vmlinux  writeback_sb_inodes + 892
> vmlinux  __writeback_inodes_wb + 156
> vmlinux  wb_writeback + 512
> vmlinux  wb_check_background_flush + 600
> vmlinux  wb_do_writeback + 644
> vmlinux  wb_workfn + 756
> vmlinux  process_one_work + 628
> vmlinux  worker_thread + 708
> vmlinux  kthread + 376
> vmlinux  ret_from_fork + 16
>
> Thread-11
> ppid=3961 pid=26057 D cpu=4 prio=120 wait=3614s Thread-11
> vmlinux  __inode_wait_for_writeback + 108
> vmlinux  inode_wait_for_writeback + 156
> vmlinux  evict + 160
> vmlinux  iput_final + 292
> vmlinux  iput + 600
> vmlinux  dentry_unlink_inode + 212
> vmlinux  __dentry_kill + 228
> vmlinux  shrink_dentry_list + 408
> vmlinux  prune_dcache_sb + 80
> vmlinux  super_cache_scan + 272
> vmlinux  do_shrink_slab + 944
> vmlinux  shrink_slab + 1104
> vmlinux  shrink_node + 712
> vmlinux  shrink_zones + 188
> vmlinux  do_try_to_free_pages + 348
> vmlinux  try_to_free_pages + 848
> vmlinux  __perform_reclaim + 64
> vmlinux  __alloc_pages_direct_reclaim + 64
> vmlinux  __alloc_pages_slowpath + 1296
> vmlinux  __alloc_pages_nodemask + 2004
> vmlinux  __alloc_pages + 16
> vmlinux  __alloc_pages_node + 16
> vmlinux  alloc_pages_node + 16
> vmlinux  __read_swap_cache_async + 172
> vmlinux  read_swap_cache_async + 12
> vmlinux  swapin_readahead + 328
> vmlinux  do_swap_page + 844
> vmlinux  handle_pte_fault + 268
> vmlinux  __handle_speculative_fault + 548
> vmlinux  handle_speculative_fault + 44
> vmlinux  do_page_fault + 500
> vmlinux  do_translation_fault + 64
> vmlinux  do_mem_abort + 72
> vmlinux  el0_sync + 1032
>
> ppid=3961 is com.google.android.providers.media.module, and it is the
> android fuse daemon.
>
> So, the daemon and wb worker were wait for each other.

Is commit 5c791fe1e2a4 ("fuse: make sure reclaim doesn't write the
inode") applied to this kernel?

Thanks,
Miklos
