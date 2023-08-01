Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C662776C083
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 00:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjHAWow (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 18:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjHAWou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 18:44:50 -0400
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6ED1BF1
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 15:44:48 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-3a73fbef692so3433638b6e.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 15:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690929888; x=1691534688;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zg/s68KC5k1+y1Gb2PPpd4zaf/NW4BA9JdQSwHJsSgA=;
        b=YV3cgvzFf+ayOiaEoa8K+LiAogb4CWn2FfiWWQErxxag0OymBbIif0rwORNQbIqXbn
         M3Vp/FB+Q0ClZ7iJj1ZztUf9mM2JaydxObwPXqi5C/1W1zabEehsECajfmK4nJBdotP1
         iVeWDVr7JoAZoIXrfQfutuEQmmyFF6lnm/HDy/9Vofy2kyrKkdzUMqSKsqw0KelZnvog
         62ZstQqm+Uoazf9tsvj1Qh92T6baEYQQBMpxAe8IalW1xMOiubAObCJCdykURgfp7vgA
         GT1GUyw6xMGz4xKxuv5q7Gm/h4tt2sHR+GdXhys7LmMvYzBuajRkUVm8PJ82RY+yR5MH
         qdjg==
X-Gm-Message-State: ABy/qLZksX35dUrPDvHnumdmDGoEHEMpLft/AmeLV0cBrEQ4TcLy/3wj
        Htf5cZh8YBPO5fi64xn7lSqQjne0z5n29YnW62YJ3UlhXa+R
X-Google-Smtp-Source: APBJJlEUIlq6tPzv4eXzjM9WQCm/pB9+67kgXkTx1NFrL6Y+PuzGs0rTd2hMNQVViJSZIhrUBDQODP6nEwJWd4/HwPFfdHWpDkBW
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2103:b0:3a5:a925:826b with SMTP id
 r3-20020a056808210300b003a5a925826bmr23637054oiw.2.1690929888287; Tue, 01 Aug
 2023 15:44:48 -0700 (PDT)
Date:   Tue, 01 Aug 2023 15:44:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054e4d10601e44b24@google.com>
Subject: [syzbot] [bfs?] KASAN: null-ptr-deref Read in drop_buffers (2)
From:   syzbot <syzbot+d285c6d0b23c6033d520@syzkaller.appspotmail.com>
To:     aivazian.tigran@gmail.com, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ec8939156379 Add linux-next specific files for 20230731
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=161e3355a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc839eae61644ed
dashboard link: https://syzkaller.appspot.com/bug?extid=d285c6d0b23c6033d520
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/084b7f2f7900/disk-ec893915.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/279a4144b6d9/vmlinux-ec893915.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a21cf5ede096/bzImage-ec893915.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d285c6d0b23c6033d520@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: null-ptr-deref in buffer_busy fs/buffer.c:2902 [inline]
BUG: KASAN: null-ptr-deref in drop_buffers.constprop.0+0x99/0x510 fs/buffer.c:2914
Read of size 4 at addr 0000000000000060 by task syz-executor.1/17034

CPU: 1 PID: 17034 Comm: syz-executor.1 Not tainted 6.5.0-rc4-next-20230731-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0xef/0x190 mm/kasan/generic.c:187
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 buffer_busy fs/buffer.c:2902 [inline]
 drop_buffers.constprop.0+0x99/0x510 fs/buffer.c:2914
 try_to_free_buffers+0x21b/0x2d0 fs/buffer.c:2944
 filemap_release_folio+0x20f/0x270 mm/filemap.c:4089
 shrink_folio_list+0x28bc/0x3dc0 mm/vmscan.c:2068
 evict_folios+0x6bc/0x18f0 mm/vmscan.c:5181
 try_to_shrink_lruvec+0x769/0xb00 mm/vmscan.c:5357
 lru_gen_shrink_lruvec mm/vmscan.c:5494 [inline]
 shrink_lruvec+0x314/0x2980 mm/vmscan.c:6269
 shrink_node_memcgs mm/vmscan.c:6489 [inline]
 shrink_node+0x807/0x3730 mm/vmscan.c:6524
 shrink_zones mm/vmscan.c:6763 [inline]
 do_try_to_free_pages+0x3cf/0x1990 mm/vmscan.c:6825
 try_to_free_mem_cgroup_pages+0x36f/0x850 mm/vmscan.c:7140
 try_charge_memcg+0x460/0x1400 mm/memcontrol.c:2692
 obj_cgroup_charge_pages mm/memcontrol.c:3106 [inline]
 __memcg_kmem_charge_page+0x179/0x3d0 mm/memcontrol.c:3132
 __alloc_pages+0x1fc/0x4a0 mm/page_alloc.c:4529
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2292
 vm_area_alloc_pages mm/vmalloc.c:3059 [inline]
 __vmalloc_area_node mm/vmalloc.c:3135 [inline]
 __vmalloc_node_range+0xa6e/0x1540 mm/vmalloc.c:3316
 kvmalloc_node+0x14b/0x1a0 mm/util.c:629
 kvmalloc include/linux/slab.h:737 [inline]
 xt_alloc_table_info+0x3e/0xa0 net/netfilter/x_tables.c:1192
 do_replace net/ipv6/netfilter/ip6_tables.c:1139 [inline]
 do_ip6t_set_ctl+0x53c/0xbd0 net/ipv6/netfilter/ip6_tables.c:1636
 nf_setsockopt+0x87/0xe0 net/netfilter/nf_sockopt.c:101
 ipv6_setsockopt+0x12b/0x190 net/ipv6/ipv6_sockglue.c:1017
 udpv6_setsockopt+0x7d/0xc0 net/ipv6/udp.c:1690
 __sys_setsockopt+0x2ca/0x5b0 net/socket.c:2265
 __do_sys_setsockopt net/socket.c:2276 [inline]
 __se_sys_setsockopt net/socket.c:2273 [inline]
 __x64_sys_setsockopt+0xbd/0x150 net/socket.c:2273
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0509e7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f050aba80c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007f0509f9bf80 RCX: 00007f0509e7cae9
RDX: 0000000000000040 RSI: 0000000000000029 RDI: 0000000000000003
RBP: 00007f0509ec847a R08: 00000000000003e0 R09: 0000000000000000
R10: 00000000200014c0 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f0509f9bf80 R15: 00007ffea4aa1d48
 </TASK>
==================================================================


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
