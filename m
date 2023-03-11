Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D4E6B580E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 04:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCKD1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 22:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKD1u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 22:27:50 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B63F12A4DA
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Mar 2023 19:27:49 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id h19-20020a056e021d9300b00318f6b50475so3626371ila.21
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Mar 2023 19:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678505268;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtqOT6CzflWo8NFA8wG8H31OfirdzkEX/EGftTEZpNg=;
        b=cMBYU7ZXaXk0XRycCrNTU7SUVkoDUqcXqzjynJkv+ULg9ktM0wYCfA9RY4kgFh6HMF
         8/mRxX1L5mcvgYig8UlY2y1ol5v36sPfS4bcAfDA667tyKOqhsNIKHPNO7Plk9G/CpeT
         rz8faWmJY/WQbeV3RWk9W+8MN0OxbNHZ6Qe/GnrqhWwzJHSdYJYDC8JKh/IPJFeXEJnt
         kMS8IAkkTKkli8v4k1rH1YFIOzRQ0y7Fs7RVjx4zZKh9+ItYaCf0W5NQQ68pbD7KNJUF
         1tBqjdj7NGX0sofNT6BzBixS8nNLS1eIKXr4O/lvQiUi0a3y2X7NLs1PJEUB7fjsL3rp
         keaQ==
X-Gm-Message-State: AO0yUKWVq4Jv/VjAzMSfgIc7JnvyAzubxQWb/6/BAx+Gby7sgv2ZVO8m
        6FKLudO/WprAIZ5Mmn1iu2PH4pXvujZXFudPMBd7QeWO+UvU
X-Google-Smtp-Source: AK7set+4D5Nw+EclJocwfNOA8Kqg37WbZUpkaY1C3RDpU+kD5YQFWXAIFO9HzqJpX3OdbtVwZbhNeNchHqZsCFu2qTtIP4q6sPmE
MIME-Version: 1.0
X-Received: by 2002:a92:c04b:0:b0:315:7a34:224 with SMTP id
 o11-20020a92c04b000000b003157a340224mr2154493ilf.3.1678505268351; Fri, 10 Mar
 2023 19:27:48 -0800 (PST)
Date:   Fri, 10 Mar 2023 19:27:48 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046238c05f69776ab@google.com>
Subject: [syzbot] [ntfs?] kernel BUG in ntfs_end_buffer_async_read
From:   syzbot <syzbot+72ba5fe5556d82ad118b@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fe15c26ee26e Linux 6.3-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12feadbcc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7573cbcd881a88c9
dashboard link: https://syzkaller.appspot.com/bug?extid=72ba5fe5556d82ad118b
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89d41abd07bd/disk-fe15c26e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fa75f5030ade/vmlinux-fe15c26e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/590d0f5903ee/Image-fe15c26e.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+72ba5fe5556d82ad118b@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ntfs/aops.c:130!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 21 Comm: ksoftirqd/1 Not tainted 6.3.0-rc1-syzkaller-gfe15c26ee26e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : ntfs_end_buffer_async_read+0xa28/0xb78 fs/ntfs/aops.c:130
lr : ntfs_end_buffer_async_read+0xa28/0xb78 fs/ntfs/aops.c:130
sp : ffff80001a477a30
x29: ffff80001a477a50 x28: ffff0001416534a0 x27: 0000000000000019
x26: dfff800000000000 x25: 0000000000001000 x24: ffff00013f9ed3a0
x23: 0000000000000000 x22: ffff00013f9ed6c0 x21: 0000000000000001
x20: 0000000000020211 x19: 0000000000000330 x18: 1fffe000368995b6
x17: ffff800015cdd000 x16: ffff80000826e470 x15: 0000000000000000
x14: 1ffff00002b9c0b2 x13: dfff800000000000 x12: 0000000000000003
x11: ff8080000965190c x10: 0000000000000000 x9 : ffff80000965190c
x8 : ffff0000c0af1b40 x7 : ffff800009651140 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff80001a477940 x1 : 0000000000020211 x0 : 0000000000001000
Call trace:
 ntfs_end_buffer_async_read+0xa28/0xb78 fs/ntfs/aops.c:130
 end_bio_bh_io_sync+0xb0/0x194 fs/buffer.c:2703
 bio_endio+0x940/0x984 block/bio.c:1607
 req_bio_endio block/blk-mq.c:795 [inline]
 blk_update_request+0x444/0xdc0 block/blk-mq.c:927
 blk_mq_end_request+0x54/0x88 block/blk-mq.c:1054
 lo_complete_rq+0x140/0x258 drivers/block/loop.c:370
 blk_complete_reqs block/blk-mq.c:1132 [inline]
 blk_done_softirq+0x11c/0x168 block/blk-mq.c:1137
 __do_softirq+0x378/0xfbc kernel/softirq.c:571
 run_ksoftirqd+0x6c/0x148 kernel/softirq.c:934
 smpboot_thread_fn+0x4b0/0x96c kernel/smpboot.c:164
 kthread+0x24c/0x2d4 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:870
Code: c8097e88 35ffffa9 17fffdb3 97bafdea (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
