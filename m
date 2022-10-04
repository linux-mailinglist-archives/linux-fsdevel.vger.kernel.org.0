Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860745F406A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 11:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiJDJyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 05:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiJDJxz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:53:55 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92C512ACB
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Oct 2022 02:53:42 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id z4-20020a921a44000000b002f8da436b83so10435121ill.19
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Oct 2022 02:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=SCT+565owULQPTlwhoQwnm7EblNgG1LpirqpsVrCf9I=;
        b=K6MGmh0RhIzxRP8AXqnkkgmlACyMlUYFL2rabuwutAD+8Qu/zwrQlArkYcr5eKQ78K
         CCpVGhiDw/2jZpQEhvXPwajKYdexJO0CHRskrNMv3UDhZ1RiEDnMqk3xgrEzcw/Wsz5X
         nUQliRDeP/NJjXV8sC2gYDod0aEnhFAR0bZoDTE3mDyDRAaXLib+sCp+NEEQ8TlTu5as
         37XjiMgFNxMkqPdm4B4A6SdjPWdYjeTYpKQSQDS3fHm6BxrqPJp662JAT2bnpFgbRxIf
         TvWCnEchCDj4mCaZx1ZS+xkDNuNFABDda547vErZVmt2RODpvrjPS3h1wQKcNs0IAWCw
         qVhQ==
X-Gm-Message-State: ACrzQf3xVycGe8vfTxhYQQfLsY2aJPiFE3C6HmfZlV+HzDJzicZxwLJk
        zfYoB4+g7ActhA2sLTBNbC3pjy6ofUfxRHhEl9IzNakDBJKo
X-Google-Smtp-Source: AMsMyM4H1eA9jebltaoE/+XRpiiiHaUCfWuMrObOp+QE2Q9XRs4/obXewcjYP7DxzNLNFSo/UZZYIVsMB2tHNGILDI8ZPinDsKzB
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2e:b0:2f9:e8fd:df47 with SMTP id
 m14-20020a056e021c2e00b002f9e8fddf47mr3371716ilh.47.1664877222123; Tue, 04
 Oct 2022 02:53:42 -0700 (PDT)
Date:   Tue, 04 Oct 2022 02:53:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b624d05ea326f79@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in do_read_cache_folio
From:   syzbot <syzbot+c3616973d9db2b0cff65@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=120e011f080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aae2d21e7dd80684
dashboard link: https://syzkaller.appspot.com/bug?extid=c3616973d9db2b0cff65
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/11078f50b80b/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/398e5f1e6c84/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c3616973d9db2b0cff65@syzkaller.appspotmail.com

ntfs: volume version 3.1.
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000086000006
  EC = 0x21: IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
user pgtable: 4k pages, 48-bit VAs, pgdp=00000001515fb000
[0000000000000000] pgd=080000015162c003, p4d=080000015162c003, pud=08000001511b5003, pmd=0000000000000000
Internal error: Oops: 0000000086000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 4711 Comm: syz-executor.1 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : 0x0
lr : filemap_read_folio+0x68/0x33c mm/filemap.c:2394
sp : ffff800015e03940
x29: ffff800015e03940 x28: 00000000ffffffff x27: 0000000000080001
x26: 0000000000001000 x25: 0000000000000000 x24: 0000000000000000
x23: fffffc00044d8580 x22: fffffc00044d8580 x21: 0000000000000000
x20: 0000000000000000 x19: fffffc00044d8580 x18: fffffffffffffff5
x17: ffff80000bffd6bc x16: 0000000000000068 x15: 000000000000000c
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000004
x11: ff808000083d0b00 x10: 0000000000000000 x9 : ffff8000083d0b00
x8 : 0000000000000100 x7 : ffff80000818d174 x6 : ffff8000083ed3f0
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : fffffc00044d8580 x1 : fffffc00044d8580 x0 : 0000000000000000
Call trace:
 0x0
 do_read_cache_folio+0x1c8/0x588 mm/filemap.c:3519
 do_read_cache_page mm/filemap.c:3561 [inline]
 read_cache_page+0x40/0x178 mm/filemap.c:3570
 read_mapping_page include/linux/pagemap.h:756 [inline]
 ntfs_map_page fs/ntfs/aops.h:75 [inline]
 ntfs_check_logfile+0x2a4/0x8cc fs/ntfs/logfile.c:532
 load_and_check_logfile+0x5c/0xcc fs/ntfs/super.c:1215
 load_system_files+0x7d0/0x1220 fs/ntfs/super.c:1941
 ntfs_fill_super+0xbac/0x1030 fs/ntfs/super.c:2891
 mount_bdev+0x1b8/0x210 fs/super.c:1400
 ntfs_mount+0x44/0x58 fs/ntfs/super.c:3048
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: bad PC value
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
