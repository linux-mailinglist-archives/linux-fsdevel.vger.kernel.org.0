Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425A15E9107
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Sep 2022 06:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiIYE6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Sep 2022 00:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiIYE6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Sep 2022 00:58:38 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14B738A10
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 21:58:37 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id q3-20020a056e0220e300b002f5e648e02eso2999939ilv.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 21:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=14/KqwvJjeku5cZoqA2iQtITLkfzH2+C0+Y4K8k2/GM=;
        b=XX7HAE397XjvNyC6oGWgghteOCz2aiBnvWOlEfrxyJuYNFc8UtXgY66rvaSozpRy3I
         sIaqjS59VjbZdYgi8603cWWd0eVNBTwvU3TMREwJU8ZWdn1hNZdnPqJYXqtAZXoBK/Ru
         52i+cCaupzNPQn8y+yR965abksL2CdCtPdtHLTyDso60rbRIW3xu83s1jJQW06w+J2dC
         QcWGI79g5pagGtKGSXnwnqP54A56JaNzwk0/DO5OMWi7fXbV623WN/2DIfePRrfTPb/r
         Xoa9xzTF/k6LywcDCSFf3IHW+g4uiKwqNlHjuiRMRZ8tBrHV8A0hQRwW5gFDtPy7SZc9
         EkrQ==
X-Gm-Message-State: ACrzQf1kxLCtFP1dG7WzQpk1yHZ9fL2iuzhNvhJcSXskqntaACEnzbZl
        wJDufzl3dlJTHkJrty/UtG6yyqiiHTzGmnm24gXjZFoXK4oC
X-Google-Smtp-Source: AMsMyM6y2Vph7DYjMzFUMZo/wOc2FxzKsEqcFdgQBkOlYUt+ObUKCGTHt56wBurbFpTVKQWwfmqDERNdGm8rS56TlpEwdfI+CT0n
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b45:b0:2f5:85da:c388 with SMTP id
 f5-20020a056e020b4500b002f585dac388mr7577436ilu.87.1664081917286; Sat, 24 Sep
 2022 21:58:37 -0700 (PDT)
Date:   Sat, 24 Sep 2022 21:58:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ea2da05e979435f@google.com>
Subject: [syzbot] kernel panic: stack is corrupted in writeback_single_inode
From:   syzbot <syzbot+84b7b87a6430a152c1f4@syzkaller.appspotmail.com>
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

HEAD commit:    3db61221f4e8 Merge tag 'io_uring-6.0-2022-09-23' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16953c4c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c221af36f6d1d811
dashboard link: https://syzkaller.appspot.com/bug?extid=84b7b87a6430a152c1f4
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+84b7b87a6430a152c1f4@syzkaller.appspotmail.com

loop3: detected capacity change from 0 to 8189
ntfs3: loop3: Different NTFS' sector size (1024) and media sector size (512)
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: writeback_single_inode+0x8e7/0x8f0
CPU: 0 PID: 6581 Comm: syz-executor.3 Not tainted 6.0.0-rc6-syzkaller-00291-g3db61221f4e8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 panic+0x2d6/0x715 kernel/panic.c:274
 __stack_chk_fail+0x12/0x20 kernel/panic.c:706
 writeback_single_inode+0x8e7/0x8f0
 write_inode_now+0x1cd/0x260 fs/fs-writeback.c:2723
 iput_final fs/inode.c:1735 [inline]
 iput+0x3e6/0x760 fs/inode.c:1774
 ntfs_fill_super+0x3af3/0x42a0 fs/ntfs3/super.c:1190
 get_tree_bdev+0x400/0x620 fs/super.c:1323
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0bebe8bb9a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0beadfdf88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f0bebe8bb9a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f0beadfdfe0
RBP: 00007f0beadfe020 R08: 00007f0beadfe020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f0beadfdfe0 R15: 000000002007aa80
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
