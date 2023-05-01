Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9296F31FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 16:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjEAOdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 10:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjEAOdC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 10:33:02 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A051A4
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 07:32:59 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3294f07346aso15086875ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 07:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682951579; x=1685543579;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/+2cE3z0lhFjJbQiqH+I4CrwDRwNUiZcC7hmNJYW8A=;
        b=E6ii+RILgx+cCqJYIEqESc3odSTwOEng/vc2beCtqPSmhMRCZ7mlPvCuWxXnqJq3/A
         XyCDb/GYKc0ayAfwDje00CxyK5tMRPDvRl8JC4R5IvE+7nHOqprTvUECBFHe+sgQorcA
         9NA5u0ARG0scBWCCzsG7SuihcUIdi6R5nXr0U/C+SFuKy9idbfIt395PCNk9Sxhr7MHJ
         xD4azffyDR2tcTYi1pA6THULwvYvneuQgGUHa0PdYUB7hEH7VLbUXU8h3lV2mEhDesWZ
         B1/tB6k+CTl3iV2L/K42BTjSN1vLvP4tT/xKfJ7VYEgEW1chtIBD4Nu1r6D7GgkXNCd8
         LzmQ==
X-Gm-Message-State: AC+VfDyBiSvJSACl79ywdQUvTMhsugBCEhHkYGGr39ztgZf6YpAW0U6z
        fqcpK34M5P50JMI16jvXlnqTrYxDsgip0kPj676qrI2v64jUguv1oA==
X-Google-Smtp-Source: ACHHUZ7DsuxZyoa81uiXdIozGw32ivqgikl7MTNF7YLxBS3TNpQmsmoQ2mMfQ+ius/6AArevc1fkfTOzPrHeH348q+hxz4yeZBE1
MIME-Version: 1.0
X-Received: by 2002:a92:c90e:0:b0:32b:1c9f:3c48 with SMTP id
 t14-20020a92c90e000000b0032b1c9f3c48mr7029883ilp.1.1682951579100; Mon, 01 May
 2023 07:32:59 -0700 (PDT)
Date:   Mon, 01 May 2023 07:32:59 -0700
In-Reply-To: <0000000000007fcc9c05f909f7f3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bf02a05faa2b3d2@google.com>
Subject: Re: [syzbot] [reiserfs?] KASAN: null-ptr-deref Read in fix_nodes
From:   syzbot <syzbot+5184326923f180b9d11a@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155bead8280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d56ffc213bf6bf4a
dashboard link: https://syzkaller.appspot.com/bug?extid=5184326923f180b9d11a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16936ffc280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/64e93dba0330/disk-58390c8c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2b7f3c1154f1/vmlinux-58390c8c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4ad00371a063/bzImage-58390c8c.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/5bd5f6fead6e/mount_1.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/58251a87486a/mount_10.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5184326923f180b9d11a@syzkaller.appspotmail.com

REISERFS warning: reiserfs-5093 is_leaf: item entry count seems wrong *3.5*[2 1 0(1) DIR], item_len 35, item_location 4029, free_space(entry_count) 2
REISERFS error (device loop2): vs-5150 search_by_key: invalid format found in block 539. Fsck?
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: null-ptr-deref in buffer_locked include/linux/buffer_head.h:126 [inline]
BUG: KASAN: null-ptr-deref in fix_nodes+0x464/0x8660 fs/reiserfs/fix_node.c:2578
Read of size 8 at addr 0000000000000000 by task syz-executor.2/5390

CPU: 1 PID: 5390 Comm: syz-executor.2 Not tainted 6.3.0-syzkaller-12049-g58390c8ce1bd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
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
RIP: 0033:0x7f4ee868c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4ee9456168 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f4ee87ac120 RCX: 00007f4ee868c169
RDX: 0000000000000000 RSI: 000000000014937e RDI: 0000000020000180
RBP: 00007f4ee86e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe3e91162f R14: 00007f4ee9456300 R15: 0000000000022000
 </TASK>
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
