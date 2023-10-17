Return-Path: <linux-fsdevel+bounces-539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A047CC81F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 17:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51BDDB2126A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 15:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D132645F4A;
	Tue, 17 Oct 2023 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1DE450F2
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 15:53:52 +0000 (UTC)
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1273E114
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 08:53:46 -0700 (PDT)
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-1ea01dcf2ccso4676774fac.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 08:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697558026; x=1698162826;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KSb0XyCU38BNui475xyYgCEOUAo9lpZ5H7S1vx0SMI8=;
        b=K1wcME7Ik9ir4NhQEUbst2nbCeTU3JCjg9anElKXm/ZhIAvVC1l+MI3tDcO8lUOsG9
         6KoI/reDB5zS1t43V2RJ37yoIV5qczysBQbQ6VRyD7PznYNztB8Soyt9s0bjxLpC6lUU
         /GDJ85uxk8yV2aeYDUnBrVf8shWRPRr0mnNvzIHFop3oZUv/1QDyu/JNx0BTgROJ5NpL
         f6fKfenC4JM4xD9tWwiRHPcnywnRXyCOuBERDIfwxef4/3V157gP7oKwGlBsi2PGqVoM
         z2VOVyiFEB4dkIo1H5qYjid2cr9LLiPa2brXi2u7U8KETaZPsGqQBPZKmHO8wrcIfJUA
         ZzXw==
X-Gm-Message-State: AOJu0Yxmda5In/b8afQokGwIv3sECgYGig8ALp1W5xPtFzg6KQoJxRQf
	otBrq/m6kGn3vaacSVjr7+wyTCF3YFOOpSN5BdTE89LQG0s0
X-Google-Smtp-Source: AGHT+IEGQT98DKVHdiFnHMkzKzazgsdC17X7KhLEqVs3JN8DOyFE591GTNasywWXN1MShMGWKANruRmWJVdbMQYlSsUVSiMhjeT3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:8197:b0:1e9:a86f:ec44 with SMTP id
 k23-20020a056870819700b001e9a86fec44mr899339oae.2.1697558025799; Tue, 17 Oct
 2023 08:53:45 -0700 (PDT)
Date: Tue, 17 Oct 2023 08:53:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d10130607eb873a@google.com>
Subject: [syzbot] [bfs?] WARNING in mark_buffer_dirty (6)
From: syzbot <syzbot+d98fd19acd08b36ff422@syzkaller.appspotmail.com>
To: aivazian.tigran@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    727fb8376504 Merge tag 'input-for-v6.6-rc5' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=165b5361680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32d0b9b42ceb8b10
dashboard link: https://syzkaller.appspot.com/bug?extid=d98fd19acd08b36ff422
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ab3d03680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1651329d680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/756c4ab74278/disk-727fb837.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f8c21021e277/vmlinux-727fb837.xz
kernel image: https://storage.googleapis.com/syzbot-assets/46bc1f7ddaac/bzImage-727fb837.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/05fb682fb025/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d98fd19acd08b36ff422@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5092 at fs/buffer.c:1188 mark_buffer_dirty+0x376/0x3e0 fs/buffer.c:1188
Modules linked in:
CPU: 0 PID: 5092 Comm: syz-executor341 Not tainted 6.6.0-rc5-syzkaller-00243-g727fb8376504 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:mark_buffer_dirty+0x376/0x3e0 fs/buffer.c:1188
Code: e9 ff e6 89 ff e8 fa e6 89 ff 48 89 ef e8 42 87 e7 ff 5b 5d e9 eb e6 89 ff e8 e6 e6 89 ff 0f 0b e9 10 fe ff ff e8 da e6 89 ff <0f> 0b e9 b7 fc ff ff e8 ce e6 89 ff 0f 0b e9 d6 fc ff ff 48 89 df
RSP: 0018:ffffc90003bcf968 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888076754488 RCX: 0000000000000000
RDX: ffff8880268f1dc0 RSI: ffffffff81fde006 RDI: 0000000000000001
RBP: ffff888076753e00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000009
R13: ffff8880275ca000 R14: dffffc0000000000 R15: ffffed1004eb942c
FS:  00007ff0e3a7f6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020004000 CR3: 00000000177ca000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 bfs_move_block fs/bfs/file.c:43 [inline]
 bfs_move_blocks fs/bfs/file.c:56 [inline]
 bfs_get_block+0x37f/0xdd0 fs/bfs/file.c:125
 __block_write_begin_int+0x3c0/0x1560 fs/buffer.c:2120
 __block_write_begin fs/buffer.c:2169 [inline]
 block_write_begin+0xb1/0x490 fs/buffer.c:2228
 bfs_write_begin+0x31/0xd0 fs/bfs/file.c:177
 generic_perform_write+0x278/0x600 mm/filemap.c:3969
 __generic_file_write_iter+0x1f9/0x240 mm/filemap.c:4064
 generic_file_write_iter+0xe3/0x350 mm/filemap.c:4090
 call_write_iter include/linux/fs.h:1956 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x650/0xe40 fs/read_write.c:584
 ksys_write+0x12f/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff0e3ac2b99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff0e3a7f218 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ff0e3b4a6c8 RCX: 00007ff0e3ac2b99
RDX: 000000000208e24b RSI: 0000000020000440 RDI: 0000000000000004
RBP: 00007ff0e3b4a6c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff0e3b170c0
R13: 00007ff0e3b1706b R14: 0030656c69662f2e R15: 0031656c69662f2e
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

