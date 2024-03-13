Return-Path: <linux-fsdevel+bounces-14293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361A287A980
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 15:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7FE01F22A42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 14:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0638E3C38;
	Wed, 13 Mar 2024 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJOUYQ0D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5889B17F3;
	Wed, 13 Mar 2024 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340347; cv=none; b=FDXPOAE0GpceEFXTkrLgeB7jglpbG7RdMH7ECGEdUvySFENKvvdwVA6IvgIB81Ew8U8NVmIeFqOQmGqrCdZmER+9dLIR0nCyTMu5TOznKwn59X+u9WMU/fE+S3hk4QAUcAW4X9bdgFeVGIg3cqQx/fBuciEbfj4Ttvq/Hb19hS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340347; c=relaxed/simple;
	bh=Y3zK9R6I5zScUZrIlgtZ3Eok/UhFNRnl5zVDEdG8Yw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lkwf0mrqdjx4GFK+Qrx0mLG95ZMsuhsGujwsPfraEm0nv5lYPwMeb4W4b/xIF+Ife1UVn8PgzsMucCXnPjSnIn7ZMsbVLJSmcWxiIy2txTpSeCWBhDDPp01DX5Dy22U5naK48XIzOlBHDMH0vgBNyWn0b5aNMC6Z1M2oSvfVI+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJOUYQ0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27336C433F1;
	Wed, 13 Mar 2024 14:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710340344;
	bh=Y3zK9R6I5zScUZrIlgtZ3Eok/UhFNRnl5zVDEdG8Yw4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=GJOUYQ0DDvJfjbRB7Zz43EmzqVbrWiLziIdwA2ija5wy9Q2y6p2A42k7DSuAhxDmX
	 ZusTqkrJmrjOzcrXBKJMZD1VtvTZtq8KdjmMW4GWVgmxIeNXSpdEYhf54k7zRPsj39
	 KO2nMLnJNzUIzQ+nUdIda4zywIaqhugdTU0MH95/ISGSwwxdVEZ4ZUdBb6o1EQ23e9
	 Drb9sq3lK+G0rchH3ZpE5PR6jAcHrm8dCdXoi7jTQPKeaB2WAlaf27eOsJCkdx3xSN
	 HZta7H2tWMNOJkPy7MZjTbm0gfaTKu1P5YOlnJs/hiB4QC3NLBq7SiHl0uWYtEkoE1
	 aW32CfObnpo4A==
Message-ID: <21fc3ed1-de3d-4027-b775-ef061eaca53d@kernel.org>
Date: Wed, 13 Mar 2024 22:32:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in
 f2fs_filemap_fault
Content-Language: en-US
To: syzbot <syzbot+763afad57075d3f862f2@syzkaller.appspotmail.com>,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <0000000000000b4e27060ef8694c@google.com>
From: Chao Yu <chao@kernel.org>
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <0000000000000b4e27060ef8694c@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip

