Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EDB5EE6BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 22:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiI1Unn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 16:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbiI1Unl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:43:41 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912558F965
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 13:43:40 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id o5-20020a056e02102500b002ddcc65029cso10658760ilj.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 13:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ON6r0sPlZ28itH0e0rVD04OXW0bLNe6cklXZWR6X21M=;
        b=oJZf4SNwW4YQoDR+5S/ZRdwKeHcv11iNcNxecl+lZxzMiPE4ntUyGEK6lgZvQPuUan
         cOdOLHOgJKauYMo4nt061sRRGhjhkvUAAu1xtelZkM7LzTEwd+cA4H90VzNI85C2UKYG
         FeMJly9EpnmwKycFiodEVpSA7XkcdHhQGbAyg8v3bjJVNDyetdPXAQF8625FuBkoA1Q6
         iiE4bMglxXhEn4BDDwYjnFDLEMRJ/5Ubb+YEtVLT6GGmIo5LUFy9STe0y2yuqE8jNy0r
         mcJ+TFoFcF9D+5uouK2OuYKVq5ho+D466y3rPPU+kXDFwJODL1eh3mFE68lsPhzF/TTX
         03dg==
X-Gm-Message-State: ACrzQf3PwF2wbMFS3RJI18l9mmI+kARAGrgoIroCiu0MDwfGTjc8VI1D
        aul0EHiO8i41T06rzm6ddZqLX4XXWw0ZH80ESVw676A5TNxr
X-Google-Smtp-Source: AMsMyM56HtC3s11FOobh/wB88iRI+IMeKr7z2QvJMsmBV3MR3YlT9ZI1ngTpPVQz65nvQ0UHgg3R0lYatOw2VBA439pw4je3aSQZ
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3492:b0:35a:9829:6ff6 with SMTP id
 t18-20020a056638349200b0035a98296ff6mr18485805jal.57.1664397819947; Wed, 28
 Sep 2022 13:43:39 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:43:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2adfa05e9c2d0b9@google.com>
Subject: [syzbot] WARNING in __brelse
From:   syzbot <syzbot+7902cd7684bc35306224@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    46452d3786a8 Merge tag 'sound-6.0-rc8' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=154595ef080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=755695d26ad09807
dashboard link: https://syzkaller.appspot.com/bug?extid=7902cd7684bc35306224
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127543c4880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1740b138880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7902cd7684bc35306224@syzkaller.appspotmail.com

------------[ cut here ]------------
VFS: brelse: Trying to free free buffer
WARNING: CPU: 0 PID: 3604 at fs/buffer.c:1145 __brelse fs/buffer.c:1145 [inline]
WARNING: CPU: 0 PID: 3604 at fs/buffer.c:1145 __brelse+0x67/0xa0 fs/buffer.c:1139
Modules linked in:
CPU: 0 PID: 3604 Comm: syz-executor576 Not tainted 6.0.0-rc7-syzkaller-00042-g46452d3786a8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
RIP: 0010:__brelse fs/buffer.c:1145 [inline]
RIP: 0010:__brelse+0x67/0xa0 fs/buffer.c:1139
Code: 7c 04 84 d2 75 4e 44 8b 63 60 31 ff 44 89 e6 e8 8f 57 95 ff 45 85 e4 75 1c e8 c5 5a 95 ff 48 c7 c7 00 93 fc 89 e8 5b 6f 54 07 <0f> 0b 5b 5d 41 5c e9 ae 5a 95 ff e8 a9 5a 95 ff be 04 00 00 00 48
RSP: 0018:ffffc9000379fbb0 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffff8880747e4bc8 RCX: 0000000000000000
RDX: ffff888024c61d80 RSI: ffffffff8161f2a8 RDI: fffff520006f3f68
RBP: ffff8880747e4c28 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000002 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff8880b9a35f80 R15: 0000000000000008
FS:  0000555556bf6300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff88e983290 CR3: 00000000715c2000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 brelse include/linux/buffer_head.h:327 [inline]
 __invalidate_bh_lrus fs/buffer.c:1391 [inline]
 invalidate_bh_lru+0x99/0x150 fs/buffer.c:1404
 smp_call_function_many_cond+0x10e2/0x1430 kernel/smp.c:979
 on_each_cpu_cond_mask+0x56/0xa0 kernel/smp.c:1154
 kill_bdev block/bdev.c:74 [inline]
 blkdev_flush_mapping+0x136/0x2f0 block/bdev.c:661
 blkdev_put_whole+0xd1/0xf0 block/bdev.c:692
 blkdev_put+0x226/0x770 block/bdev.c:952
 deactivate_locked_super+0x94/0x160 fs/super.c:332
 deactivate_super+0xad/0xd0 fs/super.c:363
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1186
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 ptrace_notify+0x114/0x140 kernel/signal.c:2353
 ptrace_report_syscall include/linux/ptrace.h:420 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:482 [inline]
 syscall_exit_work kernel/entry/common.c:249 [inline]
 syscall_exit_to_user_mode_prepare+0x129/0x280 kernel/entry/common.c:276
 __syscall_exit_to_user_mode_work kernel/entry/common.c:281 [inline]
 syscall_exit_to_user_mode+0x9/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff88e90ec27
Code: 07 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe36cd2398 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007ff88e90ec27
RDX: 00007ffe36cd2459 RSI: 000000000000000a RDI: 00007ffe36cd2450
RBP: 00007ffe36cd2450 R08: 00000000ffffffff R09: 00007ffe36cd2230
R10: 0000555556bf7653 R11: 0000000000000202 R12: 00007ffe36cd34d0
R13: 0000555556bf75f0 R14: 00007ffe36cd23c0 R15: 0000000000000005
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
