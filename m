Return-Path: <linux-fsdevel+bounces-3179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 860147F0B26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 04:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39DB51F20F53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 03:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FE420F1;
	Mon, 20 Nov 2023 03:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f208.google.com (mail-pf1-f208.google.com [209.85.210.208])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0248F
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 19:50:27 -0800 (PST)
Received: by mail-pf1-f208.google.com with SMTP id d2e1a72fcca58-6c334d2fd4cso4648430b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 19:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700452227; x=1701057027;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czWDBWKNMx3iL4sQ2kMeYwYKfl4VMxxHXVsrj8HASI0=;
        b=I5IyZOmIGy9Rnf7z0pHLq8hcYboxXnpBCT6r+gVowjenKLECL76qYd+frlgARiU5Hx
         hp8x7K+5tnVvgMwKbfVNYXReeFSxI4TV8idHTnw+M38gbNUJAStPjGYtN46YrxbVBUIV
         kpgrOoC2hpD7iSgFjukuBxGJOInTwhtLfeEIL03SGe9UVLKZtqAZXjxZchFQZCbExM+Q
         vm6PiNOcT64jcYTNiBf+JzC6vwHlcpo/6AojaYnbANWzJIWsKz381YQ7YD4Iyn1EM53l
         TMjQVJduxuTZ9FzZGI4IgqPctjVb4jdMApuX544UH+2jFJPiAhHjy8HIQrI/fnqV7+QE
         i7TQ==
X-Gm-Message-State: AOJu0Yxe+cJ7jdcGneh0HitcWQMUP3zd52QR00zsuoSNQsoy/FXIuZfT
	cAPWbJ3Ez53DksgvhTW9GlH8C4Sz9mJ8TIv68XK1a64LjZkqEU3oDw==
X-Google-Smtp-Source: AGHT+IFT795D8JvUueZa1FFE8gxM4w6QEySorD4GxB3+DZudXhtoe2Op9Q9XggE51CLT3Dy+shCOs7FyRPNYIaMFSIKJYTXXe514
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:868c:b0:6be:2f41:71be with SMTP id
 hh12-20020a056a00868c00b006be2f4171bemr1442899pfb.3.1700452226890; Sun, 19
 Nov 2023 19:50:26 -0800 (PST)
Date: Sun, 19 Nov 2023 19:50:26 -0800
In-Reply-To: <000000000000b987aa060919b4b1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f106d0060a8d62ac@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in __block_write_full_folio
From: syzbot <syzbot+c2827a62c6978df9ccc3@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8de1e7afcc1c Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1036a73f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=c2827a62c6978df9ccc3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126637b7680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12939214e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f00907f9764/disk-8de1e7af.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0502fe78c60d/vmlinux-8de1e7af.xz
kernel image: https://storage.googleapis.com/syzbot-assets/192135168cc0/Image-8de1e7af.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3d0ab932b67b/mount_6.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2827a62c6978df9ccc3@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/buffer.c:1901!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 6625 Comm: syz-executor137 Not tainted 6.6.0-rc7-syzkaller-g8de1e7afcc1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __block_write_full_folio+0xd80/0xe24 fs/buffer.c:1901
lr : __block_write_full_folio+0xd80/0xe24 fs/buffer.c:1901
sp : ffff800099656560
x29: ffff8000996565c0 x28: fffffc000376da80 x27: 1fffe0001b945bb3
x26: dfff800000000000 x25: ffff0000dca2d570 x24: 0000000000000080
x23: 0000000000000002 x22: 0000000000000004 x21: ffff0000dca2d570
x20: ffff0000dca2d570 x19: 05ffc0000000811f x18: ffff8000996557a0
x17: ffff80008e33d000 x16: ffff80008a71b360 x15: 0000000000000001
x14: 1fffe0003683238c x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000ce618000 x7 : ffff8000807d0e78 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000007 x1 : 0000000000000002 x0 : 0000000000000000
Call trace:
 __block_write_full_folio+0xd80/0xe24 fs/buffer.c:1901
 block_write_full_page+0x544/0x660
 hfsplus_writepage+0x30/0x40 fs/hfsplus/inode.c:33
 writeout mm/migrate.c:897 [inline]
 fallback_migrate_folio mm/migrate.c:921 [inline]
 move_to_new_folio+0x624/0xc24 mm/migrate.c:970
 migrate_folio_move mm/migrate.c:1274 [inline]
 migrate_pages_batch+0x1a2c/0x25f4 mm/migrate.c:1759
 migrate_pages_sync mm/migrate.c:1847 [inline]
 migrate_pages+0x1b9c/0x302c mm/migrate.c:1929
 compact_zone+0x274c/0x4158 mm/compaction.c:2515
 compact_node+0x234/0x3c0 mm/compaction.c:2812
 compact_nodes mm/compaction.c:2825 [inline]
 sysctl_compaction_handler+0x110/0x1d4 mm/compaction.c:2871
 proc_sys_call_handler+0x4cc/0x7cc fs/proc/proc_sysctl.c:600
 proc_sys_write+0x2c/0x3c fs/proc/proc_sysctl.c:626
 do_iter_write+0x65c/0xaa8 fs/read_write.c:860
 vfs_iter_write+0x88/0xac fs/read_write.c:901
 iter_file_splice_write+0x628/0xc58 fs/splice.c:736
 do_splice_from fs/splice.c:933 [inline]
 direct_splice_actor+0xe4/0x1c0 fs/splice.c:1142
 splice_direct_to_actor+0x2a0/0x7e4 fs/splice.c:1088
 do_splice_direct+0x20c/0x348 fs/splice.c:1194
 do_sendfile+0x4b8/0xcc4 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1316 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __arm64_sys_sendfile64+0x23c/0x3b4 fs/read_write.c:1308
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
Code: aa1c03e0 97f37837 d4210000 97e5ff75 (d4210000) 
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

