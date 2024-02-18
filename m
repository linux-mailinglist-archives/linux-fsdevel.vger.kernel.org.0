Return-Path: <linux-fsdevel+bounces-11928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADAE8593A7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 01:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7581C20E59
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 00:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D2B37B;
	Sun, 18 Feb 2024 00:06:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B505161
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708214783; cv=none; b=tilIAlCSWyOJYFppWIpXEpub1e7kWalcmjZINMp8XBmm7AollauvyNU3ehS1ayNRWTh8viWIDRxePk15LtwZB7sBJKAu+ox7oiDlRZhIFWXKZkbWrtsZ5ocuZ5vruO7P8+/n/pTj0nURsZNOjojs019OMthi86G1UJdO2iJNqNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708214783; c=relaxed/simple;
	bh=OvEN6CKCQlgrk41az4gi3fjtjd2Fdazk/Xp7dUgQ6r0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SXPyCx+vKR9Cj7ffQPdRSNg+g+yzLQNUYhqMuOri7q1Ydk1rE8z0YjTZE616SoXUpGHGJBLtCLS632biXj3JRj54iJKNtGyVzucXmiZdVjBzF+HzU+4PBdlQh3BmhBxpMTCoG76w64aJLRSFzW81M5+40obVV4ZY1zh2fCsW8Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-365256f2efcso2484035ab.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 16:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708214781; x=1708819581;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j7CMKaRMfhFX+v2G9CiAC8fkL6ixX+GdxcXL1z+0VGs=;
        b=rj+r8AnFNzWvGSZzcsjBd90KYpE2cXvShxlFRtsKQCrVV6NjxQQoTbbRhbmenshG1y
         Jc08Ww8cw77U2dAq+yWftd9SOLi6UytD3JSTMBz/E/j1zcsZaXTChb8fk7arv5vRJdNl
         hzdUaBQaedjV2agsEfhnanCAF3+4/Q6WemU4GQSkx66E84lLLMXUXVGgAo4HWEeSNLtR
         2tTeGM0tDWDtc/f7mHdxWfXw0IG7IcFa0iSjt4EY6uVV8tfhtfaUyY1eP2BZz1AafVyn
         Tze4X/A9nEaU1Y2q/+crxnPbo1V+ZJJI40EjUCsrP6zUbxssa6z9Sh2dbXzCylq8y1Dw
         Xy2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJACES+aZheLlfQoVZ6+ttmw8DK6Db+875IGGTW5uwm7nqSU5S6qwRA1SyJ+u5McJXeqxWQp7E9MJNpevz/iLIm+iYIRMK7Qz1F5t19w==
X-Gm-Message-State: AOJu0YyZSdU2kobB2JsnXhdJAAz9cohu9t+Rhs/iNz/SIIIaMgVzg813
	0shsWPHnrLaI4A/8n+kis/ESzt9E0ckb1MvEHqSd9qMsvolaSMrl3sVbdq30CSeFp0DeerH9R1t
	P905I7ckgiyD8z8kXRzy8Aq967FrKmhM/BFE4Jk3aHbxGLOLrUM240gg=
X-Google-Smtp-Source: AGHT+IF5T/qirDu2nTmZv8Y18h0wnmTMxZZYv7QKYNahp343uFmJal0PeSCH9P9fiRJ5rUzFOeV0IHhW3HD/Yq6EgnqBJda+del0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b02:b0:365:2290:7785 with SMTP id
 i2-20020a056e021b0200b0036522907785mr127521ilv.0.1708214781278; Sat, 17 Feb
 2024 16:06:21 -0800 (PST)
Date: Sat, 17 Feb 2024 16:06:21 -0800
In-Reply-To: <000000000000a7761e0610c754b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d021006119cbf46@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: slab-use-after-free Read in jfs_syncpt
From: syzbot <syzbot+c244f4a09ca85dd2ebc1@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ced590523156 Merge tag 'driver-core-6.8-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ee1872180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64757d4899f04e1b
dashboard link: https://syzkaller.appspot.com/bug?extid=c244f4a09ca85dd2ebc1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118f3658180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119df694180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-ced59052.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/268f9dfca97a/vmlinux-ced59052.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d95591974e31/bzImage-ced59052.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c890e5e09b22/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c244f4a09ca85dd2ebc1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __mutex_waiter_is_first kernel/locking/mutex.c:197 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock_common kernel/locking/mutex.c:686 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock+0x8f4/0x9d0 kernel/locking/mutex.c:752
Read of size 8 at addr ffff8880272d2908 by task jfsCommit/131

