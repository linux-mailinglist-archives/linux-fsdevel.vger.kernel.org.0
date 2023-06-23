Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFDC73BF5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jun 2023 22:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjFWUTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 16:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjFWUSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:18:53 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4701410D2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 13:18:51 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-77e3eaa1343so67379039f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 13:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687551530; x=1690143530;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTCEZ6avU993SuP7+FfOluMMZwAt+AbEtN50uBtijb4=;
        b=YEcKspn6J0vO9tNyi05LafjdHnPxjGHygBbvq/eYBHVTCuTLraXshQcVIGsCnZdvQD
         v+p9HirBPH9es8ysV/by8PZpsH5H4HWpxg1r55OC7bZ+OhrZUFK6+fLE1PdGqKsr6Q0w
         xmFJkYO/hES1oxivpUWGrXOFlJa0xkhv6wA0/kuRlABX4otgEltx36QEhC7UR7tt0VQM
         RXQLuT0W/0sxXv7OzVU5Enh/WGTAcHRPoW93MDk8LVNGZyWJrotWLza305zzocz6gF/p
         Hetx0C87bpDnngBW9jaO9ELkqcFB1aLa957eM2PnDajv1ko3Pj1NIB3TSSRerpjSX81v
         iPgQ==
X-Gm-Message-State: AC+VfDwjm7KTgCq3V1z2gZI+YH81Q11h6WM2Xb3Kh2RjyRRowP4f4XvB
        Vo9zgIPNrP8tTbcnp0eif0ROLRXwfQ2nVYdnqzwKJYpv0mzI
X-Google-Smtp-Source: ACHHUZ7MnU3fEHNaCiaC+rTxSzteDE/1T9Rw0ED/rHT786IEQPgBpxn3IzLTKdA/dtBp0puiJUlgumgE6vE2Da8OZp2Dgpe0bg4N
MIME-Version: 1.0
X-Received: by 2002:a02:8506:0:b0:422:ce09:bb7c with SMTP id
 g6-20020a028506000000b00422ce09bb7cmr8141088jai.4.1687551530594; Fri, 23 Jun
 2023 13:18:50 -0700 (PDT)
Date:   Fri, 23 Jun 2023 13:18:50 -0700
In-Reply-To: <000000000000a6229505fc213b06@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008577de05fed1b50b@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_relocate_block_group
From:   syzbot <syzbot+07a7e6273e07bda9ef8b@syzkaller.appspotmail.com>
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

HEAD commit:    8a28a0b6f1a1 Merge tag 'net-6.4-rc8' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1391b0e0a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=07a7e6273e07bda9ef8b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16243fdb280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1200bc77280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d02009a9822d/disk-8a28a0b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f33ad4ef1182/vmlinux-8a28a0b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f795a8ae7a8c/bzImage-8a28a0b6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ed54a18fab29/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+07a7e6273e07bda9ef8b@syzkaller.appspotmail.com

BTRFS info (device loop0): balance: start -d -m
BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5709 at fs/btrfs/relocation.c:4123 btrfs_relocate_block_group+0xaaa/0xe50 fs/btrfs/relocation.c:4123
Modules linked in:
CPU: 0 PID: 5709 Comm: syz-executor272 Not tainted 6.4.0-rc7-syzkaller-00194-g8a28a0b6f1a1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:btrfs_relocate_block_group+0xaaa/0xe50 fs/btrfs/relocation.c:4123
Code: 4c 89 ef e8 c8 38 59 fe e9 5d fe ff ff e8 5e 6b 06 fe 4c 89 f7 41 bc e6 ff ff ff e8 80 e4 0b 00 e9 11 f8 ff ff e8 46 6b 06 fe <0f> 0b e9 d7 fe ff ff e8 3a 6b 06 fe 0f 0b e9 90 fe ff ff e8 2e 6b
RSP: 0018:ffffc90005df7968 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000190000 RCX: 0000000000000000
RDX: ffff88807dfc5940 RSI: ffffffff837dde1a RDI: 0000000000000007
RBP: ffff888023904000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000190000 R11: 0000000000094001 R12: 0000000000000000
R13: ffff888015bd0000 R14: ffff88802cb88000 R15: ffff88802cb88000
FS:  00007fbbd1de1700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd3bb0ed028 CR3: 0000000016f19000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 btrfs_relocate_chunk+0x14a/0x440 fs/btrfs/volumes.c:3276
 __btrfs_balance fs/btrfs/volumes.c:4011 [inline]
 btrfs_balance+0x1e8f/0x40f0 fs/btrfs/volumes.c:4395
 btrfs_ioctl_balance fs/btrfs/ioctl.c:3599 [inline]
 btrfs_ioctl+0x12a6/0x5b30 fs/btrfs/ioctl.c:4632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbbd92586f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbbd1de12f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbbd92e37f0 RCX: 00007fbbd92586f9
RDX: 00000000200003c0 RSI: 00000000c4009420 RDI: 0000000000000005
RBP: 00007fbbd92af4cc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 61635f7261656c63 R14: 0100000000008001 R15: 00007fbbd92e37f8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
