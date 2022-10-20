Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9D660618E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 15:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiJTNZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 09:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiJTNZp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:25:45 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297E971BDC
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Oct 2022 06:25:44 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id i4-20020a056e02152400b002fa876e95b3so20012132ilu.17
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Oct 2022 06:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TaMuVZaq7QDAGspjNdrRvPMQ7xoVTTFuG6MtyPa0984=;
        b=jkertNufh73ZhzWXUrpcOD6bppXYJ4Ba+HT568lT87bTjCq7wgpHDFCUWhdLEMbihB
         Gt3hehfRlbPdX59f4xk135CUdO/m9ze7jraFtgiyiAtTgbdiQ6RRjT1waaWQwTP3F4gD
         yA613DjFih8lcB6Bq3aLZGQIE4EEiM4klhMXAdcFi7dJQB89euyMAjzZDfLQQinTsMh3
         AhojgniGMouf33krOaSojjiAecuG/Jmi3ne1mFYC8SjzCrR4nWBFoYzs/dzwTcsQHS6R
         0XBZSr5iaxOfv0Lyd0wJRE+7N3bf5kkL/RbAvhmf/YG/KR73G5lSxPeeSb7jYKAVajx5
         W13Q==
X-Gm-Message-State: ACrzQf2GVku0mAbQP9UyjwR+Sc10ofIrNlCiZo3QWjiWggW3GOHe49ib
        xTlNmmGu1chwfqKyqsN+3h6oqlomvWUSuMeULp7ydsa9UK6m
X-Google-Smtp-Source: AMsMyM5TMH6VrbfNN4/4llwU6k/STxE4cOarQ2+HTKp6p9tffQI+w3vyTgnoOiJSQH/94mb4uwWECzNlSAfPp2GCzoJxh1i6TK9F
MIME-Version: 1.0
X-Received: by 2002:a02:c735:0:b0:363:c669:9933 with SMTP id
 h21-20020a02c735000000b00363c6699933mr10904626jao.29.1666272343419; Thu, 20
 Oct 2022 06:25:43 -0700 (PDT)
Date:   Thu, 20 Oct 2022 06:25:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020f00f05eb774338@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in filemap_read_folio
From:   syzbot <syzbot+e33c2a7e25ff31df5297@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108783e6880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c29b6436e994d72e
dashboard link: https://syzkaller.appspot.com/bug?extid=e33c2a7e25ff31df5297
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c8f5131ab57d/disk-55be6084.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/77167f226f35/vmlinux-55be6084.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e33c2a7e25ff31df5297@syzkaller.appspotmail.com

ntfs: volume version 3.1.
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD a5bf9067 P4D a5bf9067 PUD 37d2e067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 11041 Comm: syz-executor.1 Not tainted 6.0.0-syzkaller-09589-g55be6084c8e0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9001504f618 EFLAGS: 00010287
RAX: ffffffff81b64c0e RBX: ffffc9001504f680 RCX: 0000000000040000
RDX: ffffc9000ae14000 RSI: ffffea0002a61580 RDI: 0000000000000000
RBP: ffffc9001504f6f8 R08: dffffc0000000000 R09: fffff9400054c2b1
R10: fffff9400054c2b1 R11: 1ffffd400054c2b0 R12: ffffea0002a61580
R13: 1ffffd400054c2b1 R14: 0000000000000000 R15: ffffea0002a61588
FS:  00007f0f425d5700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000a32e1000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 filemap_read_folio+0x1ba/0x7f0 mm/filemap.c:2399
 do_read_cache_folio+0x2d3/0x790 mm/filemap.c:3526
 do_read_cache_page mm/filemap.c:3568 [inline]
 read_cache_page+0x57/0x250 mm/filemap.c:3577
 read_mapping_page include/linux/pagemap.h:756 [inline]
 ntfs_map_page fs/ntfs/aops.h:75 [inline]
 ntfs_check_logfile+0x3f1/0x2a50 fs/ntfs/logfile.c:532
 load_and_check_logfile+0x6f/0xd0 fs/ntfs/super.c:1215
 load_system_files+0x3376/0x48d0 fs/ntfs/super.c:1941
 ntfs_fill_super+0x19a9/0x2bf0 fs/ntfs/super.c:2892
 mount_bdev+0x26c/0x3a0 fs/super.c:1400
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2e3/0x3d0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0f4148cada
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0f425d4f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f0f4148cada
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f0f425d4fe0
RBP: 00007f0f425d5020 R08: 00007f0f425d5020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f0f425d4fe0 R15: 00000000200026c0
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9001504f618 EFLAGS: 00010287
RAX: ffffffff81b64c0e RBX: ffffc9001504f680 RCX: 0000000000040000
RDX: ffffc9000ae14000 RSI: ffffea0002a61580 RDI: 0000000000000000
RBP: ffffc9001504f6f8 R08: dffffc0000000000 R09: fffff9400054c2b1
R10: fffff9400054c2b1 R11: 1ffffd400054c2b0 R12: ffffea0002a61580
R13: 1ffffd400054c2b1 R14: 0000000000000000 R15: ffffea0002a61588
FS:  00007f0f425d5700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000a32e1000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
