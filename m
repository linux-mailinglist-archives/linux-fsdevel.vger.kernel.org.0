Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913F6449F31
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 00:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241002AbhKHXtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 18:49:13 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:37631 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbhKHXtM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 18:49:12 -0500
Received: by mail-il1-f199.google.com with SMTP id l5-20020a056e0212e500b0026b231dfd46so11787059iln.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Nov 2021 15:46:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kv3eiU/xeC6qSTp+i5dk+Lz5SOGQgV3Fx7iKIxXP+Ko=;
        b=rLV4U+cCgh8ovlqqWlZfegoOInh1DXG2xIMB0X80RvlanyBBGWyb+M3OisozprjpCJ
         XRsZTkK5Wi+TP25eDB7JPUapth6LsMoc5HfHzc9A/3UqUrqbrs73kORgfFi13zwMG/xd
         jWqud0FgNbCuf38yYT2RPWLtG3gk0UZ6g/EKvRI+b00nYPLTbqV4xmXLfptl2YVq7kdJ
         o8C3gkIak30D99wuMXWnCMVlB7vvfh0PcrdmD+OcTaw+Ae+Zm+BlHCLC8El6/fRL2Vbb
         lO5JN1twPUKzC5P+R5RtInygBxfJXvg0Lgkc6WTinyAAYtQHLUCjjhoViO9Yj6VGmSIi
         0HMg==
X-Gm-Message-State: AOAM532YZxD0WUcLUavpFzYMpgBr11Tnx3QSkpF1MnVDK6hRRqPbL5M2
        JMbSXSIQS/LsxV8TKxZ/ZqNSeE+V0T7ZGeSk8kg9uvgsEe6i
X-Google-Smtp-Source: ABdhPJxKDJob30e8ZiyIj7CMUEH5RQL2ew7YaI7b9lZ/58+a4VZz08d1c6oFNNc0icajQEwpedVAVvlaQ9fL+MKqhKnoWNpjRxSJ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2e8c:: with SMTP id m12mr1948251iow.91.1636415187321;
 Mon, 08 Nov 2021 15:46:27 -0800 (PST)
Date:   Mon, 08 Nov 2021 15:46:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2075605d04f9964@google.com>
Subject: [syzbot] WARNING in iomap_iter
From:   syzbot <syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com>
To:     djwong@kernel.org, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7ddb58cb0eca Merge tag 'clk-for-linus' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13443b82b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a30ce238f371e547
dashboard link: https://syzkaller.appspot.com/bug?extid=a8e049cd3abd342936b6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1112 at fs/iomap/iter.c:33 iomap_iter_done fs/iomap/iter.c:33 [inline]
WARNING: CPU: 0 PID: 1112 at fs/iomap/iter.c:33 iomap_iter+0xdcf/0x11b0 fs/iomap/iter.c:78
Modules linked in:
CPU: 0 PID: 1112 Comm: kworker/u4:5 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: loop0 loop_rootcg_workfn
RIP: 0010:iomap_iter_done fs/iomap/iter.c:33 [inline]
RIP: 0010:iomap_iter+0xdcf/0x11b0 fs/iomap/iter.c:78
Code: fd ff ff e8 93 9f d1 ff e9 f9 f9 ff ff e8 79 24 8b ff 0f 0b e9 85 f8 ff ff e8 6d 24 8b ff 0f 0b e9 96 f7 ff ff e8 61 24 8b ff <0f> 0b e9 f8 f6 ff ff e8 55 24 8b ff 0f 0b 48 b8 00 00 00 00 00 fc
RSP: 0018:ffffc90004d4f680 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc90004d4f818 RCX: 0000000000000000
RDX: ffff88801c181d00 RSI: ffffffff81ec9faf RDI: 0000000000000003
RBP: ffffc90004d4f848 R08: 00000fff80000000 R09: 000000000000000c
R10: ffffffff81ec96a0 R11: 000000000000003f R12: ffffc90004d4f820
R13: ffffffff80000000 R14: ffffc90004d4f840 R15: ffffc90004d4f888
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc3d2148008 CR3: 00000000307d5000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __iomap_dio_rw+0x6b2/0x1a10 fs/iomap/direct-io.c:588
 iomap_dio_rw+0x38/0x90 fs/iomap/direct-io.c:679
 ext4_dio_read_iter fs/ext4/file.c:77 [inline]
 ext4_file_read_iter+0x41c/0x5d0 fs/ext4/file.c:128
 call_read_iter include/linux/fs.h:2155 [inline]
 lo_rw_aio.isra.0+0xa99/0xc90 drivers/block/loop.c:453
 do_req_filebacked drivers/block/loop.c:497 [inline]
 loop_handle_cmd drivers/block/loop.c:1857 [inline]
 loop_process_work+0x92f/0x1db0 drivers/block/loop.c:1897
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
