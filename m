Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08756EC6DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 09:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjDXHSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 03:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDXHSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:18:39 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41066E56
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 00:18:38 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-763997ab8cdso503573439f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 00:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682320717; x=1684912717;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFjHqVN3r9rl/Ity1RCKxPqQxir+BteuTQ6+Y+6jxlM=;
        b=Ny50pdXyxxcgSudm6Qijzlk6jVSpgtaOYJPepkE/9/kx2ehWsZy9Upcqbeqp8sRu8b
         uoSof67QVbHgdLO7HEFZfYJkR4k/0bp3/u1k9RF1WvfPJ7my9RuT+VfUZ8PtoWGRg5CW
         UT7MEVopQanRHr08sva1d31qfysh3pYHqL1lURLwxBM/Pw12Wxd26uOJAKt0ROAMsfYy
         fgZWSwdbInQgrGWpeWb631jodJvszlk3Yo3E1eC22WR8YWEDakYFOJzu6zo7NJtalrIn
         gTmZXyon2vfjMbqL4iWKo8jkJ2IH9ij1ZQzJ8yD3mtOdWXIg7U3fm9hXqWnKhk6aTIGq
         P39g==
X-Gm-Message-State: AAQBX9fAI3WUJbrf6k6lRhfqnqhglviWe3ddLa03fBtlTGolLXQ3OK2D
        cW6i7Zdt7ES3r2El/SpC7lgqOB0WICsTQXqwMYzmsfAw21zP
X-Google-Smtp-Source: AKy350bAo9JTXvd2enneani5sy24Vu3xEuBPm4YkaZ+jncpTkWnE8xP3quj3/LCXVSrS1c7GDPuy6KcTQ3qk7ee0vFo/s+Ec0Kzn
MIME-Version: 1.0
X-Received: by 2002:a02:a112:0:b0:40f:99ae:dba8 with SMTP id
 f18-20020a02a112000000b0040f99aedba8mr4370090jag.1.1682320717603; Mon, 24 Apr
 2023 00:18:37 -0700 (PDT)
Date:   Mon, 24 Apr 2023 00:18:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5681205fa0fd089@google.com>
Subject: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer dereference
 in filemap_read_folio (2)
From:   syzbot <syzbot+41ee2d2dcc4fc2f2f60c@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    8e41e0a57566 Revert "ACPICA: Events: Support fixed PCIe wa..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ba50f0280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4afb87f3ec27b7fd
dashboard link: https://syzkaller.appspot.com/bug?extid=41ee2d2dcc4fc2f2f60c
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/69cc9a5732ed/disk-8e41e0a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f32a5c8e9e68/vmlinux-8e41e0a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b56460ca80d/bzImage-8e41e0a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+41ee2d2dcc4fc2f2f60c@syzkaller.appspotmail.com

ntfs: (device loop1): ntfs_mapping_pairs_decompress(): Corrupt attribute.
ntfs: (device loop1): ntfs_read_block(): Failed to read from inode 0xa, attribute type 0x80, vcn 0x1, offset 0x0 because its location on disk could not be determined even after retrying (error code -5).
ntfs: (device loop1): ntfs_mapping_pairs_decompress(): Corrupt attribute.
ntfs: volume version 3.1.
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 29114067 P4D 29114067 PUD 2776f067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 19582 Comm: syz-executor.1 Not tainted 6.3.0-rc7-syzkaller-00181-g8e41e0a57566 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc900125ff618 EFLAGS: 00010283
RAX: ffffffff81ba3fa1 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc90014e2c000 RSI: ffffea0001781100 RDI: 0000000000000000
RBP: ffffc900125ff6f0 R08: dffffc0000000000 R09: fffff940002f0221
R10: 0000000000000000 R11: dffffc0000000001 R12: ffffea0001781100
R13: 1ffffd40002f0221 R14: 0000000000000000 R15: ffffea0001781108
FS:  00007f75f3998700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000393e4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 filemap_read_folio+0x19d/0x7a0 mm/filemap.c:2424
 do_read_cache_folio+0x2ee/0x820 mm/filemap.c:3683
 do_read_cache_page+0x32/0x230 mm/filemap.c:3749
 read_mapping_page include/linux/pagemap.h:769 [inline]
 ntfs_map_page fs/ntfs/aops.h:75 [inline]
 ntfs_check_logfile+0x3e1/0x28b0 fs/ntfs/logfile.c:532
 load_and_check_logfile+0x6f/0xd0 fs/ntfs/super.c:1223
 load_system_files+0x32fb/0x4840 fs/ntfs/super.c:1949
 ntfs_fill_super+0x19b4/0x2bd0 fs/ntfs/super.c:2900
 mount_bdev+0x271/0x3a0 fs/super.c:1380
 legacy_get_tree+0xef/0x190 fs/fs_context.c:610
 vfs_get_tree+0x8c/0x270 fs/super.c:1510
 do_new_mount+0x28f/0xae0 fs/namespace.c:3042
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f75f2c8d69a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f75f3997f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000000000001ec6a RCX: 00007f75f2c8d69a
RDX: 0000000020000100 RSI: 000000002001ecc0 RDI: 00007f75f3997fe0
RBP: 00007f75f3998020 R08: 00007f75f3998020 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000100
R13: 000000002001ecc0 R14: 00007f75f3997fe0 R15: 0000000020000140
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc900125ff618 EFLAGS: 00010283
RAX: ffffffff81ba3fa1 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc90014e2c000 RSI: ffffea0001781100 RDI: 0000000000000000
RBP: ffffc900125ff6f0 R08: dffffc0000000000 R09: fffff940002f0221
R10: 0000000000000000 R11: dffffc0000000001 R12: ffffea0001781100
R13: 1ffffd40002f0221 R14: 0000000000000000 R15: ffffea0001781108
FS:  00007f75f3998700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000393e4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