On 2024/1/15 17:12, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14bb9913e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=490fc2f9d4ae426c
> dashboard link: https://syzkaller.appspot.com/bug?extid=763afad57075d3f862f2
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d9fbcbe80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1422d5ebe80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/51de89c7a81e/disk-052d5343.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7e03b92536a3/vmlinux-052d5343.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3d91124eb5ff/bzImage-052d5343.xz
> mounted in repro #1: https://storage.googleapis.com/syzbot-assets/f67519526788/mount_0.gz
> mounted in repro #2: https://storage.googleapis.com/syzbot-assets/7e871268c842/mount_7.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+763afad57075d3f862f2@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in f2fs_filemap_fault+0xd1/0x2c0 fs/f2fs/file.c:49
> Read of size 8 at addr ffff88807bb22680 by task syz-executor184/5058
> 
> CPU: 0 PID: 5058 Comm: syz-executor184 Not tainted 6.7.0-syzkaller-09928-g052d534373b7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>   print_address_description mm/kasan/report.c:377 [inline]
>   print_report+0x163/0x540 mm/kasan/report.c:488
>   kasan_report+0x142/0x170 mm/kasan/report.c:601
>   f2fs_filemap_fault+0xd1/0x2c0 fs/f2fs/file.c:49
>   __do_fault+0x131/0x450 mm/memory.c:4376
>   do_shared_fault mm/memory.c:4798 [inline]
>   do_fault mm/memory.c:4872 [inline]
>   do_pte_missing mm/memory.c:3745 [inline]
>   handle_pte_fault mm/memory.c:5144 [inline]
>   __handle_mm_fault+0x23b7/0x72b0 mm/memory.c:5285
>   handle_mm_fault+0x27e/0x770 mm/memory.c:5450
>   do_user_addr_fault arch/x86/mm/fault.c:1364 [inline]
>   handle_page_fault arch/x86/mm/fault.c:1507 [inline]
>   exc_page_fault+0x456/0x870 arch/x86/mm/fault.c:1563
>   asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
> RIP: 0033:0x7f808e742b50
> Code: 20 bf 02 00 00 00 e8 9f 24 04 00 48 83 f8 ff 0f 84 08 fa ff ff 48 89 05 e6 65 0c 00 e9 fc f9 ff ff 66 0f 1f 84 00 00 00 00 00 <c7> 04 25 40 00 00 20 66 32 66 73 c6 04 25 44 00 00 20 00 e9 0f fa
> RSP: 002b:00007f808e735170 EFLAGS: 00010246
> 
> RAX: 0000000000000000 RBX: 00007f808e80b6e8 RCX: 00007f808e784fe9
> RDX: 86d0f56bab720225 RSI: 0000000000000000 RDI: 00007f808e7355a0
> RBP: 00007f808e80b6e0 R08: 0000000000000000 R09: 00007f808e7356c0
> R10: 00007f808e80b6e0 R11: 0000000000000246 R12: 00007f808e80b6ec
> R13: 0000000000000000 R14: 00007fff41e6fc30 R15: 00007fff41e6fd18
>   </TASK>
> 
> Allocated by task 5058:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3f/0x70 mm/kasan/common.c:68
>   unpoison_slab_object mm/kasan/common.c:314 [inline]
>   __kasan_slab_alloc+0x66/0x70 mm/kasan/common.c:340
>   kasan_slab_alloc include/linux/kasan.h:201 [inline]
>   slab_post_alloc_hook mm/slub.c:3813 [inline]
>   slab_alloc_node mm/slub.c:3860 [inline]
>   kmem_cache_alloc+0x16f/0x340 mm/slub.c:3867
>   vm_area_alloc+0x24/0x1d0 kernel/fork.c:465
>   mmap_region+0xbd8/0x1f90 mm/mmap.c:2804
>   do_mmap+0x76b/0xde0 mm/mmap.c:1379
>   vm_mmap_pgoff+0x1e2/0x420 mm/util.c:556
>   ksys_mmap_pgoff+0x4ff/0x6d0 mm/mmap.c:1425
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Freed by task 5064:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3f/0x70 mm/kasan/common.c:68
>   kasan_save_free_info+0x4e/0x60 mm/kasan/generic.c:634
>   poison_slab_object+0xa6/0xe0 mm/kasan/common.c:241
>   __kasan_slab_free+0x34/0x60 mm/kasan/common.c:257
>   kasan_slab_free include/linux/kasan.h:184 [inline]
>   slab_free_hook mm/slub.c:2121 [inline]
>   slab_free mm/slub.c:4299 [inline]
>   kmem_cache_free+0x102/0x2a0 mm/slub.c:4363
>   rcu_do_batch kernel/rcu/tree.c:2158 [inline]
>   rcu_core+0xad8/0x17c0 kernel/rcu/tree.c:2433
>   __do_softirq+0x2b8/0x939 kernel/softirq.c:553
> 
> Last potentially related work creation:
>   kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
>   __kasan_record_aux_stack+0xae/0x100 mm/kasan/generic.c:580
>   __call_rcu_common kernel/rcu/tree.c:2683 [inline]
>   call_rcu+0x167/0xa80 kernel/rcu/tree.c:2797
>   remove_vma mm/mmap.c:148 [inline]
>   remove_mt mm/mmap.c:2283 [inline]
>   do_vmi_align_munmap+0x159d/0x1930 mm/mmap.c:2629
>   do_vmi_munmap+0x24d/0x2d0 mm/mmap.c:2693
>   mmap_region+0x677/0x1f90 mm/mmap.c:2744
>   do_mmap+0x76b/0xde0 mm/mmap.c:1379
>   vm_mmap_pgoff+0x1e2/0x420 mm/util.c:556
>   ksys_mmap_pgoff+0x4ff/0x6d0 mm/mmap.c:1425
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> The buggy address belongs to the object at ffff88807bb22660
>   which belongs to the cache vm_area_struct of size 192
> The buggy address is located 32 bytes inside of
>   freed 192-byte region [ffff88807bb22660, ffff88807bb22720)
> 
> The buggy address belongs to the physical page:
> page:ffffea0001eec880 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7bb22
> flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
> page_type: 0xffffffff()
> raw: 00fff00000000800 ffff8880142a1b40 dead000000000122 0000000000000000
> raw: 0000000000000000 00000000800f000f 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 5039, tgid 5039 (sshd), ts 50202976366, free_ts 44674399535
>   set_page_owner include/linux/page_owner.h:31 [inline]
>   post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1533
>   prep_new_page mm/page_alloc.c:1540 [inline]
>   get_page_from_freelist+0x33ea/0x3570 mm/page_alloc.c:3311
>   __alloc_pages+0x255/0x680 mm/page_alloc.c:4567
>   __alloc_pages_node include/linux/gfp.h:238 [inline]
>   alloc_pages_node include/linux/gfp.h:261 [inline]
>   alloc_slab_page+0x5f/0x160 mm/slub.c:2190
>   allocate_slab mm/slub.c:2354 [inline]
>   new_slab+0x84/0x2f0 mm/slub.c:2407
>   ___slab_alloc+0xd17/0x13d0 mm/slub.c:3540
>   __slab_alloc mm/slub.c:3625 [inline]
>   __slab_alloc_node mm/slub.c:3678 [inline]
>   slab_alloc_node mm/slub.c:3850 [inline]
>   kmem_cache_alloc+0x249/0x340 mm/slub.c:3867
>   vm_area_dup+0x27/0x280 kernel/fork.c:480
>   dup_mmap kernel/fork.c:695 [inline]
>   dup_mm kernel/fork.c:1685 [inline]
>   copy_mm+0xd90/0x21b0 kernel/fork.c:1734
>   copy_process+0x1d6f/0x3fb0 kernel/fork.c:2496
>   kernel_clone+0x222/0x840 kernel/fork.c:2901
>   __do_sys_clone kernel/fork.c:3044 [inline]
>   __se_sys_clone kernel/fork.c:3028 [inline]
>   __x64_sys_clone+0x258/0x2a0 kernel/fork.c:3028
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
> page last free pid 5037 tgid 5037 stack trace:
>   reset_page_owner include/linux/page_owner.h:24 [inline]
>   free_pages_prepare mm/page_alloc.c:1140 [inline]
>   free_unref_page_prepare+0x959/0xa80 mm/page_alloc.c:2346
>   free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
>   pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
>   pipe_update_tail fs/pipe.c:234 [inline]
>   pipe_read+0x6ee/0x13e0 fs/pipe.c:354
>   call_read_iter include/linux/fs.h:2079 [inline]
>   new_sync_read fs/read_write.c:395 [inline]
>   vfs_read+0x662/0x900 fs/read_write.c:476
>   ksys_read+0x1a0/0x2c0 fs/read_write.c:619
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Memory state around the buggy address:
>   ffff88807bb22580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   ffff88807bb22600: 00 00 fc fc fc fc fc fc fc fc fc fc fa fb fb fb
>> ffff88807bb22680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                     ^
>   ffff88807bb22700: fb fb fb fb fc fc fc fc fc fc fc fc fc fc 00 00
>   ffff88807bb22780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

