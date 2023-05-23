Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D9B70E941
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 00:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjEWWuv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 18:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjEWWuu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 18:50:50 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8C6C2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 15:50:48 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3382ff898c3so2191435ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 15:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684882248; x=1687474248;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdB683sgWwh+OYHpDOYM2ACu6pGxWfF2nR7ZnTieMw0=;
        b=h887vVvDmc/M1B8F1or/zNM69tgIidaIwlnFETGwTs7uqXzvXWf+j8Wkmvd8UUXI8M
         tkweozf8EwxeLNXhum/d7hlquSqRRia6wI9OkIp/bqFisufQON6aQJmmkRtaaRWSVIqs
         w2JzbhTDKYEM+bEY8aBzMOliyfjoeyr9mdvcNTKgRtWi3dOMOWmg9bMZ6FDF6Al4ZDLX
         jt98++wC6sA6jLu5xt7dpScqI8mkE/v3gCeYIyjpulP31nLTQT99wgB1ib0ilG11f42r
         7268HvgECH27xvkkvBDIuEXbN4Sk5Mmku9ZwxpoO56VzB81nFV5Wk6bA/ram12o9NExn
         Pp0A==
X-Gm-Message-State: AC+VfDyOCHWJv1dHB0EcN3ayOgo4k+kgT+bXmvfKXbD26VFpnRDBcZJo
        AU/UkR0O43Eyg13Srv8SfX3goLYmMJfxFroxn+UgDHbqXN5L
X-Google-Smtp-Source: ACHHUZ6P1bc/CABl11eEtK49q0VaWEeHBQcwhV0y4KgKtuiyZrILQ9lPfSOceFAnsuz7GPDc90Rychfg9XZSReefQPm3OY+2iFU8
MIME-Version: 1.0
X-Received: by 2002:a92:d287:0:b0:335:908b:8ee with SMTP id
 p7-20020a92d287000000b00335908b08eemr7899169ilp.2.1684882248078; Tue, 23 May
 2023 15:50:48 -0700 (PDT)
Date:   Tue, 23 May 2023 15:50:48 -0700
In-Reply-To: <000000000000172fc905f8a19ab5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e29eee05fc64378e@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_commit_transaction (2)
From:   syzbot <syzbot+dafbca0e20fbc5946925@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    ae8373a5add4 Merge tag 'x86_urgent_for_6.4-rc4' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17b3b489280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f389ffdf4e9ba3f0
dashboard link: https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14243ef9280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c06772280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2c5ee189dd12/disk-ae8373a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/63acf75623d7/vmlinux-ae8373a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/29de65c99e9d/bzImage-ae8373a5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2eac0114b435/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dafbca0e20fbc5946925@syzkaller.appspotmail.com

BTRFS warning (device loop0): Skipping commit of aborted transaction.
------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 0 PID: 41 at fs/btrfs/transaction.c:1978 cleanup_transaction fs/btrfs/transaction.c:1978 [inline]
WARNING: CPU: 0 PID: 41 at fs/btrfs/transaction.c:1978 btrfs_commit_transaction+0x3223/0x3fa0 fs/btrfs/transaction.c:2565
Modules linked in:
CPU: 0 PID: 41 Comm: kworker/u4:2 Not tainted 6.4.0-rc3-syzkaller-00008-gae8373a5add4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
Workqueue: events_unbound btrfs_async_reclaim_metadata_space
RIP: 0010:cleanup_transaction fs/btrfs/transaction.c:1978 [inline]
RIP: 0010:btrfs_commit_transaction+0x3223/0x3fa0 fs/btrfs/transaction.c:2565
Code: c8 fe ff ff be 02 00 00 00 e8 f9 41 aa 00 e9 21 d3 ff ff e8 af 68 1b fe 8b b5 20 ff ff ff 48 c7 c7 c0 25 95 8a e8 2d 28 e3 fd <0f> 0b c7 85 00 ff ff ff 01 00 00 00 e9 97 df ff ff e8 87 68 1b fe
RSP: 0018:ffffc90000b27990 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 000000001f0d8001 RCX: 0000000000000000
RDX: ffff888014aa0000 RSI: ffffffff814c03e7 RDI: 0000000000000001
RBP: ffffc90000b27b00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88801f0d8000
R13: ffff888074df3e98 R14: ffff888074df4000 R15: ffff88801f0d8000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055bc77452c28 CR3: 0000000072dfb000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 flush_space+0x1e0/0xde0 fs/btrfs/space-info.c:808
 btrfs_async_reclaim_metadata_space+0x39e/0xa90 fs/btrfs/space-info.c:1078
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
