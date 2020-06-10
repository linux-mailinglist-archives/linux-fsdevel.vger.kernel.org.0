Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B211F52B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 13:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgFJLA2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 07:00:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:59620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbgFJLA1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:00:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E5709AAC7;
        Wed, 10 Jun 2020 11:00:28 +0000 (UTC)
Subject: Re: Lockdep warning after `mdadm -S`
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200610071916.GA2668@qmqm.qmqm.pl>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 xsFNBFiKBz4BEADNHZmqwhuN6EAzXj9SpPpH/nSSP8YgfwoOqwrP+JR4pIqRK0AWWeWCSwmZ
 T7g+RbfPFlmQp+EwFWOtABXlKC54zgSf+uulGwx5JAUFVUIRBmnHOYi/lUiE0yhpnb1KCA7f
 u/W+DkwGerXqhhe9TvQoGwgCKNfzFPZoM+gZrm+kWv03QLUCr210n4cwaCPJ0Nr9Z3c582xc
 bCUVbsjt7BN0CFa2BByulrx5xD9sDAYIqfLCcZetAqsTRGxM7LD0kh5WlKzOeAXj5r8DOrU2
 GdZS33uKZI/kZJZVytSmZpswDsKhnGzRN1BANGP8sC+WD4eRXajOmNh2HL4P+meO1TlM3GLl
 EQd2shHFY0qjEo7wxKZI1RyZZ5AgJnSmehrPCyuIyVY210CbMaIKHUIsTqRgY5GaNME24w7h
 TyyVCy2qAM8fLJ4Vw5bycM/u5xfWm7gyTb9V1TkZ3o1MTrEsrcqFiRrBY94Rs0oQkZvunqia
 c+NprYSaOG1Cta14o94eMH271Kka/reEwSZkC7T+o9hZ4zi2CcLcY0DXj0qdId7vUKSJjEep
 c++s8ncFekh1MPhkOgNj8pk17OAESanmDwksmzh1j12lgA5lTFPrJeRNu6/isC2zyZhTwMWs
 k3LkcTa8ZXxh0RfWAqgx/ogKPk4ZxOXQEZetkEyTFghbRH2BIwARAQABzSJOaWtvbGF5IEJv
 cmlzb3YgPG5ib3Jpc292QHN1c2UuZGU+wsF4BBMBAgAiBQJYijkSAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRBxvoJG5T8oV/B6D/9a8EcRPdHg8uLEPywuJR8URwXzkofT5bZE
 IfGF0Z+Lt2ADe+nLOXrwKsamhweUFAvwEUxxnndovRLPOpWerTOAl47lxad08080jXnGfYFS
 Dc+ew7C3SFI4tFFHln8Y22Q9075saZ2yQS1ywJy+TFPADIprAZXnPbbbNbGtJLoq0LTiESnD
 w/SUC6sfikYwGRS94Dc9qO4nWyEvBK3Ql8NkoY0Sjky3B0vL572Gq0ytILDDGYuZVo4alUs8
 LeXS5ukoZIw1QYXVstDJQnYjFxYgoQ5uGVi4t7FsFM/6ykYDzbIPNOx49Rbh9W4uKsLVhTzG
 BDTzdvX4ARl9La2kCQIjjWRg+XGuBM5rxT/NaTS78PXjhqWNYlGc5OhO0l8e5DIS2tXwYMDY
 LuHYNkkpMFksBslldvNttSNei7xr5VwjVqW4vASk2Aak5AleXZS+xIq2FADPS/XSgIaepyTV
 tkfnyreep1pk09cjfXY4A7qpEFwazCRZg9LLvYVc2M2eFQHDMtXsH59nOMstXx2OtNMcx5p8
 0a5FHXE/HoXz3p9bD0uIUq6p04VYOHsMasHqHPbsMAq9V2OCytJQPWwe46bBjYZCOwG0+x58
 fBFreP/NiJNeTQPOa6FoxLOLXMuVtpbcXIqKQDoEte9aMpoj9L24f60G4q+pL/54ql2VRscK
 d87BTQRYigc+ARAAyJSq9EFk28++SLfg791xOh28tLI6Yr8wwEOvM3wKeTfTZd+caVb9gBBy
 wxYhIopKlK1zq2YP7ZjTP1aPJGoWvcQZ8fVFdK/1nW+Z8/NTjaOx1mfrrtTGtFxVBdSCgqBB
 jHTnlDYV1R5plJqK+ggEP1a0mr/rpQ9dFGvgf/5jkVpRnH6BY0aYFPprRL8ZCcdv2DeeicOO
 YMobD5g7g/poQzHLLeT0+y1qiLIFefNABLN06Lf0GBZC5l8hCM3Rpb4ObyQ4B9PmL/KTn2FV
 Xq/c0scGMdXD2QeWLePC+yLMhf1fZby1vVJ59pXGq+o7XXfYA7xX0JsTUNxVPx/MgK8aLjYW
 hX+TRA4bCr4uYt/S3ThDRywSX6Hr1lyp4FJBwgyb8iv42it8KvoeOsHqVbuCIGRCXqGGiaeX
 Wa0M/oxN1vJjMSIEVzBAPi16tztL/wQtFHJtZAdCnuzFAz8ue6GzvsyBj97pzkBVacwp3/Mw
 qbiu7sDz7yB0d7J2tFBJYNpVt/Lce6nQhrvon0VqiWeMHxgtQ4k92Eja9u80JDaKnHDdjdwq
 FUikZirB28UiLPQV6PvCckgIiukmz/5ctAfKpyYRGfez+JbAGl6iCvHYt/wAZ7Oqe/3Cirs5
 KhaXBcMmJR1qo8QH8eYZ+qhFE3bSPH446+5oEw8A9v5oonKV7zMAEQEAAcLBXwQYAQIACQUC
 WIoHPgIbDAAKCRBxvoJG5T8oV1pyD/4zdXdOL0lhkSIjJWGqz7Idvo0wjVHSSQCbOwZDWNTN
 JBTP0BUxHpPu/Z8gRNNP9/k6i63T4eL1xjy4umTwJaej1X15H8Hsh+zakADyWHadbjcUXCkg
 OJK4NsfqhMuaIYIHbToi9K5pAKnV953xTrK6oYVyd/Rmkmb+wgsbYQJ0Ur1Ficwhp6qU1CaJ
 mJwFjaWaVgUERoxcejL4ruds66LM9Z1Qqgoer62ZneID6ovmzpCWbi2sfbz98+kW46aA/w8r
 7sulgs1KXWhBSv5aWqKU8C4twKjlV2XsztUUsyrjHFj91j31pnHRklBgXHTD/pSRsN0UvM26
 lPs0g3ryVlG5wiZ9+JbI3sKMfbdfdOeLxtL25ujs443rw1s/PVghphoeadVAKMPINeRCgoJH
 zZV/2Z/myWPRWWl/79amy/9MfxffZqO9rfugRBORY0ywPHLDdo9Kmzoxoxp9w3uTrTLZaT9M
 KIuxEcV8wcVjr+Wr9zRl06waOCkgrQbTPp631hToxo+4rA1jiQF2M80HAet65ytBVR2pFGZF
 zGYYLqiG+mpUZ+FPjxk9kpkRYz61mTLSY7tuFljExfJWMGfgSg1OxfLV631jV1TcdUnx+h3l
 Sqs2vMhAVt14zT8mpIuu2VNxcontxgVr1kzYA/tQg32fVRbGr449j1gw57BV9i0vww==
