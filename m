Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8F96DD380
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 08:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjDKGzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 02:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjDKGzI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:55:08 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1DE3AAE
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 23:54:46 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id bc13-20020a056602360d00b0074ca36737d2so4772288iob.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 23:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681196086; x=1683788086;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/YbcYTo9M/S3HWsy6UrBsSf4W5Kjaa4ObHWBDg+yw7g=;
        b=JuvmrBBXwh+ps03mZmf4q8qSv5+uQv8obXfMH7xiftj97p1c3LaOaLR74ueH+nB6XS
         uvCTf/P/4Mig74baz7SYJc+vgCz6oM5OoC2sLljDez30NPWTjI5T/mNS4f+h6cPizLYR
         lfJcltvWevLXoanOqQJ4aEM4JBPvSgMzMnfa8fh8jLo5AF2304lkrVY63Luzp6LSAm8F
         Yz971+WnY+EiNU20ZI3QegxvuLPxrLANapunnAECqcYiURfEhSaA4KX5Spt5Vb5Wl2oE
         KRjVz05hCGus67Zy+iNtsKzTTUGeNK9kfmL4YmGAJ935kliYznhzzhLLpb7r71XKInoj
         5wZw==
X-Gm-Message-State: AAQBX9euZgXSHN+5XD4qGjcZYkiEISpR3JQCWVFX/D7l9Ivi5m/bdNqC
        zmqj0Cql4W87QPOWeCJYLzMcrVwvgWiTWNRGsv/Uelsn0mNJ6yit4g==
X-Google-Smtp-Source: AKy350bLOGd7B+uS2uwvFKsGfbteuGvSQH4pGMpxG0I+dJ6K+aTPKT6iD6M4mffWjpjXok5IpulIrqholdZh8kTvOfK2SCRy7cXI
MIME-Version: 1.0
X-Received: by 2002:a02:8621:0:b0:40b:d839:4633 with SMTP id
 e30-20020a028621000000b0040bd8394633mr553255jai.3.1681196085920; Mon, 10 Apr
 2023 23:54:45 -0700 (PDT)
Date:   Mon, 10 Apr 2023 23:54:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fcc9c05f909f7f3@google.com>
Subject: [syzbot] [reiserfs?] KASAN: null-ptr-deref Read in fix_nodes
From:   syzbot <syzbot+5184326923f180b9d11a@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    148341f0a2f5 Merge tag 'vfs.misc.fixes.v6.3-rc6' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131e7b5dc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3500b143c204867
dashboard link: https://syzkaller.appspot.com/bug?extid=5184326923f180b9d11a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bd1a34836b5e/disk-148341f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/04a1edfc1dd9/vmlinux-148341f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ec7cb22838b5/bzImage-148341f0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5184326923f180b9d11a@syzkaller.appspotmail.com

REISERFS (device loop2): Remounting filesystem read-only
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:72 [inline]
BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: null-ptr-deref in buffer_locked include/linux/buffer_head.h:126 [inline]
BUG: KASAN: null-ptr-deref in fix_nodes+0x464/0x8660 fs/reiserfs/fix_node.c:2578
Read of size 8 at addr 0000000000000000 by task syz-executor.2/4037

CPU: 1 PID: 4037 Comm: syz-executor.2 Not tainted 6.3.0-rc5-syzkaller-00005-g148341f0a2f5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_report mm/kasan/report.c:433 [inline]
 kasan_report+0xec/0x130 mm/kasan/report.c:536
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0x141/0x190 mm/kasan/generic.c:187
 instrument_atomic_read include/linux/instrumented.h:72 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 buffer_locked include/linux/buffer_head.h:126 [inline]
 fix_nodes+0x464/0x8660 fs/reiserfs/fix_node.c:2578
 reiserfs_cut_from_item+0x2bd/0x1b20 fs/reiserfs/stree.c:1742
 reiserfs_do_truncate+0x630/0x1080 fs/reiserfs/stree.c:1973
 reiserfs_truncate_file+0x1b5/0x1070 fs/reiserfs/inode.c:2310
 reiserfs_setattr+0xddf/0x1370 fs/reiserfs/inode.c:3395
 notify_change+0xb2c/0x1180 fs/attr.c:482
 do_truncate+0x143/0x200 fs/open.c:66
 handle_truncate fs/namei.c:3219 [inline]
 do_open fs/namei.c:3564 [inline]
 path_openat+0x2083/0x2750 fs/namei.c:3715
 do_filp_open+0x1ba/0x410 fs/namei.c:3742
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1348
 do_sys_open fs/open.c:1364 [inline]
 __do_sys_creat fs/open.c:1440 [inline]
 __se_sys_creat fs/open.c:1434 [inline]
 __x64_sys_creat+0xcd/0x120 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd96be8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd96cb5a168 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fd96bfac1f0 RCX: 00007fd96be8c169
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000040
RBP: 00007fd96bee7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcd572849f R14: 00007fd96cb5a300 R15: 0000000000022000
 </TASK>
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
