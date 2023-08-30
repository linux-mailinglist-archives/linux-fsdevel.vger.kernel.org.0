Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DA278DAA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbjH3Sgv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242284AbjH3Ht5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:49:57 -0400
Received: from mail-pl1-f207.google.com (mail-pl1-f207.google.com [209.85.214.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CBFCD8
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 00:49:54 -0700 (PDT)
Received: by mail-pl1-f207.google.com with SMTP id d9443c01a7336-1c09d82dfc7so52852485ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 00:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693381794; x=1693986594;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cTDt+bYQ6/mSJ4jCUdcdtOg7X5im5pInz2MbzpCzUzU=;
        b=EFetV04dkiOjvOexbyBelCBQRVRsyykt/ZdlySm4uq7wEs4GbJuZJ2dWX0p8ZItvkW
         aAJln45qR6zmM770zrksOPU/Gi2rFuTilqP5ycfw8FmYWz998JHZ1o83kZhuUDvCBa/u
         X+MXfjuxuROawiN68pz7cYvWJ9ASMiDR6w602J9nhpowRwb2L3s0yBkoiaCsM1YP8+sx
         p4R8j4WE6bUHOkbC09Balua8yCspIC6+mBFwR9jDvLCSB3j8mSieu5wQ6T2QFMLJEOeB
         t+6mLlsH+G1Xzt14sYgR5s8zdjh/jmuLrOQn/lJWV/ZKV84kN5xxk8LlmxuZv2cwXkGh
         3gaA==
X-Gm-Message-State: AOJu0YxiwAFCnjgq7zYQ04On9O5xNedKGpNEIheytWoD59SyFaAZAvRT
        EAOJ6R+rsx27gVdQVTI9a36GSkbx3JVAOqujflWSBGMU6xak
X-Google-Smtp-Source: AGHT+IGLGLtOU++31iOl3HsQ4ALkIEcFZFjlI33fIt3VEG5cMRJjGYewpLyhKZy4cEg5de/RAU2H2G6WzOKOsgBsZyCgQBXu++q2
MIME-Version: 1.0
X-Received: by 2002:a17:902:f68f:b0:1b8:a8f5:a97b with SMTP id
 l15-20020a170902f68f00b001b8a8f5a97bmr448638plg.7.1693381793779; Wed, 30 Aug
 2023 00:49:53 -0700 (PDT)
Date:   Wed, 30 Aug 2023 00:49:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000049964e06041f2cbf@google.com>
Subject: [syzbot] [btrfs?] UBSAN: array-index-out-of-bounds in FSE_decompress_wksp_body_bmi2
From:   syzbot <syzbot+1f2eb3e8cd123ffce499@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        terrelln@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    382d4cd18475 lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15979833a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=1f2eb3e8cd123ffce499
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/57260ac283ce/disk-382d4cd1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8be20b71d903/vmlinux-382d4cd1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/518fe2320c33/bzImage-382d4cd1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f2eb3e8cd123ffce499@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in lib/zstd/common/fse_decompress.c:345:30
index 33 is out of range for type 'FSE_DTable[1]' (aka 'unsigned int[1]')
CPU: 0 PID: 2895 Comm: kworker/u4:7 Not tainted 6.5.0-rc7-syzkaller-00164-g382d4cd18475 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: btrfs-endio btrfs_end_bio_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
 FSE_decompress_wksp_body lib/zstd/common/fse_decompress.c:345 [inline]
 FSE_decompress_wksp_body_bmi2+0x2e8/0x3790 lib/zstd/common/fse_decompress.c:370
 FSE_decompress_wksp_bmi2+0xc7/0x3670 lib/zstd/common/fse_decompress.c:378
 HUF_readStats_body lib/zstd/common/entropy_common.c:289 [inline]
 HUF_readStats_body_bmi2+0xba/0x620 lib/zstd/common/entropy_common.c:340
 HUF_readDTableX1_wksp_bmi2+0x161/0x2740 lib/zstd/decompress/huf_decompress.c:353
 HUF_decompress1X1_DCtx_wksp_bmi2+0x4e/0xe0 lib/zstd/decompress/huf_decompress.c:1693
 ZSTD_decodeLiteralsBlock+0x1009/0x1560 lib/zstd/decompress/zstd_decompress_block.c:195
 ZSTD_decompressBlock_internal+0x106/0xacc0 lib/zstd/decompress/zstd_decompress_block.c:1995
 ZSTD_decompressContinue+0x571/0x1690 lib/zstd/decompress/zstd_decompress.c:1184
 ZSTD_decompressContinueStream lib/zstd/decompress/zstd_decompress.c:1855 [inline]
 ZSTD_decompressStream+0x208f/0x3080 lib/zstd/decompress/zstd_decompress.c:2036
 zstd_decompress_bio+0x22b/0x570 fs/btrfs/zstd.c:573
 compression_decompress_bio fs/btrfs/compression.c:131 [inline]
 btrfs_decompress_bio fs/btrfs/compression.c:930 [inline]
 end_compressed_bio_read+0x145/0x400 fs/btrfs/compression.c:178
 btrfs_check_read_bio+0x138f/0x19b0 fs/btrfs/bio.c:324
 process_one_work+0x92c/0x12c0 kernel/workqueue.c:2600
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2751
 kthread+0x2b8/0x350 kernel/kthread.c:389
 ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