Message-ID: <5e70658f-d071-bcec-74ce-214f12da396e@suse.com>
Date:   Wed, 10 Jun 2020 14:00:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610071916.GA2668@qmqm.qmqm.pl>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10.06.20 г. 10:19 ч., Michał Mirosław wrote:
> Dear Developers,
> 
> I found a lockdep warning in dmesg some after doing 'mdadm -S' while
> also having btrfs mounted (light to none I/O load).  Disks under MD and
> btrfs are unrelated.

Huhz, I think that's genuine, because btrfs and md shared at least the bd_mutex 
and the workqueue. So the scenario could go something along the lines of: 

					   
 					   						 
T1: 						T2:					T3:							T4:					T5:
 initiates process of stopping md,													transaction commit blocked on   		User tries to (erroneously) mount mddev 
 holds bd_mutex, open_mutex, 								wants to begin a new transaction but 		device_list_mutex, callstack #3,		but blocks on callstack at #4 since T1 
 blocks on flushing md_misc_wq,		Should begin  mmdev_delayed_delete		blocks on callstack #0 due to a 		holding sb_internal				holds bd_open  and is holding device_list_mutex
 Callstack #6				but never does because workqueue is  		running transaction commit in T4
					blocked due to T3 being blocked	                NB: This happens from writeback		   
					 					       	context, ie. same as T2 workqueue				  
              				  					        bd_mutex held by T1 	

So T5 blocks T4, which blocks T3, which blocks the shared writeback workqueue, 
this prevents T2 from running which when done would cause T1 to unlock bd_mutex, 
which would unblock T5. I think this is generally possible but highly unlikely.

