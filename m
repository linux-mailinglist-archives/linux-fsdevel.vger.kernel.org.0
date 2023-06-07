Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653B8727347
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 01:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjFGXpz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 19:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFGXpy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:45:54 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0810210A
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 16:45:52 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-77760439873so646915839f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 16:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181552; x=1688773552;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWOJCBMKP6mSfYbctvklOmN3wcRqN+DKVS7GuRE6chI=;
        b=lMsrBd5m4LeFWS1rFrIZlG3ITJwodVeMdsYYL1I1Vt/fq6bm3b8OvclGSpV23s/nuy
         96kezI3Tl3TvL0vvBQpp4a32CD5AeWgV/vchCIB9S1+oH9l999Jb0vdcSi+XTcKJt25O
         s1hV1EWHQi9Yc8B6GP3Q1epK41aN8fFn5WCRlUKnJ4CacH1FdabhF3OuQn1MYqReKNG7
         c4cTAm3yZGSBqlb2IlgQ9LDuStWSzVgWWOaTvI2EzBZT8Yi7Y3vi60EGxCvTQDgjjSRb
         dFmuWsywtpZdBIAzJO8t56mwoSXlegBuDGpOMq7lhX3ZNV0U5aFZHhKWFpvyGOwCx/d6
         Ialw==
X-Gm-Message-State: AC+VfDxPNK9hwO6iWs0auqWCOBL2l4YgoIl2zEs/4CYep0dXuxqtjP0K
        tNARHj3bVtXVOecnMvlL1gIpvCrrLkBmaEukofUxxJ2AlmwL
X-Google-Smtp-Source: ACHHUZ55IA8Z0TgQ4yXZHNd1NXUzMwL9ikkAEETla75rjb06L4umBd1aPiWzck/1UePIu/KS0vMO0nXHoS4SsDf0wp3TbJyF/dOc
MIME-Version: 1.0
X-Received: by 2002:a6b:7507:0:b0:76c:7d5f:3690 with SMTP id
 l7-20020a6b7507000000b0076c7d5f3690mr3378640ioh.1.1686181552159; Wed, 07 Jun
 2023 16:45:52 -0700 (PDT)
Date:   Wed, 07 Jun 2023 16:45:52 -0700
In-Reply-To: <00000000000009ee1005fc425b4b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071812e05fd92bcef@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_split_ordered_extent
From:   syzbot <syzbot+ee90502d5c8fd1d0dd93@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    a27648c74210 afs: Fix setting of mtime when creating a fil..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12b04695280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=ee90502d5c8fd1d0dd93
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120b88fd280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e6a23b280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/33fadb6220e9/disk-a27648c7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/31a2f6248c1a/vmlinux-a27648c7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c97df5fe3d0b/bzImage-a27648c7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/735d868a5353/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ee90502d5c8fd1d0dd93@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5017 at fs/btrfs/ordered-data.c:1138 btrfs_split_ordered_extent+0x628/0x840
Modules linked in:
CPU: 1 PID: 5017 Comm: syz-executor199 Not tainted 6.4.0-rc5-syzkaller-00017-ga27648c74210 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:btrfs_split_ordered_extent+0x628/0x840 fs/btrfs/ordered-data.c:1138
Code: fe 48 c7 c7 a0 94 2a 8b 48 c7 c6 20 90 2a 8b ba 6c 04 00 00 e8 09 a9 1d 07 e8 f4 4a fb fd 0f 0b e9 21 fb ff ff e8 e8 4a fb fd <0f> 0b bb ea ff ff ff eb b0 e8 da 4a fb fd 0f 0b bb ea ff ff ff eb
RSP: 0018:ffffc90003cbedd8 EFLAGS: 00010293
RAX: ffffffff83903448 RBX: 0000000000010000 RCX: ffff88801929bb80
RDX: 0000000000000000 RSI: 0000000000010000 RDI: 0000000000001000
RBP: 1ffff1100fde111b R08: ffffffff83903012 R09: fffffbfff1cab9ae
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: ffff88807ef088d8 R14: 0000000000001000 R15: 0000000000000000
FS:  00007f807fad4700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9cf00c2723 CR3: 000000002b121000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_extract_ordered_extent+0x12c/0xb00 fs/btrfs/inode.c:2625
 btrfs_dio_submit_io+0x239/0x340 fs/btrfs/inode.c:7737
 iomap_dio_submit_bio fs/iomap/direct-io.c:75 [inline]
 iomap_dio_bio_iter+0xe15/0x1430 fs/iomap/direct-io.c:355
 __iomap_dio_rw+0x12c3/0x22e0 fs/iomap/direct-io.c:598
 btrfs_dio_write+0xb6/0x100 fs/btrfs/inode.c:7770
 btrfs_direct_write fs/btrfs/file.c:1529 [inline]
 btrfs_do_write_iter+0x870/0x1270 fs/btrfs/file.c:1674
 do_iter_write+0x7b1/0xcb0 fs/read_write.c:860
 iter_file_splice_write+0x843/0xfe0 fs/splice.c:795
 do_splice_from fs/splice.c:873 [inline]
 direct_splice_actor+0xe7/0x1c0 fs/splice.c:1039
 splice_direct_to_actor+0x4c4/0xbd0 fs/splice.c:994
 do_splice_direct+0x283/0x3d0 fs/splice.c:1082
 do_sendfile+0x620/0xff0 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8086f49329
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f807fad42f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f8086fd27b0 RCX: 00007f8086f49329
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000004
RBP: 00007f8086f9f1f4 R08: 00007f807fad4700 R09: 0000000000000000
R10: 0000000008800000 R11: 0000000000000246 R12: 6f63617461646f6e
R13: 70735f6473736f6e R14: 0030656c69662f2e R15: 00007f8086fd27b8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
