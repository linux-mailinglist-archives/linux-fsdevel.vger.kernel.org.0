Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E6C7579EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 12:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjGRK6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 06:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGRK5t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:57:49 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36188172E
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 03:57:44 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3a3a8d12040so8933001b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 03:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689677863; x=1692269863;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ipw5rrA7DhZGkPbMudtw/52EsMRXKQJmWjHgh816E8=;
        b=Aw2T7K8DRtyNEnkB4GLtsCHicT0NNuLJpG2Aoy1qYl4IJnl/nMKUUqK9DpsIfOj5zJ
         iCgCmzR1+m7jk2YbLwa+DQd0+ZCHL/jQurCAE7x3Qu9vUiTYUzx0mdhnMujJCu84dcW/
         APyInN1zBju82GR2E1hGfu4eJpVWuwpzYXskReds1Xn5f4bbRJAbJ9LvYUdh/F85v9+7
         RM9aCL1tQ1NWYnU5yrLtSm4S9SwypeeMhWjTJ1hDG0/5gqJLLqwUuqYU0I7VwPZyIsMy
         LBOStOhYB1H6Lt2btn4YuL6yjiUBqlOF9KRu2C3RaFQlTWp2ORLMWluTAwRUpU0wqUCq
         Nf7g==
X-Gm-Message-State: ABy/qLYD9NBwAA92ydsn2EvsAS/k0TzpRv4/g6unhvLIzAb33w9vVDQg
        Hjyipgp+75tTj4KTkEfGl+rQkSvKI8yoPbpNO84yoq2/SGLVEP2nhA==
X-Google-Smtp-Source: APBJJlFvvlQlBj8Qq0dfLeUzDZhkUGMmERNLlEbPHur16LKuBd+fMbnbe22a33lgdg6ycdWFxwHnI5gw1gx2R4LviuhU9OafDYKj
MIME-Version: 1.0
X-Received: by 2002:a05:6808:198e:b0:3a1:e58d:aae0 with SMTP id
 bj14-20020a056808198e00b003a1e58daae0mr21182527oib.3.1689677863595; Tue, 18
 Jul 2023 03:57:43 -0700 (PDT)
Date:   Tue, 18 Jul 2023 03:57:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8352e0600c0c804@google.com>
Subject: [syzbot] [hfs?] kernel BUG in hfsplus_show_options
From:   syzbot <syzbot+98d3ceb7e01269e7bf4f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    aeba456828b4 Add linux-next specific files for 20230718
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=111d6a62a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7ec534f91cfce6c
dashboard link: https://syzkaller.appspot.com/bug?extid=98d3ceb7e01269e7bf4f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ecf646a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1476f30aa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/94f67a948e1d/disk-aeba4568.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9818a252eddd/vmlinux-aeba4568.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fbf9befe9bc9/bzImage-aeba4568.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d8265d21ad1c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+98d3ceb7e01269e7bf4f@syzkaller.appspotmail.com

memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=5032 'syz-executor324'
loop0: detected capacity change from 0 to 1024
detected buffer overflow in strnlen
------------[ cut here ]------------
kernel BUG at lib/string_helpers.c:1031!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5032 Comm: syz-executor324 Not tainted 6.5.0-rc2-next-20230718-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
RIP: 0010:fortify_panic+0x1c/0x20 lib/string_helpers.c:1031
Code: ba fd eb d7 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 53 48 89 fb e8 23 de 65 fd 48 89 de 48 c7 c7 00 2c c8 8a e8 e4 28 49 fd <0f> 0b 66 90 f3 0f 1e fa 41 55 41 54 55 53 48 89 fb e8 fe dd 65 fd
RSP: 0018:ffffc90003a1f7b8 EFLAGS: 00010282
RAX: 0000000000000023 RBX: ffffffff8a873580 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816aad20 RDI: 0000000000000005
RBP: ffff888019f16cb8 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: 1ffff92000743efa
R13: 0000000000000004 R14: ffff888078fa69c0 R15: ffffc90003a1f7f0
FS:  0000555556e72380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000456b30 CR3: 0000000079883000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 strnlen include/linux/fortify-string.h:181 [inline]
 strscpy include/linux/fortify-string.h:324 [inline]
 hfsplus_show_options+0x658/0x740 fs/hfsplus/options.c:226
 show_mountinfo+0x671/0x990 fs/proc_namespace.c:191
 seq_read_iter+0xaf0/0x1280 fs/seq_file.c:272
 call_read_iter include/linux/fs.h:1911 [inline]
 copy_splice_read+0x418/0x8f0 fs/splice.c:366
 vfs_splice_read fs/splice.c:993 [inline]
 vfs_splice_read+0x2c8/0x3b0 fs/splice.c:962
 splice_direct_to_actor+0x2a5/0xa30 fs/splice.c:1069
 do_splice_direct+0x1af/0x280 fs/splice.c:1194
 do_sendfile+0xb88/0x1390 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4339573a79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff9271428 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007ffff9271430 RCX: 00007f4339573a79
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00007f43395e7610 R08: 0000000000000000 R09: 65732f636f72702f
R10: 0800000080004105 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffff9271668 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:fortify_panic+0x1c/0x20 lib/string_helpers.c:1031
Code: ba fd eb d7 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 53 48 89 fb e8 23 de 65 fd 48 89 de 48 c7 c7 00 2c c8 8a e8 e4 28 49 fd <0f> 0b 66 90 f3 0f 1e fa 41 55 41 54 55 53 48 89 fb e8 fe dd 65 fd
RSP: 0018:ffffc90003a1f7b8 EFLAGS: 00010282
RAX: 0000000000000023 RBX: ffffffff8a873580 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816aad20 RDI: 0000000000000005
RBP: ffff888019f16cb8 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: 1ffff92000743efa
R13: 0000000000000004 R14: ffff888078fa69c0 R15: ffffc90003a1f7f0
FS:  0000555556e72380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000456b30 CR3: 0000000079883000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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
