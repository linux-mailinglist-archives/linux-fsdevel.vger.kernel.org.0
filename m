Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B55D781915
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Aug 2023 12:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjHSKsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Aug 2023 06:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjHSKsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:48:39 -0400
Received: from mail-pf1-f207.google.com (mail-pf1-f207.google.com [209.85.210.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9A82F445
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Aug 2023 03:48:04 -0700 (PDT)
Received: by mail-pf1-f207.google.com with SMTP id d2e1a72fcca58-688952b739fso2251666b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Aug 2023 03:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692442079; x=1693046879;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CT5gB/VbboEBRriucm0WNmnXYtyJVrTVfxhNY9LdZtU=;
        b=eDWGzSIT9eUjh8G70OC1qr0CQuQXd7lnQ3LJnemQa7/ho272LNIUjRYV/UtoCVkDSh
         +tzMjB/Ek7/exFzUcaV1WVbPLLtFxXmP0YqlObtG103J7oz9wT8wbNZhlePYi750Vy3i
         d8PMpLdDXAdde5kYNdqvrj67yGd7dfaRKWlb7jmB+L0kDSzgbhKtv7Wd3xND/gclOOH0
         4lDPmSrlLxM/x7PU9SOSuSDiCbvo86lo/OO1fRq98zJ7NXQMdIJYIzFd19ueOmoLXlGd
         IXacQxcCRGV4lZHdZJFiKjtWuNK8FyBsEDGZv03l/mpEqifxFcR3SbICFuuFDz+vSDXR
         9INg==
X-Gm-Message-State: AOJu0YzPOz/pX7uFAesaIgUeH1Bw2UWBe6OWGeac87ocwfn6ncX066J9
        KpIoFMsRdSdLt8QI21ybDiKgtgx2yxAJ+KOxuLV2jJr/uWLB
X-Google-Smtp-Source: AGHT+IEjPSquAh6sp6nYTTLwHwK77EGfV9EEQA0Z8R/LzHi1+9SskfCChdYL8AgqAv/tHyy1yYDeD3sNBRT29v33QVTTpOMnMjaF
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:c92:b0:68a:ab8:e3c1 with SMTP id
 a18-20020a056a000c9200b0068a0ab8e3c1mr1048632pfv.2.1692442078965; Sat, 19 Aug
 2023 03:47:58 -0700 (PDT)
Date:   Sat, 19 Aug 2023 03:47:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb769006034460ca@google.com>
Subject: [syzbot] [ntfs3?] WARNING in do_symlinkat (2)
From:   syzbot <syzbot+d123d9a1df4f9a897854@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d4ddefee5160 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1684c769a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c37cc0e4fcc5f8d
dashboard link: https://syzkaller.appspot.com/bug?extid=d123d9a1df4f9a897854
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1610933da80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d81e5fa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/faa4473182fa/disk-d4ddefee.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f12b676582f4/vmlinux-d4ddefee.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e8c9cea34485/bzImage-d4ddefee.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/027d8c9977f5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d123d9a1df4f9a897854@syzkaller.appspotmail.com

DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff8880715bea70, owner = 0x0, curr 0xffff88802212bb80, list empty
WARNING: CPU: 1 PID: 5387 at kernel/locking/rwsem.c:1370 __up_write kernel/locking/rwsem.c:1369 [inline]
WARNING: CPU: 1 PID: 5387 at kernel/locking/rwsem.c:1370 up_write+0x4f4/0x580 kernel/locking/rwsem.c:1626
Modules linked in:
CPU: 1 PID: 5387 Comm: syz-executor310 Not tainted 6.5.0-rc6-syzkaller-00200-gd4ddefee5160 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:__up_write kernel/locking/rwsem.c:1369 [inline]
RIP: 0010:up_write+0x4f4/0x580 kernel/locking/rwsem.c:1626
Code: 48 c7 c7 20 8c 0a 8b 48 c7 c6 60 8e 0a 8b 48 8b 54 24 28 48 8b 4c 24 18 4d 89 e0 4c 8b 4c 24 30 53 e8 30 59 e8 ff 48 83 c4 08 <0f> 0b e9 75 fd ff ff 48 c7 c1 88 ab 98 8e 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc900042afd40 EFLAGS: 00010292
RAX: 083997afe1a51c00 RBX: ffffffff8b0a8d00 RCX: ffff88802212bb80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900042afe10 R08: ffffffff8152d442 R09: 1ffff92000855f20
R10: dffffc0000000000 R11: fffff52000855f21 R12: 0000000000000000
R13: ffff8880715bea70 R14: 1ffff92000855fb0 R15: dffffc0000000000
FS:  00007f472f84f6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4737a71000 CR3: 000000002634e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:776 [inline]
 done_path_create fs/namei.c:3937 [inline]
 do_symlinkat+0x25e/0x610 fs/namei.c:4505
 __do_sys_symlink fs/namei.c:4524 [inline]
 __se_sys_symlink fs/namei.c:4522 [inline]
 __x64_sys_symlink+0x7e/0x90 fs/namei.c:4522
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4737ab3d89
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f472f84f218 EFLAGS: 00000246 ORIG_RAX: 0000000000000058
RAX: ffffffffffffffda RBX: 00007f4737b5b6d8 RCX: 00007f4737ab3d89
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000020000540
RBP: 00007f4737b5b6d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4737b27954
R13: 00007f4737b27850 R14: 0031656c69662f2e R15: 0030656c69662f2e
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
