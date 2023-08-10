Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438B6778082
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 20:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbjHJSlj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 14:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbjHJSlZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:41:25 -0400
Received: from mail-pl1-f208.google.com (mail-pl1-f208.google.com [209.85.214.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E214205
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 11:40:47 -0700 (PDT)
Received: by mail-pl1-f208.google.com with SMTP id d9443c01a7336-1bba7a32a40so18102035ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 11:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691692810; x=1692297610;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3sPzBtVJAxtctHbIGwoUSg9Jcm5dUTDuAMkH18JVVo=;
        b=Y5BTw9vfYfCIK1FHyZMCZlBl+HmfrvfMXa0r3WIs3XJhve8756p+rAEekAkiVRhkO2
         IM5NRfASWdbcvFRAmle0pWQJ6KFyPWGL73utmQ+GX0gCNlB2Njczplb7i84f13gsxsv2
         vd8BZss2uLQfoviJJznlR6iUybhCOJN+0+bczAfpPEyU4W48u6JXNBmiuRUY/hOUr69O
         rddYFn5UwanzDbRvojNs3EGABA93Un4cqm8K1wShq2kyzWnrZGrjZ9RXWkwv1SQJhqRi
         LZOvKkJyKFKIHUDb60LvOwE2LPJlLJAamMRrbzsY7Ke3H4+sxbbjUFjfgCYDiyEO+rKI
         7AOw==
X-Gm-Message-State: AOJu0YzYp8+vamXkqTrybUGL7pE09tsePkWoiJloKyAJUz3TdrDXylcC
        jJU/F5+edaGQ2Q04Wn1hSjAFo/pV2wXhSLQ7fprvtBtsB6J8
X-Google-Smtp-Source: AGHT+IFLFWxLpjiMT5J8FLrCJlf9MKkaL4SqtagbFrMLVL79K8VFaLPhVz9a2P6ac2P0QjJsJ+FLo23SQsEkOZLivLavuDweTnxZ
MIME-Version: 1.0
X-Received: by 2002:a17:902:f688:b0:1ba:ff36:e0d7 with SMTP id
 l8-20020a170902f68800b001baff36e0d7mr1204431plg.12.1691692810358; Thu, 10 Aug
 2023 11:40:10 -0700 (PDT)
Date:   Thu, 10 Aug 2023 11:40:10 -0700
In-Reply-To: <000000000000804fb406009d9880@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007d77e060295ed3c@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_finish_one_ordered
From:   syzbot <syzbot+6e54e639e7b934d64304@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    374a7f47bf40 Merge tag '6.5-rc5-ksmbd-server' of git://git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=103260f7a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da6e201fec031cc0
dashboard link: https://syzkaller.appspot.com/bug?extid=6e54e639e7b934d64304
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17eef89da80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147c2fa5a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ac1351a051ec/disk-374a7f47.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bc7b4ffa739d/vmlinux-374a7f47.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2764a8bb0cd5/bzImage-374a7f47.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4ee442dd4f54/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e54e639e7b934d64304@syzkaller.appspotmail.com

------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 1 PID: 32 at fs/btrfs/inode.c:3279 btrfs_finish_one_ordered+0x1d42/0x2240 fs/btrfs/inode.c:3279
Modules linked in:
CPU: 1 PID: 32 Comm: kworker/u4:2 Not tainted 6.5.0-rc5-syzkaller-00063-g374a7f47bf40 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: btrfs-endio-write btrfs_work_helper
RIP: 0010:btrfs_finish_one_ordered+0x1d42/0x2240 fs/btrfs/inode.c:3279
Code: c6 80 af b5 8a 48 c7 c7 00 9a b5 8a e8 67 3a f6 fd 0f 0b e8 80 d8 12 fe 8b b5 10 ff ff ff 48 c7 c7 00 ab b5 8a e8 ce 99 d9 fd <0f> 0b e9 b1 fc ff ff e8 62 d8 12 fe 8b b5 10 ff ff ff 48 c7 c7 00
RSP: 0018:ffffc90000c9fad8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888079be3c20 RCX: 0000000000000000
RDX: ffff888013af0140 RSI: ffffffff814be3c6 RDI: 0000000000000001
RBP: ffffc90000c9fc58 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff888071f926e0
R13: 0000000000000001 R14: ffff888071f92690 R15: ffff888079be3c68
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2c26c23060 CR3: 000000002a825000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_work_helper+0x20b/0xba0 fs/btrfs/async-thread.c:314
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
