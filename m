Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8100FA7319
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 21:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfICTFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 15:05:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:55360 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfICTFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:05:08 -0400
Received: by mail-io1-f69.google.com with SMTP id i2so18538705iof.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 12:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=m8nBMZVn/k6tEKtwKSNRs4YaYnqD+Ax70Mt0S0TCRDQ=;
        b=Tz/nxy4ZuTIMkzYT2OBrt6EHm2ZW8mpdXKDvWurgJGmrPU0JoLkyMXBnpuYefIbpkp
         6Du1YCDEjD10Gm1nVk6bX2rJyMPnLjzWB2RKAHRhTlMaycYvphtDhE97zdFYWEl7+jyD
         JHOOjmGj4T6N/NBPfJFzc90hUDN8TyVp030Tg/YBT+SP/aA1ysua99KfaXddPheiKIt9
         5zApGD5Dshct7hqhayispS5NwZTCy6jnoAzfqLWf5FcMLx8LnQUc9vFYASIdcu1Iu+jU
         IQmFxXfvsXOrgSRjBlJMJgrZXKWwGBw/UBY58tBXrlPgMosK/95Cq+KfFTzqJ18j8IUD
         jJYQ==
X-Gm-Message-State: APjAAAUyY2UG2o1JvD+pFiQOBKy8HHu3WPs6MU4DjMG4Xo8592l65VAt
        3UMGz9R++ilbnCJxgSRizD4Ul1gg/39XCNcqZHRGA58ZrXhK
X-Google-Smtp-Source: APXvYqzJbdEbPc7GobbS3t8obH8YZ8WsFNsDybbmlYxAiDB1wkKEyBuRKJYFdYPYj18FVxoYB7MYJdriI8J8EBB+YxYeK7mDvTrt
MIME-Version: 1.0
X-Received: by 2002:a6b:b4c7:: with SMTP id d190mr3121258iof.209.1567537506907;
 Tue, 03 Sep 2019 12:05:06 -0700 (PDT)
Date:   Tue, 03 Sep 2019 12:05:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000457db90591aac41c@google.com>
Subject: kernel BUG at ./include/linux/highmem.h:LINE!
From:   syzbot <syzbot+9256cdd80b48e98d3902@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6525771f Merge tag 'arc-5.3-rc7' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17588432600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58485246ad14eafe
dashboard link: https://syzkaller.appspot.com/bug?extid=9256cdd80b48e98d3902
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9256cdd80b48e98d3902@syzkaller.appspotmail.com

attempt to access beyond end of device
loop3: rw=1, want=27689, limit=106
------------[ cut here ]------------
kernel BUG at ./include/linux/highmem.h:224!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 24596 Comm: syz-executor.3 Not tainted 5.3.0-rc6+ #94
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:zero_user_segments include/linux/highmem.h:224 [inline]
RIP: 0010:zero_user include/linux/highmem.h:245 [inline]
RIP: 0010:guard_bio_eod+0x632/0x640 fs/buffer.c:3043
Code: e8 ff e9 47 fe ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c a7 fe ff  
ff 4c 89 f7 e8 78 47 e8 ff e9 9a fe ff ff e8 2e 4f af ff <0f> 0b 66 90 66  
2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 57 41 56
RSP: 0018:ffff88804b90eef8 EFLAGS: 00010283
RAX: ffffffff81c43b82 RBX: 0000000000004000 RCX: 0000000000040000
RDX: ffffc9000c775000 RSI: 0000000000005ba7 RDI: 0000000000005ba8
RBP: ffff88804b90ef48 R08: ffffffff81c439b5 R09: fffffbfff117be65
R10: fffffbfff117be65 R11: 0000000000000000 R12: 0000000000003e00
R13: 0000000000000200 R14: ffff88804ca5f548 R15: 1ffff1100994bea9
FS:  00007f038dbd5700(0000) GS:ffff8880aeb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2fa24000 CR3: 0000000094d86000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  mpage_bio_submit fs/mpage.c:65 [inline]
  mpage_readpages+0x519/0x5a0 fs/mpage.c:410
  fat_readpages+0x2c/0x40 fs/fat/inode.c:210
  read_pages+0xb0/0x3e0 mm/readahead.c:126
  __do_page_cache_readahead+0x480/0x530 mm/readahead.c:212
  ondemand_readahead+0x6e1/0xcf0 mm/internal.h:62
  page_cache_async_readahead+0x2af/0x340 mm/readahead.c:574
  generic_file_buffered_read mm/filemap.c:2079 [inline]
  generic_file_read_iter+0x6a6/0x21b0 mm/filemap.c:2344
  call_read_iter include/linux/fs.h:1864 [inline]
  new_sync_read fs/read_write.c:414 [inline]
  __vfs_read+0x59e/0x730 fs/read_write.c:427
  integrity_kernel_read+0x113/0x190 security/integrity/iint.c:200
  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:352 [inline]
  ima_calc_file_shash security/integrity/ima/ima_crypto.c:381 [inline]
  ima_calc_file_hash+0xaef/0x1b20 security/integrity/ima/ima_crypto.c:446
  ima_collect_measurement+0x220/0x4a0 security/integrity/ima/ima_api.c:239
  process_measurement+0xbdb/0x16c0 security/integrity/ima/ima_main.c:311
  ima_file_check+0x9b/0xe0 security/integrity/ima/ima_main.c:422
  do_last fs/namei.c:3420 [inline]
  path_openat+0x1760/0x4460 fs/namei.c:3533
  do_filp_open+0x192/0x3d0 fs/namei.c:3563
  do_sys_open+0x29f/0x560 fs/open.c:1089
  __do_sys_open fs/open.c:1107 [inline]
  __se_sys_open fs/open.c:1102 [inline]
  __x64_sys_open+0x87/0x90 fs/open.c:1102
  do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459879
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f038dbd4c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459879
RDX: 0000000000000000 RSI: 0000000000141042 RDI: 0000000020000400
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f038dbd56d4
R13: 00000000004f907f R14: 00000000004dac90 R15: 00000000ffffffff
Modules linked in:
---[ end trace 60aa945b5ab317e4 ]---
RIP: 0010:zero_user_segments include/linux/highmem.h:224 [inline]
RIP: 0010:zero_user include/linux/highmem.h:245 [inline]
RIP: 0010:guard_bio_eod+0x632/0x640 fs/buffer.c:3043
Code: e8 ff e9 47 fe ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c a7 fe ff  
ff 4c 89 f7 e8 78 47 e8 ff e9 9a fe ff ff e8 2e 4f af ff <0f> 0b 66 90 66  
2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 57 41 56
RSP: 0018:ffff88804b90eef8 EFLAGS: 00010283
RAX: ffffffff81c43b82 RBX: 0000000000004000 RCX: 0000000000040000
RDX: ffffc9000c775000 RSI: 0000000000005ba7 RDI: 0000000000005ba8
RBP: ffff88804b90ef48 R08: ffffffff81c439b5 R09: fffffbfff117be65
R10: fffffbfff117be65 R11: 0000000000000000 R12: 0000000000003e00
R13: 0000000000000200 R14: ffff88804ca5f548 R15: 1ffff1100994bea9
FS:  00007f038dbd5700(0000) GS:ffff8880aeb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2fa24000 CR3: 0000000094d86000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
