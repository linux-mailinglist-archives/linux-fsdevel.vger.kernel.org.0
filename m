Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2BD6FE82A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 01:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbjEJXnC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 19:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbjEJXnB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 19:43:01 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E75272A
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 16:42:59 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-331828cdc2dso52224845ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 16:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683762178; x=1686354178;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJ2CjbqO9Wez5R1+ZFtUTiE12GfQcm0Zdhi4kchA1wg=;
        b=ejZ1shecNEFFCAGqGxB7XEpjlLYmmuJ6DbxrhPEywX+r/LDYpT/a+9RIEj/9U3321p
         s6hMcPBc3CX7IEZAsncsCC2MARmCyG4y7PD8b1zbVwISS8DX4edhGhKBPgj4CQ+oRTqk
         f216LBXHMeDomspzk7/Ph/tDXI3iRAwMuz0dCqK9yNKi2G5t82Bqh6y24j198c3GbhT1
         /fik6G5c3ZQ0FhGYv0cdolUaTg1RH0yzYXzt/IrcYXVhVBdeCZGDx0cj9sWpruXV6FoE
         ZBRLMDfD/Q1KnDTFqco+OEjdW5tk1vQgRVdfHhU5Bke/KDcr2HJhuKt4A9MAFvObtAIJ
         YwYQ==
X-Gm-Message-State: AC+VfDxe0MsAS3DPjGeVkjafSiJSEIvsl/HZnfGvSZI93VROCOeIF1Ss
        u5dS1vUer0/0ASsuWNk0CupJ/puM4LGV+BUswdpPqhDUigsk
X-Google-Smtp-Source: ACHHUZ5LNoilAFvV3sFHQlHsVmf0YatUr2a6Qpv/JMq7Frzzno5x2oH7xX908WD+ruJvnzypjCg8md7r8F67qpllhYF2KtTW+xsj
MIME-Version: 1.0
X-Received: by 2002:a92:6b01:0:b0:335:7a0a:3cbd with SMTP id
 g1-20020a926b01000000b003357a0a3cbdmr4726911ilc.3.1683762178707; Wed, 10 May
 2023 16:42:58 -0700 (PDT)
Date:   Wed, 10 May 2023 16:42:58 -0700
In-Reply-To: <0000000000009b5b5705fb5dfda0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c5bed05fb5f6e00@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in __ext4fs_dirhash
From:   syzbot <syzbot+344aaa8697ebd232bfc8@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    578215f3e21c Add linux-next specific files for 20230510
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15d567ea280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb5a64fc61c29c5f
dashboard link: https://syzkaller.appspot.com/bug?extid=344aaa8697ebd232bfc8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b80e32280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=113f582a280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/61ae2512b5cb/disk-578215f3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e16190a5b183/vmlinux-578215f3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/04000a0b9ddf/bzImage-578215f3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/dbdccddcf7e8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+344aaa8697ebd232bfc8@syzkaller.appspotmail.com

EXT4-fs error (device loop0): ext4_orphan_get:1397: comm syz-executor380: couldn't read orphan inode 15 (err -117)
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: writeback.
EXT4-fs warning (device loop0): __ext4fs_dirhash:281: invalid/unsupported hash tree version 135
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5007 at fs/ext4/hash.c:284 __ext4fs_dirhash+0xa34/0xb40 fs/ext4/hash.c:281
Modules linked in:
CPU: 0 PID: 5007 Comm: syz-executor380 Not tainted 6.4.0-rc1-next-20230510-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:__ext4fs_dirhash+0xa34/0xb40 fs/ext4/hash.c:284
Code: 00 0f 85 16 01 00 00 48 8b 04 24 41 89 d8 48 c7 c1 60 d2 62 8a ba 19 01 00 00 48 c7 c6 80 d3 62 8a 48 8b 78 28 e8 9c 7a 12 00 <0f> 0b 41 bc ea ff ff ff e9 2a fd ff ff e8 aa 94 5a ff 8b 9c 24 88
RSP: 0018:ffffc900039cf768 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000087 RCX: 0000000000000000
RDX: ffff88801ed61dc0 RSI: ffffffff823bfd38 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: 000000005948191c
R13: 0000000000000001 R14: dffffc0000000000 R15: ffff88807c0ba0c4
FS:  00005555571d4300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ede0 CR3: 0000000073ff4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4fs_dirhash+0x13e/0x2e0 fs/ext4/hash.c:323
 htree_dirblock_to_tree+0x81e/0xc90 fs/ext4/namei.c:1122
 ext4_htree_fill_tree+0x327/0xc40 fs/ext4/namei.c:1217
 ext4_dx_readdir fs/ext4/dir.c:597 [inline]
 ext4_readdir+0x1d18/0x35f0 fs/ext4/dir.c:142
 iterate_dir+0x56e/0x6f0 fs/readdir.c:65
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64 fs/readdir.c:354 [inline]
 __x64_sys_getdents64+0x13e/0x2c0 fs/readdir.c:354
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f74ba642749
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff0b1f4e88 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f74ba642749
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f74ba602010 R08: 000000000000044b R09: 0000000000000000
R10: 00007fff0b1f4d40 R11: 0000000000000246 R12: 00007f74ba6020a0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
