Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3426E8E54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 11:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjDTJhu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 05:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbjDTJg4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:36:56 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B04C46A4
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 02:36:42 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-760c58747cdso136354539f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 02:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681983402; x=1684575402;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7H2xOuyMfKKw8Cz3kgRz9OwKi3ZnzM005yfTOCX8Dc=;
        b=G2k8H0xSUdDSzKWMKSBgpGBWW124dYJdlgM1Rrf9evOLi/MxGf1aHbtWsJkcKzmUn9
         8LUWdVVdc3dJarsbg/DzmN4YOBrtegLt0Z+Bd14s02bDlMz6iWaGoY3TCnPgJlpzseLI
         ZVTx17Hk4sm0cXc8ZMNi4s5kWLk3sMT7pLLz1xI4X5T/sc/8mf6wjxoGXeWIiwMFOZo9
         7Vxyfpf81Cq1U6QK5syI6iDPSCuieSQC4RtT/pNyfW35ZA2dSvcD966PvXuEql+53c4f
         QVnpuEjC0gNttSx+lxQkW2DTt+YOR+/WWGdAxg2YLdMOyOZTj7dm5MsC+ybmSJ5/SZw0
         23LA==
X-Gm-Message-State: AAQBX9dD7zQBc0xH6j++hr+JLuae0oJuLNswvM8tdprf0Cy2eciIKR0m
        9RZcTAH6oGoOkT8Bb/vt+DpOjI3YjeDAy4wYnhF27nmfXRq4
X-Google-Smtp-Source: AKy350bffhmeNWTFMGPSYlI5SDPCwW36yvX9w7ztHwAOf+XiOffwbJHw4LSGuDD/V6Z3u4Pls56qashA1AFFxL0GZMUdjMruIw7w
MIME-Version: 1.0
X-Received: by 2002:a5d:9f49:0:b0:760:ec21:a8ab with SMTP id
 u9-20020a5d9f49000000b00760ec21a8abmr575074iot.0.1681983401920; Thu, 20 Apr
 2023 02:36:41 -0700 (PDT)
Date:   Thu, 20 Apr 2023 02:36:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000030932c05f9c1472f@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_mark_ordered_io_finished
From:   syzbot <syzbot+049b5ea03bae9d6acc9b@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a7a55e27ad72 Merge tag 'i2c-for-6.3-rc7' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104304fbc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=759d5e665e47a55
dashboard link: https://syzkaller.appspot.com/bug?extid=049b5ea03bae9d6acc9b
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89778cf51c73/disk-a7a55e27.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8d826c46f139/vmlinux-a7a55e27.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fb0e22b4bb2a/bzImage-a7a55e27.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+049b5ea03bae9d6acc9b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 1070 at fs/btrfs/ordered-data.c:388 btrfs_mark_ordered_io_finished+0x993/0xcf0
Modules linked in:
CPU: 1 PID: 1070 Comm: kworker/u4:5 Not tainted 6.3.0-rc6-syzkaller-00183-ga7a55e27ad72 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Workqueue: events_unbound btrfs_async_reclaim_metadata_space
RIP: 0010:btrfs_mark_ordered_io_finished+0x993/0xcf0 fs/btrfs/ordered-data.c:388
Code: f8 ff ff e8 af 8a fe fd 48 c7 c7 80 45 2a 8b 48 c7 c6 e0 43 2a 8b ba 71 01 00 00 e8 c7 fe 10 07 e9 06 fd ff ff e8 8d 8a fe fd <0f> 0b 48 8b 84 24 a0 00 00 00 42 80 3c 28 00 4c 8b 7c 24 68 74 0a
RSP: 0018:ffffc90005cfee98 EFLAGS: 00010093
RAX: ffffffff838bec33 RBX: 00000000000ca000 RCX: ffff8880212a1d40
RDX: 0000000000000000 RSI: 00000000000ca000 RDI: 0000000000085000
RBP: fffffffffffbb000 R08: ffffffff838be9b7 R09: 0000000000000003
R10: ffffffffffffffff R11: dffffc0000000001 R12: 1ffff110048753ad
R13: dffffc0000000000 R14: 0000000000002000 R15: 00000000000ca000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32025000 CR3: 000000002ec18000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_run_delalloc_range+0xee2/0x11d0 fs/btrfs/inode.c:2258
 writepage_delalloc+0x261/0x590 fs/btrfs/extent_io.c:1424
 __extent_writepage+0x850/0x16d0 fs/btrfs/extent_io.c:1724
 extent_write_cache_pages fs/btrfs/extent_io.c:2635 [inline]
 extent_writepages+0xc31/0x1930 fs/btrfs/extent_io.c:2755
 do_writepages+0x3a6/0x670 mm/page-writeback.c:2551
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:390
 start_delalloc_inodes+0x7e1/0xcb0 fs/btrfs/inode.c:9287
 btrfs_start_delalloc_roots+0x745/0xab0 fs/btrfs/inode.c:9366
 shrink_delalloc fs/btrfs/space-info.c:611 [inline]
 flush_space+0x61d/0xe30 fs/btrfs/space-info.c:719
 btrfs_async_reclaim_metadata_space+0x29f/0x350 fs/btrfs/space-info.c:1066
 process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2390
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2537
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
