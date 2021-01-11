Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D6C2F11AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 12:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbhAKLnQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 06:43:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57645 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729866AbhAKLnQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610365309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=USNadpbrdLIlMpKxyyoTuXb3BT0mvznhCnwwd+cN4dQ=;
        b=N/rCzTFuK6FstRgSUibN/m9wqSdCGeAhS6ucLgwiLl1MovLBXbqhVivx9RXsOmHuC4bWuk
        cxLJgFbV88zee85A0hY4MfEsuL7Jn3O9aGz33r55WRPdygZP7jL4vSLF/jX29j7PfinlWf
        Vcdx5zteEAM1oko9RHRlpZ5igmVKKf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-vztTchXGMEScV9qKBHrPyg-1; Mon, 11 Jan 2021 06:41:45 -0500
X-MC-Unique: vztTchXGMEScV9qKBHrPyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FE3A801AC3;
        Mon, 11 Jan 2021 11:41:42 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D0DB35D720;
        Mon, 11 Jan 2021 11:41:38 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 10BBfcfv004873;
        Mon, 11 Jan 2021 06:41:38 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 10BBfaB8004867;
        Mon, 11 Jan 2021 06:41:36 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 11 Jan 2021 06:41:36 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: Re: [RFC v2] nvfs: a filesystem for persistent memory
In-Reply-To: <20210110234042.GX3579531@ZenIV.linux.org.uk>
Message-ID: <alpine.LRH.2.02.2101110631330.4356@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com> <20210110162008.GV3579531@ZenIV.linux.org.uk> <alpine.LRH.2.02.2101101410230.7245@file01.intranet.prod.int.rdu2.redhat.com>
 <20210110234042.GX3579531@ZenIV.linux.org.uk>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Sun, 10 Jan 2021, Al Viro wrote:

> On Sun, Jan 10, 2021 at 04:14:55PM -0500, Mikulas Patocka wrote:
> 
> > That's a good point. I split nvfs_rw_iter to separate functions 
> > nvfs_read_iter and nvfs_write_iter - and inlined nvfs_rw_iter_locked into 
> > both of them. It improved performance by 1.3%.
> > 
> > > Not that it had been more useful on the write side, really,
> > > but that's another story (nvfs_write_pages() handling of
> > > copyin is... interesting).  Let's figure out what's going
> > > on with the read overhead first...
> > > 
> > > lib/iov_iter.c primitives certainly could use massage for
> > > better code generation, but let's find out how much of the
> > > PITA is due to those and how much comes from you fighing
> > > the damn thing instead of using it sanely...
> > 
> > The results are:
> > 
> > read:                                           6.744s
> > read_iter:                                      7.417s
> > read_iter - separate read and write path:       7.321s
> > Al's read_iter:                                 7.182s
> > Al's read_iter with _copy_to_iter:              7.181s
> 
> So
> 	* overhead of hardening stuff is noise here
> 	* switching to more straightforward ->read_iter() cuts
> the overhead by about 1/3.
> 
> 	Interesting...  I wonder how much of that is spent in
> iterate_and_advance() glue inside copy_to_iter() here.  There's
> certainly quite a bit of optimizations possible in those
> primitives and your usecase makes a decent test for that...
> 
> 	Could you profile that and see where is it spending
> the time, on instruction level?

This is the read method profile:

time	9.056s
    52.69%  pread    [kernel.vmlinux]  [k] copy_user_generic_string
     6.24%  pread    [kernel.vmlinux]  [k] current_time
     6.22%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64
     4.88%  pread    libc-2.31.so      [.] __libc_pread
     3.75%  pread    [kernel.vmlinux]  [k] syscall_return_via_sysret
     3.63%  pread    [nvfs]            [k] nvfs_read
     2.83%  pread    [nvfs]            [k] nvfs_bmap
     2.81%  pread    [kernel.vmlinux]  [k] vfs_read
     2.63%  pread    [kernel.vmlinux]  [k] __x64_sys_pread64
     2.27%  pread    [kernel.vmlinux]  [k] __fsnotify_parent
     2.19%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64_after_hwframe
     1.55%  pread    [kernel.vmlinux]  [k] atime_needs_update
     1.17%  pread    [kernel.vmlinux]  [k] syscall_enter_from_user_mode
     1.15%  pread    [kernel.vmlinux]  [k] touch_atime
     0.84%  pread    [kernel.vmlinux]  [k] down_read
     0.82%  pread    [kernel.vmlinux]  [k] syscall_exit_to_user_mode
     0.71%  pread    [kernel.vmlinux]  [k] do_syscall_64
     0.68%  pread    [kernel.vmlinux]  [k] ktime_get_coarse_real_ts64
     0.66%  pread    [kernel.vmlinux]  [k] __fget_light
     0.53%  pread    [kernel.vmlinux]  [k] exit_to_user_mode_prepare
     0.45%  pread    [kernel.vmlinux]  [k] up_read
     0.44%  pread    pread             [.] main
     0.44%  pread    [kernel.vmlinux]  [k] syscall_exit_to_user_mode_prepare
     0.26%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64_safe_stack
     0.12%  pread    pread             [.] pread@plt
     0.07%  pread    [kernel.vmlinux]  [k] __fdget
     0.00%  perf     [kernel.vmlinux]  [k] x86_pmu_enable_all


