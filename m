Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB086FBC30
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 02:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjEIAz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 20:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjEIAzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 20:55:52 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8684E9027
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 May 2023 17:55:50 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-76c550fbae9so43042239f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 May 2023 17:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683593750; x=1686185750;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+LadK4ztz7DMxRtO6OmvxwUFVGeyvRciIiCq7RQ694Q=;
        b=VTR6IUgvzySYClFwOrLNThrlNEDPZ7TR+YCjQO2erO1/pt2LQ971OINB3BHcjBcSFH
         hSKaZ+CgxWVS2ZoJqva18RqU5vIl7wW8nXNbDaGk4ERb4wkTM12rj39f2a8jGfbUfaqu
         E+LEo1XtBn0857yfVnJC85RHQEqHavqsJNp+Pgvmr4dKS9wtISoOlAer4jPggua+uho3
         eGN+K+x5dzmx9JxpGFH/TVwmWhspKbhU8HEPPub7zlW9wx2H1/kHOd/OlsKVjn+1Gh5U
         ocoyw2Dj7LU7C/8CHvJ9kcrZpHN+I/oz6qo2du78refyOjc2h56oyUz/MctgQscl5uuR
         8ggg==
X-Gm-Message-State: AC+VfDyvGigLAVt+9tb68Z56nkiBI9yWcIHp4MdleaC7qQRLESSGUN2T
        bij0xT5lQiKHR8tuW8QIWRklTgQiaXDAYKRj7OZcWNEv4y5+
X-Google-Smtp-Source: ACHHUZ4RS4qgUNxbc6bSatT4oCmoxvP5DvIb1R8vnlXKvZn876jkbj6tEooeFjSiO1SK+tI7+mVt14YQP+lojgwpFg901A8YdXc/
MIME-Version: 1.0
X-Received: by 2002:a02:84a8:0:b0:416:6d60:e462 with SMTP id
 f37-20020a0284a8000000b004166d60e462mr501621jai.2.1683593749853; Mon, 08 May
 2023 17:55:49 -0700 (PDT)
Date:   Mon, 08 May 2023 17:55:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000067fdc105fb3837b8@google.com>
Subject: [syzbot] [udf?] WARNING in udf_unlink
From:   syzbot <syzbot+0b7eed2aab568dec42b8@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    1a5304fecee5 Merge tag 'parisc-for-6.4-1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1159c15a280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73a06f6ef2d5b492
dashboard link: https://syzkaller.appspot.com/bug?extid=0b7eed2aab568dec42b8
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dd767dde3306/disk-1a5304fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/21e0fbeccd39/vmlinux-1a5304fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dada79d4407c/bzImage-1a5304fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b7eed2aab568dec42b8@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8987 at fs/udf/udfdecl.h:123 udf_add_fid_counter fs/udf/namei.c:350 [inline]
WARNING: CPU: 0 PID: 8987 at fs/udf/udfdecl.h:123 udf_unlink+0x5ab/0x740 fs/udf/namei.c:565
Modules linked in:
CPU: 0 PID: 8987 Comm: syz-executor.0 Not tainted 6.3.0-syzkaller-13027-g1a5304fecee5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:udf_updated_lvid fs/udf/udfdecl.h:121 [inline]
RIP: 0010:udf_add_fid_counter fs/udf/namei.c:350 [inline]
RIP: 0010:udf_unlink+0x5ab/0x740 fs/udf/namei.c:565
Code: 04 25 28 00 00 00 48 3b 84 24 40 01 00 00 0f 85 06 01 00 00 89 d8 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 e5 c0 8b fe <0f> 0b e9 1f ff ff ff 89 f9 80 e1 07 38 c1 0f 8c 47 fb ff ff be 06
RSP: 0018:ffffc9000709fba0 EFLAGS: 00010283
RAX: ffffffff82ffcf3b RBX: 000000003fd1f4fc RCX: 0000000000040000
RDX: ffffc90004091000 RSI: 00000000000020ee RDI: 00000000000020ef
RBP: ffffc9000709fd30 R08: ffffffff82ffce54 R09: fffffbfff1cab866
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: 1ffff92000e13f7c R14: ffff8880754c2678 R15: ffff88804e5b201c
FS:  00007f52a20dd700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000a43 CR3: 000000007d2e7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vfs_unlink+0x35d/0x5f0 fs/namei.c:4327
 do_unlinkat+0x4a7/0x950 fs/namei.c:4393
 __do_sys_unlink fs/namei.c:4441 [inline]
 __se_sys_unlink fs/namei.c:4439 [inline]
 __x64_sys_unlink+0x49/0x50 fs/namei.c:4439
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f52ab88c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f52a20dd168 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007f52ab9ac050 RCX: 00007f52ab88c169
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000300
RBP: 00007f52ab8e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc735e15ef R14: 00007f52a20dd300 R15: 0000000000022000
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
