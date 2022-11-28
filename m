Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647AF63A600
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 11:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiK1KVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 05:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiK1KVk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:21:40 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522F51A3B6
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 02:21:37 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id y12-20020a056e021bec00b00302a7d5bc83so8474407ilv.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 02:21:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tMqDQsEzmaylonuYRqp1axSYbobnt52p4j0WRJfZDns=;
        b=PAzOfUvjIZdjxdp83IjZkOZUYrOQJZhuGXhibNWrEVYQuZ0jMjwR99Njn7vpuPfiIl
         cikEkzd5zz0mPbDeV8gLGhO13lt/O0swyrhnB6Tod0WcCKuORnMPASAxnloQwPRVDA7e
         mj8/4ydvEz5BCBruACwtM6dhcnCD24fRWSWtLZgO1t+l+9WRF5tZQ4bVwFP4yRZcSHNS
         4v8TGwJCyyQiNyOZxI33DXSGmee9DR0GbDWdCPM58rSTNnOIwgFVAs85ahsrVnkw+iHM
         7fcy76jxyGz0nS0TpAVB4SnoH9bViOc6U7hgghZbOWSTMEQd9h3/b+J/hApsbamHkCFd
         +GaA==
X-Gm-Message-State: ANoB5pmYWYrPtT9v5ffCIxP6ST4m6mQwx1GscJke0wQnT+TOe82XCIEz
        Gtp445gHhGhEG43l0rGZUR8ks1+pLc+cXf0VoirUPpYX/8wr
X-Google-Smtp-Source: AA0mqf6S7pp56wltRqO9M1GKqYCsW4lFvbm2livjgsib1m60AkHoMvTPPWhHtJmDZZ6ryfPdfB2zp92Zd+m3xQing5AaI6iP23Ey
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:966:b0:302:fca8:5d45 with SMTP id
 q6-20020a056e02096600b00302fca85d45mr6321889ilt.193.1669630896678; Mon, 28
 Nov 2022 02:21:36 -0800 (PST)
Date:   Mon, 28 Nov 2022 02:21:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080afdc05ee853c31@google.com>
Subject: [syzbot] kernel BUG in hfs_btree_open
From:   syzbot <syzbot+e5896dff7bbe057e5fff@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, fmdefrancesco@gmail.com,
        ira.weiny@intel.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, slava@dubeyko.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    faf68e3523c2 Merge tag 'kbuild-fixes-v6.1-4' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1141006b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca997ea105bc6faa
dashboard link: https://syzkaller.appspot.com/bug?extid=e5896dff7bbe057e5fff
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e7a5d146da01/disk-faf68e35.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7689402fe5ca/vmlinux-faf68e35.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6dd405048273/bzImage-faf68e35.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e5896dff7bbe057e5fff@syzkaller.appspotmail.com

loop2: detected capacity change from 0 to 64
------------[ cut here ]------------
kernel BUG at fs/hfs/btree.c:41!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 13190 Comm: syz-executor.2 Not tainted 6.1.0-rc6-syzkaller-00315-gfaf68e3523c2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:hfs_btree_open+0xf04/0xf20 fs/hfs/btree.c:41
Code: 7e ff e9 77 fa ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 93 fa ff ff 4c 89 f7 e8 d6 29 7e ff e9 86 fa ff ff e8 cc 2f 29 ff <0f> 0b e8 c5 2f 29 ff 0f 0b e8 be 2f 29 ff 0f 0b 66 2e 0f 1f 84 00
RSP: 0018:ffffc9000b0d77b8 EFLAGS: 00010293
RAX: ffffffff826363a4 RBX: ffff8880904aa380 RCX: ffff88807d51ba80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff82635603 R09: ffffed101209548c
R10: ffffed101209548c R11: 1ffff1101209548b R12: ffff888073fde000
R13: ffff888095a5e008 R14: ffff888095a5e000 R15: dffffc0000000000
FS:  00007f4863a6c700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7e3e9a8000 CR3: 0000000079964000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hfs_mdb_get+0x1466/0x21d0 fs/hfs/mdb.c:199
 hfs_fill_super+0x10a2/0x1800 fs/hfs/super.c:406
 mount_bdev+0x26c/0x3a0 fs/super.c:1401
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2e3/0x3d0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4862c8d60a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4863a6bf88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000240 RCX: 00007f4862c8d60a
RDX: 0000000020000240 RSI: 0000000020000280 RDI: 00007f4863a6bfe0
RBP: 00007f4863a6c020 R08: 00007f4863a6c020 R09: 0000000000004000
R10: 0000000000004000 R11: 0000000000000202 R12: 0000000020000240
R13: 0000000020000280 R14: 00007f4863a6bfe0 R15: 0000000020000400
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfs_btree_open+0xf04/0xf20 fs/hfs/btree.c:41
Code: 7e ff e9 77 fa ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 93 fa ff ff 4c 89 f7 e8 d6 29 7e ff e9 86 fa ff ff e8 cc 2f 29 ff <0f> 0b e8 c5 2f 29 ff 0f 0b e8 be 2f 29 ff 0f 0b 66 2e 0f 1f 84 00
RSP: 0018:ffffc9000b0d77b8 EFLAGS: 00010293
RAX: ffffffff826363a4 RBX: ffff8880904aa380 RCX: ffff88807d51ba80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff82635603 R09: ffffed101209548c
R10: ffffed101209548c R11: 1ffff1101209548b R12: ffff888073fde000
R13: ffff888095a5e008 R14: ffff888095a5e000 R15: dffffc0000000000
FS:  00007f4863a6c700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7e3e9a8000 CR3: 0000000079964000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
