Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665B46A9DCB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 18:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjCCRg5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 12:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjCCRg4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:36:56 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EA415C84
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Mar 2023 09:36:55 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id 4-20020a056e0211a400b003157534461aso1668031ilj.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Mar 2023 09:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0CosFoSXFpJIF2mFdq6e5N6hPuvDMU0PAabkFcIAiRc=;
        b=SQpN6xE3GdWyJk7FBYASxZOu1sxc5m3Zo3rqNdbBGXJ6CPWR7mCJUoJxUIIv/cMun2
         aQH/s4G+ewyd8F7+QEbF+0Hf6MC+Zo4KfuvHICrvGtUQfSXAzIS5ZPwhhJYmtwE3nnwW
         W15rmhPf47iGqz5N6YHM+TsNyHYvouwuYN+25ZSThEomt3qHW51GYKlzwe7nwklb4B0A
         XUMp6QFEp51pYknO5bqwGUiXaa9gZCb2DYo5Pw2K13gGKA/lkwaI5c6ml1hSw4pewF2P
         P44ohZF51eqvKAIsBGH6c9t5PJ7EOnYTy/HzxwRbwFZKj2AB0T9BWNstNuYE+f25IRDh
         Rn0w==
X-Gm-Message-State: AO0yUKX4QXHbR7fBjSJQseRYTtaEnBWQ8IIis2nBPoNXG0gzFz7TQ4WZ
        xWpG1R8VeVOvwGuHYA1Q7xpzGKx7Me4jM3g9thFOxM0HsLGw
X-Google-Smtp-Source: AK7set/SWsId3AeRaBfKXrXymElZpbKFQJ24geHKmHFEfQZka/DTKJbT/NjFQAzLFCmJGwGWKJaPP07KUjGbEcO+iGsPIW1SptTh
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11ac:b0:315:8d25:1eaf with SMTP id
 12-20020a056e0211ac00b003158d251eafmr1208423ilj.4.1677865014726; Fri, 03 Mar
 2023 09:36:54 -0800 (PST)
Date:   Fri, 03 Mar 2023 09:36:54 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f18b905f6026455@google.com>
Subject: [syzbot] [ntfs?] UBSAN: shift-out-of-bounds in ntfs_read_inode_mount
From:   syzbot <syzbot+c601e38d15ce8253186a@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    04a357b1f6f0 Merge tag 'mips_6.3_1' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144617acc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f763d89e26d3d4c4
dashboard link: https://syzkaller.appspot.com/bug?extid=c601e38d15ce8253186a
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e9f8326ebe2/disk-04a357b1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/138ae11c9b96/vmlinux-04a357b1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d0594947835d/bzImage-04a357b1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c601e38d15ce8253186a@syzkaller.appspotmail.com

loop1: detected capacity change from 0 to 4096
================================================================================
UBSAN: shift-out-of-bounds in fs/ntfs/inode.c:1080:43
shift exponent 48 is too large for 32-bit type 'unsigned int'
CPU: 0 PID: 2557 Comm: syz-executor.1 Not tainted 6.2.0-syzkaller-13163-g04a357b1f6f0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c3/0x420 lib/ubsan.c:387
 ntfs_read_locked_inode+0x4665/0x49c0 fs/ntfs/inode.c:1080
 ntfs_read_inode_mount+0xda6/0x2660 fs/ntfs/inode.c:2098
 ntfs_fill_super+0x1884/0x2bd0 fs/ntfs/super.c:2863
 mount_bdev+0x271/0x3a0 fs/super.c:1371
 legacy_get_tree+0xef/0x190 fs/fs_context.c:610
 vfs_get_tree+0x8c/0x270 fs/super.c:1501
 do_new_mount+0x28f/0xae0 fs/namespace.c:3042
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fee1468d62a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fee1548af88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000000000001f6d9 RCX: 00007fee1468d62a
RDX: 000000002001f6c0 RSI: 000000002001f640 RDI: 00007fee1548afe0
RBP: 00007fee1548b020 R08: 00007fee1548b020 R09: 000000000000870b
R10: 000000000000870b R11: 0000000000000202 R12: 000000002001f6c0
R13: 000000002001f640 R14: 00007fee1548afe0 R15: 0000000020000000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
