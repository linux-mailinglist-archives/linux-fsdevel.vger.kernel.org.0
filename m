Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A4175D5F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 22:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGUUsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 16:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjGUUsN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:48:13 -0400
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DFA10F5
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 13:48:12 -0700 (PDT)
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-6b9cf208fb5so4866420a34.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 13:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689972491; x=1690577291;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qTOg30Pyyd8rsEqqzfnKH2ivlCUarSSwgeMcDgQLn0=;
        b=B7uPpa1G1LREDdAQx6gMX+wZer8rbZ4Lyp/WdVTIsbLCASO0U/t60tVla9xH4xNHsH
         MKEvuI3tKwGUQh6zG3GLuJwhqmZhSFmKRy/S8kw53AXQSqFV4gG0MJb4dcAo3it8TxeE
         z3Q+2UjSZ8KmnB0bWN6w2WInyhdxXZObwCt8NoJwGOC4tO5LuYdv9wZ8yq6m6YNCtoZU
         LJNYqJNulJt/zgy6zISpH1HlDeD5IniGWVGOpA6ZSEQ6HA+cYu+qLAAkEPLnnFfH3Xbp
         lFkW4j9aRKBKZ8ubZk5K59EuOSzpXhhGZ4GK5DXR3H4kK7dQe/j4XweoVL8hdlkIj6+q
         37Yg==
X-Gm-Message-State: ABy/qLYXK4PIPZdo0cq6+PaVJfJidtSBZDkQYaVO0gP0VzAw16xyqeg5
        LCCNmiiu/bj7LNLNAU1CovU8xKcdN3jLeyhWEn1IdNwrUpzM
X-Google-Smtp-Source: APBJJlElBQGXVCLZabwgLaEmLzMHQYKFHWenz4onzfkqO/Quvh8RT0SkcxsUzr4MJ14kIrJG99OR+w3TcFKHqjGUEqFpJ3LCHfkw
MIME-Version: 1.0
X-Received: by 2002:a05:6830:118:b0:6b9:a90e:f515 with SMTP id
 i24-20020a056830011800b006b9a90ef515mr1450617otp.3.1689972491743; Fri, 21 Jul
 2023 13:48:11 -0700 (PDT)
Date:   Fri, 21 Jul 2023 13:48:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000cf7de0601056232@google.com>
Subject: [syzbot] [gfs2?] kernel panic: hung_task: blocked tasks (2)
From:   syzbot <syzbot+607aa822c60b2e75b269@syzkaller.appspotmail.com>
To:     cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fdf0eaf11452 Linux 6.5-rc2
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1797783aa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27e33fd2346a54b
dashboard link: https://syzkaller.appspot.com/bug?extid=607aa822c60b2e75b269
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11322fb6a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17687f1aa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ac950f24d26/disk-fdf0eaf1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/666fcbcfa05d/vmlinux-fdf0eaf1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5bbe73baa630/bzImage-fdf0eaf1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/85821d156573/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+607aa822c60b2e75b269@syzkaller.appspotmail.com

Kernel panic - not syncing: hung_task: blocked tasks
CPU: 0 PID: 27 Comm: khungtaskd Not tainted 6.5.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 panic+0x6a4/0x750 kernel/panic.c:340
 check_hung_uninterruptible_tasks kernel/hung_task.c:226 [inline]
 watchdog+0xcf2/0x11b0 kernel/hung_task.c:379
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
RIP: 0000:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


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
