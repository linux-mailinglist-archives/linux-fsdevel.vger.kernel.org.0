Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180FB23C6D7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 09:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgHEHS0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 03:18:26 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:38165 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgHEHSX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:18:23 -0400
Received: by mail-io1-f70.google.com with SMTP id a65so22125560iog.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2020 00:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Fa0gLd9XVcoRN25QyrKmn6yha622efdv80gtOrAX5uA=;
        b=GzD0yryJrYNoKw9bmHEIVgUK7p7SS0ZKO0POIPyXnaU1vN8iJUpfchNDOVcbdkkSP5
         tWygVsqy9xMbPt4Unx66VtS2AAWSZQofKuckWLzCwV01EDLHPlweVvtFawIYAReRUVx/
         +DTE0YaqQxYJ5uiZsHJRYYKDu1psrZYqjQMnypLtq/KqpaU3BB+ppqOZCoYyoI+8dKTE
         bVZpeVpIOASDVXlcx6Uttsywd1jI2mCU1btp5xNrMi9c4RbWN76gzujDOiSto3XUquEH
         acAy0XiDyq0hbvmxWmOnNk7ftWVJYwA/Y08IL/ClfPe71x6yTbuJKJOoaApTXt6EDaoJ
         ej9g==
X-Gm-Message-State: AOAM530tVWwOA2MwplQo6CjyMx03D1bZXnyM+Bm1nQXMqKXE6AfJli62
        jJyqZdVm250TgRLYCFh4EE11p5hZ9Xa8uIv1oH4gTEAZSl8Y
X-Google-Smtp-Source: ABdhPJx37KgKaXdMV9jxRlO8ttoO67P5NQABfCZCP2MWRuE2Mzy+hPYLLl/H4xpv1mwfNNh78hENiSdgUk2zrje3gvEUZYqE/ha4
MIME-Version: 1.0
X-Received: by 2002:a92:7010:: with SMTP id l16mr2547146ilc.91.1596611902772;
 Wed, 05 Aug 2020 00:18:22 -0700 (PDT)
Date:   Wed, 05 Aug 2020 00:18:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f1bb205ac1c2dce@google.com>
Subject: upstream test error: WARNING in ep_scan_ready_list
From:   syzbot <syzbot+d99fcdc44745d2f54a57@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3950e975 Merge branch 'exec-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13be87cc900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2b75627f23a2ff9
dashboard link: https://syzkaller.appspot.com/bug?extid=d99fcdc44745d2f54a57
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d99fcdc44745d2f54a57@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 1 at fs/eventpoll.c:688 ep_scan_ready_list+0x9f/0x470 fs/eventpoll.c:688
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 1 Comm: systemd Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x16e/0x25d lib/dump_stack.c:118
 panic+0x20c/0x69a kernel/panic.c:231
 __warn+0x211/0x240 kernel/panic.c:600
 report_bug+0x153/0x1d0 lib/bug.c:198
 handle_bug+0x4d/0x90 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x16/0x70 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:547
RIP: 0010:ep_scan_ready_list+0x9f/0x470 fs/eventpoll.c:688
Code: 37 d4 c6 ff 85 db 74 1d e8 1e d0 c6 ff 40 84 ed 75 0c eb 1d e8 12 d0 c6 ff 40 84 ed 74 13 e8 08 d0 c6 ff eb 1c e8 01 d0 c6 ff <0f> 0b 40 84 ed 75 ed e8 f5 cf c6 ff 4c 89 f7 44 89 fe e8 1a 8b a5
RSP: 0000:ffffc90000c73dc8 EFLAGS: 00010293
RAX: ffffffff81853bff RBX: 0000000000000000 RCX: ffff88812b766040
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff81853bd9 R09: 0000ffff88619eb7
R10: 0000ffffffffffff R11: 0000000000000000 R12: 0000000000000000
R13: ffffc90000c73de8 R14: ffff8881297af600 R15: 0000000000000000
 ep_send_events fs/eventpoll.c:1788 [inline]
 ep_poll fs/eventpoll.c:1944 [inline]
 do_epoll_wait+0x55c/0x920 fs/eventpoll.c:2333
 __do_sys_epoll_wait fs/eventpoll.c:2343 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2340 [inline]
 __x64_sys_epoll_wait+0x4d/0x60 fs/eventpoll.c:2340
 do_syscall_64+0x6a/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f310b8db303
Code: 49 89 ca b8 e8 00 00 00 0f 05 48 3d 01 f0 ff ff 73 34 c3 48 83 ec 08 e8 0b c2 00 00 48 89 04 24 49 89 ca b8 e8 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 51 c2 00 00 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffdc7ffa4c0 EFLAGS: 00000293 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 000055e909e78f50 RCX: 00007f310b8db303
RDX: 0000000000000025 RSI: 00007ffdc7ffa4d0 RDI: 0000000000000004
RBP: 00007ffdc7ffa790 R08: 846474467368a395 R09: 00000000000061c0
R10: 00000000ffffffff R11: 0000000000000293 R12: 00007ffdc7ffa4d0
R13: 0000000000000001 R14: ffffffffffffffff R15: 0000000000000002
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