This is profile of "read_iter - separate read and write path":

time	10.058s
    53.05%  pread    [kernel.vmlinux]  [k] copy_user_generic_string
     6.82%  pread    [kernel.vmlinux]  [k] current_time
     6.27%  pread    [nvfs]            [k] nvfs_read_iter
     4.70%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64
     3.20%  pread    libc-2.31.so      [.] __libc_pread
     2.77%  pread    [kernel.vmlinux]  [k] syscall_return_via_sysret
     2.31%  pread    [kernel.vmlinux]  [k] vfs_read
     2.15%  pread    [kernel.vmlinux]  [k] new_sync_read
     2.06%  pread    [kernel.vmlinux]  [k] __fsnotify_parent
     2.02%  pread    [nvfs]            [k] nvfs_bmap
     1.87%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64_after_hwframe
     1.86%  pread    [kernel.vmlinux]  [k] iov_iter_advance
     1.62%  pread    [kernel.vmlinux]  [k] __x64_sys_pread64
     1.40%  pread    [kernel.vmlinux]  [k] atime_needs_update
     0.99%  pread    [kernel.vmlinux]  [k] syscall_enter_from_user_mode
     0.85%  pread    [kernel.vmlinux]  [k] touch_atime
     0.85%  pread    [kernel.vmlinux]  [k] down_read
     0.84%  pread    [kernel.vmlinux]  [k] syscall_exit_to_user_mode
     0.78%  pread    [kernel.vmlinux]  [k] ktime_get_coarse_real_ts64
     0.65%  pread    [kernel.vmlinux]  [k] __fget_light
     0.57%  pread    [kernel.vmlinux]  [k] exit_to_user_mode_prepare
     0.53%  pread    [kernel.vmlinux]  [k] syscall_exit_to_user_mode_prepare
     0.45%  pread    pread             [.] main
     0.43%  pread    [kernel.vmlinux]  [k] up_read
     0.43%  pread    [kernel.vmlinux]  [k] do_syscall_64
     0.28%  pread    [kernel.vmlinux]  [k] iov_iter_init
     0.16%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64_safe_stack
     0.09%  pread    pread             [.] pread@plt
     0.03%  pread    [kernel.vmlinux]  [k] __fdget
     0.00%  pread    [kernel.vmlinux]  [k] update_rt_rq_load_avg
     0.00%  perf     [kernel.vmlinux]  [k] x86_pmu_enable_all


This is your read_iter_locked profile (read_iter_locked is inlined to 
nvfs_read_iter):

time	10.056s
    50.71%  pread    [kernel.vmlinux]  [k] copy_user_generic_string
     6.95%  pread    [kernel.vmlinux]  [k] current_time
     5.22%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64
     4.29%  pread    libc-2.31.so      [.] __libc_pread
     4.17%  pread    [nvfs]            [k] nvfs_read_iter
     3.20%  pread    [kernel.vmlinux]  [k] syscall_return_via_sysret
     2.66%  pread    [kernel.vmlinux]  [k] _copy_to_iter
     2.44%  pread    [kernel.vmlinux]  [k] __x64_sys_pread64
     2.38%  pread    [kernel.vmlinux]  [k] new_sync_read
     2.37%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64_after_hwframe
     2.26%  pread    [kernel.vmlinux]  [k] vfs_read
     2.02%  pread    [nvfs]            [k] nvfs_bmap
     1.88%  pread    [kernel.vmlinux]  [k] __fsnotify_parent
     1.46%  pread    [kernel.vmlinux]  [k] atime_needs_update
     1.08%  pread    [kernel.vmlinux]  [k] touch_atime
     0.83%  pread    [kernel.vmlinux]  [k] syscall_exit_to_user_mode
     0.82%  pread    [kernel.vmlinux]  [k] syscall_enter_from_user_mode
     0.75%  pread    [kernel.vmlinux]  [k] syscall_exit_to_user_mode_prepare
     0.73%  pread    [kernel.vmlinux]  [k] __fget_light
     0.65%  pread    [kernel.vmlinux]  [k] down_read
     0.58%  pread    pread             [.] main
     0.58%  pread    [kernel.vmlinux]  [k] exit_to_user_mode_prepare
     0.52%  pread    [kernel.vmlinux]  [k] ktime_get_coarse_real_ts64
     0.48%  pread    [kernel.vmlinux]  [k] up_read
     0.42%  pread    [kernel.vmlinux]  [k] do_syscall_64
     0.28%  pread    [kernel.vmlinux]  [k] iov_iter_init
     0.13%  pread    [kernel.vmlinux]  [k] __fdget
     0.12%  pread    [kernel.vmlinux]  [k] entry_SYSCALL_64_safe_stack
     0.03%  pread    pread             [.] pread@plt
     0.00%  perf     [kernel.vmlinux]  [k] x86_pmu_enable_all

Mikulas

