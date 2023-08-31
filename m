Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C80278E5E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 07:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244518AbjHaFjT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 01:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244754AbjHaFjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 01:39:17 -0400
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A7AE6E
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 22:39:00 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-3a78c2cdd77so519926b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 22:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693460339; x=1694065139;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=soFosyDp1uCJmsl2PKWOCioo+0yKoaNhADP2lI3aq7k=;
        b=KMVwbq/EFn1LoSf4u4dzRRzJXUbg3H4uKdO7ks0g5OV5668pBfJe9dejG/jihRQJ0g
         mK+JdW4oleCkIhCNAYL76CaYWTBec3vJE6xYUOT8PQNQJohDZkh5+pRxvZX6fw2GSafO
         Wn3baeKI2xdlO2yYhZDaRz8Ok5uy/4vuXzcMPcFAPC/JioBHugtD0J5ZyrNKDfRpTWyT
         /7QO95A34E7cTcw10xJLCm2EYx/mD/H+jIng+G6JsX9nA826PxShG8r5N6NnMIQIHdlb
         1srTUZvWB1BvGVNOkDTlnVoI8/NCnoOy6Xd/xr5Eo60N/rFgtxExdqI4HT7bUHKnyUJL
         nnpg==
X-Gm-Message-State: AOJu0YylPgOzniQfVfnGZdJw8agu1uYFDiFTAsiq8BfeLAd8xgX/xidm
        msTIagRpW1BZj6+jz41sIohTzmQWphsATS0Psac3c5FgSYLP
X-Google-Smtp-Source: AGHT+IHIgdqfKUOnVR68do56qlQhXeHtdbiq+KB8bx8rQnOxL40q5/RxtSAUIlD500lSfQsIFj+/s0Inp05QBFh7YCBw9O/0AqJh
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1587:b0:3a4:18d1:1686 with SMTP id
 t7-20020a056808158700b003a418d11686mr788824oiw.10.1693460339403; Wed, 30 Aug
 2023 22:38:59 -0700 (PDT)
Date:   Wed, 30 Aug 2023 22:38:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8b2d7060431755a@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_quota_enable
From:   syzbot <syzbot+f919c2a4aa16cd906ab7@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3b35375f19fe Merge tag 'irq-urgent-2023-08-26' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103e2acba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=f919c2a4aa16cd906ab7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/be3796252a5a/disk-3b35375f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44ebaf698631/vmlinux-3b35375f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/727e7da83980/bzImage-3b35375f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f919c2a4aa16cd906ab7@syzkaller.appspotmail.com

------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 1 PID: 8137 at fs/btrfs/qgroup.c:1039 btrfs_quota_enable+0x197c/0x1f40 fs/btrfs/qgroup.c:1039
Modules linked in:
CPU: 1 PID: 8137 Comm: syz-executor.4 Not tainted 6.5.0-rc7-syzkaller-00182-g3b35375f19fe #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:btrfs_quota_enable+0x197c/0x1f40 fs/btrfs/qgroup.c:1039
Code: ff ff be 08 00 00 00 48 89 df e8 9f 87 3f fe e9 3d e8 ff ff e8 f5 a5 e6 fd 48 c7 c7 80 cd 4b 8b 48 8b 74 24 20 e8 14 bf ad fd <0f> 0b e9 9f f9 ff ff e8 d8 a5 e6 fd 48 c7 c7 80 cd 4b 8b be f4 ff
RSP: 0018:ffffc9001788fca0 EFLAGS: 00010246
RAX: ecef377177158500 RBX: ffff888078194001 RCX: 0000000000040000
RDX: ffffc9000bbd5000 RSI: 000000000000698d RDI: 000000000000698e
RBP: ffffc9001788fea8 R08: ffffffff8152d442 R09: 1ffff11017325162
R10: dffffc0000000000 R11: ffffed1017325163 R12: dffffc0000000000
R13: ffff8880751b5248 R14: 1ffff1100ea36a49 R15: 0000000000000000
FS:  00007fdab1cee6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f972ed67f00 CR3: 000000007ca4b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_ioctl_quota_ctl+0x144/0x180 fs/btrfs/ioctl.c:3694
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdab107cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdab1cee0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fdab119c120 RCX: 00007fdab107cae9
RDX: 00000000200013c0 RSI: 00000000c0109428 RDI: 0000000000000006
RBP: 00007fdab10c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fdab119c120 R15: 00007ffc4fefa1c8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
