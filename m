Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0113872C928
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 17:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238642AbjFLPBP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 11:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238677AbjFLPBN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:01:13 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334CC123
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 08:01:12 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-33b372d1deeso37485225ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 08:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582071; x=1689174071;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YN3ynu0U4WVKTG1RHVdbuOrP7GA0Qluqiyijqs3pGpk=;
        b=F215vb+xuRNjRQt1hhsCdm1zM0e30rDlbhOit4Xfqb1wL0lmfa4ltvkGjmt1gOr7Vz
         dbyK3E3L4HlX6ncGZv3vZgwZCcCJEgdtEQWA5z8z20RSjcPZR0Dh7kmUFc/BCA05k5UL
         IRD3D4bWMFLq9fFKVufCpVHdSEYpuffw9DGv55m0xMflQScAJflKkHdw6s6jam5LE3qn
         qDYbFgGdCf8AU0c7OpWhiOjUQXIRggiKZYfCBtKay+L14ku03siekydWQEA9DjvD2eGg
         C+2ePnggZlqVA8yy9JOtPvfqS9WIqDAHPAskBbkxzliuiUIrRZYSS8MgQqQL9xbtjrfy
         gIvA==
X-Gm-Message-State: AC+VfDy0pUKzFF4S7keKJZvkV+fscitwWktsmv8RloSwU4iXUfNhsS4x
        mxOmafeT6PBF3crc0qe2vjhciMaohee+Z4Fd5fiMMxCrX5Iz
X-Google-Smtp-Source: ACHHUZ77uH/BBpn9hMjUBO8ctk9N9xc3hS5FVZT4MZC55A2PCJ88NDv/QOXwp8RhTeGyyXAVwlZR1jMjo3+QtmjsszC2KRu93OfU
MIME-Version: 1.0
X-Received: by 2002:a92:cac2:0:b0:335:b02:f8b4 with SMTP id
 m2-20020a92cac2000000b003350b02f8b4mr4185406ilq.2.1686582071238; Mon, 12 Jun
 2023 08:01:11 -0700 (PDT)
Date:   Mon, 12 Jun 2023 08:01:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003da75f05fdeffd12@google.com>
Subject: [syzbot] [nilfs?] WARNING in mark_buffer_dirty (5)
From:   syzbot <syzbot+cdfcae656bac88ba0e2d@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5f63595ebd82 Merge tag 'input-for-v6.4-rc5' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1095a51b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=cdfcae656bac88ba0e2d
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a18595280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141c5463280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d12b9e46ffe8/disk-5f63595e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c9044ded7edd/vmlinux-5f63595e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/09f0fd3926e8/bzImage-5f63595e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1f3799cb13b4/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cdfcae656bac88ba0e2d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5085 at fs/buffer.c:1130 mark_buffer_dirty+0x2dd/0x500
Modules linked in:
CPU: 1 PID: 5085 Comm: syz-executor134 Not tainted 6.4.0-rc5-syzkaller-00024-g5f63595ebd82 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:mark_buffer_dirty+0x2dd/0x500 fs/buffer.c:1130
Code: df e8 57 0e e0 ff 48 8b 3b be 04 00 00 00 5b 41 5c 41 5e 41 5f 5d e9 22 69 fc ff e8 3d 39 88 ff e9 71 ff ff ff e8 33 39 88 ff <0f> 0b e9 6d fd ff ff e8 27 39 88 ff 0f 0b e9 96 fd ff ff e8 1b 39
RSP: 0018:ffffc90003f5f810 EFLAGS: 00010293

RAX: ffffffff820345fd RBX: ffff8880775fbb01 RCX: ffff888015f30000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff82034364 R09: ffffed100eeb48af
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff8880775a4570
R13: dffffc0000000000 R14: ffffc90003f5f880 R15: 1ffff920007ebf10
FS:  0000555556a02300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000002ba98000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __nilfs_mark_inode_dirty+0x105/0x280 fs/nilfs2/inode.c:1115
 nilfs_dirty_inode+0x164/0x200 fs/nilfs2/inode.c:1148
 __mark_inode_dirty+0x305/0xd90 fs/fs-writeback.c:2424
 mark_inode_dirty include/linux/fs.h:2144 [inline]
 generic_write_end+0x184/0x1e0 fs/buffer.c:2257
 nilfs_write_end+0x85/0xf0 fs/nilfs2/inode.c:280
 generic_perform_write+0x3ed/0x5e0 mm/filemap.c:3934
 __generic_file_write_iter+0x29b/0x400 mm/filemap.c:4019
 generic_file_write_iter+0xaf/0x310 mm/filemap.c:4083
 call_write_iter include/linux/fs.h:1868 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x790/0xb20 fs/read_write.c:584
 ksys_write+0x1a0/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f417000db39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd6c282ed8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0032656c69662f2e RCX: 00007f417000db39
RDX: 0000000000000018 RSI: 00000000200001c0 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007ffd6c282f00 R09: 00007ffd6c282f00
R10: 00007ffd6c282f00 R11: 0000000000000246 R12: 00007ffd6c282efc
R13: 00007ffd6c282f30 R14: 00007ffd6c282f10 R15: 0000000000000006
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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