Also looking at the code in T5 (callstack #4 below) it seems that the same could happen if 
scan ioctl is sent for the mddev. Discussing this with peterz he proposed the following half-baked 
patch: https://paste.debian.net/1151314/

The idea is to remove the md_open mutex which would break the dependency chain between 
#4->#6. What do mdraid people think?
											
> 
> Best Regards,
> Michał Mirosław
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.7.1mq+ #383 Tainted: G           O     
> ------------------------------------------------------
> kworker/u16:3/8175 is trying to acquire lock:
> ffff8882f19556a0 (sb_internal#3){.+.+}-{0:0}, at: start_transaction+0x37e/0x550 [btrfs]
> 
> but task is already holding lock:
> ffffc900087c7e68 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x235/0x620
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #8 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}:
>        __flush_work+0x331/0x490
>        wb_shutdown+0x8f/0xb0
>        bdi_unregister+0x72/0x1f0
>        del_gendisk+0x2b0/0x2c0
>        md_free+0x28/0x90
>        kobject_put+0xa6/0x1b0
>        process_one_work+0x2b6/0x620
>        worker_thread+0x35/0x3e0
>        kthread+0x143/0x160
>        ret_from_fork+0x3a/0x50
> 
> -> #7 ((work_completion)(&mddev->del_work)){+.+.}-{0:0}:
>        process_one_work+0x28d/0x620
>        worker_thread+0x35/0x3e0
>        kthread+0x143/0x160
>        ret_from_fork+0x3a/0x50
> 
> -> #6 ((wq_completion)md_misc){+.+.}-{0:0}:
>        flush_workqueue+0xa9/0x4e0
>        __md_stop_writes+0x18/0x100
>        do_md_stop+0x165/0x2d0
>        md_ioctl+0xa52/0x1d60
>        blkdev_ioctl+0x1cc/0x2a0
>        block_ioctl+0x3a/0x40
>        ksys_ioctl+0x81/0xc0
>        __x64_sys_ioctl+0x11/0x20
>        do_syscall_64+0x4f/0x210
>        entry_SYSCALL_64_after_hwframe+0x49/0xb3
> 
> -> #5 (&mddev->open_mutex){+.+.}-{3:3}:
>        __mutex_lock+0x93/0x9c0
>        md_open+0x43/0xc0
>        __blkdev_get+0xea/0x560
>        blkdev_get+0x60/0x130
>        do_dentry_open+0x147/0x3e0
>        path_openat+0x84f/0xa80
>        do_filp_open+0x8e/0x100
>        do_sys_openat2+0x225/0x2e0
>        do_sys_open+0x46/0x80
>        do_syscall_64+0x4f/0x210
>        entry_SYSCALL_64_after_hwframe+0x49/0xb3
> 
> -> #4 (&bdev->bd_mutex){+.+.}-{3:3}:
>        __mutex_lock+0x93/0x9c0
>        __blkdev_get+0x77/0x560
>        blkdev_get+0x60/0x130
>        blkdev_get_by_path+0x41/0x80
>        btrfs_get_bdev_and_sb+0x16/0xb0 [btrfs]
>        open_fs_devices+0x9d/0x240 [btrfs]
>        btrfs_open_devices+0x89/0x90 [btrfs]
>        btrfs_mount_root+0x26a/0x4b0 [btrfs]
>        legacy_get_tree+0x2b/0x50
>        vfs_get_tree+0x23/0xc0
>        fc_mount+0x9/0x40
>        vfs_kern_mount.part.40+0x57/0x80
>        btrfs_mount+0x148/0x3f0 [btrfs]
>        legacy_get_tree+0x2b/0x50
>        vfs_get_tree+0x23/0xc0
>        do_mount+0x712/0xa40
>        __x64_sys_mount+0xbf/0xe0
>        do_syscall_64+0x4f/0x210
>        entry_SYSCALL_64_after_hwframe+0x49/0xb3
> 
> -> #3 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
>        __mutex_lock+0x93/0x9c0
>        btrfs_run_dev_stats+0x44/0x470 [btrfs]
>        commit_cowonly_roots+0xac/0x2a0 [btrfs]
>        btrfs_commit_transaction+0x511/0xa70 [btrfs]
>        transaction_kthread+0x13c/0x160 [btrfs]
>        kthread+0x143/0x160
>        ret_from_fork+0x3a/0x50
> 
> -> #2 (&fs_info->tree_log_mutex){+.+.}-{3:3}:
>        __mutex_lock+0x93/0x9c0
>        btrfs_commit_transaction+0x4b6/0xa70 [btrfs]
>        transaction_kthread+0x13c/0x160 [btrfs]
>        kthread+0x143/0x160
>        ret_from_fork+0x3a/0x50
> 
> -> #1 (&fs_info->reloc_mutex){+.+.}-{3:3}:
>        __mutex_lock+0x93/0x9c0
>        btrfs_record_root_in_trans+0x3e/0x60 [btrfs]
>        start_transaction+0xcb/0x550 [btrfs]
>        btrfs_mkdir+0x5c/0x1e0 [btrfs]
>        vfs_mkdir+0x107/0x1d0
>        do_mkdirat+0xe7/0x110
>        do_syscall_64+0x4f/0x210
>        entry_SYSCALL_64_after_hwframe+0x49/0xb3
> 
> -> #0 (sb_internal#3){.+.+}-{0:0}:
>        __lock_acquire+0x11f9/0x1aa0
>        lock_acquire+0x9e/0x380
>        __sb_start_write+0x13a/0x270
>        start_transaction+0x37e/0x550 [btrfs]
>        cow_file_range_inline.constprop.74+0xe4/0x640 [btrfs]
>        cow_file_range+0xe5/0x3f0 [btrfs]
>        btrfs_run_delalloc_range+0x128/0x620 [btrfs]
>        writepage_delalloc+0xe2/0x140 [btrfs]
>        __extent_writepage+0x1a3/0x370 [btrfs]
>        extent_write_cache_pages+0x2b8/0x470 [btrfs]
>        extent_writepages+0x3f/0x90 [btrfs]
>        do_writepages+0x3c/0xe0
>        __writeback_single_inode+0x4f/0x650
>        writeback_sb_inodes+0x1f7/0x560
>        __writeback_inodes_wb+0x58/0xa0
>        wb_writeback+0x33b/0x4b0
>        wb_workfn+0x428/0x5b0
>        process_one_work+0x2b6/0x620
>        worker_thread+0x35/0x3e0
>        kthread+0x143/0x160
>        ret_from_fork+0x3a/0x50
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   sb_internal#3 --> (work_completion)(&mddev->del_work) --> (work_completion)(&(&wb->dwork)->work)
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock((work_completion)(&(&wb->dwork)->work));
>                                lock((work_completion)(&mddev->del_work));
>                                lock((work_completion)(&(&wb->dwork)->work));
>   lock(sb_internal#3);
> 
>  *** DEADLOCK ***
> 
> 3 locks held by kworker/u16:3/8175:
>  #0: ffff88840baa6948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x235/0x620
>  #1: ffffc900087c7e68 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x235/0x620
>  #2: ffff8882f19550e8 (&type->s_umount_key#52){++++}-{3:3}, at: trylock_super+0x11/0x50
> 
> stack backtrace:
> CPU: 1 PID: 8175 Comm: kworker/u16:3 Tainted: G           O      5.7.1mq+ #383
> Hardware name: System manufacturer System Product Name/P8Z68-V PRO, BIOS 3603 11/09/2012
> Workqueue: writeback wb_workfn (flush-btrfs-1)
> Call Trace:
>  dump_stack+0x71/0xa0
>  check_noncircular+0x165/0x180
>  ? stack_trace_save+0x46/0x70
>  __lock_acquire+0x11f9/0x1aa0
>  lock_acquire+0x9e/0x380
>  ? start_transaction+0x37e/0x550 [btrfs]
>  __sb_start_write+0x13a/0x270
>  ? start_transaction+0x37e/0x550 [btrfs]
>  start_transaction+0x37e/0x550 [btrfs]
>  ? kmem_cache_alloc+0x1b0/0x2c0
>  cow_file_range_inline.constprop.74+0xe4/0x640 [btrfs]
>  ? lock_acquire+0x9e/0x380
>  ? test_range_bit+0x3d/0x130 [btrfs]
>  cow_file_range+0xe5/0x3f0 [btrfs]
>  btrfs_run_delalloc_range+0x128/0x620 [btrfs]
>  ? find_lock_delalloc_range+0x1f3/0x220 [btrfs]
>  writepage_delalloc+0xe2/0x140 [btrfs]
>  __extent_writepage+0x1a3/0x370 [btrfs]
>  extent_write_cache_pages+0x2b8/0x470 [btrfs]
>  ? __lock_acquire+0x3fc/0x1aa0
>  extent_writepages+0x3f/0x90 [btrfs]
>  do_writepages+0x3c/0xe0
>  ? find_held_lock+0x2d/0x90
>  __writeback_single_inode+0x4f/0x650
>  writeback_sb_inodes+0x1f7/0x560
>  __writeback_inodes_wb+0x58/0xa0
>  wb_writeback+0x33b/0x4b0
>  wb_workfn+0x428/0x5b0
>  ? sched_clock_cpu+0xe/0xd0
>  process_one_work+0x2b6/0x620
>  ? worker_thread+0xc7/0x3e0
>  worker_thread+0x35/0x3e0
>  ? process_one_work+0x620/0x620
>  kthread+0x143/0x160
>  ? kthread_park+0x80/0x80
>  ret_from_fork+0x3a/0x50
> 
