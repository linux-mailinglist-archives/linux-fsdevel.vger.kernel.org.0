Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520A06EC6E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 09:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjDXHTx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 03:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjDXHTt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:19:49 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718332D5D
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 00:19:46 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-760f829b0caso343428539f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 00:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682320785; x=1684912785;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cOQMklzzRQ8C4IiTO2E3YRpd1f6ELuERm1Tm7c2LT64=;
        b=Mv9FyHewH4EeYKxcytFQCSUHYE6lYVAeTCn4PKXTYyUi5p6ttK3Y1NdYv/Oy5Nblc9
         O8gU6dgMK92JvNJpf9ln7cjveY0S2A/vA1X+1+74LIZRTdb1NrQ6V7NaBSqaSLU//wFE
         BpwwcE/28JrZd4cQ/oJR2FI3sSZW1+qux/JTGjRowYxVTV3Ux3DW45xixAjflACjiwJx
         P9ydJq6dZzWAjDz1PFkJmI8yZhNZ9UbktUBip1ZMA2WvIo5v5QfMf9nVRKqMrRR3x/qB
         uR+6ZWKeMA0YuWCsDgPjZLYndeIvLVAX/aq3BASj21+HEVZqmGBMUaZAfucqf+8FbCGH
         6JDQ==
X-Gm-Message-State: AAQBX9c5LtbQEFgtxFbatos5sIje4CFQoeZq5u1TI73iLRA/eHGjSihB
        6ZZJKW2+V18guS1RLQbnqV/BO5tljVIT2h7ijHFDRgjP1vIc
X-Google-Smtp-Source: AKy350Yj5Hp3cd9ci8OEGCwRnmQb8OlzxOEjTtnieMT+sWfJ7lzgg3r8STuTxWuBaqDbKDfeIeCEjN+HpSIIKUT0dZS+lOrpHTu1
MIME-Version: 1.0
X-Received: by 2002:a6b:d618:0:b0:763:5f92:afc3 with SMTP id
 w24-20020a6bd618000000b007635f92afc3mr3924400ioa.0.1682320785648; Mon, 24 Apr
 2023 00:19:45 -0700 (PDT)
Date:   Mon, 24 Apr 2023 00:19:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3b33905fa0fd4a6@google.com>
Subject: [syzbot] [ext4?] KCSAN: data-race in __es_find_extent_range /
 __es_find_extent_range (6)
From:   syzbot <syzbot+4a03518df1e31b537066@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

Hello,

syzbot found the following issue on:

HEAD commit:    44149752e998 Merge tag 'cgroup-for-6.3-rc6-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100db37bc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=710057cbb8def08c
dashboard link: https://syzkaller.appspot.com/bug?extid=4a03518df1e31b537066
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7bfa303f05cc/disk-44149752.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4e8ea8730409/vmlinux-44149752.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e584bce13ba7/bzImage-44149752.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4a03518df1e31b537066@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __es_find_extent_range / __es_find_extent_range

write to 0xffff88810a5a98a8 of 8 bytes by task 10666 on cpu 0:
 __es_find_extent_range+0x212/0x300 fs/ext4/extents_status.c:296
 ext4_es_find_extent_range+0x91/0x260 fs/ext4/extents_status.c:318
 ext4_ext_put_gap_in_cache fs/ext4/extents.c:2284 [inline]
 ext4_ext_map_blocks+0x120d/0x36c0 fs/ext4/extents.c:4191
 ext4_map_blocks+0x2a0/0x1050 fs/ext4/inode.c:576
 ext4_mpage_readpages+0x699/0x1440 fs/ext4/readpage.c:300
 ext4_read_folio+0xc5/0x1a0 fs/ext4/inode.c:3308
 filemap_read_folio+0x2c/0x100 mm/filemap.c:2424
 filemap_fault+0x66f/0xb20 mm/filemap.c:3367
 __do_fault mm/memory.c:4155 [inline]
 do_read_fault mm/memory.c:4506 [inline]
 do_fault mm/memory.c:4635 [inline]
 handle_pte_fault mm/memory.c:4923 [inline]
 __handle_mm_fault mm/memory.c:5065 [inline]
 handle_mm_fault+0x115d/0x21d0 mm/memory.c:5211
 faultin_page mm/gup.c:925 [inline]
 __get_user_pages+0x363/0xc30 mm/gup.c:1147
 populate_vma_page_range mm/gup.c:1543 [inline]
 __mm_populate+0x23a/0x360 mm/gup.c:1652
 mm_populate include/linux/mm.h:3026 [inline]
 vm_mmap_pgoff+0x174/0x210 mm/util.c:547
 ksys_mmap_pgoff+0x2ac/0x320 mm/mmap.c:1410
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff88810a5a98a8 of 8 bytes by task 10630 on cpu 1:
 __es_find_extent_range+0x79/0x300 fs/ext4/extents_status.c:270
 __es_scan_range fs/ext4/extents_status.c:345 [inline]
 __es_scan_clu fs/ext4/extents_status.c:399 [inline]
 ext4_es_scan_clu+0xe4/0x190 fs/ext4/extents_status.c:415
 ext4_insert_delayed_block fs/ext4/inode.c:1694 [inline]
 ext4_da_map_blocks fs/ext4/inode.c:1806 [inline]
 ext4_da_get_block_prep+0x575/0xa70 fs/ext4/inode.c:1870
 __block_write_begin_int+0x349/0xe50 fs/buffer.c:2034
 __block_write_begin+0x5e/0x110 fs/buffer.c:2084
 ext4_da_write_begin+0x2fa/0x610 fs/ext4/inode.c:3084
 generic_perform_write+0x1c3/0x3d0 mm/filemap.c:3926
 ext4_buffered_write_iter+0x234/0x3e0 fs/ext4/file.c:289
 ext4_file_write_iter+0xd7/0x10e0
 call_write_iter include/linux/fs.h:1851 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x463/0x760 fs/read_write.c:584
 ksys_write+0xeb/0x1a0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __x64_sys_write+0x42/0x50 fs/read_write.c:646
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0xffff88810a653dc0 -> 0xffff8881067334d8

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 10630 Comm: syz-executor.0 Not tainted 6.3.0-rc6-syzkaller-00138-g44149752e998 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
