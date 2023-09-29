Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1CE7B2DB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 10:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjI2IVo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 04:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjI2IVo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:21:44 -0400
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B60C1AC
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 01:21:42 -0700 (PDT)
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-57b739e5637so23538866eaf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 01:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695975701; x=1696580501;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QncnMnDgdyL2pjjT0J+hO9DvAnqoe9HZBWwXyXogEv0=;
        b=LL94aVFhN3EhqrvuX5bItJf7pAOrUiqLOFkN+dvlx27zK86sKzofw4cOx2xmSGzxJA
         y1TKC0d7CXlODEqWiIzq7776M3nfisUmbNagRa4zepwEVxQPCVhLNFb6vfCx5naz6D5A
         c9MZ3xBpzQuKtoIrYiuM7ZdnT7hzScduqiVnMZXobG7Rgr/1E34SwhBUSsMy5oitZUeC
         4jqJ4X+qxLe9GNpItXD8sz9wB2Ar/d1Lxlzpw8jc9bBw0fZ9itx0qn/YLZ5aaO0V+mlc
         Sqtbv7riS0HaKRwSijOZlS3ZIUZLvJsva3yqNypYgMs3pCVELCHaFS8GShjo5IHAwHWq
         HvOA==
X-Gm-Message-State: AOJu0YzaG1+F3KYEcvqpiUiRDRI9mco2PMEUGvddDbcorF1QRftxC3c2
        Q2fkfI4julFBXb69xpu8XgrvvpFFm4Zyjargt0qb21w3V8pi
X-Google-Smtp-Source: AGHT+IGId2yjzzorKtGVzl2YpcTdBIqF3KFVR7yxef8YfkTk8dFRhGhe90zRQTIpFeGhynjjn/+STGIqCVQWsVOKH/7At4F3NmrT
MIME-Version: 1.0
X-Received: by 2002:a4a:3356:0:b0:56c:86f2:ae14 with SMTP id
 q83-20020a4a3356000000b0056c86f2ae14mr943396ooq.0.1695975701380; Fri, 29 Sep
 2023 01:21:41 -0700 (PDT)
Date:   Fri, 29 Sep 2023 01:21:41 -0700
In-Reply-To: <0000000000005697bd05fe4aea49@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a874b06067b1d4d@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_iomap_begin (2)
From:   syzbot <syzbot+307da6ca5cb0d01d581a@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    9ed22ae6be81 Merge tag 'spi-fix-v6.6-rc3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126a50d6680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12da82ece7bf46f9
dashboard link: https://syzkaller.appspot.com/bug?extid=307da6ca5cb0d01d581a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15eb672e680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16219bc6680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f059028ccc85/disk-9ed22ae6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b01e6cd5f62/vmlinux-9ed22ae6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/32202918d16c/bzImage-9ed22ae6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/38533c948c72/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+307da6ca5cb0d01d581a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5195 at fs/ext4/inode.c:3338 ext4_iomap_begin+0xa9b/0xd30
Modules linked in:
CPU: 0 PID: 5195 Comm: syz-executor392 Not tainted 6.6.0-rc3-syzkaller-00055-g9ed22ae6be81 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:ext4_iomap_begin+0xa9b/0xd30 fs/ext4/inode.c:3338
Code: d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 ce 3d 4c ff 49 be 00 00 00 00 00 fc ff df 48 8b 5c 24 48 e9 65 ff ff ff e8 b5 3d 4c ff <0f> 0b 41 bc de ff ff ff e9 8f f6 ff ff 89 d9 80 e1 07 38 c1 0f 8c
RSP: 0018:ffffc9000405f580 EFLAGS: 00010293
RAX: ffffffff8241ccbb RBX: 0000000010000000 RCX: ffff88802234d940
RDX: 0000000000000000 RSI: 00000000000000bc RDI: 0000000000000000
RBP: ffffc9000405f6f0 R08: ffffffff8241c408 R09: 1ffff1100eff5b4a
R10: dffffc0000000000 R11: ffffed100eff5b4b R12: 00000000000000bc
R13: 1ffff1100eff5baf R14: 000000000000000b R15: 0000000000000016
FS:  00007f68b788c6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f68b788cd58 CR3: 000000006b9c0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iomap_iter+0x677/0xec0 fs/iomap/iter.c:91
 __iomap_dio_rw+0xe2e/0x2370 fs/iomap/direct-io.c:658
 iomap_dio_rw+0x46/0xa0 fs/iomap/direct-io.c:748
 ext4_dio_write_iter fs/ext4/file.c:605 [inline]
 ext4_file_write_iter+0x165f/0x1ad0 fs/ext4/file.c:715
 call_write_iter include/linux/fs.h:1956 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x782/0xaf0 fs/read_write.c:584
 ksys_pwrite64 fs/read_write.c:699 [inline]
 __do_sys_pwrite64 fs/read_write.c:709 [inline]
 __se_sys_pwrite64 fs/read_write.c:706 [inline]
 __x64_sys_pwrite64+0x1aa/0x230 fs/read_write.c:706
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f68bfbf0b59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f68b788c218 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007f68b788c6c0 RCX: 00007f68bfbf0b59
RDX: 0000000000000001 RSI: 0000000020000100 RDI: 0000000000000005
RBP: 00007f68bfc796d8 R08: 00007ffd6a04dbc7 R09: 0000000000000000
R10: 000000000000b114 R11: 0000000000000246 R12: ffffffffffffffb0
R13: 00007f68bfc796d0 R14: 00007f68bfc45840 R15: 0030656c69662f2e
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
