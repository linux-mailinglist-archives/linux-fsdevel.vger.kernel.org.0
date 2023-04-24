Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24D36EC6E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 09:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjDXHTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 03:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjDXHTr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:19:47 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2001C2700
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 00:19:46 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-32ab192a7b3so28140075ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 00:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682320785; x=1684912785;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4YdRQWkMgSvT2egQkHZSW9JYhDomQLIj+TlteNPVbs=;
        b=aOomrlQekzMUewE1lBhNWMuyPHMi3NJqx5+5Bis4BrSpAzgIOhM7sLru+RboZaFIBW
         XSlVURfLE7lIW3TE+nU8mB+t2l/8MgpLKXzhWQNrru5qljNN4OQ0M3j18HR+WTGuXO/1
         ekXLb1137ySIK4I8WKc5pWjSkEhdPyKuyNLJD8yUV8LvnrVRmZ9jGwUDjxr0EgvS8gOp
         1quJd6hFXRL7C+pbWck0PnWfe7pbGqdcXyjaY16X55JcSf4BDmGyPjTRd+r6JHJfc6m5
         3SSD2zUnuCyjzHSIM48Uwf3e1piwtHadqvgc40G8aVCF1wrZGzxXvAK48qC16RfxZJng
         cNdw==
X-Gm-Message-State: AAQBX9fEVypgpsHLMIBIfiOAG5zHQvEYE8moYIq5ngHB3fkxYa1JUsdJ
        w/5ykJUEtZNTmNMiSTegAus5X7ftobR6+qNDwvX7x0JIqETt
X-Google-Smtp-Source: AKy350YyOTqG5wtxPzeC5FKGP+YLYkDWHRY7TbIFtXDP9wCg2W2w9ONhcdK0y1gPZC83LS4gcG8bptO71qdO2Ef/KEtxouC/WTcl
MIME-Version: 1.0
X-Received: by 2002:a92:d248:0:b0:32b:a8bd:50f7 with SMTP id
 v8-20020a92d248000000b0032ba8bd50f7mr4357513ilg.2.1682320785435; Mon, 24 Apr
 2023 00:19:45 -0700 (PDT)
Date:   Mon, 24 Apr 2023 00:19:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0737c05fa0fd499@google.com>
Subject: [syzbot] [fs?] [mm?] KCSAN: data-race in __filemap_remove_folio /
 folio_mapping (2)
From:   syzbot <syzbot+606f94dfeaaa45124c90@syzkaller.appspotmail.com>
To:     djwong@kernel.org, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    622322f53c6d Merge tag 'mips-fixes_6.3_2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12342880280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa4baf7c6b35b5d5
dashboard link: https://syzkaller.appspot.com/bug?extid=606f94dfeaaa45124c90
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8b5f31d96315/disk-622322f5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/adca7dc8daae/vmlinux-622322f5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed78ddc31ccb/bzImage-622322f5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+606f94dfeaaa45124c90@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __filemap_remove_folio / folio_mapping

write to 0xffffea0004958618 of 8 bytes by task 17586 on cpu 1:
 page_cache_delete mm/filemap.c:145 [inline]
 __filemap_remove_folio+0x210/0x330 mm/filemap.c:225
 invalidate_complete_folio2 mm/truncate.c:586 [inline]
 invalidate_inode_pages2_range+0x506/0x790 mm/truncate.c:673
 iomap_dio_complete+0x383/0x470 fs/iomap/direct-io.c:115
 iomap_dio_rw+0x62/0x90 fs/iomap/direct-io.c:687
 ext4_dio_write_iter fs/ext4/file.c:597 [inline]
 ext4_file_write_iter+0x9e6/0x10e0 fs/ext4/file.c:708
 do_iter_write+0x418/0x700 fs/read_write.c:861
 vfs_iter_write+0x50/0x70 fs/read_write.c:902
 iter_file_splice_write+0x456/0x7d0 fs/splice.c:778
 do_splice_from fs/splice.c:856 [inline]
 direct_splice_actor+0x84/0xa0 fs/splice.c:1022
 splice_direct_to_actor+0x2ee/0x5f0 fs/splice.c:977
 do_splice_direct+0x104/0x180 fs/splice.c:1065
 do_sendfile+0x3b8/0x950 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x110/0x150 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffffea0004958618 of 8 bytes by task 17568 on cpu 0:
 folio_mapping+0x92/0x110 mm/util.c:774
 folio_evictable mm/internal.h:156 [inline]
 lru_add_fn+0x92/0x450 mm/swap.c:181
 folio_batch_move_lru+0x21e/0x2f0 mm/swap.c:217
 folio_batch_add_and_move mm/swap.c:234 [inline]
 folio_add_lru+0xc9/0x130 mm/swap.c:517
 filemap_add_folio+0xfc/0x150 mm/filemap.c:954
 page_cache_ra_unbounded+0x15e/0x2e0 mm/readahead.c:251
 do_page_cache_ra mm/readahead.c:300 [inline]
 page_cache_ra_order mm/readahead.c:560 [inline]
 ondemand_readahead+0x550/0x6c0 mm/readahead.c:682
 page_cache_sync_ra+0x284/0x2a0 mm/readahead.c:709
 page_cache_sync_readahead include/linux/pagemap.h:1214 [inline]
 filemap_get_pages+0x257/0xea0 mm/filemap.c:2598
 filemap_read+0x223/0x680 mm/filemap.c:2693
 generic_file_read_iter+0x76/0x320 mm/filemap.c:2840
 ext4_file_read_iter+0x1cc/0x290
 call_read_iter include/linux/fs.h:1845 [inline]
 generic_file_splice_read+0xe3/0x290 fs/splice.c:402
 do_splice_to fs/splice.c:885 [inline]
 splice_direct_to_actor+0x25a/0x5f0 fs/splice.c:956
 do_splice_direct+0x104/0x180 fs/splice.c:1065
 do_sendfile+0x3b8/0x950 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x110/0x150 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0xffff88810a98f7b0 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 17568 Comm: syz-executor.2 Not tainted 6.3.0-rc7-syzkaller-00191-g622322f53c6d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
