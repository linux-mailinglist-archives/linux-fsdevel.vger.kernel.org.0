Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E958C7321A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 23:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbjFOV0G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 17:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237161AbjFOV0D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:26:03 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653882D53
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 14:25:51 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-77a1335cf04so1006516439f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 14:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686864350; x=1689456350;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyGuBkOkfn1vzxniYK1NxAxBPMXoWG64Z93gFfspPmk=;
        b=RB+DaIc6TdyHyO7LqqBJd+z9sqD99KbyaRnQpNURuqCUW+dloA6MzzGlmCQoHC6Cph
         VEstTnWQNTv0SMUIvqSZe7toc4XPK3ImcNO+1LFxBbt/0AOJjtrkBbcTthuto3Chsdhu
         dXbnrENdTkxyO6fqzmCkEcmSLJyUFMGxM/S71OpS1h1530fvK6Nd2ETbenHoM/OsPnBD
         u9faCRkvzZttPddmIN77HE8QECSB5Crb/5EyF2qmtHm1aS75GLTpDJ3SYptgUkXtdE4m
         ubizmeCRGE87uC1u6yVUPlnBTauoRpYGe0FcsNVFs5mQ/qjEvdF6Yvh4+eYVYOcW28z/
         tkMA==
X-Gm-Message-State: AC+VfDyF/puRvddgeavlV2lboW8RNZlbMbTaIwUQDaDS6ZlD1qU6NjSJ
        J9upempqjUhNQJJvkZ64O893m/OEV6mUclumZ7VXqTyCf65YhnTvJg==
X-Google-Smtp-Source: ACHHUZ7fZ83ceLB+hf8LDWpMq1TETENwzSI2ME2hj43xEPpeM+rHTNvlLCW/kRC0+nZmxVNzSy6KzTzG8ZfYGU/lCNHNDBAB7mra
MIME-Version: 1.0
X-Received: by 2002:a02:7a57:0:b0:423:1c61:b08f with SMTP id
 z23-20020a027a57000000b004231c61b08fmr120752jad.2.1686864350400; Thu, 15 Jun
 2023 14:25:50 -0700 (PDT)
Date:   Thu, 15 Jun 2023 14:25:50 -0700
In-Reply-To: <0000000000007fcc9c05f909f7f3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063df4305fe31b6c7@google.com>
Subject: Re: [syzbot] [reiserfs?] KASAN: null-ptr-deref Read in fix_nodes
From:   syzbot <syzbot+5184326923f180b9d11a@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    b6dad5178cea Merge tag 'nios2_fix_v6.4' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1495dce3280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac246111fb601aec
dashboard link: https://syzkaller.appspot.com/bug?extid=5184326923f180b9d11a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bbc887280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c9558b280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fb7aeb21864c/disk-b6dad517.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3004476364b7/vmlinux-b6dad517.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a143be294854/bzImage-b6dad517.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/92adf3c12845/mount_1.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/3861119d1700/mount_8.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5184326923f180b9d11a@syzkaller.appspotmail.com

REISERFS error (device loop2): vs-5150 search_by_key: invalid format found in block 540. Fsck?
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: null-ptr-deref in buffer_locked include/linux/buffer_head.h:126 [inline]
BUG: KASAN: null-ptr-deref in fix_nodes+0x464/0x8660 fs/reiserfs/fix_node.c:2578
Read of size 8 at addr 0000000000000000 by task syz-executor539/5535

CPU: 0 PID: 5535 Comm: syz-executor539 Not tainted 6.4.0-rc6-syzkaller-00037-gb6dad5178cea #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_report mm/kasan/report.c:465 [inline]
 kasan_report+0xec/0x130 mm/kasan/report.c:572
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0x141/0x190 mm/kasan/generic.c:187
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 buffer_locked include/linux/buffer_head.h:126 [inline]
 fix_nodes+0x464/0x8660 fs/reiserfs/fix_node.c:2578
 reiserfs_cut_from_item+0x2bd/0x1b20 fs/reiserfs/stree.c:1740
 reiserfs_do_truncate+0x630/0x1080 fs/reiserfs/stree.c:1971
 reiserfs_truncate_file+0x1b5/0x1070 fs/reiserfs/inode.c:2308
 reiserfs_setattr+0xddf/0x1370 fs/reiserfs/inode.c:3393
 notify_change+0xb2c/0x1180 fs/attr.c:483
 do_truncate+0x143/0x200 fs/open.c:66
 handle_truncate fs/namei.c:3295 [inline]
 do_open fs/namei.c:3640 [inline]
 path_openat+0x2083/0x2750 fs/namei.c:3791
 do_filp_open+0x1ba/0x410 fs/namei.c:3818
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_open fs/open.c:1380 [inline]
 __se_sys_open fs/open.c:1376 [inline]
 __x64_sys_open+0x11d/0x1c0 fs/open.c:1376
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7cb89c3be9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7cb094e2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f7cb8a497f0 RCX: 00007f7cb89c3be9
RDX: 0000000000000000 RSI: 000000000014937e RDI: 0000000020000180
RBP: 00007f7cb8a16410 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000010f7 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 7366726573696572 R14: 6bd71a7077694d3f R15: 00007f7cb8a497f8
 </TASK>
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
