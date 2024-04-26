Return-Path: <linux-fsdevel+bounces-17894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C798B380B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 15:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E56C284128
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 13:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E7D146D6A;
	Fri, 26 Apr 2024 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DV6M4qnf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E232413F436;
	Fri, 26 Apr 2024 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137166; cv=none; b=RWmtZUHIAMGxPXo7olHeD5y2TQykSyjTHSyv8QcMjETYAFYi0OcwUMlv1TejLb+80nrYIy4FtMbI2GxwdsbRJ7eBTDDV/LQ/sc2G4xtKB1hwQ2LAPRsTPXV7TLGKM5DburGjE3ngO0pM1LpA55TQD2C5KSeKCpy/I84KJ4NrIaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137166; c=relaxed/simple;
	bh=2fEgbRDowaTm66qyV4Co8XGrR2VhH1xyHIFbs/OS0Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hD8oftwWpi2crCotlWHYa5qKeQjf6O4Up2Xkj5tq8ROJUA/WDEcrsL2EWEqcf1VI4jboWGga3GVG5MmJ3SC4BRJf2Vj+YPXPVw08wj3qHxQ6Ge+ifwNjd/2Jb7jgf09aF3K5yIj4DuX215yNWdLzwfiulGrw84FOhqRRF3dsSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DV6M4qnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28569C113CD;
	Fri, 26 Apr 2024 13:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714137165;
	bh=2fEgbRDowaTm66qyV4Co8XGrR2VhH1xyHIFbs/OS0Q4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=DV6M4qnfvdb51kigk2gKO651QfQq19aSROZeVKHAA3NoLPIg7+Zo/rmJizp5OyQwK
	 og4bq6ZkeEmufyBwIKrzN5MiMykDq2yZ3tCv8K1iMHKfJzdUb+f1bDtetX8pZvCZMX
	 1/IWc48qR3tvmC4RqyQv2W/OZqpnjr1FjVMc0KF+OE7oAFpeQXs+lcg5GBR6xfNjOb
	 t8rG/7e3gS2wk3Q4lvOlwU0mgA+ynSLgCwlKFZA2z1dA/jAuzXDvZOcBg7idVPKIsC
	 CuaY8FeFI1wybyb/YtaUfdS3KQclOXLE/ggIW1eJpYLF+ZU1J1uN4fs3bbXj0k3SlP
	 N9712M02r440A==
Message-ID: <c0a1b8d8-4b54-4881-b924-406e0e2cbca5@kernel.org>
Date: Fri, 26 Apr 2024 21:12:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [f2fs?] KASAN: slab-out-of-bounds Read in
 f2fs_get_node_info
To: syzbot <syzbot+3694e283cf5c40df6d14@syzkaller.appspotmail.com>,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <00000000000094036c0616e72a1d@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <00000000000094036c0616e72a1d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/syzbot

