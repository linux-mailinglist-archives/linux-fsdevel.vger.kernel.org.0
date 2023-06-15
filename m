Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9910A7322F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 01:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjFOXDP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 19:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjFOXDO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:03:14 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2542965
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 16:03:12 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7773997237cso6067339f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 16:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686870191; x=1689462191;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uI/qin+IXEGRa3nylH1otRAWekGozAdq8GTVNCdVh5o=;
        b=IJP8o7HqBk0P4iqHSmoSgebeIxx/5THJkFuLWrmNNcutyv8P5LbBjMlPb6ncAymfwh
         e+x7KSKH2emYgVyvQ1W60qQvAlNaGYis7dqqpijoOhphLCsupbz4sUsUhsBH8I11igJv
         UXPPS4m67qp38Ys3ljpo2kHfqQ/PkAW7agRNQ+DYQd9yhy0boB7qP5+vWF1LDgsxRfWo
         acLm5wTkpM147WJGSPCVuLrr5dcNYd354Hmdok+hIddLX9E2x2R8V1i0QCnTI0RjDuIi
         FJ/DtKHvHiz1aSZG+IwlMxUozH/aO7CYu5EjPzRiIu6ih3wG7Sr15ws5kE1mYdD1UQcO
         QdeA==
X-Gm-Message-State: AC+VfDxzzzP74IOeMHSKo22VnU7XSUisw1kJaWhg3JbzNNILdgUg8Pao
        CL87fEFPhh4QGvDIyv38FFxM4hyVDmYpIH3Cb8MTKA7s84ao
X-Google-Smtp-Source: ACHHUZ4iIHMRj8/x9kKb4jIVvW4ik6IoN9ypPW/7WcMpCPeLryEytqJt4FNV1MSA9sIMbUA0ZgCKmFZq/0cej/haU0A7dpgST8dK
MIME-Version: 1.0
X-Received: by 2002:a6b:fd03:0:b0:763:dd01:e143 with SMTP id
 c3-20020a6bfd03000000b00763dd01e143mr280370ioi.2.1686870191727; Thu, 15 Jun
 2023 16:03:11 -0700 (PDT)
Date:   Thu, 15 Jun 2023 16:03:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f70d405fe331298@google.com>
Subject: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbUpdatePMap (2)
From:   syzbot <syzbot+91ad2b52815a08caf4ea@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4c605260bc60 Merge tag 'x86_urgent_for_v6.4_rc6' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=170c95b3280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=91ad2b52815a08caf4ea
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bc032d280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14aa25b3280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b8183c640f8a/disk-4c605260.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/66b85f02d905/vmlinux-4c605260.xz
kernel image: https://storage.googleapis.com/syzbot-assets/80073dbaded3/bzImage-4c605260.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/85d11f73be8a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91ad2b52815a08caf4ea@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:470:12
shift exponent 131072 is too large for 64-bit type 'long long'
CPU: 0 PID: 106 Comm: jfsCommit Not tainted 6.4.0-rc5-syzkaller-00313-g4c605260bc60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c3/0x420 lib/ubsan.c:387
 dbUpdatePMap+0xe4e/0xf50 fs/jfs/jfs_dmap.c:470
 txAllocPMap+0x57b/0x6b0 fs/jfs/jfs_txnmgr.c:2420
 txUpdateMap+0x7cc/0x9e0 fs/jfs/jfs_txnmgr.c:2358
 txLazyCommit fs/jfs/jfs_txnmgr.c:2659 [inline]
 jfs_lazycommit+0x47a/0xb70 fs/jfs/jfs_txnmgr.c:2727
 kthread+0x2b8/0x350 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
================================================================================
Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 0 PID: 106 Comm: jfsCommit Not tainted 6.4.0-rc5-syzkaller-00313-g4c605260bc60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 panic+0x30f/0x770 kernel/panic.c:340
 check_panic_on_warn+0x82/0xa0 kernel/panic.c:236
 ubsan_epilogue lib/ubsan.c:223 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3e2/0x420 lib/ubsan.c:387
 dbUpdatePMap+0xe4e/0xf50 fs/jfs/jfs_dmap.c:470
 txAllocPMap+0x57b/0x6b0 fs/jfs/jfs_txnmgr.c:2420
 txUpdateMap+0x7cc/0x9e0 fs/jfs/jfs_txnmgr.c:2358
 txLazyCommit fs/jfs/jfs_txnmgr.c:2659 [inline]
 jfs_lazycommit+0x47a/0xb70 fs/jfs/jfs_txnmgr.c:2727
 kthread+0x2b8/0x350 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
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
