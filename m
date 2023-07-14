Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6FC75393D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 13:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjGNLGP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 07:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjGNLGO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:06:14 -0400
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499282D78
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 04:06:12 -0700 (PDT)
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-5666806ccfaso4035691eaf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 04:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689332771; x=1691924771;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WpNoZihh1nJGYILfWvMV+nx2XuRAECBIh6cWOBEqnzc=;
        b=JhtHI7kzOGiaT6W8y4ngMFdEnVeyqcyuX4aXB/VXc7ZBZ00u299gxROFCmro7Aa7eE
         oKBmGcgWoQSyqws51Ah+UCIR1la+l+Mw1TAz8ZMMFNQQTs4N7zqrntsJYb5qMKzQz4jL
         vuCN7MXkJ2IoHnp+yMJ15Mv0QPxzj+Ae811PtjsgJUrtQFyotLbL35Igl7dYQjAm8Zkp
         JCDBnbHn+I3F76dkIIAi9tH77OlSz8wLIH3j+ny98tkOPCApfnvK+06xYRipBhGh3hdN
         GDcPoygN/UcHeYZ6F/lmbE9ofw9HqR7Hb23UkicGMKoZAjhrnJite6sUE7tkgflTLK5Z
         dN5Q==
X-Gm-Message-State: ABy/qLYhkfCgNtSwZdBTzOEaEecJgXRE8V4/Kr6tn3mBD1dkLh8eEVZF
        J3otz+KPQeP9UeRWhaNV2N9kAxw81Il+D/m2FWygQJbCFiPs
X-Google-Smtp-Source: APBJJlEgjrXtEMDE+U9I+GvN9NQvRVbf6mbGE0KH1jaAwz35lkewTGNycZ0YCYCUrXh3x752ys7LZinBuMOVEzvVz7uqNx8d1n27
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c992:b0:1ba:2305:45d0 with SMTP id
 hi18-20020a056870c99200b001ba230545d0mr3494370oab.0.1689332771662; Fri, 14
 Jul 2023 04:06:11 -0700 (PDT)
Date:   Fri, 14 Jul 2023 04:06:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c331580600706f06@google.com>
Subject: [syzbot] [udf?] WARNING in udf_add_free_space (2)
From:   syzbot <syzbot+4100f31f97d5a2276416@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    06c2afb862f9 Linux 6.5-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1220cf54a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=150188feee7071a7
dashboard link: https://syzkaller.appspot.com/bug?extid=4100f31f97d5a2276416
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c208715c3f9e/disk-06c2afb8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df15524c5f57/vmlinux-06c2afb8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5f7b49f73ba7/bzImage-06c2afb8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4100f31f97d5a2276416@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 10155 at fs/udf/udfdecl.h:121 udf_add_free_space.isra.0+0x1b2/0x200 fs/udf/udfdecl.h:121
Modules linked in:
CPU: 0 PID: 10155 Comm: syz-executor.1 Not tainted 6.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
RIP: 0010:udf_add_free_space.isra.0+0x1b2/0x200 fs/udf/udfdecl.h:121
Code: 02 84 c0 74 04 3c 03 7e 25 c7 83 50 01 00 00 01 00 00 00 5b 5d 41 5c 41 5d e9 5a c9 9e fe e8 55 c9 9e fe 0f 0b e8 4e c9 9e fe <0f> 0b eb b2 e8 75 ff f1 fe eb d4 e8 ee fe f1 fe e9 6b fe ff ff e8
RSP: 0018:ffffc9000a8cf768 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880177aac00 RCX: 0000000000000000
RDX: ffff8880307a5940 RSI: ffffffff82e61872 RDI: 0000000000000005
RBP: 0000000041105f00 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000041105f00 R11: 0000000000000001 R12: ffff888042aed000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880318d0e28
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f212dd88fb8 CR3: 000000002d003000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 udf_table_free_blocks fs/udf/balloc.c:403 [inline]
 udf_free_blocks+0x430/0x1330 fs/udf/balloc.c:681
 udf_discard_prealloc+0x47b/0x4e0 fs/udf/truncate.c:147
 udf_release_file fs/udf/file.c:184 [inline]
 udf_release_file+0xdc/0x110 fs/udf/file.c:174
 __fput+0x40c/0xad0 fs/file_table.c:384
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa9a/0x29a0 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 get_signal+0x249b/0x25f0 kernel/signal.c:2877
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:308
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 ret_from_fork+0x15/0x30 arch/x86/entry/entry_64.S:301
RIP: 0033:0x7f1c8b28c389
Code: Unable to access opcode bytes at 0x7f1c8b28c35f.
RSP: 002b:00007f1c8c08b118 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: 0000000000000000 RBX: 00007f1c8b3abf80 RCX: 00007f1c8b28c389
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007f1c8b2d7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe4ed07c0f R14: 00007f1c8c08b300 R15: 0000000000022000
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
