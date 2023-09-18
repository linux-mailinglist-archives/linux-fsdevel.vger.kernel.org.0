Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F061E7A51D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 20:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjIRSPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 14:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIRSPK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:15:10 -0400
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB43AFB
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 11:15:03 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-3ade1002692so567324b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 11:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695060903; x=1695665703;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Pj2gflzChdTjSILey0wOqNwEyneT96tigxwfb0NNcI=;
        b=fXjJ57JSajUIzJYw8NTzg+Dj9U8yMqI7EDfztWX1y6Y9a01/Wf/Lsl3PqmyNygjN9t
         2dhu4UWq/5cplS8rZHB+N9GojonVngzW28I/uSVu0/8QxJjQvzxttOJZ6vacdUXZjEjt
         1pCC1SGgol6rCcpVnDbDZFi4bOfb80knxppPEDoSMY8Hc637QLnY6Sfx9PM74WH+DWaj
         lb6vYp37rRI310PI5ysPgTNUgJlhxzTwU6rGnW/4Ma1kyb+KqnLyCsnH1aXlSVwaUOjU
         N3SL3ATjd3HLuQ0kLaW9TAisxX7+1w1HI/Q2i/q2OpSzY1Yaqn2RLwdGr+iSrMqUyhL+
         NWPg==
X-Gm-Message-State: AOJu0YzU2/sTCwdvsdpPo4GpGN3yXhR8hBDmTFftFv2zqrgH5zV+TBmL
        KtFS5S8gw/Kd4pj9cm/pQi3FmDC9PxLulV4Jn8tG0KG4n6gZ
X-Google-Smtp-Source: AGHT+IH/KlrUDvkFgo9hFBpByYArzSmPKdxJWL6YyFOfonnFx5CNvuIiVHkGgxAVgWkj2bXY1b+CLP8xf3F5PvfGjymwPk5ETPHG
MIME-Version: 1.0
X-Received: by 2002:a05:6808:13c6:b0:3a8:42ec:53b with SMTP id
 d6-20020a05680813c600b003a842ec053bmr4399697oiw.3.1695060903158; Mon, 18 Sep
 2023 11:15:03 -0700 (PDT)
Date:   Mon, 18 Sep 2023 11:15:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001752e0605a61fd8@google.com>
Subject: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbAlloc (2)
From:   syzbot <syzbot+debee9ab7ae2b34b0307@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    aed8aee11130 Merge tag 'pmdomain-v6.6-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14eb20c4680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4894cf58531f
dashboard link: https://syzkaller.appspot.com/bug?extid=debee9ab7ae2b34b0307
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1e8c59eb8bd1/disk-aed8aee1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/edab4b80fc33/vmlinux-aed8aee1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b280af46d8f/bzImage-aed8aee1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+debee9ab7ae2b34b0307@syzkaller.appspotmail.com

loop3: detected capacity change from 0 to 32768
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:799:12
shift exponent -16777216 is negative
CPU: 1 PID: 16087 Comm: syz-executor.3 Not tainted 6.6.0-rc1-syzkaller-00072-gaed8aee11130 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x27a/0x600 lib/ubsan.c:387
 dbAlloc.cold+0x33/0x38 fs/jfs/jfs_dmap.c:799
 diNewExt+0x736/0x1a70 fs/jfs/jfs_imap.c:2252
 diAllocExt fs/jfs/jfs_imap.c:1946 [inline]
 diAllocAG+0x1707/0x2330 fs/jfs/jfs_imap.c:1663
 diAlloc+0x893/0x1a00 fs/jfs/jfs_imap.c:1584
 ialloc+0x8e/0xa70 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x240/0xb00 fs/jfs/namei.c:225
 vfs_mkdir+0x532/0x7e0 fs/namei.c:4120
 do_mkdirat+0x2a9/0x330 fs/namei.c:4143
 __do_sys_mkdirat fs/namei.c:4158 [inline]
 __se_sys_mkdirat fs/namei.c:4156 [inline]
 __x64_sys_mkdirat+0x115/0x170 fs/namei.c:4156
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe9b047b5e7
Code: 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 02 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe9b124eee8 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe9b047b5e7
RDX: 00000000000001ff RSI: 00000000200016c0 RDI: 00000000ffffff9c
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000200016c0
R13: 00007fe9b124ef40 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
================================================================================


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
