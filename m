Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C924075790F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 12:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjGRKNw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 06:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGRKNv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:13:51 -0400
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0678116
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 03:13:50 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3a044f9104dso9043136b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 03:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689675230; x=1692267230;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94gU9Cm0HvT/INyO59YYDp2AwD4IHO+lDlr2Eco5aCc=;
        b=UHyYUjJ/Pi3JyXYhxXPinZQ0SpPTItVei1TZ6RKAGaJpDtSTYasmY7tznFWUQkZoa+
         SGy9NFf7HcTFeqRBYbStBsrafKCtiWYcM5+SecHk2a579scEDzAKrJeYwlfS8qzAU1ka
         nYfx56BCPsmejNHvREzcHiq8JMtKsroZP+Ib3/WjAm8dyOq/Xhaf8AvkTX2pfFFFWjMK
         Mra+6iXcyS7mpyXSHUPAjAZp9OiymJcQbE7X7DEvtDodiEqRvSKBzXqLuTPKD1jYpLyd
         7lGQ4ttwDTTAMJb62a6Vl6PWOLnC4KC28v36UcMIHH/+l0c7ZUvkyK1yEqkNvUqnlWf4
         RuHA==
X-Gm-Message-State: ABy/qLZqqjKQDVi/XyIvMhyKqSdLdvlgPg1Pm825kC+tUVCuQSCf9OsX
        CjRsocZFk/BSVqVuDGANY7mvGcmZ1wFu0fzibaqE7V5ASdgmoNvdVg==
X-Google-Smtp-Source: APBJJlGg0H/RMlzPzlO8s+7kJUejmRoNsfZLtceYr4nS+AsenM02OJ/ezEh8WVeF1f7fUhqJ60h7NphOl8nf49DAzkfA5UTv8hSa
MIME-Version: 1.0
X-Received: by 2002:a05:6808:20a0:b0:39e:de07:a6b7 with SMTP id
 s32-20020a05680820a000b0039ede07a6b7mr4311665oiw.1.1689675229972; Tue, 18 Jul
 2023 03:13:49 -0700 (PDT)
Date:   Tue, 18 Jul 2023 03:13:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de4c2c0600c02b28@google.com>
Subject: [syzbot] [hfs?] kernel BUG in hfs_show_options
From:   syzbot <syzbot+155274e882dcbf9885df@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1615a7b6a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7ec534f91cfce6c
dashboard link: https://syzkaller.appspot.com/bug?extid=155274e882dcbf9885df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136fa2aaa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16629fe4a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/94f67a948e1d/disk-aeba4568.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9818a252eddd/vmlinux-aeba4568.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fbf9befe9bc9/bzImage-aeba4568.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f676b00757fa/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+155274e882dcbf9885df@syzkaller.appspotmail.com

memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=5030 'syz-executor221'
loop0: detected capacity change from 0 to 64
detected buffer overflow in strnlen
------------[ cut here ]------------
kernel BUG at lib/string_helpers.c:1031!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5030 Comm: syz-executor221 Not tainted 6.5.0-rc2-next-20230718-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
RIP: 0010:fortify_panic+0x1c/0x20 lib/string_helpers.c:1031
Code: ba fd eb d7 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 53 48 89 fb e8 23 de 65 fd 48 89 de 48 c7 c7 00 2c c8 8a e8 e4 28 49 fd <0f> 0b 66 90 f3 0f 1e fa 41 55 41 54 55 53 48 89 fb e8 fe dd 65 fd
RSP: 0018:ffffc90003b0fb38 EFLAGS: 00010286
RAX: 0000000000000023 RBX: ffffffff8a879260 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816aad20 RDI: 0000000000000005
RBP: ffff888029e9f000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: 1ffff92000761f69
R13: 0000000000000004 R14: ffff88807ea07864 R15: ffffc90003b0fb68
FS:  00005555558f2380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 0000000023140000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 strnlen include/linux/fortify-string.h:181 [inline]
 strscpy include/linux/fortify-string.h:324 [inline]
 hfs_show_options+0x6c7/0x7a0 fs/hfs/super.c:138
 show_vfsmnt+0x364/0x470 fs/proc_namespace.c:129
 seq_read_iter+0xaf0/0x1280 fs/seq_file.c:272
 call_read_iter include/linux/fs.h:1911 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x4e0/0x930 fs/read_write.c:470
 ksys_read+0x12f/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcba03d9ab9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd12ef40b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcba03d9ab9
RDX: 0000000000002020 RSI: 0000000020000340 RDI: 0000000000000004
RBP: 00007ffd12ef40c0 R08: 0000000000000000 R09: 65732f636f72702f
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd12ef4308 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:fortify_panic+0x1c/0x20 lib/string_helpers.c:1031
Code: ba fd eb d7 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 53 48 89 fb e8 23 de 65 fd 48 89 de 48 c7 c7 00 2c c8 8a e8 e4 28 49 fd <0f> 0b 66 90 f3 0f 1e fa 41 55 41 54 55 53 48 89 fb e8 fe dd 65 fd
RSP: 0018:ffffc90003b0fb38 EFLAGS: 00010286
RAX: 0000000000000023 RBX: ffffffff8a879260 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816aad20 RDI: 0000000000000005
RBP: ffff888029e9f000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: 1ffff92000761f69
R13: 0000000000000004 R14: ffff88807ea07864 R15: ffffc90003b0fb68
FS:  00005555558f2380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 0000000023140000 CR4: 00000000003506f0
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
