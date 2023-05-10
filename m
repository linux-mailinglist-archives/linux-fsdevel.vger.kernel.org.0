Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA2E6FE687
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 23:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbjEJV7w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 17:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEJV7u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 17:59:50 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EEEE60
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 14:59:49 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-763646b324aso1142384139f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 14:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683755989; x=1686347989;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjllICd3LQIMP/gta6LsmZizuNSUq+Z9Txu8r2Eu7/c=;
        b=O5VsAJ+dOZSlCkrrjZBzdJymQP/xeaSvn14PUIU1VezK8rAkyf4Kegq5G9TFSBuD28
         /YKjNtpJzg+LNLdJmHwRYd5/8Pp8Td6NQJi0thA1ks6eK6t1gspa8aWU7xZc7lcKbs8n
         B2KoHismldgAZoKaTz0TX8+Z62O7RdzFfAVAsHpOhZxmw8DPxWu6aZBy382qyfvAOZ6r
         DTCqoz/9zjkLP0Webwc+F2N9ggD3BVVZUWYBUnXhjJm7zFOO6kBW298QLLE5LPDDUyXP
         4jQhjvRzc1apslRtO+Wn0PQplsgwluh+VN9aFVKVaosjvaCyJEK9TP5wkzyBaWT8tl76
         mVaQ==
X-Gm-Message-State: AC+VfDz0b8YWJ0YUwTmhVCFvBxkGcPYf0nEYNFxRrqmKTN6Mdq3t3Q1j
        IVAo2RBgUwP6G4HEmWCq1P6hEHFpR69zTNJrOD0OZBzWvUSP
X-Google-Smtp-Source: ACHHUZ4Tlf9yInWtJSWzOY5LQEm1B9HNNpfKXMRdZpzR3mazFAPq/l3UdS4ttb0lSmmO33WpYrmE//7sGJJMm/9hDRi5aZatLYI0
MIME-Version: 1.0
X-Received: by 2002:a02:b054:0:b0:40f:ae69:a144 with SMTP id
 q20-20020a02b054000000b0040fae69a144mr4093051jah.5.1683755988887; Wed, 10 May
 2023 14:59:48 -0700 (PDT)
Date:   Wed, 10 May 2023 14:59:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b5b5705fb5dfda0@google.com>
Subject: [syzbot] [ext4?] WARNING in __ext4fs_dirhash
From:   syzbot <syzbot+344aaa8697ebd232bfc8@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    578215f3e21c Add linux-next specific files for 20230510
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10a11e34280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb5a64fc61c29c5f
dashboard link: https://syzkaller.appspot.com/bug?extid=344aaa8697ebd232bfc8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/61ae2512b5cb/disk-578215f3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e16190a5b183/vmlinux-578215f3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/04000a0b9ddf/bzImage-578215f3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+344aaa8697ebd232bfc8@syzkaller.appspotmail.com

EXT4-fs warning (device loop1): __ext4fs_dirhash:281: invalid/unsupported hash tree version 135
------------[ cut here ]------------
WARNING: CPU: 1 PID: 16903 at fs/ext4/hash.c:284 __ext4fs_dirhash+0xa34/0xb40 fs/ext4/hash.c:281
Modules linked in:
CPU: 1 PID: 16903 Comm: syz-executor.1 Not tainted 6.4.0-rc1-next-20230510-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:__ext4fs_dirhash+0xa34/0xb40 fs/ext4/hash.c:284
Code: 00 0f 85 16 01 00 00 48 8b 04 24 41 89 d8 48 c7 c1 60 d2 62 8a ba 19 01 00 00 48 c7 c6 80 d3 62 8a 48 8b 78 28 e8 9c 7a 12 00 <0f> 0b 41 bc ea ff ff ff e9 2a fd ff ff e8 aa 94 5a ff 8b 9c 24 88
RSP: 0018:ffffc9000438f768 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000087 RCX: ffffc90016a21000
RDX: 0000000000040000 RSI: ffffffff823bfd38 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: 000000005948191c
R13: 0000000000000001 R14: dffffc0000000000 R15: ffff88802825c0c4
FS:  00007f06285fe700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffaa49ad988 CR3: 000000007b715000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4fs_dirhash+0x13e/0x2e0 fs/ext4/hash.c:323
 htree_dirblock_to_tree+0x81e/0xc90 fs/ext4/namei.c:1122
 ext4_htree_fill_tree+0x327/0xc40 fs/ext4/namei.c:1217
 ext4_dx_readdir fs/ext4/dir.c:597 [inline]
 ext4_readdir+0x1d18/0x35f0 fs/ext4/dir.c:142
 iterate_dir+0x56e/0x6f0 fs/readdir.c:65
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64 fs/readdir.c:354 [inline]
 __x64_sys_getdents64+0x13e/0x2c0 fs/readdir.c:354
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0629a8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f06285fe168 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f0629bac050 RCX: 00007f0629a8c169
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000008
RBP: 00007f0629ae7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc126daaaf R14: 00007f06285fe300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
