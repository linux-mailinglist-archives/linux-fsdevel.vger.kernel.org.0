Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D13476A15E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 21:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjGaTjy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 15:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjGaTjx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:39:53 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31692199F
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 12:39:52 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1bb52b94b4eso9722023fac.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 12:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690832391; x=1691437191;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cm3XSjN6H7r/ng7NKyK3iKnYCBzx9MyxBE9I8DFsmyY=;
        b=Lvj82gC1rssxc1AciuOg+dOu6kj9vE5V4GCzZlHDG4ZOHRIS50XeVSWd+pMvOO/RWz
         nZXcamyiuMYSDBsVqY59JZdyNRZbW9g2BsSaoqxnHoCgfhaqiTD0Xc9X4D6ZZZlElfmT
         Zk1FIfyIQJQ9XGnDkZgoCkdzvUgh+c8+ESO7O5dJ9CzqNyPVqt6UOO8+irHFKLfGkM3O
         6VR0d1tJGWKPQQMADzumiVF3tIteAmL12CKYdLk1L+Zhv12UNZ7nAXTj3S1Ev6MYpRab
         2y+gMo2UGLWhbb94PW4XgzDlXPd8N10yLgXXrzdpx+01iIvBbhBWB8hzhcoPpq2QAkY1
         xT6A==
X-Gm-Message-State: ABy/qLYqLCC133pVY4ZogvuU72ZkbR4zNLos5tqQGvkmPsQRfHtDKldH
        q+AXwh3waHam/S7UtR5rgtuOB/ZW001JhSvn/5IYT3MbZ2KZ
X-Google-Smtp-Source: APBJJlHwV5TYZX8UXUuEfQTpG4vZ1TQMM8rIzvqTyILhBUwNuikHymdXHVxbmkc3fedKjqInHir/ivMm/zsYpZxnO7hSQdRzALXf
MIME-Version: 1.0
X-Received: by 2002:a05:6870:d884:b0:1b7:6077:bef1 with SMTP id
 dv4-20020a056870d88400b001b76077bef1mr13454830oab.0.1690832391361; Mon, 31
 Jul 2023 12:39:51 -0700 (PDT)
Date:   Mon, 31 Jul 2023 12:39:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000fdc630601cd9825@google.com>
Subject: [syzbot] [udf?] UBSAN: array-index-out-of-bounds in udf_process_sequence
From:   syzbot <syzbot+abb7222a58e4ebc930ad@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0a8db05b571a Merge tag 'platform-drivers-x86-v6.5-3' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145f2726a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d10d93e1ae1f229
dashboard link: https://syzkaller.appspot.com/bug?extid=abb7222a58e4ebc930ad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/58a518a693f4/disk-0a8db05b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/22cc85e51a4d/vmlinux-0a8db05b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/daeac90304b9/bzImage-0a8db05b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+abb7222a58e4ebc930ad@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in fs/udf/super.c:1365:9
index 4 is out of range for type '__le32[4]' (aka 'unsigned int[4]')
CPU: 0 PID: 10089 Comm: syz-executor.0 Not tainted 6.5.0-rc3-syzkaller-00044-g0a8db05b571a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
 udf_load_sparable_map fs/udf/super.c:1365 [inline]
 udf_load_logicalvol fs/udf/super.c:1457 [inline]
 udf_process_sequence+0x300d/0x4e70 fs/udf/super.c:1773
 udf_load_sequence fs/udf/super.c:1820 [inline]
 udf_check_anchor_block+0x2a6/0x550 fs/udf/super.c:1855
 udf_scan_anchors fs/udf/super.c:1909 [inline]
 udf_load_vrs+0xa71/0x1100 fs/udf/super.c:1969
 udf_fill_super+0x95d/0x23a0 fs/udf/super.c:2147
 mount_bdev+0x276/0x3b0 fs/super.c:1391
 legacy_get_tree+0xef/0x190 fs/fs_context.c:611
 vfs_get_tree+0x8c/0x270 fs/super.c:1519
 do_new_mount+0x28f/0xae0 fs/namespace.c:3335
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f838747e22a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f838819eee8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f838819ef80 RCX: 00007f838747e22a
RDX: 0000000020000100 RSI: 0000000020000200 RDI: 00007f838819ef40
RBP: 0000000020000100 R08: 00007f838819ef80 R09: 0000000000214856
R10: 0000000000214856 R11: 0000000000000202 R12: 0000000020000200
R13: 00007f838819ef40 R14: 0000000000000c1d R15: 0000000020000240
 </TASK>
================================================================================


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
