Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEB22C02F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 11:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgKWKFS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 05:05:18 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:37572 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgKWKFR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:05:17 -0500
Received: by mail-io1-f71.google.com with SMTP id b4so12298522ioa.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 02:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WaUADOnuz3DDKLiV4eDIKdQIyofQv4t0rpE3AR0uVkg=;
        b=GlqrE03WzvvhvcXhFFJPsTVTYZ6eAbxNPxnACXMlDVtkxy3rUu1ORXpYH7JXNrB3J+
         QmmtSUQawrb9u8UllK/4GaUDbZg+xblp87vtNWw06oQm6gsE+Mk81zs9mh77o1p5Fgm8
         5/fywFfVkaACFS6XLlIajUiAZrb856YOEFRRUA5H5umOfxo+KrECrhzwXi32Lfha1k9K
         MzyXSKqVwC8jTv8ORC5LsNi8P88vPvOV3EZtkbd/2M/WZIFGFWazDF2YvDrZs50Dnddo
         xEglZohGl504Fjqu8BX4ExI+ig2uy87oMLmtqjZ7yqt5wZc1uCQaH59FIA5damAXbT8k
         HDPQ==
X-Gm-Message-State: AOAM533OL4IVaCfZHdYscuYiGHwpQ1l7YdfAPsiEiHIMqSkCiT6WLwHG
        AV4f7RSfKaJDqx9DW+auQuvP3HBasSXmI3Nef/4nXBpOLRN1
X-Google-Smtp-Source: ABdhPJxbkk61mW4TMXkQn1ETeA0YcdXR+oc/w9eN25HD1JHpRsjqVmYmhzVPhAfXbNZh4aRDgaYVUX3tq9lJ+AIuZ0wu43ZxP6mb
MIME-Version: 1.0
X-Received: by 2002:a02:6ccd:: with SMTP id w196mr27987669jab.133.1606125916931;
 Mon, 23 Nov 2020 02:05:16 -0800 (PST)
Date:   Mon, 23 Nov 2020 02:05:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be4c9505b4c35420@google.com>
Subject: kernel BUG at fs/notify/dnotify/dnotify.c:LINE! (2)
From:   syzbot <syzbot+f427adf9324b92652ccc@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    27bba9c5 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b82225500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=330f3436df12fd44
dashboard link: https://syzkaller.appspot.com/bug?extid=f427adf9324b92652ccc
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d3f015500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17162d4d500000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16570525500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15570525500000
console output: https://syzkaller.appspot.com/x/log.txt?x=11570525500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f427adf9324b92652ccc@syzkaller.appspotmail.com

wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
------------[ cut here ]------------
kernel BUG at fs/notify/dnotify/dnotify.c:118!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 648 Comm: kworker/u4:4 Not tainted 5.10.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound fsnotify_mark_destroy_workfn
RIP: 0010:dnotify_free_mark fs/notify/dnotify/dnotify.c:118 [inline]
RIP: 0010:dnotify_free_mark+0x4b/0x60 fs/notify/dnotify/dnotify.c:112
Code: 80 3c 02 00 75 26 48 83 bd 80 00 00 00 00 75 15 e8 0a d3 a0 ff 48 89 ee 48 8b 3d 68 8c 1d 0b 5d e9 aa 06 e2 ff e8 f5 d2 a0 ff <0f> 0b e8 ae 4d e2 ff eb d3 66 90 66 2e 0f 1f 84 00 00 00 00 00 41
RSP: 0018:ffffc90002f1fc38 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffffff8958ae60 RCX: 1ffff920005e3f95
RDX: ffff888012601a40 RSI: ffffffff81cf5ceb RDI: ffff88801aea2080
RBP: ffff88801aea2000 R08: 0000000000000001 R09: ffffffff8ebb170f
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880171a2000
R13: ffffc90002f1fc98 R14: ffff88801aea2010 R15: ffff88801aea2018
FS:  0000000000000000(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056045fa95978 CR3: 0000000012121000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 fsnotify_final_mark_destroy+0x71/0xb0 fs/notify/mark.c:205
 fsnotify_mark_destroy_workfn+0x1eb/0x340 fs/notify/mark.c:840
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Modules linked in:


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
