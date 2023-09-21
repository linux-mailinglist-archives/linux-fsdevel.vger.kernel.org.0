Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414347AA57A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 01:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjIUXKv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 19:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIUXKt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:10:49 -0400
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF51102
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 16:10:41 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-3a6e180e49aso2394472b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 16:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695337840; x=1695942640;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/yHc8m8Ppc+ZSh/h1oHChVO3RcbS3h+g7+zq5fzEJY=;
        b=YGYcnFHNwpNyRSoSj2QGJOPfxVl91uAKGw1qkxcDpB/yqZCat+lXvrRJDedEyFP8Kk
         TwVdPskiYzoCgFr5GJ26ePD2Xp6mjLSuleLZEPnJ/R9hVNDGXAVG34xhqevJoSc5vP9g
         3xvCye4/lAjaidip++KJ2XyACDd8L56tZoF03com+UNxMkVyph2qz9LZcYEOvb3PN/IJ
         RygcfYu94h4ls3I9R4fUzL/6aYqZx9auAR0U8ctD6nUpPtgnyPo/bTld08RqE0n6oCT+
         55Ap8gohJ5hUrsBfEeLi8KflOURdO8hLnNBoJOd8IlFRJhCWROtnMGBYhOa1r3nra4wy
         6Grg==
X-Gm-Message-State: AOJu0Yxyb88SDpF33mkoOV9XGwF306624BCw6SiIhBow/vte2OXkMoU0
        SyvU5Q5V8ZdS40luW99L4Yvkixx/CaSkkS2cyBnYbg2SX2i02an8Ow==
X-Google-Smtp-Source: AGHT+IEBaQK/NideN3h8SjjwDaInNVzd/XsMojnCsli3nX+nJC2oaFzayNnuycsL6VCSSU6/CPMLn9weHAbHzYeCKAZR4qgJ8o3d
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1589:b0:3a7:392a:7405 with SMTP id
 t9-20020a056808158900b003a7392a7405mr3561216oiw.2.1695337840659; Thu, 21 Sep
 2023 16:10:40 -0700 (PDT)
Date:   Thu, 21 Sep 2023 16:10:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c456810605e6997c@google.com>
Subject: [syzbot] [fs?] BUG: sleeping function called from invalid context in bdev_getblk
From:   syzbot <syzbot+51c61e2b1259fcd64071@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dfa449a58323 Add linux-next specific files for 20230915
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14c33a54680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e204dda2e58397ec
dashboard link: https://syzkaller.appspot.com/bug?extid=51c61e2b1259fcd64071
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117f463c680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12406dac680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/34f9995871ed/disk-dfa449a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/95e2e1c3ab9e/vmlinux-dfa449a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cfc6db9684d4/bzImage-dfa449a5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7542796b830f/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12847a3c680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11847a3c680000
console output: https://syzkaller.appspot.com/x/log.txt?x=16847a3c680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+51c61e2b1259fcd64071@syzkaller.appspotmail.com

