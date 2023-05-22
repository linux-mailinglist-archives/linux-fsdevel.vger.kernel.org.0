Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48F970CA5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 22:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjEVUHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 16:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjEVUHx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 16:07:53 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E7B95
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 13:07:52 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-772d796bbe5so253073639f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 13:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786072; x=1687378072;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VaXnjSH38I+oMnQShq1OgL1MwuU4LJkpqrVRB5TxzhE=;
        b=MP0+/TLtisXfJ4x7TVXDm5zCnnZLCWIDBchAAyKtplnTTT+KMRvKKCdvHklbmOdG3Z
         cidLjdFn7G8LbYtRILCFDfIOTexm5PIeUiSnQdTjC3barlZrcJa1p7ogiWObr4rnLTVL
         /nNZNwKpMXfuDiZBmrQ+UcH0iNIppr1hYrDBG2GbWswVfe26MYitOF52DHQ17uwMsg+i
         dzV0MSEJEp5FIsBvlReDfdk6mjBSJVnsCtFCrwl581aEqw+G75rFC+Uv3RoPkcjxbQw5
         3X3rIX86KFihmQIxdDNkLTKR4fkuFHdwtexMccpLR6Zc8/YBnzOM7qHZWcvjqzvo5dDf
         rQAA==
X-Gm-Message-State: AC+VfDx018mM5fUr+1+CqlUQxVJJ6Dp7kT9HtIWxZTJfmGUjb/FMF0Kp
        6sohuAeiMromRjNef4oBpBdgI2oi8QWD/0HNorqCYLrcqGvH
X-Google-Smtp-Source: ACHHUZ7hbKBftR8z/o8AdDyqmMjTxvZeU5fbRcrzjU9UEADrsaoUMs6DzOE1YQyUgmOG1pR7NBNuaMhjbs/lT4hprSjqIV99wU2b
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2158:b0:774:8142:9931 with SMTP id
 y24-20020a056602215800b0077481429931mr43990ioy.1.1684786071921; Mon, 22 May
 2023 13:07:51 -0700 (PDT)
Date:   Mon, 22 May 2023 13:07:51 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000056edfa05fc4dd3ba@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data
From:   syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    44c026a73be8 Linux 6.4-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1028b7a1280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f389ffdf4e9ba3f0
dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162a1a8e280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12eb0691280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8c94fba58ffe/disk-44c026a7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc04d8a50461/vmlinux-44c026a7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d861756bf1a/bzImage-44c026a7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f43e36084b2b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:235!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5070 Comm: syz-executor189 Not tainted 6.4.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
RIP: 0010:ext4_write_inline_data+0x344/0x3e0 fs/ext4/inline.c:235
Code: 5f e9 80 76 59 ff e8 7b 76 59 ff 45 8d 64 2c c4 41 bd 3c 00 00 00 41 29 ed e9 e8 fe ff ff e8 63 76 59 ff 0f 0b e8 5c 76 59 ff <0f> 0b e8 25 40 ac ff e9 fe fd ff ff 4c 89 ff e8 18 40 ac ff e9 99
RSP: 0018:ffffc90003e7f950 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807497c8b0 RCX: 0000000000000000
RDX: ffff888020bb1dc0 RSI: ffffffff822acc74 RDI: 0000000000000006
RBP: 0000000000000054 R08: 0000000000000006 R09: 0000000000000060
R10: 0000000000000054 R11: 0000000000000000 R12: 000000000000000c
R13: 0000000000000060 R14: ffffc90003e7f9e8 R15: ffff88807497ce6a
FS:  00007f4e59eb8700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4e59e71000 CR3: 000000002bdc2000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 ext4_write_inline_data_end+0x2b3/0xd20 fs/ext4/inline.c:775
 ext4_da_write_end+0x3d0/0xad0 fs/ext4/inode.c:2985
 generic_perform_write+0x316/0x570 mm/filemap.c:3934
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:289
 ext4_file_write_iter+0xbe0/0x1740 fs/ext4/file.c:710
 call_write_iter include/linux/fs.h:1868 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x945/0xd50 fs/read_write.c:584
 ksys_write+0x12b/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4e62256399
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4e59eb82f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000000003a RCX: 00007f4e62256399
RDX: 000000000000000c RSI: 00000000200002c0 RDI: 0000000000000004
RBP: 00007f4e622d37a8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4e622d37a0
R13: 00007f4e622a08f8 R14: 0000000020001200 R15: 0030656c69662f2e
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_write_inline_data+0x344/0x3e0 fs/ext4/inline.c:235
Code: 5f e9 80 76 59 ff e8 7b 76 59 ff 45 8d 64 2c c4 41 bd 3c 00 00 00 41 29 ed e9 e8 fe ff ff e8 63 76 59 ff 0f 0b e8 5c 76 59 ff <0f> 0b e8 25 40 ac ff e9 fe fd ff ff 4c 89 ff e8 18 40 ac ff e9 99
RSP: 0018:ffffc90003e7f950 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807497c8b0 RCX: 0000000000000000
RDX: ffff888020bb1dc0 RSI: ffffffff822acc74 RDI: 0000000000000006
RBP: 0000000000000054 R08: 0000000000000006 R09: 0000000000000060
R10: 0000000000000054 R11: 0000000000000000 R12: 000000000000000c
R13: 0000000000000060 R14: ffffc90003e7f9e8 R15: ffff88807497ce6a
FS:  00007f4e59eb8700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555a6837b238 CR3: 000000002bdc2000 CR4: 0000000000350ee0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
