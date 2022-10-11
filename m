Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44EA5FB0D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 12:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJKK5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 06:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJKK5h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 06:57:37 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36CB51416
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 03:57:35 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id 5-20020a5d9c05000000b006a44709a638so9069708ioe.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 03:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0qC+2Zxh/yll07tUtKXw60gt0zrPPh5YTAAcg0A6gA=;
        b=zV/a5uSOGFKzY21FyQKDcuowgtklyN3R5+3qrq56YPyG0awILauQ+vOqXlyrn54upx
         zMSU6Irtq2pF3MT+XUz4Y+/mO8irbsUSPbnC+e1aaPMoioDeUKvIwBDATrfsQa4kDagc
         0W/F43pISgZPuoVuwo6oA2AM/D3J8ajQYn1PRq7PYVRJaW6VXnxuCmSSWsBAmqmapoMe
         XrlNGbh2w5xebt72EpGGmi33QD1UHR2NmHRRuw+SAug+MTu4vmkpgy0OS4Xezn7NozHi
         I+Ucf4F0+BsORSb6MyJE88MCCN//gszInOrwu9paE0GjGLs7gXX3ko++xPA2zQGc3R9v
         5QWw==
X-Gm-Message-State: ACrzQf2eb4yyPv5CkYexnM9DygwMxsjaoO/+I1FzW1NGv7zEBoC9ocuY
        gFvgn/uiRZN7VGcwX/r14TveIIC6I/Zj0tumBvXU4saHQ/Zs
X-Google-Smtp-Source: AMsMyM42XSbaOltlhhS5aYpEKY/4hYmilYM9l0wRq1Hdq9TYyjcJLDCDQhQo+n2bNip7YPZhTvTuv9As8zlR3YkeIiWMFHlpc9DN
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ef0:b0:2f9:4403:8d28 with SMTP id
 j16-20020a056e020ef000b002f944038d28mr11317784ilk.193.1665485855384; Tue, 11
 Oct 2022 03:57:35 -0700 (PDT)
Date:   Tue, 11 Oct 2022 03:57:35 -0700
In-Reply-To: <000000000000c2ac0405eaa934f3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9e8a305eac02404@google.com>
Subject: Re: [syzbot] general protection fault in __d_add
From:   syzbot <syzbot+a8f26a403c169b7593fe@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=140066b2880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=a8f26a403c169b7593fe
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1269583a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d7c1a4880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1dad1b149d9c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a8f26a403c169b7593fe@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS' sector size (1024) and media sector size (512)
ntfs3: loop0: Mark volume as dirty due to NTFS errors
general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 3606 Comm: syz-executor276 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:d_flags_for_inode fs/dcache.c:1980 [inline]
RIP: 0010:__d_add+0x5ce/0x800 fs/dcache.c:2796
Code: 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 ea c0 ea ff 48 8b 1b 48 83 c3 08 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 c4 c0 ea ff 48 83 3b 00 0f 85 b7 01
RSP: 0018:ffffc90003cff870 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000008 RCX: dffffc0000000000
RDX: ffff88801c181d80 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff8880741270f2 R08: ffffffff81ef2679 R09: ffff888075bba128
R10: ffffed100eb77427 R11: 1ffff1100eb77425 R12: 0000000000000008
R13: 1ffff1100e824e1e R14: ffff888075bba000 R15: 0000000000000000
FS:  0000555557353300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff1887b000 CR3: 00000000730e1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 d_splice_alias+0x122/0x3b0 fs/dcache.c:3191
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x10e6/0x2df0 fs/namei.c:3688
 do_filp_open+0x264/0x4f0 fs/namei.c:3718
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_open fs/open.c:1334 [inline]
 __se_sys_open fs/open.c:1330 [inline]
 __x64_sys_open+0x221/0x270 fs/open.c:1330
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f651e934f79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff1887a418 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f651e934f79
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000080
RBP: 00007f651e8f4740 R08: 00005555573532c0 R09: 0000000000000000
R10: 00007fff1887a2e0 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000000 R14: 00030030454c4946 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:d_flags_for_inode fs/dcache.c:1980 [inline]
RIP: 0010:__d_add+0x5ce/0x800 fs/dcache.c:2796
Code: 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 ea c0 ea ff 48 8b 1b 48 83 c3 08 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 c4 c0 ea ff 48 83 3b 00 0f 85 b7 01
RSP: 0018:ffffc90003cff870 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000008 RCX: dffffc0000000000
RDX: ffff88801c181d80 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff8880741270f2 R08: ffffffff81ef2679 R09: ffff888075bba128
R10: ffffed100eb77427 R11: 1ffff1100eb77425 R12: 0000000000000008
R13: 1ffff1100e824e1e R14: ffff888075bba000 R15: 0000000000000000
FS:  0000555557353300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff1887b000 CR3: 00000000730e1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 4 bytes skipped:
   0:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
   4:	74 08                	je     0xe
   6:	48 89 df             	mov    %rbx,%rdi
   9:	e8 ea c0 ea ff       	callq  0xffeac0f8
   e:	48 8b 1b             	mov    (%rbx),%rbx
  11:	48 83 c3 08          	add    $0x8,%rbx
  15:	48 89 d8             	mov    %rbx,%rax
  18:	48 c1 e8 03          	shr    $0x3,%rax
  1c:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  23:	fc ff df
* 26:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2a:	74 08                	je     0x34
  2c:	48 89 df             	mov    %rbx,%rdi
  2f:	e8 c4 c0 ea ff       	callq  0xffeac0f8
  34:	48 83 3b 00          	cmpq   $0x0,(%rbx)
  38:	0f                   	.byte 0xf
  39:	85                   	.byte 0x85
  3a:	b7 01                	mov    $0x1,%bh