loop0: rw=0, sector=17668342, nr_sectors = 2 limit=128
Buffer I/O error on dev loop0, logical block 8834171, async page read
syz-executor392: attempt to access beyond end of device
loop0: rw=0, sector=26932834, nr_sectors = 2 limit=128
Buffer I/O error on dev loop0, logical block 13466417, async page read
syz-executor392: attempt to access beyond end of device
loop0: rw=0, sector=16147212, nr_sectors = 2 limit=128
Buffer I/O error on dev loop0, logical block 8073606, async page read
BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5047, name: syz-executor392
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor392/5047:
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:812 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3543 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x18a5/0x29c0 fs/namei.c:3774
 #1: ffffffff8cfc8b98 (pointers_lock){.+.+}-{2:2}, at: get_block+0x18f/0x15c0 fs/sysv/itree.c:221
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 5047 Comm: syz-executor392 Not tainted 6.6.0-rc1-next-20230915-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 __might_resched+0x3c3/0x5e0 kernel/sched/core.c:10106
 might_alloc include/linux/sched/mm.h:306 [inline]
 bdev_getblk+0x89/0xc0 fs/buffer.c:1430
 __bread_gfp+0xaf/0x370 fs/buffer.c:1479
 sb_bread include/linux/buffer_head.h:326 [inline]
 get_branch+0x2cb/0x660 fs/sysv/itree.c:104
 get_block+0x1ad/0x15c0 fs/sysv/itree.c:222
 block_read_full_folio+0x3df/0xae0 fs/buffer.c:2398
 filemap_read_folio+0xe9/0x2c0 mm/filemap.c:2368
 do_read_cache_folio+0x205/0x540 mm/filemap.c:3728
 do_read_cache_page mm/filemap.c:3794 [inline]
 read_cache_page+0x5b/0x160 mm/filemap.c:3803
 read_mapping_page include/linux/pagemap.h:854 [inline]
 dir_get_page fs/sysv/dir.c:64 [inline]
 sysv_find_entry+0x1db/0x480 fs/sysv/dir.c:157
 sysv_inode_by_name+0x74/0x1c0 fs/sysv/dir.c:374
 sysv_lookup fs/sysv/namei.c:38 [inline]
 sysv_lookup+0x88/0x100 fs/sysv/namei.c:31
 lookup_open.isra.0+0x926/0x13b0 fs/namei.c:3454
 open_last_lookups fs/namei.c:3544 [inline]
 path_openat+0x931/0x29c0 fs/namei.c:3774
 do_filp_open+0x1de/0x430 fs/namei.c:3804
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_open fs/open.c:1445 [inline]
 __se_sys_open fs/open.c:1441 [inline]
 __x64_sys_open+0x154/0x1e0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5f628dda19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe787af38 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5f628dda19
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 00007f5f6295a5f0 R08: 0000000000009e13 R09: 00005555563914c0
R10: 00007fffe787ae00 R11: 0000000000000246 R12: 00007fffe787af60
R13: 00007fffe787b188 R14: 431bde82d7b634db R15: 00007f5f6292603b
 </TASK>
syz-executor392: attempt to access beyond end of device
loop0: rw=0, sector=6491548, nr_sectors = 2 limit=128
Buffer I/O error on dev loop0, logical block 3245774, async page read
syz-executor392: attempt to access beyond end of device
loop0: rw=0, sector=17669878, nr_sectors = 2 limit=128
Buffer I/O error on dev loop0, logical block 8834939, async page read
BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5047, name: syz-executor392
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor392/5047:
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:812 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3543 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x18a5/0x29c0 fs/namei.c:3774
 #1: ffffffff8cfc8b98 (pointers_lock){.+.+}-{2:2}, at: get_block+0x18f/0x15c0 fs/sysv/itree.c:221
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 5047 Comm: syz-executor392 Tainted: G        W          6.6.0-rc1-next-20230915-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 __might_resched+0x3c3/0x5e0 kernel/sched/core.c:10106
 might_alloc include/linux/sched/mm.h:306 [inline]
 bdev_getblk+0x89/0xc0 fs/buffer.c:1430
 __bread_gfp+0xaf/0x370 fs/buffer.c:1479
 sb_bread include/linux/buffer_head.h:326 [inline]
 get_branch+0x2cb/0x660 fs/sysv/itree.c:104
 get_block+0x1ad/0x15c0 fs/sysv/itree.c:222
 block_read_full_folio+0x3df/0xae0 fs/buffer.c:2398
 filemap_read_folio+0xe9/0x2c0 mm/filemap.c:2368
 do_read_cache_folio+0x205/0x540 mm/filemap.c:3728
 do_read_cache_page mm/filemap.c:3794 [inline]
 read_cache_page+0x5b/0x160 mm/filemap.c:3803
 read_mapping_page include/linux/pagemap.h:854 [inline]
 dir_get_page fs/sysv/dir.c:64 [inline]
 sysv_find_entry+0x1db/0x480 fs/sysv/dir.c:157
 sysv_inode_by_name+0x74/0x1c0 fs/sysv/dir.c:374
 sysv_lookup fs/sysv/namei.c:38 [inline]
 sysv_lookup+0x88/0x100 fs/sysv/namei.c:31
 lookup_open.isra.0+0x926/0x13b0 fs/namei.c:3454
 open_last_lookups fs/namei.c:3544 [inline]
 path_openat+0x931/0x29c0 fs/namei.c:3774
 do_filp_open+0x1de/0x430 fs/namei.c:3804
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_open fs/open.c:1445 [inline]
 __se_sys_open fs/open.c:1441 [inline]
 __x64_sys_open+0x154/0x1e0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5f628dda19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe787af38 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5f628dda19
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 00007f5f6295a5f0 R08: 0000000000009e13 R09: 00005555563914c0
R10: 00007fffe787ae00 R11: 0000000000000246 R12: 00007fffe787af60
R13: 00007fffe787b188 R14: 431bde82d7b634db R15: 00007f5f6292603b
 </TASK>
BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5047, name: syz-executor392
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor392/5047:
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:812 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3543 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x18a5/0x29c0 fs/namei.c:3774
 #1: ffffffff8cfc8b98 (pointers_lock){.+.+}-{2:2}, at: get_block+0x18f/0x15c0 fs/sysv/itree.c:221
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 5047 Comm: syz-executor392 Tainted: G        W          6.6.0-rc1-next-20230915-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 __might_resched+0x3c3/0x5e0 kernel/sched/core.c:10106
 might_alloc include/linux/sched/mm.h:306 [inline]
 bdev_getblk+0x89/0xc0 fs/buffer.c:1430
 __bread_gfp+0xaf/0x370 fs/buffer.c:1479
 sb_bread include/linux/buffer_head.h:326 [inline]
 get_branch+0x2cb/0x660 fs/sysv/itree.c:104
 get_block+0x1ad/0x15c0 fs/sysv/itree.c:222
 block_read_full_folio+0x3df/0xae0 fs/buffer.c:2398
 filemap_read_folio+0xe9/0x2c0 mm/filemap.c:2368
 do_read_cache_folio+0x205/0x540 mm/filemap.c:3728
 do_read_cache_page mm/filemap.c:3794 [inline]
 read_cache_page+0x5b/0x160 mm/filemap.c:3803
 read_mapping_page include/linux/pagemap.h:854 [inline]
 dir_get_page fs/sysv/dir.c:64 [inline]
 sysv_find_entry+0x1db/0x480 fs/sysv/dir.c:157
 sysv_inode_by_name+0x74/0x1c0 fs/sysv/dir.c:374
 sysv_lookup fs/sysv/namei.c:38 [inline]
 sysv_lookup+0x88/0x100 fs/sysv/namei.c:31
 lookup_open.isra.0+0x926/0x13b0 fs/namei.c:3454
 open_last_lookups fs/namei.c:3544 [inline]
 path_openat+0x931/0x29c0 fs/namei.c:3774
 do_filp_open+0x1de/0x430 fs/namei.c:3804
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_open fs/open.c:1445 [inline]
 __se_sys_open fs/open.c:1441 [inline]
 __x64_sys_open+0x154/0x1e0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5f628dda19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe787af38 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5f628dda19
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 00007f5f6295a5f0 R08: 0000000000009e13 R09: 00005555563914c0
R10: 00007fffe787ae00 R11: 0000000000000246 R12: 00007fffe787af60
R13: 00007fffe787b188 R14: 431bde82d7b634db R15: 00007f5f6292603b
 </TASK>
BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5047, name: syz-executor392
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor392/5047:
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:812 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3543 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x18a5/0x29c0 fs/namei.c:3774
 #1: ffffffff8cfc8b98 (pointers_lock){.+.+}-{2:2}, at: get_block+0x18f/0x15c0 fs/sysv/itree.c:221
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 5047 Comm: syz-executor392 Tainted: G        W          6.6.0-rc1-next-20230915-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 __might_resched+0x3c3/0x5e0 kernel/sched/core.c:10106
 might_alloc include/linux/sched/mm.h:306 [inline]
 bdev_getblk+0x89/0xc0 fs/buffer.c:1430
 __bread_gfp+0xaf/0x370 fs/buffer.c:1479
 sb_bread include/linux/buffer_head.h:326 [inline]
 get_branch+0x2cb/0x660 fs/sysv/itree.c:104
 get_block+0x1ad/0x15c0 fs/sysv/itree.c:222
 block_read_full_folio+0x3df/0xae0 fs/buffer.c:2398
 filemap_read_folio+0xe9/0x2c0 mm/filemap.c:2368
 do_read_cache_folio+0x205/0x540 mm/filemap.c:3728
 do_read_cache_page mm/filemap.c:3794 [inline]
 read_cache_page+0x5b/0x160 mm/filemap.c:3803
 read_mapping_page include/linux/pagemap.h:854 [inline]
 dir_get_page fs/sysv/dir.c:64 [inline]
 sysv_find_entry+0x1db/0x480 fs/sysv/dir.c:157
 sysv_inode_by_name+0x74/0x1c0 fs/sysv/dir.c:374
 sysv_lookup fs/sysv/namei.c:38 [inline]
 sysv_lookup+0x88/0x100 fs/sysv/namei.c:31
 lookup_open.isra.0+0x926/0x13b0 fs/namei.c:3454
 open_last_lookups fs/namei.c:3544 [inline]
 path_openat+0x931/0x29c0 fs/namei.c:3774
 do_filp_open+0x1de/0x430 fs/namei.c:3804
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_open fs/open.c:1445 [inline]
 __se_sys_open fs/open.c:1441 [inline]
 __x64_sys_open+0x154/0x1e0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5f628dda19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe787af38 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5f628dda19
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 00007f5f6295a5f0 R08: 0000000000009e13 R09: 00005555563914c0
R10: 00007fffe787ae00 R11: 0000000000000246 R12: 00007fffe787af60
R13: 00007fffe787b188 R14: 431bde82d7b634db R15: 00007f5f6292603b
 </TASK>
