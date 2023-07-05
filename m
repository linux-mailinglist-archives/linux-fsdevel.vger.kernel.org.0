Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504D9748830
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 17:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjGEPjK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 11:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjGEPjJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:39:09 -0400
Received: from mail-pf1-f208.google.com (mail-pf1-f208.google.com [209.85.210.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08EB171D
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jul 2023 08:39:07 -0700 (PDT)
Received: by mail-pf1-f208.google.com with SMTP id d2e1a72fcca58-682796bdb8bso4772382b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jul 2023 08:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688571547; x=1691163547;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AnlTnizGjQwa9uDAi28x6y7rFFNwIM+SsAIVOeqMxGE=;
        b=dXCArNsxY8G54rokgWEpIAtvCR4VbyGgDqc9qwG7CsAy1oiYfT9FojxAY1XTD3dxeA
         9hJCS0B6TxL3Y8OfiVRXy6mnWRayPcDjNs32hwrVLM4L95ScxNSIDVE9bG0q6K44IvWr
         bGZ1xszPdIE+KU6B/58l6btqywT/ZhxeANRhD3Wv3lULNv0gV1nC7di/Ymdap+XxWOi+
         7cmNN3n6496HjNqqUgyJKlAV2raXqhN17GOpjMxrmCK1Yuc5ukBLFndVsIf5SD4xOEfk
         sX9vmcd1wGDCTU5xTwsAkN+2RkWlow5XqhfGDqMCM7dVsg6pzJnoSTBT5Rh0dlQ9rDZj
         qPNg==
X-Gm-Message-State: ABy/qLY1YaoGdjRMmhYYHDJTqLSWl+b+9Xdh3mWeVyEHBKL7HNTsnVjc
        3E+GdvV30uzWLyDAOSduxGCwDz0NDqu/i54byq9PBs/uMi5P
X-Google-Smtp-Source: APBJJlHGGZ93My9g1gDTGDHXg2YW/iw8fyFkj2dS3FNQL8+aqjt1kP2mYJQXSZGu7Lxnpq5biML4Ap6t8OjY6z0ws/Q4ZAZ8PZEx
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1783:b0:668:69fa:f795 with SMTP id
 s3-20020a056a00178300b0066869faf795mr21021295pfg.2.1688571547278; Wed, 05 Jul
 2023 08:39:07 -0700 (PDT)
Date:   Wed, 05 Jul 2023 08:39:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040e14205ffbf333f@google.com>
Subject: [syzbot] [ntfs3?] WARNING in wnd_add_free_ext (2)
From:   syzbot <syzbot+5b2f934f08ab03d473ff@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
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

Hello,

syzbot found the following issue on:

HEAD commit:    d528014517f2 Revert ".gitignore: ignore *.cover and *.mbx"
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1785ad94a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d576750da57ebbb5
dashboard link: https://syzkaller.appspot.com/bug?extid=5b2f934f08ab03d473ff
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-d5280145.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/84fcf20c8c27/vmlinux-d5280145.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1ab1ac572337/bzImage-d5280145.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b2f934f08ab03d473ff@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 1577 at fs/ntfs3/bitmap.c:216 rb_insert_start fs/ntfs3/bitmap.c:216 [inline]
WARNING: CPU: 3 PID: 1577 at fs/ntfs3/bitmap.c:216 wnd_add_free_ext+0xd29/0x10e0 fs/ntfs3/bitmap.c:351
Modules linked in:
CPU: 3 PID: 1577 Comm: syz-executor.1 Not tainted 6.4.0-syzkaller-11478-gd528014517f2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:rb_insert_start fs/ntfs3/bitmap.c:216 [inline]
RIP: 0010:wnd_add_free_ext+0xd29/0x10e0 fs/ntfs3/bitmap.c:351
Code: c1 ea 03 80 3c 02 00 0f 85 3b 02 00 00 49 8d 85 e0 00 00 00 4d 89 b5 00 01 00 00 48 89 44 24 10 e9 b9 f9 ff ff e8 87 1a cf fe <0f> 0b e9 40 fd ff ff e8 7b 1a cf fe 48 8b 7c 24 10 e8 31 19 5b 07
RSP: 0018:ffffc900079bec10 EFLAGS: 00010216
RAX: 000000000003c404 RBX: 0000000000000000 RCX: ffffc90028037000
RDX: 0000000000040000 RSI: ffffffff82b5c4e9 RDI: 0000000000000006
RBP: ffff888029643ba0 R08: 0000000000000006 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff88804a80e1f0 R14: dffffc0000000000 R15: ffff888029643360
FS:  0000000000000000(0000) GS:ffff88802c900000(0063) knlGS:00000000f7f36b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000edbfe800 CR3: 0000000074033000 CR4: 0000000000352ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 wnd_zone_set+0x159/0x1b0 fs/ntfs3/bitmap.c:1419
 ntfs_look_for_free_space+0x479/0x740 fs/ntfs3/fsntfs.c:421
 attr_allocate_clusters+0x3ee/0x6e0 fs/ntfs3/attrib.c:159
 attr_set_size+0x1452/0x2ac0 fs/ntfs3/attrib.c:572
 ntfs_extend_mft+0x296/0x430 fs/ntfs3/fsntfs.c:526
 ntfs_look_free_mft+0x548/0xe60 fs/ntfs3/fsntfs.c:589
 ni_create_attr_list+0xbdd/0x12c0 fs/ntfs3/frecord.c:873
 ni_ins_attr_ext+0x3ca/0xba0 fs/ntfs3/frecord.c:968
 ni_insert_attr+0x3ea/0x850 fs/ntfs3/frecord.c:1135
 ni_insert_resident+0xd9/0x3a0 fs/ntfs3/frecord.c:1519
 ntfs_set_ea+0xa3b/0x1380 fs/ntfs3/xattr.c:433
 ntfs_save_wsl_perm+0x12b/0x3d0 fs/ntfs3/xattr.c:944
 ntfs3_setattr+0xa2b/0xc30 fs/ntfs3/file.c:708
 notify_change+0xb2c/0x1180 fs/attr.c:483
 chown_common+0x57f/0x650 fs/open.c:768
 do_fchownat+0x12a/0x1e0 fs/open.c:799
 ksys_lchown include/linux/syscalls.h:1342 [inline]
 __do_sys_lchown16 kernel/uid16.c:30 [inline]
 __se_sys_lchown16 kernel/uid16.c:28 [inline]
 __ia32_sys_lchown16+0xe3/0x110 kernel/uid16.c:28
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7f3b579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7f365cc EFLAGS: 00000296 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000020000140 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	retq
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
