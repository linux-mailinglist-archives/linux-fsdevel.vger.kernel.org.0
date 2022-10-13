Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B232E5FD5DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Oct 2022 10:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJMIBv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 04:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJMIBu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:01:50 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C974F0357
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 01:01:49 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id n6-20020a056e021ba600b002fc99858e34so935545ili.14
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 01:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5tyGVMnECA3wWyWqGy8dFnwc4HRs2yeTj/5aiMiOJ64=;
        b=yqic/u9kbwfTBo1TBbtFwQyWzP9cEi/6MecjlhZk2RgJasQCEnUjG4RKa64ePJ3Mwy
         dHT56gLtd+JKCR38bBIFMySyTLk0oLktH1kCn3l+ouGvjOA9Bta63gKxkR20u8AkMjPn
         xvtB6m57cjDlbHo9Gx4kKkGwqJkNrUd0kzclRUoT+HXpVwjdbnok/VGOjmZaF1/DHBjx
         u00Ztn+DmaKsbynHtUrzGl27mSK7JgFu7Q31HkRLUil7LDos1FZNCX2KVxRiMLA9uF1U
         M92z6syDvd27h4HxjQdWsfrKppNTOsBXj9N3Cg01R5OKMfNpNX8UpoqRQfCGa4kkxkFx
         ga2g==
X-Gm-Message-State: ACrzQf3q6/FCjPCAPUpUHrnTIoRHUznCiayySodICuOLLuhayTKExa+r
        cbm75VNnMhuxMMEK9FgxttlQf5RDwAMk3j5VdQTGWXQ58AiT
X-Google-Smtp-Source: AMsMyM6amQad36+UbgWoUTL+SJ1LBojpAequ4ZbVdAi++eGm+30anfSxBXn40Il+BqVIO3Zi9GU6Z/137tUUMaEjqqEk23q/R8cw
MIME-Version: 1.0
X-Received: by 2002:a05:6602:160c:b0:68a:9ed3:e6ff with SMTP id
 x12-20020a056602160c00b0068a9ed3e6ffmr14967679iow.207.1665648108435; Thu, 13
 Oct 2022 01:01:48 -0700 (PDT)
Date:   Thu, 13 Oct 2022 01:01:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2fe6805eae5ebff@google.com>
Subject: [syzbot] kernel BUG in truncate_inode_pages_range
From:   syzbot <syzbot+67418a97d2c47464ca17@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d3b31a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=67418a97d2c47464ca17
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+67418a97d2c47464ca17@syzkaller.appspotmail.com

 sb_set_blocksize block/bdev.c:161 [inline]
 sb_min_blocksize+0xc0/0x180 block/bdev.c:177
 isofs_fill_super+0xa28/0x28d0 fs/isofs/inode.c:658
 mount_bdev+0x26c/0x3a0 fs/super.c:1400
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
------------[ cut here ]------------
kernel BUG at mm/truncate.c:424!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 27836 Comm: syz-executor.2 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:truncate_inode_pages_range+0x1548/0x1780 mm/truncate.c:424
Code: e8 ad 0e ce ff 4c 89 ff 48 c7 c6 20 50 98 8a e8 de 24 0a 00 0f 0b e8 97 0e ce ff 4c 89 ff 48 c7 c6 80 4f 98 8a e8 c8 24 0a 00 <0f> 0b e8 e1 96 6d 08 e8 7c 0e ce ff 4c 89 e7 48 c7 c6 20 50 98 8a
RSP: 0018:ffffc9000916f7c0 EFLAGS: 00010246
RAX: 0d16a9ba1ff17c00 RBX: fffffffffffff880 RCX: 0000000000040000
RDX: ffffc9000a999000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: ffffc9000916f9f0 R08: ffffffff81e2ae1b R09: ffffed10173667f1
R10: ffffed10173667f1 R11: 1ffff110173667f0 R12: 00000000000007ff
R13: 0000000000000002 R14: 0000000000000001 R15: ffffea0001e08c00
FS:  00007f3cf4838700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0247f4320 CR3: 00000000268a5000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kill_bdev block/bdev.c:76 [inline]
 set_blocksize+0x2ec/0x360 block/bdev.c:152
 sb_set_blocksize block/bdev.c:161 [inline]
 sb_min_blocksize+0xc0/0x180 block/bdev.c:177
 isofs_fill_super+0xa28/0x28d0 fs/isofs/inode.c:658
 mount_bdev+0x26c/0x3a0 fs/super.c:1400
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3cf368cada
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3cf4837f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f3cf368cada
RDX: 0000000020000100 RSI: 00000000200001c0 RDI: 00007f3cf4837fe0
RBP: 00007f3cf4838020 R08: 00007f3cf4838020 R09: 0000000020000100
R10: 0000000000000001 R11: 0000000000000202 R12: 0000000020000100
R13: 00000000200001c0 R14: 00007f3cf4837fe0 R15: 0000000020000080
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:truncate_inode_pages_range+0x1548/0x1780 mm/truncate.c:424
Code: e8 ad 0e ce ff 4c 89 ff 48 c7 c6 20 50 98 8a e8 de 24 0a 00 0f 0b e8 97 0e ce ff 4c 89 ff 48 c7 c6 80 4f 98 8a e8 c8 24 0a 00 <0f> 0b e8 e1 96 6d 08 e8 7c 0e ce ff 4c 89 e7 48 c7 c6 20 50 98 8a
RSP: 0018:ffffc9000916f7c0 EFLAGS: 00010246
RAX: 0d16a9ba1ff17c00 RBX: fffffffffffff880 RCX: 0000000000040000
RDX: ffffc9000a999000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: ffffc9000916f9f0 R08: ffffffff81e2ae1b R09: ffffed10173667f1
R10: ffffed10173667f1 R11: 1ffff110173667f0 R12: 00000000000007ff
R13: 0000000000000002 R14: 0000000000000001 R15: ffffea0001e08c00
FS:  00007f3cf4838700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c023176000 CR3: 00000000268a5000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