On 2024/4/25 15:59, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ed30a4a51bb1 Linux 6.9-rc5
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1116bc30980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
> dashboard link: https://syzkaller.appspot.com/bug?extid=3694e283cf5c40df6d14
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1128486b180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1516bc30980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7a2e1a02882c/disk-ed30a4a5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/329966999344/vmlinux-ed30a4a5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1befbdf4dcac/bzImage-ed30a4a5.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/42ddf2738cf7/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3694e283cf5c40df6d14@syzkaller.appspotmail.com
> 
> F2FS-fs (loop0): Mounted with checkpoint version = 48b305e4
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in f2fs_test_bit fs/f2fs/f2fs.h:2933 [inline]
> BUG: KASAN: slab-out-of-bounds in current_nat_addr fs/f2fs/node.h:213 [inline]
> BUG: KASAN: slab-out-of-bounds in f2fs_get_node_info+0xece/0x1200 fs/f2fs/node.c:600
> Read of size 1 at addr ffff88807a58c76c by task syz-executor280/5076
> 
> CPU: 1 PID: 5076 Comm: syz-executor280 Not tainted 6.9.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>   print_address_description mm/kasan/report.c:377 [inline]
>   print_report+0x169/0x550 mm/kasan/report.c:488
>   kasan_report+0x143/0x180 mm/kasan/report.c:601
>   f2fs_test_bit fs/f2fs/f2fs.h:2933 [inline]
>   current_nat_addr fs/f2fs/node.h:213 [inline]
>   f2fs_get_node_info+0xece/0x1200 fs/f2fs/node.c:600
>   f2fs_xattr_fiemap fs/f2fs/data.c:1848 [inline]
>   f2fs_fiemap+0x55d/0x1ee0 fs/f2fs/data.c:1925
>   ioctl_fiemap fs/ioctl.c:220 [inline]
>   do_vfs_ioctl+0x1c07/0x2e50 fs/ioctl.c:838
>   __do_sys_ioctl fs/ioctl.c:902 [inline]
>   __se_sys_ioctl+0x81/0x170 fs/ioctl.c:890
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f60d34ae739
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc9f2f1148 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ffc9f2f1318 RCX: 00007f60d34ae739
> RDX: 0000000020000040 RSI: 00000000c020660b RDI: 0000000000000004
> RBP: 00007f60d3527610 R08: 0000000000000000 R09: 00007ffc9f2f1318
> R10: 000000000000551a R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffc9f2f1308 R14: 0000000000000001 R15: 0000000000000001
>   </TASK>
> 
> Allocated by task 5076:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>   poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>   __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>   kasan_kmalloc include/linux/kasan.h:211 [inline]
>   __do_kmalloc_node mm/slub.c:3966 [inline]
>   __kmalloc_node_track_caller+0x24e/0x4e0 mm/slub.c:3986
>   kmemdup+0x2a/0x60 mm/util.c:131
>   init_node_manager fs/f2fs/node.c:3268 [inline]
>   f2fs_build_node_manager+0x8cc/0x2870 fs/f2fs/node.c:3329
>   f2fs_fill_super+0x583c/0x8120 fs/f2fs/super.c:4540
>   mount_bdev+0x20a/0x2d0 fs/super.c:1658
>   legacy_get_tree+0xee/0x190 fs/fs_context.c:662
>   vfs_get_tree+0x90/0x2a0 fs/super.c:1779
>   do_new_mount+0x2be/0xb40 fs/namespace.c:3352
>   do_mount fs/namespace.c:3692 [inline]
>   __do_sys_mount fs/namespace.c:3898 [inline]
>   __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff88807a58c700
>   which belongs to the cache kmalloc-64 of size 64
> The buggy address is located 44 bytes to the right of
>   allocated 64-byte region [ffff88807a58c700, ffff88807a58c740)
> 
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7a58c
> flags: 0xfff80000000800(slab|node=0|zone=1|lastcpupid=0xfff)
> page_type: 0xffffffff()
> raw: 00fff80000000800 ffff888015041640 ffffea0000aa6400 dead000000000004
> raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY), pid 4536, tgid 106643948 (udevd), ts 4536, free_ts 43042041281
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
>   prep_new_page mm/page_alloc.c:1541 [inline]
>   get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
>   __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
>   __alloc_pages_node include/linux/gfp.h:238 [inline]
>   alloc_pages_node include/linux/gfp.h:261 [inline]
>   alloc_slab_page+0x5f/0x160 mm/slub.c:2175
>   allocate_slab mm/slub.c:2338 [inline]
>   new_slab+0x84/0x2f0 mm/slub.c:2391
>   ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
>   __slab_alloc mm/slub.c:3610 [inline]
>   __slab_alloc_node mm/slub.c:3663 [inline]
>   slab_alloc_node mm/slub.c:3835 [inline]
>   __do_kmalloc_node mm/slub.c:3965 [inline]
>   __kmalloc+0x2e5/0x4a0 mm/slub.c:3979
>   kmalloc include/linux/slab.h:632 [inline]
>   kzalloc include/linux/slab.h:749 [inline]
>   tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
>   tomoyo_encode+0x26f/0x540 security/tomoyo/realpath.c:80
>   tomoyo_realpath_from_path+0x59e/0x5e0 security/tomoyo/realpath.c:283
>   tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>   tomoyo_path_number_perm+0x23a/0x880 security/tomoyo/file.c:723
>   tomoyo_path_mknod+0x176/0x1b0 security/tomoyo/tomoyo.c:252
>   security_path_mknod+0xf8/0x150 security/security.c:1791
>   may_o_create fs/namei.c:3319 [inline]
>   lookup_open fs/namei.c:3460 [inline]
>   open_last_lookups fs/namei.c:3566 [inline]
>   path_openat+0xc7c/0x3240 fs/namei.c:3796
>   do_filp_open+0x235/0x490 fs/namei.c:3826
>   do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
>   do_sys_open fs/open.c:1421 [inline]
>   __do_sys_openat fs/open.c:1437 [inline]
>   __se_sys_openat fs/open.c:1432 [inline]
>   __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
> page last free pid 4528 tgid 4528 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1141 [inline]
>   free_unref_page_prepare+0x97b/0xaa0 mm/page_alloc.c:2347
>   free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
>   __slab_free+0x31b/0x3d0 mm/slub.c:4192
>   qlink_free mm/kasan/quarantine.c:163 [inline]
>   qlist_free_all+0x5e/0xc0 mm/kasan/quarantine.c:179
>   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
>   kasan_slab_alloc include/linux/kasan.h:201 [inline]
>   slab_post_alloc_hook mm/slub.c:3798 [inline]
>   slab_alloc_node mm/slub.c:3845 [inline]
>   __do_kmalloc_node mm/slub.c:3965 [inline]
>   __kmalloc+0x1e2/0x4a0 mm/slub.c:3979
>   kmalloc include/linux/slab.h:632 [inline]
>   kzalloc include/linux/slab.h:749 [inline]
>   tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
>   tomoyo_encode+0x26f/0x540 security/tomoyo/realpath.c:80
>   tomoyo_realpath_from_path+0x59e/0x5e0 security/tomoyo/realpath.c:283
>   tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>   tomoyo_path_number_perm+0x23a/0x880 security/tomoyo/file.c:723
>   tomoyo_path_mknod+0x176/0x1b0 security/tomoyo/tomoyo.c:252
>   security_path_mknod+0xf8/0x150 security/security.c:1791
>   may_o_create fs/namei.c:3319 [inline]
>   lookup_open fs/namei.c:3460 [inline]
>   open_last_lookups fs/namei.c:3566 [inline]
>   path_openat+0xc7c/0x3240 fs/namei.c:3796
>   do_filp_open+0x235/0x490 fs/namei.c:3826
>   do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
>   do_sys_open fs/open.c:1421 [inline]
>   __do_sys_openat fs/open.c:1437 [inline]
>   __se_sys_openat fs/open.c:1432 [inline]
>   __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
> 
> Memory state around the buggy address:
>   ffff88807a58c600: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>   ffff88807a58c680: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>> ffff88807a58c700: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>                                                            ^
>   ffff88807a58c780: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>   ffff88807a58c800: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
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

