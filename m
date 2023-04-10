Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A306B6DC21D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Apr 2023 02:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjDJAAu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Apr 2023 20:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDJAAt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Apr 2023 20:00:49 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5C430FA
        for <linux-fsdevel@vger.kernel.org>; Sun,  9 Apr 2023 17:00:48 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id d11-20020a056e020c0b00b00326156e3a8bso25744182ile.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Apr 2023 17:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681084847; x=1683676847;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KUe7oj9hTq5hcskImUR6Y1MNxIs+QSkpYtdEdfE2RGE=;
        b=x6a5z64PzYLGlZWtLHnjiTZl1Mh9aE8sxKloMCIqaICzSLyqc6d6TAbO8SM85e+m0R
         fJbYd+b0ofSz7zcgzekOzmOFp8DFYb6dHjpMufZDXp7rlhQRZAWlCbNYb41wZP7T116a
         1kCHxfL3aMn16khmSJJpDqexFuwkvSnsRP7TL4a8tCE5uwJFDvR15/EN1SL+EdY+OcJA
         4nJ0ytb7X8h1RNHMVMf0+1pFFpAcG7Ysm2PnZxDt8tLyF5ECdOBBR6oQGtjqA4I8A0PV
         b0n6Kpe765F7x3gYYJOqDVnyqieGo7NxtNusvQQY/TiA79QUAjwwCS/iPL68viaimXsY
         HbxA==
X-Gm-Message-State: AAQBX9eB4DvNgDxhwewW2Oyn9Y8iWpya1OYZZ0ZWfRl8Kz7At25Nyi11
        f171zzsM4yXh+1PItGH1XWoztt+8CNlhGjOy71zRb5oGtk/v
X-Google-Smtp-Source: AKy350Y/UG//8klK566koPPD5BsMP1Bvg8PQE7X+VafGvAkCN6LUNSl8FL7vkqf5L+9ttMzMuNMOVW72CaxQf3qr+T/vlE2/xNcc
MIME-Version: 1.0
X-Received: by 2002:a5e:8e4a:0:b0:71b:8c6:6123 with SMTP id
 r10-20020a5e8e4a000000b0071b08c66123mr3904508ioo.3.1681084847398; Sun, 09 Apr
 2023 17:00:47 -0700 (PDT)
Date:   Sun, 09 Apr 2023 17:00:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002aa60c05f8f0114b@google.com>
Subject: [syzbot] [ntfs3?] WARNING in errseq_set
From:   syzbot <syzbot+e08a9f98656d7a208859@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    99ddf2254feb Merge tag 'trace-v6.3-rc5' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a3ec8dc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5666fa6aca264e42
dashboard link: https://syzkaller.appspot.com/bug?extid=e08a9f98656d7a208859
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/907a43450c5c/disk-99ddf225.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a142637e5396/vmlinux-99ddf225.xz
kernel image: https://storage.googleapis.com/syzbot-assets/447736ad6200/bzImage-99ddf225.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e08a9f98656d7a208859@syzkaller.appspotmail.com

------------[ cut here ]------------
err = 556
WARNING: CPU: 1 PID: 46 at lib/errseq.c:75 errseq_set+0xf2/0x120 lib/errseq.c:74
Modules linked in:
CPU: 1 PID: 46 Comm: kworker/u4:3 Not tainted 6.3.0-rc5-syzkaller-00032-g99ddf2254feb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Workqueue: writeback wb_workfn (flush-7:0)
RIP: 0010:errseq_set+0xf2/0x120 lib/errseq.c:74
Code: fd 89 e8 5b 41 5c 41 5e 41 5f 5d c3 e8 f7 4d 5a fd 44 89 e5 eb eb e8 ed 4d 5a fd 48 c7 c7 c0 c0 37 8b 44 89 fe e8 4e 65 22 fd <0f> 0b 44 89 e5 eb d0 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 2a ff
RSP: 0018:ffffc90000b770f0 EFLAGS: 00010246
RAX: 4af338da7583c100 RBX: ffff888074f98bd8 RCX: ffff888017d23a80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 000000000000022c R08: ffffffff81527c82 R09: ffffed101732515b
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
R13: 1ffff1100e9f317b R14: ffff888074f98da0 R15: 000000000000022c
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd05cb85998 CR3: 000000006cd24000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __filemap_set_wb_err+0x22/0x1e0 mm/filemap.c:698
 mapping_set_error include/linux/pagemap.h:224 [inline]
 ntfs_resident_writepage+0x90/0x150 fs/ntfs3/inode.c:848
 write_cache_pages+0x89e/0x12c0 mm/page-writeback.c:2473
 do_writepages+0x3a6/0x670 mm/page-writeback.c:2551
 __writeback_single_inode+0x155/0xfb0 fs/fs-writeback.c:1600
 writeback_sb_inodes+0x8ef/0x11d0 fs/fs-writeback.c:1891
 wb_writeback+0x458/0xc70 fs/fs-writeback.c:2065
 wb_do_writeback fs/fs-writeback.c:2208 [inline]
 wb_workfn+0x400/0xff0 fs/fs-writeback.c:2248
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
