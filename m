Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261735A15D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 17:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242938AbiHYPaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 11:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237971AbiHYP3w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:29:52 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACC8B99E6
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Aug 2022 08:29:33 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id g4-20020a6b7604000000b0068a39eb2b95so6417425iom.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Aug 2022 08:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=K574Ff7OPSlBHPVjGOP+dUqSOXbxKjkiE9xNTOQccMw=;
        b=sTWakUhRkyQRTK0RAxyfprOxXdqExZI/JESR7e3yhbq+NU+qR1tQF8XdJR4zocr8ZQ
         vebePV/rGQroXSu48BeV3BO5VM448HUaCd0jU3D5Odz+mXNz7Z2EiWBfbRoDsWxEV05E
         6zLTrJPsA5EVh3X13AHX7lIWbQrV+eZersrPazS7QqgIttelBu+YhzG6KAa8o8ypIQAZ
         HrYAdQ5OHFRa91Wnys3FrGoiCt4I/9emT9AXAJqZPROCsxSmQAsq/yiq5+OxMSfQ/mqT
         2uxVI70JmXyElP2GvqmCVm6bfyvJ5EKALO5GHhJtrxtg/zdIflC14/rvfBNl4M7veYDc
         3RbA==
X-Gm-Message-State: ACgBeo1S7sDicloljKFRz41OU+0rINavsL4ErB9VWrcrupT93x0tD2qm
        pbuZa1RaaFoN4TqVg4TwE9KH4OEGlfDQ9pNDTbba93YL26fC
X-Google-Smtp-Source: AA6agR5ZJgGc7Ic7Y0MX25+ATXSRlrUcNAYZehaJfmI230ybdiZ8HX+LmsfHYc/luADdqqEYPuZaJaZUnKJfYEr1BtGpyD3hMBdc
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20eb:b0:2df:302c:fb10 with SMTP id
 q11-20020a056e0220eb00b002df302cfb10mr2218744ilv.35.1661441372695; Thu, 25
 Aug 2022 08:29:32 -0700 (PDT)
Date:   Thu, 25 Aug 2022 08:29:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5b4fe05e7127662@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in set_page_dirty
From:   syzbot <syzbot+775a3440817f74fddb8c@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a41a877bc12d Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=175def47080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5cea15779c42821c
dashboard link: https://syzkaller.appspot.com/bug?extid=775a3440817f74fddb8c
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+775a3440817f74fddb8c@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000086000005
  EC = 0x21: IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
user pgtable: 4k pages, 48-bit VAs, pgdp=00000001249cc000
[0000000000000000] pgd=080000012ee65003, p4d=080000012ee65003, pud=0000000000000000
Internal error: Oops: 86000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3044 Comm: syz-executor.0 Not tainted 6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/20/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : 0x0
lr : folio_mark_dirty+0xbc/0x208 mm/page-writeback.c:2748
sp : ffff800012803830
x29: ffff800012803830 x28: ffff0000d02c8000 x27: 0000000000000009
x26: 0000000000000001 x25: 0000000000000a00 x24: 0000000000000080
x23: 0000000000000000 x22: ffff0000ef276c00 x21: 05ffc00000000007
x20: ffff0000f14b83b8 x19: fffffc00036409c0 x18: fffffffffffffff5
x17: ffff80000dd7a698 x16: ffff80000dbb8658 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: ff808000083e9814 x10: 0000000000000000 x9 : ffff8000083e9814
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff0000d9028000 x4 : ffff0000d5c31000 x3 : ffff0000d9027f80
x2 : fffffffffffffff0 x1 : fffffc00036409c0 x0 : ffff0000f14b83b8
Call trace:
 0x0
 set_page_dirty+0x38/0xbc mm/folio-compat.c:62
 get_next_nat_page+0x198/0x300 fs/f2fs/node.c:154
 __flush_nat_entry_set fs/f2fs/node.c:3005 [inline]
 f2fs_flush_nat_entries+0x354/0x988 fs/f2fs/node.c:3109
 f2fs_write_checkpoint+0x350/0x568 fs/f2fs/checkpoint.c:1667
 f2fs_issue_checkpoint+0x1b0/0x234
 f2fs_sync_fs+0x8c/0xc8 fs/f2fs/super.c:1651
 sync_filesystem+0xe0/0x134 fs/sync.c:66
 generic_shutdown_super+0x38/0x190 fs/super.c:474
 kill_block_super+0x30/0x78 fs/super.c:1427
 kill_f2fs_super+0x140/0x184 fs/f2fs/super.c:4544
 deactivate_locked_super+0x70/0xd4 fs/super.c:332
 deactivate_super+0xb8/0xbc fs/super.c:363
 cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0xc4/0x208 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1d0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:625
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
Code: bad PC value
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
