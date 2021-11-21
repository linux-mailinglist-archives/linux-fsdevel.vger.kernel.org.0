Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C1B45864E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Nov 2021 21:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhKUUcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Nov 2021 15:32:25 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:43671 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbhKUUcZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Nov 2021 15:32:25 -0500
Received: by mail-io1-f69.google.com with SMTP id j13-20020a0566022ccd00b005e9684c80c6so9497604iow.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Nov 2021 12:29:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=HPyoETOCBjBL9zwWlrxZDkqaoPWkh2w9rg5ZP4PDyfo=;
        b=zXP53UPkUrEa1iZcerBL43BdzC+G7eaELzsZ7N/wGtIw6vdkrKUYWljC9rHr9GOMWI
         5Efauvy2xLGzLM375ikmwIY4Gqdzl7Z5aCcx8FBNmNQQvXfnav606JVELAH6BnY6CZaa
         zYEQ7uUQfb4tHNwhifCWEO0Y8gd5CrtFxIU+pCCbYX7rQ10XydF8PyY3eJTuNjz5nQg3
         /UAHI0qacAURyWqx9Lw3tndRStG8NUKOCWDUw+qeA64kfaXDIeMQTM5hp+y++CuzFpwL
         80TaUTQ3JuiV/XogApaMwwzFhOLKIoDcgtr0b3uk1KTM9mwCoBUi06vN92KaaNbYrrto
         oKVw==
X-Gm-Message-State: AOAM533/4pJZaTv+RxpFPIpuQnO0fk0Id5xstbxiykpDxx9m8R0nmCOt
        hp9z7p5JSZWxstbYqHJdWeeGL/mxqqZFX/bupJAVU9Zt55no
X-Google-Smtp-Source: ABdhPJzVKT0RtmbehmQ6s+MNul/pvqkYTltNtUp06L4qTLWEgrB1JpFxVNh3t0HWKU3eO4Mn8bBi+9/YRvyS2mU0m6rVd6DDJLc5
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e5:: with SMTP id q5mr10071635ilv.63.1637526559818;
 Sun, 21 Nov 2021 12:29:19 -0800 (PST)
Date:   Sun, 21 Nov 2021 12:29:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e88cad05d1525c27@google.com>
Subject: [syzbot] WARNING in fuse_writepage_locked
From:   syzbot <syzbot+d0dd8d6b123d46c4dcf2@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    42eb8fdac2fc Merge tag 'gfs2-v5.16-rc2-fixes' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137ec159b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d3b8fd1977c1e73
dashboard link: https://syzkaller.appspot.com/bug?extid=d0dd8d6b123d46c4dcf2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d0dd8d6b123d46c4dcf2@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 17813 at fs/fuse/file.c:1833 fuse_write_file_get fs/fuse/file.c:1833 [inline]
WARNING: CPU: 1 PID: 17813 at fs/fuse/file.c:1833 fuse_write_file_get fs/fuse/file.c:1830 [inline]
WARNING: CPU: 1 PID: 17813 at fs/fuse/file.c:1833 fuse_writepage_locked+0xa84/0xd40 fs/fuse/file.c:1918
Modules linked in:
CPU: 1 PID: 17813 Comm: syz-executor.2 Not tainted 5.16.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:fuse_write_file_get fs/fuse/file.c:1833 [inline]
RIP: 0010:fuse_write_file_get fs/fuse/file.c:1830 [inline]
RIP: 0010:fuse_writepage_locked+0xa84/0xd40 fs/fuse/file.c:1918
Code: 20 5b 5d 41 5c 41 5d 41 5e 41 5f c3 41 bc f4 ff ff ff e9 2d ff ff ff e8 8a dd c6 fe 48 8b 3c 24 e8 b1 fe a3 06 e8 7c dd c6 fe <0f> 0b 49 8d be c8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa
RSP: 0018:ffffc90018f3f5f0 EFLAGS: 00010212
RAX: 000000000000a311 RBX: ffff8880834ba688 RCX: ffffc9000d9e9000
RDX: 0000000000040000 RSI: ffffffff82b10a64 RDI: 0000000000000001
RBP: ffffea0000263e40 R08: 0000000000000000 R09: ffff8880834ba7a3
R10: ffffed10106974f4 R11: 000000000000001f R12: ffff8880834ba1c0
R13: ffffea000258d080 R14: ffff888018b83c00 R15: ffff88814a7ac800
FS:  00007f75e4cad700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc15c0ef7c CR3: 0000000073f74000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <TASK>
 fuse_writepage+0x104/0x160 fs/fuse/file.c:1976
 writeout mm/migrate.c:826 [inline]
 fallback_migrate_page mm/migrate.c:850 [inline]
 move_to_new_page+0x7ea/0xf00 mm/migrate.c:901
 __unmap_and_move mm/migrate.c:1063 [inline]
 unmap_and_move mm/migrate.c:1204 [inline]
 migrate_pages+0x27f5/0x3810 mm/migrate.c:1481
 compact_zone+0x1abb/0x3860 mm/compaction.c:2399
 compact_node+0x129/0x1f0 mm/compaction.c:2683
 compact_nodes mm/compaction.c:2699 [inline]
 sysctl_compaction_handler+0x10e/0x160 mm/compaction.c:2741
 proc_sys_call_handler+0x437/0x620 fs/proc/proc_sysctl.c:586
 call_write_iter include/linux/fs.h:2162 [inline]
 new_sync_write+0x429/0x660 fs/read_write.c:503
 vfs_write+0x7cd/0xae0 fs/read_write.c:590
 ksys_write+0x12d/0x250 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f75e7737ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f75e4cad188 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f75e784af60 RCX: 00007f75e7737ae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f75e7791f6d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffee68ffeff R14: 00007f75e4cad300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
