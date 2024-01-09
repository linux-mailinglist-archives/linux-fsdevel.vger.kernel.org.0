Return-Path: <linux-fsdevel+bounces-7649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC6B828C7A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 19:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF2428E8EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 18:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A673C47B;
	Tue,  9 Jan 2024 18:21:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41953C46B
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fc70bd879so24504545ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jan 2024 10:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824482; x=1705429282;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qVC59Vc23lgT6cCDMP/0LxeIGJAbvJ9xzH67hQSixik=;
        b=p/sVU/Gr1IRyzFowW6KS2Zo0wz59fq6sMr9yyXvHFihXVhulmCB84TtYVcMciETOU1
         u+NkXJb6GdH3qNNo2ec+W6sukRUyaduuIqg1Q2YA2lyNHb4E18A5rW6yUnVEO00dFFMG
         LjFEJabrALT2r2FNmja8kr88W2UYw4jz1ytyAPu/7hqqpIaoFcQNCLY31oorTs5PEr+a
         99YHUw5jxAp19VgEpi6F/6CriQk+96r2PEo8cSGvLXGajEJGAiz1+08VIR3B+QpHiNe+
         8+fGudl4z55kQNnUo5oEdvAsxQLuhN89vbxs38LP2/BkyXvnWA9Iw7bABxkTnUh63BQ5
         6gFg==
X-Gm-Message-State: AOJu0YyXsSnsGMnoNzPIN4uvBOTWUh5UkzIBbeq4B85Fhca5MTQ21cxH
	QNVeCL5+s0I2gQ9dK2L6HsEM1sBkVfn8ocLrjX4XII/DXkun
X-Google-Smtp-Source: AGHT+IERKeoTEFtGwaMVTAC83n/K6i2RlH970TbrnaxqeQCzDF3WTECRu6bDMsSSRc8x7je4/lvtmWezux6R8KExIjDPXOCxk1v3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6b:b0:360:6243:433f with SMTP id
 w11-20020a056e021a6b00b003606243433fmr652670ilv.1.1704824482075; Tue, 09 Jan
 2024 10:21:22 -0800 (PST)
Date: Tue, 09 Jan 2024 10:21:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a89b3d060e876153@google.com>
Subject: [syzbot] [gfs2?] KMSAN: uninit-value in inode_go_dump (3)
From: syzbot <syzbot+82373528417bbb67ec62@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2639772a11c8 get_maintainer: remove stray punctuation when..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17090a91e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4130d4bb32c48ef
dashboard link: https://syzkaller.appspot.com/bug?extid=82373528417bbb67ec62
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8ce611d4ffb7/disk-2639772a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b5d39093f7c1/vmlinux-2639772a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dfc8359e9375/bzImage-2639772a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+82373528417bbb67ec62@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: G:  s:SH n:2/13 f:qobnN t:SH d:EX/0 a:0 v:0 r:3 m:20 p:1
gfs2: fsid=syz:syz.0:  H: s:SH f:eEcH e:0 p:0 [(none)] init_inodes+0x125/0x510 fs/gfs2/ops_fstype.c:884
=====================================================
BUG: KMSAN: uninit-value in inode_go_dump+0x471/0x4b0 fs/gfs2/glops.c:549
 inode_go_dump+0x471/0x4b0 fs/gfs2/glops.c:549
 gfs2_dump_glock+0x2219/0x2340 fs/gfs2/glock.c:2373
 gfs2_consist_inode_i+0x19f/0x220 fs/gfs2/util.c:456
 gfs2_dinode_in fs/gfs2/glops.c:470 [inline]
 gfs2_inode_refresh+0xf42/0x1550 fs/gfs2/glops.c:490
 inode_go_instantiate+0x6e/0xc0 fs/gfs2/glops.c:509
 gfs2_instantiate+0x26f/0x4b0 fs/gfs2/glock.c:454
 gfs2_glock_holder_ready fs/gfs2/glock.c:1319 [inline]
 gfs2_glock_wait+0x2a4/0x3e0 fs/gfs2/glock.c:1339
 gfs2_glock_nq+0x1d9f/0x2a00 fs/gfs2/glock.c:1579
 gfs2_glock_nq_init fs/gfs2/glock.h:237 [inline]
 init_journal+0x1208/0x38b0 fs/gfs2/ops_fstype.c:790
 init_inodes+0x125/0x510 fs/gfs2/ops_fstype.c:884
 gfs2_fill_super+0x3c05/0x42a0 fs/gfs2/ops_fstype.c:1263
 get_tree_bdev+0x6b5/0x8f0 fs/super.c:1598
 gfs2_get_tree+0x5c/0x340 fs/gfs2/ops_fstype.c:1341
 vfs_get_tree+0xa5/0x520 fs/super.c:1771
 do_new_mount+0x68d/0x1550 fs/namespace.c:3337
 path_mount+0x73d/0x1f20 fs/namespace.c:3664
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3863
 __ia32_sys_mount+0xe3/0x150 fs/namespace.c:3863
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

Uninit was created at:
 __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4591
 alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
 alloc_pages+0x1be/0x1e0 mm/mempolicy.c:2204
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x421/0x1570 mm/slub.c:2070
 ___slab_alloc+0x13db/0x33d0 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc_lru+0x552/0x970 mm/slub.c:3509
 alloc_inode_sb include/linux/fs.h:2937 [inline]
 gfs2_alloc_inode+0x66/0x210 fs/gfs2/super.c:1554
 alloc_inode+0x83/0x440 fs/inode.c:261
 iget5_locked+0xa9/0x210 fs/inode.c:1271
 gfs2_inode_lookup+0xbe/0x1440 fs/gfs2/inode.c:124
 gfs2_lookup_root fs/gfs2/ops_fstype.c:460 [inline]
 init_sb+0xe62/0x1880 fs/gfs2/ops_fstype.c:527
 gfs2_fill_super+0x327e/0x42a0 fs/gfs2/ops_fstype.c:1230
 get_tree_bdev+0x6b5/0x8f0 fs/super.c:1598
 gfs2_get_tree+0x5c/0x340 fs/gfs2/ops_fstype.c:1341
 vfs_get_tree+0xa5/0x520 fs/super.c:1771
 do_new_mount+0x68d/0x1550 fs/namespace.c:3337
 path_mount+0x73d/0x1f20 fs/namespace.c:3664
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3863
 __ia32_sys_mount+0xe3/0x150 fs/namespace.c:3863
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

CPU: 0 PID: 6179 Comm: syz-executor.5 Not tainted 6.7.0-rc7-syzkaller-00051-g2639772a11c8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