BUG: sleeping function called from invalid context at include/linux/pagemap.h:1012
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5047, name: syz-executor392
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor392/5047:
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:812 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3543 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x18a5/0x29c0 fs/namei.c:3774
 #1: ffffffff8cfc8b98 (pointers_lock){.+.+}-{2:2}, at: get_block+0x18f/0x15c0 fs/sysv/itree.c:221
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 5047 Comm: syz-executor392 Tainted: G        W          6.6.0-rc1-next-20230915-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 __might_resched+0x3c3/0x5e0 kernel/sched/core.c:10106
 folio_lock include/linux/pagemap.h:1012 [inline]
 __filemap_get_folio+0x5e0/0xa90 mm/filemap.c:1880
 grow_dev_page fs/buffer.c:1047 [inline]
 grow_buffers fs/buffer.c:1111 [inline]
 __getblk_slow+0x1be/0x720 fs/buffer.c:1138
 bdev_getblk+0xad/0xc0 fs/buffer.c:1434
 __bread_gfp+0xaf/0x370 fs/buffer.c:1479
 sb_bread include/linux/buffer_head.h:326 [inline]
 get_branch+0x2cb/0x660 fs/sysv/itree.c:104
 get_block+0x1ad/0x15c0 fs/sysv/itree.c:222
 block_read_full_folio+0x3df/0xae0 fs/buffer.c:2398
 filemap_read_folio+0xe9/0x2c0 mm/filemap.c:2368
 do_read_cache_folio+0x205/0x540 mm/filemap.c:3728
 do_read_cache_page mm/filemap.c:3794 [inline]
 read_cache_page+0x5b/0x160 mm/filemap.c:3803
 read_mapping_page include/linux/pagemap.h:854 [inline]
 dir_get_page fs/sysv/dir.c:64 [inline]
 sysv_find_entry+0x1db/0x480 fs/sysv/dir.c:157
 sysv_inode_by_name+0x74/0x1c0 fs/sysv/dir.c:374
 sysv_lookup fs/sysv/namei.c:38 [inline]
 sysv_lookup+0x88/0x100 fs/sysv/namei.c:31
 lookup_open.isra.0+0x926/0x13b0 fs/namei.c:3454
 open_last_lookups fs/namei.c:3544 [inline]
 path_openat+0x931/0x29c0 fs/namei.c:3774
 do_filp_open+0x1de/0x430 fs/namei.c:3804
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_open fs/open.c:1445 [inline]
 __se_sys_open fs/open.c:1441 [inline]
 __x64_sys_open+0x154/0x1e0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5f628dda19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe787af38 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5f628dda19
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 00007f5f6295a5f0 R08: 0000000000009e13 R09: 00005555563914c0
R10: 00007fffe787ae00 R11: 0000000000000246 R12: 00007fffe787af60
R13: 00007fffe787b188 R14: 431bde82d7b634db R15: 00007f5f6292603b
 </TASK>
BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5047, name: syz-executor392
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor392/5047:
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:812 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3543 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x18a5/0x29c0 fs/namei.c:3774
 #1: ffffffff8cfc8b98 (pointers_lock){.+.+}-{2:2}, at: get_block+0x18f/0x15c0 fs/sysv/itree.c:221
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 5047 Comm: syz-executor392 Tainted: G        W          6.6.0-rc1-next-20230915-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 __might_resched+0x3c3/0x5e0 kernel/sched/core.c:10106
 might_alloc include/linux/sched/mm.h:306 [inline]
 bdev_getblk+0x89/0xc0 fs/buffer.c:1430
 __bread_gfp+0xaf/0x370 fs/buffer.c:1479
 sb_bread include/linux/buffer_head.h:326 [inline]
 get_branch+0x2cb/0x660 fs/sysv/itree.c:104
 get_block+0x1ad/0x15c0 fs/sysv/itree.c:222
 block_read_full_folio+0x3df/0xae0 fs/buffer.c:2398
 filemap_read_folio+0xe9/0x2c0 mm/filemap.c:2368
 do_read_cache_folio+0x205/0x540 mm/filemap.c:3728
 do_read_cache_page mm/filemap.c:3794 [inline]
 read_cache_page+0x5b/0x160 mm/filemap.c:3803
 read_mapping_page include/linux/pagemap.h:854 [inline]
 dir_get_page fs/sysv/dir.c:64 [inline]
 sysv_find_entry+0x1db/0x480 fs/sysv/dir.c:157
 sysv_inode_by_name+0x74/0x1c0 fs/sysv/dir.c:374
 sysv_lookup fs/sysv/namei.c:38 [inline]
 sysv_lookup+0x88/0x100 fs/sysv/namei.c:31
 lookup_open.isra.0+0x926/0x13b0 fs/namei.c:3454
 open_last_lookups fs/namei.c:3544 [inline]
 path_openat+0x931/0x29c0 fs/namei.c:3774
 do_filp_open+0x1de/0x430 fs/namei.c:3804
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_open fs/open.c:1445 [inline]
 __se_sys_open fs/open.c:1441 [inline]
 __x64_sys_open+0x154/0x1e0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5f628dda19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe787af38 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5f628dda19
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 00007f5f6295a5f0 R08: 0000000000009e13 R09: 00005555563914c0
R10: 00007fffe787ae00 R11: 0000000000000246 R12: 00007fffe787af60
R13: 00007fffe787b188 R14: 431bde82d7b634db R15: 00007f5f6292603b
 </TASK>
BUG: sleeping function called from invalid context at include/linux/pagemap.h:1012
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5047, name: syz-executor392
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor392/5047:
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:812 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3543 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x18a5/0x29c0 fs/namei.c:3774
 #1: ffffffff8cfc8b98 (pointers_lock){.+.+}-{2:2}, at: get_block+0x18f/0x15c0 fs/sysv/itree.c:221
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 5047 Comm: syz-executor392 Tainted: G        W          6.6.0-rc1-next-20230915-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 __might_resched+0x3c3/0x5e0 kernel/sched/core.c:10106
 folio_lock include/linux/pagemap.h:1012 [inline]
 __filemap_get_folio+0x5e0/0xa90 mm/filemap.c:1880
 grow_dev_page fs/buffer.c:1047 [inline]
 grow_buffers fs/buffer.c:1111 [inline]
 __getblk_slow+0x1be/0x720 fs/buffer.c:1138
 bdev_getblk+0xad/0xc0 fs/buffer.c:1434
 __bread_gfp+0xaf/0x370 fs/buffer.c:1479
 sb_bread include/linux/buffer_head.h:326 [inline]
 get_branch+0x2cb/0x660 fs/sysv/itree.c:104
 get_block+0x1ad/0x15c0 fs/sysv/itree.c:222
 block_read_full_folio+0x3df/0xae0 fs/buffer.c:2398
 filemap_read_folio+0xe9/0x2c0 mm/filemap.c:2368
 do_read_cache_folio+0x205/0x540 mm/filemap.c:3728
 do_read_cache_page mm/filemap.c:3794 [inline]
 read_cache_page+0x5b/0x160 mm/filemap.c:3803
 read_mapping_page include/linux/pagemap.h:854 [inline]
 dir_get_page fs/sysv/dir.c:64 [inline]
 sysv_find_entry+0x1db/0x480 fs/sysv/dir.c:157
 sysv_inode_by_name+0x74/0x1c0 fs/sysv/dir.c:374
 sysv_lookup fs/sysv/namei.c:38 [inline]
 sysv_lookup+0x88/0x100 fs/sysv/namei.c:31
 lookup_open.isra.0+0x926/0x13b0 fs/namei.c:3454
 open_last_lookups fs/namei.c:3544 [inline]
 path_openat+0x931/0x29c0 fs/namei.c:3774
 do_filp_open+0x1de/0x430 fs/namei.c:3804
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_open fs/open.c:1445 [inline]
 __se_sys_open fs/open.c:1441 [inline]
 __x64_sys_open+0x154/0x1e0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5f628dda19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe787af38 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5f628dda19
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 00007f5f6295a5f0 R08: 0000000000009e13 R09: 00005555563914c0
R10: 00007fffe787ae00 R11: 0000000000000246 R12: 00007fffe787af60
R13: 00007fffe787b188 R14: 431bde82d7b634db R15: 00007f5f6292603b
 </TASK>
BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5047, name: syz-executor392
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor392/5047:
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:812 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3543 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x18a5/0x29c0 fs/namei.c:3774
 #1: ffffffff8cfc8b98 (pointers_lock){.+.+}-{2:2}, at: get_block+0x18f/0x15c0 fs/sysv/itree.c:221
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 5047 Comm: syz-executor392 Tainted: G        W          6.6.0-rc1-next-20230915-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 __might_resched+0x3c3/0x5e0 kernel/sched/core.c:10106
 might_alloc include/linux/sched/mm.h:306 [inline]
 bdev_getblk+0x89/0xc0 fs/buffer.c:1430
 __bread_gfp+0xaf/0x370 fs/buffer.c:1479
 sb_bread include/linux/buffer_head.h:326 [inline]
 get_branch+0x2cb/0x660 fs/sysv/itree.c:104
 get_block+0x1ad/0x15c0 fs/sysv/itree.c:222
 block_read_full_folio+0x3df/0xae0 fs/buffer.c:2398
 filemap_read_folio+0xe9/0x2c0 mm/filemap.c:2368
 do_read_cache_folio+0x205/0x540 mm/filemap.c:3728
 do_read_cache_page mm/filemap.c:3794 [inline]
 read_cache_page+0x5b/0x160 mm/filemap.c:3803
 read_mapping_page include/linux/pagemap.h:854 [inline]
 dir_get_page fs/sysv/dir.c:64 [inline]
 sysv_find_entry+0x1db/0x480 fs/sysv/dir.c:157
 sysv_inode_by_name+0x74/0x1c0 fs/sysv/dir.c:374
 sysv_lookup fs/sysv/namei.c:38 [inline]
 sysv_lookup+0x88/0x100 fs/sysv/namei.c:31
 lookup_open.isra.0+0x926/0x13b0 fs/namei.c:3454
 open_last_lookups fs/namei.c:3544 [inline]
 path_openat+0x931/0x29c0 fs/namei.c:3774
 do_filp_open+0x1de/0x430 fs/namei.c:3804
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_open fs/open.c:1445 [inline]
 __se_sys_open fs/open.c:1441 [inline]
 __x64_sys_open+0x154/0x1e0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5f628dda19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe787af38 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5f628dda19
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 00007f5f6295a5f0 R08: 0000000000009e13 R09: 00005555563914c0
R10: 00007fffe787ae00 R11: 0000000000000246 R12: 00007fffe787af60
R13: 00007fffe787b188 R14: 431bde82d7b634db R15: 00007f5f6292603b
 </TASK>
BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5047, name: syz-executor392
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor392/5047:
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:812 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3543 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x18a5/0x29c0 fs/namei.c:3774
 #1: ffffffff8cfc8b98 (pointers_lock){.+.+}-{2:2}, at: get_block+0x18f/0x15c0 fs/sysv/itree.c:221
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 5047 Comm: syz-executor392 Tainted: G        W          6.6.0-rc1-next-20230915-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 __might_resched+0x3c3/0x5e0 kernel/sched/core.c:10106
 might_alloc include/linux/sched/mm.h:306 [inline]
 bdev_getblk+0x89/0xc0 fs/buffer.c:1430
 __bread_gfp+0xaf/0x370 fs/buffer.c:1479
 sb_bread include/linux/buffer_head.h:326 [inline]
 get_branch+0x2cb/0x660 fs/sysv/itree.c:104
 get_block+0x1ad/0x15c0 fs/sysv/itree.c:222
 block_read_full_folio+0x3df/0xae0 fs/buffer.c:2398
 filemap_read_folio+0xe9/0x2c0 mm/filemap.c:2368
 do_read_cache_folio+0x205/0x540 mm/filemap.c:3728
 do_read_cache_page mm/filemap.c:3794 [inline]
 read_cache_page+0x5b/0x160 mm/filemap.c:3803
 read_mapping_page include/linux/pagemap.h:854 [inline]
 dir_get_page fs/sysv/dir.c:64 [inline]
 sysv_find_entry+0x1db/0x480 fs/sysv/dir.c:157
 sysv_inode_by_name+0x74/0x1c0 fs/sysv/dir.c:374
 sysv_lookup fs/sysv/namei.c:38 [inline]
 sysv_lookup+0x88/0x100 fs/sysv/namei.c:31
 lookup_open.isra.0+0x926/0x13b0 fs/namei.c:3454
 open_last_lookups fs/namei.c:3544 [inline]
 path_openat+0x931/0x29c0 fs/namei.c:3774
 do_filp_open+0x1de/0x430 fs/namei.c:3804
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_open fs/open.c:1445 [inline]
 __se_sys_open fs/open.c:1441 [inline]
 __x64_sys_open+0x154/0x1e0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5f628dda19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe787af38 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5f628dda19
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 00007f5f6295a5f0 R08: 0000000000009e13 R09: 00005555563914c0
R10: 00007fffe787ae00 R11: 0000000000000246 R12: 00007fffe787af60
R13: 00007fffe787b188 R14: 431bde82d7b634db R15: 00007f5f6292603b
 </TASK>
BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5047, name: syz-executor392
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor392/5047:
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:812 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: open_last_lookups fs/namei.c:3543 [inline]
 #0: ffff888076ce8188 (&type->i_mutex_dir_key#6){.+.+}-{3:3}, at: path_openat+0x18a5/0x29c0 fs/namei.c:3774
 #1: ffffffff8cfc8b98 (pointers_lock){.+.+}-{2:2}, at: get_block+0x18f/0x15c0 fs/sysv/itree.c:221
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 5047 Comm: syz-executor392 Tainted: G        W          6.6.0-rc1-next-20230915-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 __might_resched+0x3c3/0x5e0 kernel/sched/core.c:10106
 might_alloc include/linux/sched/mm.h:306 [inline]
 bdev_getblk+0x89/0xc0 fs/buffer.c:1430
 __bread_gfp+0xaf/0x370 fs/buffer.c:1479
 sb_bread include/linux/buffer_head.h:326 [inline]
 get_branch+0x2cb/0x660 fs/sysv/itree.c:104
 get_block+0x1ad/0x15c0 fs/sysv/itree.c:222
 block_read_full_folio+0x3df/0xae0 fs/buffer.c:2398
 filemap_read_folio+0xe9/0x2c0 mm/filemap.c:2368
 do_read_cache_folio+0x205/0x540 mm/filemap.c:3728
 do_read_cache_page mm/filemap.c:3794 [inline]
 read_cache_page+0x5b/0x160 mm/filemap.c:3803
 read_mapping_page include/linux/pagemap.h:854 [inline]
 dir_get_page fs/sysv/dir.c:64 [inline]
 sysv_find_entry+0x1db/0x480 fs/sysv/dir.c:157
 sysv_inode_by_name+0x74/0x1c0 fs/sysv/dir.c:374
 sysv_lookup fs/sysv/namei.c:38 [inline]
 sysv_lookup+0x88/0x100 fs/sysv/namei.c:31
 lookup_open.isra.0+0x926/0x13b0 fs/namei.c:3454
 open_last_lookups fs/namei.c:3544 [inline]
 path_openat+0x931/0x29c0 fs/namei.c:3774
 do_filp_open+0x1de/0x430 fs/namei.c:3804
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_open fs/open.c:1445 [inline]
 __se_sys_open fs/open.c:1441 [inline]
 __x64_sys_open+0x154/0x1e0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5f628dda19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe787af38 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5f628dda19
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 00007f5f6295a5f0 R08: 0000000000009e13 R09: 00005555563914c0
R10: 00007fffe787ae00 R11: 0000000000000246 R12: 00007fffe787af60
R13: 00007fffe787b188 R14: 431bde82d7b634db R15: 00007f5f6292603b
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
