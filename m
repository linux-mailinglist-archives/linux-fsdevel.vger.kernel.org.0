Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189BA53FFB8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 15:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244491AbiFGNLh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 09:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244471AbiFGNL0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:11:26 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF78C9662
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 06:11:23 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id k4-20020a6b4004000000b006697f6074e6so708994ioa.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jun 2022 06:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QdpiH1zf2g1QfmGEmiyd/ASppcMDWZ+/Qd+vKzppL80=;
        b=JgRKuVmXOarnHUwWtaSp966CV25Yya070hF7LVKJAKf5IMqQvf8YsB2ST8epU1lRs4
         UqfbrH83GmrRjV/OeE+BYk1ldKMWOQdOX+2V29aKCet4HYhC4qFsv2tkZdSKe3AkOE3T
         MehP732O21ANkqM7HwoSNPrtwhn196nLqDGi7G1R3idBzwdm6BHXYl9tXYB1w+iuvChY
         9BPewAwecucMdNLP1LwWpUXP2cL4xycU1ODQDKxbgTKTxo7NrCsb/891KHbfri5IQjqC
         xNz/hFaz6PPjozugLvnbmX/vkQ69NegKLWYV5+pxqtyNjyo6iDbV0lcLAeYXxW/bZ4cQ
         6pjg==
X-Gm-Message-State: AOAM533aXRWg0/0IvYRRxqAicjtT0I57MU2BRYSJSs+Z48ZpEST1yfUX
        EuF4NfRcU+j/9qoZszx5nmmaFkFxI0TvcwPjS49oFMepdCyv
X-Google-Smtp-Source: ABdhPJzpsElH7CPkj15sJP83oYbAf5DXGOYbkFiMYnv/JqtbiwHAf5e7dMZADXg1Y8w3A9Y3Zst4XhlgjYmAuvLs1hgPCC51LgTL
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c26:b0:2d3:bbe3:9223 with SMTP id
 m6-20020a056e021c2600b002d3bbe39223mr16048928ilh.176.1654607482511; Tue, 07
 Jun 2022 06:11:22 -0700 (PDT)
Date:   Tue, 07 Jun 2022 06:11:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ce9d105e0db53c8@google.com>
Subject: [syzbot] KASAN: use-after-free Read in copy_page_from_iter_atomic (2)
From:   syzbot <syzbot+d2dd123304b4ae59f1bd@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    73d0e32571a0 Add linux-next specific files for 20220607
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1433bacff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=448ee2b64e828049
dashboard link: https://syzkaller.appspot.com/bug?extid=d2dd123304b4ae59f1bd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d2dd123304b4ae59f1bd@syzkaller.appspotmail.com

BTRFS error (device loop2): bad tree block start, want 22036480 have 0
==================================================================
BUG: KASAN: use-after-free in copy_page_from_iter_atomic+0xef6/0x1b30 lib/iov_iter.c:969
Read of size 4096 at addr ffff888177101000 by task kworker/u4:30/4131

CPU: 0 PID: 4131 Comm: kworker/u4:30 Not tainted 5.19.0-rc1-next-20220607-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: loop2 loop_workfn
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 memcpy+0x20/0x60 mm/kasan/shadow.c:65
 copy_page_from_iter_atomic+0xef6/0x1b30 lib/iov_iter.c:969
 generic_perform_write+0x2b8/0x560 mm/filemap.c:3734
 __generic_file_write_iter+0x2aa/0x4d0 mm/filemap.c:3854
 generic_file_write_iter+0xd7/0x220 mm/filemap.c:3886
 call_write_iter include/linux/fs.h:2059 [inline]
 do_iter_readv_writev+0x3d1/0x640 fs/read_write.c:742
 do_iter_write+0x182/0x700 fs/read_write.c:868
 vfs_iter_write+0x70/0xa0 fs/read_write.c:909
 lo_write_bvec drivers/block/loop.c:249 [inline]
 lo_write_simple drivers/block/loop.c:271 [inline]
 do_req_filebacked drivers/block/loop.c:495 [inline]
 loop_handle_cmd drivers/block/loop.c:1859 [inline]
 loop_process_work+0xd83/0x2050 drivers/block/loop.c:1894
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0005dc4040 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x177101
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
raw: 057ff00000000000 ffffea0005dc4048 ffffea0005dc4048 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffff888177100f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888177100f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888177101000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff888177101080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888177101100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
