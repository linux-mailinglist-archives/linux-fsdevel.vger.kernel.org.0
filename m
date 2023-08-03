Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC14376E457
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 11:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbjHCJ3u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 05:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjHCJ3p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:29:45 -0400
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049661702
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 02:29:44 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3a5a7e981ddso1157114b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Aug 2023 02:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691054983; x=1691659783;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qGMx653nBJJ5yCLKWyGkaDu1qfLKlUYKMW2dOxBahgI=;
        b=DNsXdmJUktJugOwNRjP8S85UqCTxGNSaDihDmut/xixWL/d2VP9pAsNUY6XwhlX+ct
         Tv/Xz4D7Fsb6sbidOjg6UXZ23ciIffUMEMeVONwY82Mphd9++oTktSRdy4vF58wstAPu
         Ud8jHKIhzPMDhRh5xX8jA80HSIa6phn8be4C5BaZauS4LGiQAoBs519E3/ZIfEqlEjnv
         bSWORwzl5lqqF4uI8Iy3T2PWyIthlwiQB949h58rJ63FguN5yn9EeZImwYrY1ZbDFypJ
         eFTmTC4sxmak2Lsh4KkR0rfam1bK1Qa8eBPjfCCbYVeRv+EFaU6Sp65h4hSbX7YfjXjT
         5T7w==
X-Gm-Message-State: ABy/qLZjcfqb1e9QUU167Wiv5RtDw8wQKtHfmkOWLvhtZurghqkmpg21
        RpYIfJIGTHz0lBRIjvHyVPO3cl93DZun3t8aU9pPYwKRqVLh
X-Google-Smtp-Source: APBJJlG01oRDK24DsiBiA2UYAah381ZDGUtdTeTO3mK1a8YPspGeveVVPVe0TUeS6He2hxzzg6TtpyrAxUqjFPrnnNmid58Wfqvp
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3090:b0:3a7:49f1:1d86 with SMTP id
 bl16-20020a056808309000b003a749f11d86mr8773349oib.11.1691054983424; Thu, 03
 Aug 2023 02:29:43 -0700 (PDT)
Date:   Thu, 03 Aug 2023 02:29:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009531dc0602016bb0@google.com>
Subject: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in hdr_find_e (2)
From:   syzbot <syzbot+60cf892fc31d1f4358fc@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4b954598a47b Merge tag 'exfat-for-6.5-rc5' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17c9ee5ea80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e3d5175079af5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=60cf892fc31d1f4358fc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ee0aa6a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100eaedea80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0032b69f541f/disk-4b954598.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/03d8f0d906d0/vmlinux-4b954598.xz
kernel image: https://storage.googleapis.com/syzbot-assets/564663ea69f2/bzImage-4b954598.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0942a51fa81c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+60cf892fc31d1f4358fc@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS sector size (2048) and media sector size (512).
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 7ce85067 P4D 7ce85067 PUD 7de36067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5020 Comm: syz-executor569 Not tainted 6.5.0-rc4-syzkaller-00009-g4b954598a47b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90003c1f778 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: ffff88807a700210 RSI: 0000000000000000 RDI: ffff888021486600
RBP: ffffc90003c1f9b0 R08: ffff88807c3dc000 R09: 0000000000000000
R10: ffffc90003c1f820 R11: fffff52000783f24 R12: 0000000000000000
R13: ffff88807a700200 R14: dffffc0000000000 R15: 00000000000000d0
FS:  0000555557244380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000002adce000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hdr_find_e+0x33e/0x600 fs/ntfs3/index.c:759
 indx_find+0x317/0xb60 fs/ntfs3/index.c:1166
 dir_search_u+0x1b7/0x3a0 fs/ntfs3/dir.c:254
 ntfs_lookup+0x106/0x1f0 fs/ntfs3/namei.c:85
 lookup_one_qstr_excl+0x11b/0x250 fs/namei.c:1605
 do_renameat2+0x650/0x1660 fs/namei.c:4950
 __do_sys_rename fs/namei.c:5055 [inline]
 __se_sys_rename fs/namei.c:5053 [inline]
 __x64_sys_rename+0x86/0x90 fs/namei.c:5053
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f20709905f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcfe70b878 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007f20709905f9
RDX: 00007f207098f8f0 RSI: 00000000200000c0 RDI: 0000000020000040
RBP: 00007f2070a22610 R08: 000000000001f3d5 R09: 0000000000000000
R10: 00007ffcfe70b740 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffcfe70ba48 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90003c1f778 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: ffff88807a700210 RSI: 0000000000000000 RDI: ffff888021486600
RBP: ffffc90003c1f9b0 R08: ffff88807c3dc000 R09: 0000000000000000
R10: ffffc90003c1f820 R11: fffff52000783f24 R12: 0000000000000000
R13: ffff88807a700200 R14: dffffc0000000000 R15: 00000000000000d0
FS:  0000555557244380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000002adce000 CR4: 00000000003506f0
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
