Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42CE6ACB0D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 18:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCFRp5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 12:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCFRpt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:45:49 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6A76BDCD
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 09:45:14 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id y187-20020a6bc8c4000000b0074d28aa136dso5685057iof.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Mar 2023 09:45:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678124678;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvGwBPTQ7j4fKwRJaqe9v0f7Zi4TnEYXY8bTeBecqR4=;
        b=aOqwwgqHkz/YZfxaXnRklFlTTJ/kf6p5TAstEBowQR19oQQUBzoTH0zji1QbPwJZtz
         zYIBbj5YRNU8FQdEiTaa02CHgvTyEM9ZmAq3ubSKAdoprrg0/mQb94N/VNNsSx5YhTR0
         io1fQSn9A7mkVTG8vmnsClUVckMPJVa3c8Eax1wahr1fsxWMUnhP3DxtB5F3IPn7rvcI
         6gX0/Gtelk06mRZAG/1Od9kcnarG6LM1EB8hxfT7vZZvo7IoBB40QtBsrBTYdcheEOW5
         vfa5DPXmB4c6SdcqRDJDrhJ35Fm8zAKuBXyXejJ0i7qpEQ0nJD1M6b/YmYO3wTsWykGK
         CPuA==
X-Gm-Message-State: AO0yUKW37KdfZOsngSfkSalTtSgdMaIggO8EvJCcPoQViQkQf87ZbIpe
        JF+fJISGKUK+2wZFLSQryL2HDjGPRF+u8vNVr7IGlFg0v+XHPFY=
X-Google-Smtp-Source: AK7set/whmgHHHaEz+dxLemDH8Mpf08oeUidi88EJ9qB9lD9fwWkfeSEUBp++VkaZXUH9HZ/AUSU8/JXgqqMcKH2YuOR5QMsZ8vn
MIME-Version: 1.0
X-Received: by 2002:a02:95cd:0:b0:3c5:15d2:9a1c with SMTP id
 b71-20020a0295cd000000b003c515d29a1cmr5734944jai.2.1678124678137; Mon, 06 Mar
 2023 09:44:38 -0800 (PST)
Date:   Mon, 06 Mar 2023 09:44:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005451a705f63ed952@google.com>
Subject: [syzbot] [hfs?] kernel BUG in hfsplus_bnode_unhash
From:   syzbot <syzbot+65f654e7ff6234bf771f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    0988a0ea7919 Merge tag 'for-v6.3-part2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ee96e4c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff98a3b3c1aed3ab
dashboard link: https://syzkaller.appspot.com/bug?extid=65f654e7ff6234bf771f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+65f654e7ff6234bf771f@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/hfsplus/bnode.c:461!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 100 Comm: kswapd0 Not tainted 6.2.0-syzkaller-13467-g0988a0ea7919 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:hfsplus_bnode_unhash+0xf7/0x1e0 fs/hfsplus/bnode.c:461
Code: 2b e8 fd e7 34 ff 48 8d 6b 20 48 89 e8 48 c1 e8 03 42 80 3c 28 00 0f 85 b3 00 00 00 48 8b 5b 20 48 85 db 75 d2 e8 d9 e7 34 ff <0f> 0b e8 d2 e7 34 ff e8 cd e7 34 ff 49 8d 7c 24 20 48 b8 00 00 00
RSP: 0018:ffffc90001587348 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880160f0100 RSI: ffffffff824f32d7 RDI: ffff88802a310120
RBP: ffff88802a310000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888029372a00
R13: 0000000000000000 R14: ffffea00009f81c0 R15: 0000000000001000
FS:  0000000000000000(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7fd8638528 CR3: 0000000071e75000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hfsplus_release_folio+0x285/0x5f0 fs/hfsplus/inode.c:102
 filemap_release_folio+0x13f/0x1b0 mm/filemap.c:4121
 shrink_folio_list+0x1fe3/0x3c80 mm/vmscan.c:2010
 evict_folios+0x794/0x1940 mm/vmscan.c:5121
 try_to_shrink_lruvec+0x82c/0xb90 mm/vmscan.c:5297
 shrink_one+0x46b/0x810 mm/vmscan.c:5341
 shrink_many mm/vmscan.c:5394 [inline]
 lru_gen_shrink_node mm/vmscan.c:5511 [inline]
 shrink_node+0x2064/0x35f0 mm/vmscan.c:6459
 kswapd_shrink_node mm/vmscan.c:7262 [inline]
 balance_pgdat+0xa02/0x1ac0 mm/vmscan.c:7452
 kswapd+0x70b/0x1000 mm/vmscan.c:7712
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfsplus_bnode_unhash+0xf7/0x1e0 fs/hfsplus/bnode.c:461
Code: 2b e8 fd e7 34 ff 48 8d 6b 20 48 89 e8 48 c1 e8 03 42 80 3c 28 00 0f 85 b3 00 00 00 48 8b 5b 20 48 85 db 75 d2 e8 d9 e7 34 ff <0f> 0b e8 d2 e7 34 ff e8 cd e7 34 ff 49 8d 7c 24 20 48 b8 00 00 00
RSP: 0018:ffffc90001587348 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880160f0100 RSI: ffffffff824f32d7 RDI: ffff88802a310120
RBP: ffff88802a310000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888029372a00
R13: 0000000000000000 R14: ffffea00009f81c0 R15: 0000000000001000
FS:  0000000000000000(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7fd8638528 CR3: 0000000071e75000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
