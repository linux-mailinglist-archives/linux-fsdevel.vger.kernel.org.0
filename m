Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849005EE6D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 22:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiI1Uwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 16:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiI1Uwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:52:43 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED1923146
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 13:52:42 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id 5-20020a5d9c05000000b006a44709a638so8568934ioe.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 13:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+aAFpnJBHZPXPfaDgyMNQf3pqjAuAm5ZpZxokXIbiRQ=;
        b=eXMc2I+aXWym3NwzDC1RJonTtWhnj08tkcQdfmsqm2BKAlhFNwBqU0NW4kY5eS+1Z5
         SYS+mluEzN0Hncz9i2drqzOojlGfGv/wAnmvn1Gp0NpO7Fhxd6I7jjHLjipZpBUi1vQC
         EG+gVFXmKggiKyCG7sFDAb0gcLeXyYXKuQ/tWEh0nWjavMnD0wo1eCeCJZ8mUhukfzjZ
         ZIifr3u+HILjhU0PJHpOczfV5aqGRr2HLngK8UIBxX2TPpmmjzgbX0+yPIfLzLxCUgyE
         Qc3D625iYRMdY3ZQUZizA7+Xvu6l6Q6HTf0cdPMb4xrHDi3IBlpHIZ9W/ULLdqR4U5ZR
         3E1w==
X-Gm-Message-State: ACrzQf2EfBw6/L/jQo+76mZzlztioRg6eBPn//26FHB+Hqpk1xzE2gg5
        ZAi0thnWIpa4LRVIOxu5AAT7FD7oxQuMDYrbYlsfFc4f5q87
X-Google-Smtp-Source: AMsMyM6CDIXmEbxIb9jZ6+fifK3F8uCUyFPxojiNgmi8eg2DMkD5hDMbJe8PMGu7JcwKnts6VbKpsvoTPHTjv3CJi4RpgoORS8Fw
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1687:b0:6a4:d44:74bf with SMTP id
 s7-20020a056602168700b006a40d4474bfmr13211067iow.80.1664398361945; Wed, 28
 Sep 2022 13:52:41 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:52:41 -0700
In-Reply-To: <0000000000008ea2da05e979435f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020ef6305e9c2f181@google.com>
Subject: Re: [syzbot] kernel panic: stack is corrupted in writeback_single_inode
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    49c13ed0316d Merge tag 'soc-fixes-6.0-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1124fd74880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4520785fccee9b40
dashboard link: https://syzkaller.appspot.com/bug?extid=84b7b87a6430a152c1f4
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173f55df080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+84b7b87a6430a152c1f4@syzkaller.appspotmail.com

ntfs3: loop1: failed to read volume at offset 0x120000
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: writeback_single_inode+0x8fb/0x910
CPU: 0 PID: 10703 Comm: syz-executor.1 Not tainted 6.0.0-rc7-syzkaller-00068-g49c13ed0316d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 panic+0x316/0x76b kernel/panic.c:274
 __stack_chk_fail+0x12/0x20 kernel/panic.c:706
 writeback_single_inode+0x8fb/0x910
 write_inode_now+0x1cd/0x260 fs/fs-writeback.c:2723
 iput_final fs/inode.c:1735 [inline]
 iput+0x3e6/0x760 fs/inode.c:1774
 ntfs_fill_super+0x3c6c/0x4420 fs/ntfs3/super.c:1190
 get_tree_bdev+0x400/0x620 fs/super.c:1323
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2e3/0x3d0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f102428bada
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f10253dff88 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f102428bada
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f10253dffe0
RBP: 00007f10253e0020 R08: 00007f10253e0020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f10253dffe0 R15: 0000000020003580
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..

