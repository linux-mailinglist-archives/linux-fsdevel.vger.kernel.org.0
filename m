Return-Path: <linux-fsdevel+bounces-56318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDA3B158CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 08:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9344A3A3813
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 06:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C741B1F09A5;
	Wed, 30 Jul 2025 06:14:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C927E1;
	Wed, 30 Jul 2025 06:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753856052; cv=none; b=FpaGoVsUJHIwT7WHjiYxzjS3fhbc4Owc1lNn2QQOkkL/mMe29ODobkjOMkEcWDlLxigCmcLRhon683FaaZSIgT25csBu1ranmVGbOIMYlJsIXM5hvbPqmk83ptzTDJAGvbr6R6Lfrs2KlzgaCekEx7laYECKSLlCk+W8QFEpGeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753856052; c=relaxed/simple;
	bh=CM4Qx4TBUjayBboc8N6x+a8km6ZinxSNNaYy4Qi1nJ0=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PQBmOEwEey1KV4m/uKFBswW27/5MbXumreG3YLElfKN8nsQVaF7945y5TI2RqI7L4TR74IkcphG7iJKaH3b642HuTxoReZNohuCi5Vr4d/rja+udR2KRv+J8pzT4pQ2e51dW4sQqwsGrxVjoPqBveYmzGjdN64/y6s4CzhFcWvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bsMNv6VXlzYQv6y;
	Wed, 30 Jul 2025 14:14:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 91E7F1A0F9E;
	Wed, 30 Jul 2025 14:14:06 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHERIpuIlo4x_bBw--.6139S3;
	Wed, 30 Jul 2025 14:14:02 +0800 (CST)
Subject: Re: [syzbot] [fuse?] [block?] KASAN: slab-use-after-free Read in
 disk_add_events
To: syzbot <syzbot+fa3a12519f0d3fd4ec16@syzkaller.appspotmail.com>,
 axboe@kernel.dk, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, miklos@szeredi.hu,
 syzkaller-bugs@googlegroups.com, "yukuai (C)" <yukuai3@huawei.com>
References: <68894408.a00a0220.26d0e1.0013.GAE@google.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <762c700c-7094-e816-9fcf-b4cfea26283e@huaweicloud.com>
Date: Wed, 30 Jul 2025 14:14:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <68894408.a00a0220.26d0e1.0013.GAE@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHERIpuIlo4x_bBw--.6139S3
X-Coremail-Antispam: 1UD129KBjvAXoWfJFW8ZrykCw4fAw1DGF48JFb_yoW8JFW8uo
	WIqr4rCF48Gry5JF97Cr4UJ3y3GFykXFnrJr4Ykr45WFy2v3yUA34kKwnavrW5tr4rWF43
	Ary2qr1rKwsrGrn7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY77kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS
	14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	iF4tUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

+CC Xiao

在 2025/07/30 5:58, syzbot 写道:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ced1b9e0392d Merge tag 'ata-6.17-rc1' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=133b8cf0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=52c12ce9080f644c
> dashboard link: https://syzkaller.appspot.com/bug?extid=fa3a12519f0d3fd4ec16
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154b31bc580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171a9782580000
> 

This looks like the same cause with another report:

https://lore.kernel.org/all/68894408.a00a0220.26d0e1.0012.GAE@google.com/

The mddev kobject liftime is broken, now in the case del_work is queued,
means mddev is about to be freed, meanwhile md_open can succeed.

Thanks,
Kuai

> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ced1b9e0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c709b0d9538c/vmlinux-ced1b9e0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/129af0799fa3/bzImage-ced1b9e0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fa3a12519f0d3fd4ec16@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in __list_add_valid_or_report+0x151/0x190 lib/list_debug.c:32
> Read of size 8 at addr ffff888036fa1400 by task syz.2.1231/9834
> 
> CPU: 3 UID: 0 PID: 9834 Comm: syz.2.1231 Not tainted 6.16.0-syzkaller-00857-gced1b9e0392d #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:378 [inline]
>   print_report+0xcd/0x630 mm/kasan/report.c:482
>   kasan_report+0xe0/0x110 mm/kasan/report.c:595
>   __list_add_valid_or_report+0x151/0x190 lib/list_debug.c:32
>   __list_add_valid include/linux/list.h:88 [inline]
>   __list_add include/linux/list.h:150 [inline]
>   list_add_tail include/linux/list.h:183 [inline]
>   disk_add_events+0x90/0x170 block/disk-events.c:463
>   add_disk_final block/genhd.c:427 [inline]
>   add_disk_fwnode+0x3c8/0x5d0 block/genhd.c:610
>   add_disk include/linux/blkdev.h:773 [inline]
>   md_alloc+0x3c2/0x1080 drivers/md/md.c:5981
>   md_alloc_and_put drivers/md/md.c:6016 [inline]
>   md_probe drivers/md/md.c:6029 [inline]
>   md_probe+0x6e/0xd0 drivers/md/md.c:6024
>   blk_probe_dev+0x116/0x1a0 block/genhd.c:884
>   blk_request_module+0x16/0xb0 block/genhd.c:897
>   blkdev_get_no_open+0x9b/0x100 block/bdev.c:825
>   blkdev_open+0x141/0x3f0 block/fops.c:684
>   do_dentry_open+0x744/0x1c10 fs/open.c:965
>   vfs_open+0x82/0x3f0 fs/open.c:1095
>   do_open fs/namei.c:3887 [inline]
>   path_openat+0x1de4/0x2cb0 fs/namei.c:4046
>   do_filp_open+0x20b/0x470 fs/namei.c:4073
>   do_sys_openat2+0x11b/0x1d0 fs/open.c:1435
>   do_sys_open fs/open.c:1450 [inline]
>   __do_sys_openat fs/open.c:1466 [inline]
>   __se_sys_openat fs/open.c:1461 [inline]
>   __x64_sys_openat+0x174/0x210 fs/open.c:1461
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f4ea558e9a9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f4ea645e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 00007f4ea57b6080 RCX: 00007f4ea558e9a9
> RDX: 0000000000000000 RSI: 0000200000000a80 RDI: ffffffffffffff9c
> RBP: 00007f4ea5610d69 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f4ea57b6080 R15: 00007fff25d53038
>   </TASK>
> 
> Allocated by task 9822:
>   kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>   kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>   poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>   __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
>   kmalloc_noprof include/linux/slab.h:905 [inline]
>   kzalloc_noprof include/linux/slab.h:1039 [inline]
>   disk_alloc_events+0xf0/0x3f0 block/disk-events.c:439
>   __add_disk+0x475/0xf00 block/genhd.c:500
>   add_disk_fwnode+0x3f8/0x5d0 block/genhd.c:601
>   add_disk include/linux/blkdev.h:773 [inline]
>   md_alloc+0x3c2/0x1080 drivers/md/md.c:5981
>   md_alloc_and_put drivers/md/md.c:6016 [inline]
>   md_probe drivers/md/md.c:6029 [inline]
>   md_probe+0x6e/0xd0 drivers/md/md.c:6024
>   blk_probe_dev+0x116/0x1a0 block/genhd.c:884
>   blk_request_module+0x16/0xb0 block/genhd.c:897
>   blkdev_get_no_open+0x9b/0x100 block/bdev.c:825
>   blkdev_open+0x141/0x3f0 block/fops.c:684
>   do_dentry_open+0x744/0x1c10 fs/open.c:965
>   vfs_open+0x82/0x3f0 fs/open.c:1095
>   do_open fs/namei.c:3887 [inline]
>   path_openat+0x1de4/0x2cb0 fs/namei.c:4046
>   do_filp_open+0x20b/0x470 fs/namei.c:4073
>   do_sys_openat2+0x11b/0x1d0 fs/open.c:1435
>   do_sys_open fs/open.c:1450 [inline]
>   __do_sys_openat fs/open.c:1466 [inline]
>   __se_sys_openat fs/open.c:1461 [inline]
>   __x64_sys_openat+0x174/0x210 fs/open.c:1461
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 9817:
>   kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>   kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>   kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
>   poison_slab_object mm/kasan/common.c:247 [inline]
>   __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
>   kasan_slab_free include/linux/kasan.h:233 [inline]
>   slab_free_hook mm/slub.c:2381 [inline]
>   slab_free mm/slub.c:4643 [inline]
>   kfree+0x2b4/0x4d0 mm/slub.c:4842
>   disk_release+0x161/0x410 block/genhd.c:1301
>   device_release+0xa1/0x240 drivers/base/core.c:2568
>   kobject_cleanup lib/kobject.c:689 [inline]
>   kobject_release lib/kobject.c:720 [inline]
>   kref_put include/linux/kref.h:65 [inline]
>   kobject_put+0x1e7/0x5a0 lib/kobject.c:737
>   put_device+0x1f/0x30 drivers/base/core.c:3800
>   blkdev_release+0x15/0x20 block/fops.c:699
>   __fput+0x402/0xb70 fs/file_table.c:468
>   task_work_run+0x14d/0x240 kernel/task_work.c:227
>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>   exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:114
>   exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
>   syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
>   syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
>   do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff888036fa1400
>   which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 0 bytes inside of
>   freed 512-byte region [ffff888036fa1400, ffff888036fa1600)
> 
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x36fa0
> head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000040 ffff88801b842c80 dead000000000100 dead000000000122
> raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
> head: 00fff00000000040 ffff88801b842c80 dead000000000100 dead000000000122
> head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
> head: 00fff00000000002 ffffea0000dbe801 00000000ffffffff 00000000ffffffff
> head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2, tgid 2 (kthreadd), ts 71482349709, free_ts 68765218476
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1704
>   prep_new_page mm/page_alloc.c:1712 [inline]
>   get_page_from_freelist+0x1321/0x3890 mm/page_alloc.c:3669
>   __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:4959
>   alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2419
>   alloc_slab_page mm/slub.c:2451 [inline]
>   allocate_slab mm/slub.c:2619 [inline]
>   new_slab+0x23b/0x330 mm/slub.c:2673
>   ___slab_alloc+0xd9c/0x1940 mm/slub.c:3859
>   __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3949
>   __slab_alloc_node mm/slub.c:4024 [inline]
>   slab_alloc_node mm/slub.c:4185 [inline]
>   __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4354
>   kmalloc_noprof include/linux/slab.h:905 [inline]
>   kzalloc_noprof include/linux/slab.h:1039 [inline]
>   set_kthread_struct+0xcb/0x380 kernel/kthread.c:126
>   copy_process+0x3107/0x7650 kernel/fork.c:2097
>   kernel_clone+0xfc/0x960 kernel/fork.c:2599
>   kernel_thread+0xd4/0x120 kernel/fork.c:2661
>   create_kthread kernel/kthread.c:487 [inline]
>   kthreadd+0x503/0x800 kernel/kthread.c:847
>   ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> page last free pid 6016 tgid 6016 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1248 [inline]
>   __free_frozen_pages+0x7fe/0x1180 mm/page_alloc.c:2706
>   vfree+0x1fd/0xb50 mm/vmalloc.c:3434
>   kcov_put kernel/kcov.c:439 [inline]
>   kcov_put kernel/kcov.c:435 [inline]
>   kcov_close+0x34/0x60 kernel/kcov.c:535
>   __fput+0x402/0xb70 fs/file_table.c:468
>   task_work_run+0x14d/0x240 kernel/task_work.c:227
>   exit_task_work include/linux/task_work.h:40 [inline]
>   do_exit+0x86c/0x2bd0 kernel/exit.c:964
>   do_group_exit+0xd3/0x2a0 kernel/exit.c:1105
>   get_signal+0x2673/0x26d0 kernel/signal.c:3034
>   arch_do_signal_or_restart+0x8f/0x7d0 arch/x86/kernel/signal.c:337
>   exit_to_user_mode_loop+0x84/0x110 kernel/entry/common.c:111
>   exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
>   syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
>   syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
>   do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Memory state around the buggy address:
>   ffff888036fa1300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff888036fa1380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ffff888036fa1400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                     ^
>   ffff888036fa1480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff888036fa1500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 
> 
> .
> 


