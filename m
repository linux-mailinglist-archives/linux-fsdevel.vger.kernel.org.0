Return-Path: <linux-fsdevel+bounces-353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BC27C9254
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 04:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1E4282DE7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 02:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACF61876;
	Sat, 14 Oct 2023 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED71860
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Oct 2023 02:31:45 +0000 (UTC)
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9D4A9
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 19:31:43 -0700 (PDT)
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-57eeeb2f0f1so3570499eaf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 19:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697250703; x=1697855503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKe3WfUskrhp2lC+Z58onZskswLuUC/GNtqmfwJqSCU=;
        b=muP/k+T0ZwrQQh8ZoI7QFdYPjCsU3RklT+872vawr6MPmdN0rYVM1Wp7WjaA1iW/bE
         KdLi0tKP8OORWZXNHWMO4aMeyNX3ZVw7dY+E82c8toD0Hw/xZBHp1Plrwx83LXKQOKD8
         xXSa8OdrVZu2HvnA9Hfqmfvtld7bR4XdMN/nGFn2NqAI8AMtNaQKBeMeIgxTB138ngOO
         nfGBH49a+ylG0f/ASp6QST0O7Y6QvEpZXFzwD7qV10pVg8FRtZ+sEwuv1hkxObxVfFoK
         stACaIBGm88xciUZXVQ7pja8jO7P2MewH89SdppafhRyyeQysdKZBnNX6Wdl3qnJp6xx
         CFYQ==
X-Gm-Message-State: AOJu0Yy2wLaSzwxB1k4srct85hQkHiCpiwkDnMUtvMUQK94fHnFIfihX
	FfTnzUJOkmtRqZwdUoIPdEw415a6dVVfAkBHgF0TrarcHbHU
X-Google-Smtp-Source: AGHT+IEjwxHWWlr5Re6ARaA3BvUNXLB+J1Z4UvBXFGrbIi2tLoovYfeElpvi5F11PWa5rv1dMTMyt282ckxIKcHuGg5liNgaQ4Zv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:33c8:0:b0:57b:6d64:b425 with SMTP id
 q191-20020a4a33c8000000b0057b6d64b425mr8829388ooq.1.1697250703270; Fri, 13
 Oct 2023 19:31:43 -0700 (PDT)
Date: Fri, 13 Oct 2023 19:31:43 -0700
In-Reply-To: <000000000000e9e9ee05f716c445@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000436e210607a3f9e9@google.com>
Subject: Re: [syzbot] [udf?] WARNING in udf_new_block
From: syzbot <syzbot+cc717c6c5fee9ed6e41d@syzkaller.appspotmail.com>
To: jack@suse.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has found a reproducer for the following issue on:

HEAD commit:    10a6e5feccb8 Merge tag 'drm-fixes-2023-10-13' of git://ano..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=113e0565680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11e478e28144788c
dashboard link: https://syzkaller.appspot.com/bug?extid=cc717c6c5fee9ed6e41d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16700ae5680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f897f1680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/21775b2ca981/disk-10a6e5fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dc65fd4b8051/vmlinux-10a6e5fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/77c25d5e1726/bzImage-10a6e5fe.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/0eb31cc26570/mount_5.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/57ae6a77a446/mount_9.gz
mounted in repro #3: https://storage.googleapis.com/syzbot-assets/0ed1541d7830/mount_17.gz
mounted in repro #4: https://storage.googleapis.com/syzbot-assets/92cae054e78b/mount_18.gz
mounted in repro #5: https://storage.googleapis.com/syzbot-assets/292eda4b66a9/mount_34.gz
mounted in repro #6: https://storage.googleapis.com/syzbot-assets/7066203790a0/mount_43.gz
mounted in repro #7: https://storage.googleapis.com/syzbot-assets/a204a71df92a/mount_47.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc717c6c5fee9ed6e41d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5033 at fs/udf/udfdecl.h:123 udf_add_free_space fs/udf/balloc.c:121 [inline]
WARNING: CPU: 1 PID: 5033 at fs/udf/udfdecl.h:123 udf_bitmap_new_block fs/udf/balloc.c:365 [inline]
WARNING: CPU: 1 PID: 5033 at fs/udf/udfdecl.h:123 udf_new_block+0x1dea/0x2130 fs/udf/balloc.c:725
Modules linked in:
CPU: 1 PID: 5033 Comm: syz-executor112 Not tainted 6.6.0-rc5-syzkaller-00192-g10a6e5feccb8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:udf_updated_lvid fs/udf/udfdecl.h:121 [inline]
RIP: 0010:udf_add_free_space fs/udf/balloc.c:121 [inline]
RIP: 0010:udf_bitmap_new_block fs/udf/balloc.c:365 [inline]
RIP: 0010:udf_new_block+0x1dea/0x2130 fs/udf/balloc.c:725
Code: 87 fe 0f 0b e9 64 fc ff ff 89 d9 80 e1 07 fe c1 38 c1 0f 8c 7d e3 ff ff 48 89 df e8 60 53 e2 fe e9 70 e3 ff ff e8 56 d4 87 fe <0f> 0b e9 10 ff ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c fa e3 ff
RSP: 0018:ffffc9000395f5c0 EFLAGS: 00010293
RAX: ffffffff8306378a RBX: 0000000070d0c345 RCX: ffff88807e139dc0
RDX: 0000000000000000 RSI: 0000000070d0c345 RDI: 0000000000000000
RBP: ffffc9000395f810 R08: ffffffff83063694 R09: 1ffff1100ee3b7d0
R10: dffffc0000000000 R11: ffffed100ee3b7d1 R12: 000000000000003e
R13: dffffc0000000000 R14: ffff88807e23401c R15: 00000000000000fe
FS:  00005555572c4380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2aa7df4000 CR3: 0000000075d20000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_new_inode+0x389/0xcf0 fs/udf/ialloc.c:67
 udf_create+0x21/0xe0 fs/udf/namei.c:380
 lookup_open fs/namei.c:3495 [inline]
 open_last_lookups fs/namei.c:3563 [inline]
 path_openat+0x13e7/0x3180 fs/namei.c:3793
 do_filp_open+0x234/0x490 fs/namei.c:3823
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_creat fs/open.c:1513 [inline]
 __se_sys_creat fs/open.c:1507 [inline]
 __x64_sys_creat+0x123/0x160 fs/open.c:1507
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2ab0213579
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc0fb25858 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f2ab025c04b RCX: 00007f2ab0213579
RDX: 00007f2ab0212870 RSI: 0000000000000000 RDI: 0000000020000440
RBP: 00007f2ab025c060 R08: 000000000001f21e R09: 00000000200012c0
R10: 000000000001f222 R11: 0000000000000246 R12: 00007f2ab025e158
R13: 000000000000ba30 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