CPU: 3 PID: 131 Comm: jfsCommit Not tainted 6.8.0-rc4-syzkaller-00388-gced590523156 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:488
 kasan_report+0xda/0x110 mm/kasan/report.c:601
 __mutex_waiter_is_first kernel/locking/mutex.c:197 [inline]
 __mutex_lock_common kernel/locking/mutex.c:686 [inline]
 __mutex_lock+0x8f4/0x9d0 kernel/locking/mutex.c:752
 jfs_syncpt+0x2a/0xa0 fs/jfs/jfs_logmgr.c:1039
 txEnd+0x30d/0x5a0 fs/jfs/jfs_txnmgr.c:549
 txLazyCommit fs/jfs/jfs_txnmgr.c:2684 [inline]
 jfs_lazycommit+0x77d/0xb20 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x2c6/0x3b0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 5178:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:389
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 open_inline_log fs/jfs/jfs_logmgr.c:1159 [inline]
 lmLogOpen+0x571/0x1410 fs/jfs/jfs_logmgr.c:1069
 jfs_mount_rw+0x2ea/0x700 fs/jfs/jfs_mount.c:257
 jfs_fill_super+0x9d6/0xd20 fs/jfs/super.c:565
 mount_bdev+0x1e3/0x2d0 fs/super.c:1663
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1784
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14ea/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

Freed by task 5177:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:640
 poison_slab_object mm/kasan/common.c:241 [inline]
 __kasan_slab_free+0x121/0x1c0 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x124/0x370 mm/slub.c:4409
 lmLogClose+0x585/0x710 fs/jfs/jfs_logmgr.c:1461
 jfs_umount+0x2f0/0x440 fs/jfs/jfs_umount.c:114
 jfs_put_super+0x88/0x1d0 fs/jfs/super.c:194
 generic_shutdown_super+0x159/0x3d0 fs/super.c:646
 kill_block_super+0x3b/0x90 fs/super.c:1680
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:477
 deactivate_super+0xde/0x100 fs/super.c:510
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14f/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:108 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0x281/0x2b0 kernel/entry/common.c:212
 do_syscall_64+0xe5/0x270 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

The buggy address belongs to the object at ffff8880272d2800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 264 bytes inside of
 freed 1024-byte region [ffff8880272d2800, ffff8880272d2c00)

The buggy address belongs to the physical page:
page:ffffea00009cb400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x272d0
head:ffffea00009cb400 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888014c42dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4910, tgid 4910 (dhcpcd-run-hook), ts 31763109865, free_ts 31737584223
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3311
 __alloc_pages+0x22f/0x2440 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2190 [inline]
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2407
 ___slab_alloc+0x4af/0x19a0 mm/slub.c:3540
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3625
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc+0x3b8/0x440 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 load_elf_phdrs+0x103/0x210 fs/binfmt_elf.c:526
 load_elf_binary+0x14dc/0x4e40 fs/binfmt_elf.c:955
 search_binary_handler fs/exec.c:1783 [inline]
 exec_binprm fs/exec.c:1825 [inline]
 bprm_execve fs/exec.c:1877 [inline]
 bprm_execve+0x70a/0x1980 fs/exec.c:1853
 do_execveat_common.isra.0+0x5cf/0x750 fs/exec.c:1984
 do_execve fs/exec.c:2058 [inline]
 __do_sys_execve fs/exec.c:2134 [inline]
 __se_sys_execve fs/exec.c:2129 [inline]
 __x64_sys_execve+0x8c/0xb0 fs/exec.c:2129
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
page last free pid 4909 tgid 4909 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2346
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2486
 qlink_free mm/kasan/quarantine.c:160 [inline]
 qlist_free_all+0x58/0x150 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:324
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc+0x136/0x320 mm/slub.c:3867
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:140
 getname_flags include/linux/audit.h:322 [inline]
 getname+0x90/0xe0 fs/namei.c:219
 do_sys_openat2+0x104/0x1e0 fs/open.c:1398
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_openat fs/open.c:1435 [inline]
 __se_sys_openat fs/open.c:1430 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1430
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

Memory state around the buggy address:
 ffff8880272d2800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880272d2880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880272d2900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff8880272d2980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880272d2a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

