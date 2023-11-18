Return-Path: <linux-fsdevel+bounces-3113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2DC7EFDCC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 06:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AFCE1F230EF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 05:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E90D2EE;
	Sat, 18 Nov 2023 05:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f206.google.com (mail-pl1-f206.google.com [209.85.214.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7147810D0
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 21:11:25 -0800 (PST)
Received: by mail-pl1-f206.google.com with SMTP id d9443c01a7336-1ccdf149e60so33587145ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 21:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700284285; x=1700889085;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWcN2Swm6eBSy3wsn/fR0wUJrZB2K0rIKojBtFvJvxY=;
        b=Wa9nT5zPeD/NRvqZa/ziNv1uqSaWNh0Huy8V38OnHimp0qQd2QFh/pWKYKzMtu7grD
         utWvL9ulWWEgiIsiHiF2DsOVaLj+GK+GmBgIbeoVvSvBfqp1G43zNQPeTENn4WhSqwIK
         qNrbfEPQ2TDta9aLAq5sPSdLfL1pIOZTZraesxQR4yfGVTKvL+gJUI/8J1joW/0di5tr
         ZmLL6zDf42F/EFRHYT6rISLXDtnyAT9g6pVO+DMd7c4e+jDJw8hMI3JmGMC/kzyfkJ+7
         a/e0slqWqej9x2p3zzsqJURkmVjQoL3M+IoI+VbqkuFMvIcP3O2IWS6NV4AcenVIjOjx
         5NCQ==
X-Gm-Message-State: AOJu0Ywghy2NvsBEXblCYgNH2CPM9oGVkcycj4L/vTXeB/dnZxcACs1l
	JOr4uAjjFT1uxXvAbxUUfFuZMxG5OUwQGV1hcz8PlQ7xBazD
X-Google-Smtp-Source: AGHT+IHFNFhl+Z+0w/OIfFzgAmhojEud2JquzB2wDdenrvOkG4Y6yRK7wZPFphZoqdtc0pipSvt7lroKdn00M1tzl8uMd2RUu3oy
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:eacc:b0:1cc:478b:ef1 with SMTP id
 p12-20020a170902eacc00b001cc478b0ef1mr391699pld.13.1700284284997; Fri, 17 Nov
 2023 21:11:24 -0800 (PST)
Date: Fri, 17 Nov 2023 21:11:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d31668060a664897@google.com>
Subject: [syzbot] [exfat?] UBSAN: shift-out-of-bounds in exfat_fill_super (2)
From: syzbot <syzbot+d33808a177641a02213e@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9bacdd8996c7 Merge tag 'for-6.7-rc1-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12051eff680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af04b7c4d36966d8
dashboard link: https://syzkaller.appspot.com/bug?extid=d33808a177641a02213e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cf19f53338f0/disk-9bacdd89.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dd19b4c3f5a9/vmlinux-9bacdd89.xz
kernel image: https://storage.googleapis.com/syzbot-assets/227655c91334/bzImage-9bacdd89.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d33808a177641a02213e@syzkaller.appspotmail.com

UBSAN: shift-out-of-bounds in fs/exfat/super.c:503:32
shift exponent 97 is too large for 64-bit type 'long long unsigned int'
CPU: 1 PID: 11990 Comm: syz-executor.2 Not tainted 6.7.0-rc1-syzkaller-00012-g9bacdd8996c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x2a6/0x480 lib/ubsan.c:387
 exfat_read_boot_sector fs/exfat/super.c:503 [inline]
 __exfat_fill_super fs/exfat/super.c:582 [inline]
 exfat_fill_super.cold+0x119/0x12a fs/exfat/super.c:646
 get_tree_bdev+0x3b5/0x650 fs/super.c:1598
 vfs_get_tree+0x8c/0x370 fs/super.c:1771
 do_new_mount fs/namespace.c:3337 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3664
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount fs/namespace.c:3863 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3863
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f057367e1ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f05743c0ee8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f05743c0f80 RCX: 00007f057367e1ea
RDX: 00000000200001c0 RSI: 0000000020000a00 RDI: 00007f05743c0f40
RBP: 00000000200001c0 R08: 00007f05743c0f80 R09: 0000000000000004
R10: 0000000000000004 R11: 0000000000000202 R12: 0000000020000a00
R13: 00007f05743c0f40 R14: 00000000000014e6 R15: 0000000020000240
 </TASK>
================================================================================


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

