Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFBD721578
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jun 2023 10:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjFDICy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 04:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjFDICx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 04:02:53 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D1FC1
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jun 2023 01:02:51 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-77567c00a37so279628039f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jun 2023 01:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685865770; x=1688457770;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pX3JrkxK3bl4mL5qQRzJ3YzJ93nC54ATg72Z3TueWFg=;
        b=X7IMD8TDqhSW/nxcYrf+U5VbjDBtYDDQjrT9YAL+idF0BQZRAy/+pFdyxn0WERKo1Z
         hxUNgcstjadE4L5yG3oZ5hYKohrIvyI8bwHxvRhdsn9+/mMpuYwFJRSp+2lIj0+mh5IQ
         pYadL5tnxQZ3FegisMiswqMkax0LIthIYPLqOAXNXbx+SavioHYelgeGvd2BvUw06p1g
         ZE/1tvkOYTsMHTINQFusyNwcYZgCBb6KF4C7Bw+BoDAGBvi+Y9K+e1z6E6vlQP/TEMbe
         kjyaQiH6l9bu4Zk1juDt9UhO20W194a/aerTNojAAME/aX6xI+fzhuEKFI2IJBTXkLft
         zVbw==
X-Gm-Message-State: AC+VfDx+Sg88NRERdDAelZ2PkAugKH56OURm1bfVnlCJPaqRo5QyGiiN
        l9j1i3yKmlP01ZMpsVPgvsXT/lTvnufKpNFsFE0ROFhYfMT9
X-Google-Smtp-Source: ACHHUZ7qk0MWucJ4G9ALaHbToQi4eroKlaw30e7bZ4ghmojvQqN8CxQfvRbeszVQphZZMrO/BeyBLwC1EifGg3Yweyz2eooA6Ya1
MIME-Version: 1.0
X-Received: by 2002:a02:29c5:0:b0:41c:feac:7a9c with SMTP id
 p188-20020a0229c5000000b0041cfeac7a9cmr6425394jap.6.1685865770507; Sun, 04
 Jun 2023 01:02:50 -0700 (PDT)
Date:   Sun, 04 Jun 2023 01:02:50 -0700
In-Reply-To: <00000000000050314505d3429981@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063e8d005fd493617@google.com>
Subject: Re: [syzbot] [jfs?] kernel BUG in lbmIODone
From:   syzbot <syzbot+52ddb6c83a04ca55f975@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    715abedee4cd Add linux-next specific files for 20230515
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16769f33280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a2745d066dda0ec
dashboard link: https://syzkaller.appspot.com/bug?extid=52ddb6c83a04ca55f975
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1262d159280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e3b42d280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d4d1d06b34b8/disk-715abede.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ef33a86fdc8/vmlinux-715abede.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0006b413ed1/bzImage-715abede.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e03edfdf992b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+52ddb6c83a04ca55f975@syzkaller.appspotmail.com

BUG at fs/jfs/jfs_logmgr.c:2298 assert(bp->l_flag & lbmRELEASE)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_logmgr.c:2298!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 6.4.0-rc2-next-20230515-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:lbmIODone+0x111a/0x11d0 fs/jfs/jfs_logmgr.c:2298
Code: fe e9 97 f3 ff ff e8 25 70 95 fe 48 c7 c1 80 ac 89 8a ba fa 08 00 00 48 c7 c6 c0 aa 89 8a 48 c7 c7 00 ab 89 8a e8 26 58 79 fe <0f> 0b e8 df 70 e8 fe e9 09 f2 ff ff e8 f5 6f 95 fe 48 c7 c1 c0 ac
RSP: 0018:ffffc90000147c70 EFLAGS: 00010086
RAX: 000000000000003f RBX: ffff88814aa95200 RCX: 0000000000000100
RDX: 0000000000000000 RSI: ffffffff81689ddc RDI: 0000000000000005
RBP: 0000000000000020 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000101 R11: 0000000000000001 R12: 0000000000000246
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5731f31000 CR3: 00000000219b5000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bio_endio+0x5af/0x6c0 block/bio.c:1608
 req_bio_endio block/blk-mq.c:761 [inline]
 blk_update_request+0x56a/0x14f0 block/blk-mq.c:906
 blk_mq_end_request+0x59/0x4c0 block/blk-mq.c:1023
 lo_complete_rq+0x1c6/0x280 drivers/block/loop.c:370
 blk_complete_reqs+0xad/0xe0 block/blk-mq.c:1101
 __do_softirq+0x1d4/0x905 kernel/softirq.c:553
 run_ksoftirqd kernel/softirq.c:921 [inline]
 run_ksoftirqd+0x31/0x60 kernel/softirq.c:913
 smpboot_thread_fn+0x659/0x9f0 kernel/smpboot.c:164
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:lbmIODone+0x111a/0x11d0 fs/jfs/jfs_logmgr.c:2298
Code: fe e9 97 f3 ff ff e8 25 70 95 fe 48 c7 c1 80 ac 89 8a ba fa 08 00 00 48 c7 c6 c0 aa 89 8a 48 c7 c7 00 ab 89 8a e8 26 58 79 fe <0f> 0b e8 df 70 e8 fe e9 09 f2 ff ff e8 f5 6f 95 fe 48 c7 c1 c0 ac
RSP: 0018:ffffc90000147c70 EFLAGS: 00010086
RAX: 000000000000003f RBX: ffff88814aa95200 RCX: 0000000000000100
RDX: 0000000000000000 RSI: ffffffff81689ddc RDI: 0000000000000005
RBP: 0000000000000020 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000101 R11: 0000000000000001 R12: 0000000000000246
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5731f31000 CR3: 00000000219b5000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
