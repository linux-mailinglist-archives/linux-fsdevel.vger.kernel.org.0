Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF897495A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 08:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjGFGdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 02:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjGFGdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:33:46 -0400
Received: from mail-pf1-f206.google.com (mail-pf1-f206.google.com [209.85.210.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77655198B
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jul 2023 23:33:45 -0700 (PDT)
Received: by mail-pf1-f206.google.com with SMTP id d2e1a72fcca58-665bd7fe2f4so540707b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jul 2023 23:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688625224; x=1691217224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rQfgqYhN80cocuiZ4CtvhG1o5YWInCsGK0oXglBkVZQ=;
        b=NwZd+TQbm7nAvgPCiYAtvGp6B1AlFV3POULA8UgCqc9ZXAPuZ77JjVpLzY/jTeMNR4
         4z2HD8aR1PvUr7G+JNzOKDaC2HLSs/cEa/lyQ6kgySb2AJXuD7d6D4B4X8O11FzubGvU
         EAV3ZTillrCfEuX4Fe9s9cQXSEXuXdb8j3FlZ70l6DSjEbRo5qYeP4Il9spMP9M9o/71
         KkU/vCHRv2nypfyW6I+SdAFklSkluxaYmLF/ee8qNZoPnnQy//W2sVLXCdVebydKWh5I
         R6RfKBJ8Ob5jyuj5dLEX9QClltpxFHRb2KFskQiP42EsCeg9a0kyXlGuQGQ8nE29VV7+
         oZqA==
X-Gm-Message-State: ABy/qLZg2jWJJCamsH26RK/6SDoJHwolNPPpVWP/qlsBzvgYzomw6Kcn
        aMs0rhjxCUcXZzJIZkCJT1ZOPZPfrxcBKL96tnUhFlTfGW2S
X-Google-Smtp-Source: APBJJlHCvDebXUaazEvvRKiHgWMrvAJwTERHZkxu7vxis5raXolCfIJxGKP2pCC+Od2nQ3qJF5UTvPJThLwz78fvvXvwcefvkXK0
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d9b:b0:678:e0b1:7f28 with SMTP id
 fb27-20020a056a002d9b00b00678e0b17f28mr1181998pfb.6.1688625224084; Wed, 05
 Jul 2023 23:33:44 -0700 (PDT)
Date:   Wed, 05 Jul 2023 23:33:43 -0700
In-Reply-To: <0000000000007faf0005fe4f14b9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3f45805ffcbb21f@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_file_write_iter
From:   syzbot <syzbot+5050ad0fb47527b1808a@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    6843306689af Merge tag 'net-6.5-rc1' of git://git.kernel.o..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=114522aca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ad417033279f15a
dashboard link: https://syzkaller.appspot.com/bug?extid=5050ad0fb47527b1808a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102cb190a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c49d90a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6adc10dbd71/disk-68433066.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5c3fa1329201/vmlinux-68433066.xz
kernel image: https://storage.googleapis.com/syzbot-assets/84db3452bac5/bzImage-68433066.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5050ad0fb47527b1808a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5382 at fs/ext4/file.c:611 ext4_dio_write_iter fs/ext4/file.c:611 [inline]
WARNING: CPU: 1 PID: 5382 at fs/ext4/file.c:611 ext4_file_write_iter+0x1470/0x1880 fs/ext4/file.c:720
Modules linked in:
CPU: 1 PID: 5382 Comm: syz-executor288 Not tainted 6.4.0-syzkaller-11989-g6843306689af #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:ext4_dio_write_iter fs/ext4/file.c:611 [inline]
RIP: 0010:ext4_file_write_iter+0x1470/0x1880 fs/ext4/file.c:720
Code: 84 03 00 00 48 8b 04 24 31 ff 8b 40 20 89 c3 89 44 24 10 83 e3 08 89 de e8 5d 5a 5b ff 85 db 0f 85 d5 fc ff ff e8 30 5e 5b ff <0f> 0b e9 c9 fc ff ff e8 24 5e 5b ff 48 8b 4c 24 40 4c 89 fa 4c 89
RSP: 0018:ffffc9000522fc30 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880277a3b80 RSI: ffffffff82298140 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff8a832a60
R13: 0000000000000000 R14: 0000000000000000 R15: fffffffffffffff5
FS:  00007f154db95700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f154db74718 CR3: 000000006bcc7000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 call_write_iter include/linux/fs.h:1871 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x981/0xda0 fs/read_write.c:584
 ksys_write+0x122/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f154dc094f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f154db952f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f154dc924f0 RCX: 00007f154dc094f9
RDX: 0000000000248800 RSI: 0000000020000000 RDI: 0000000000000006
RBP: 00007f154dc5f628 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 652e79726f6d656d
R13: 656c6c616b7a7973 R14: 6465646165726874 R15: 00007f154dc924f8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
