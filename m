Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155056DD639
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 11:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjDKJHN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 05:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjDKJGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:06:52 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECA14C2C
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 02:05:41 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id a3-20020a92c543000000b0032651795968so19939488ilj.19
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 02:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681203941; x=1683795941;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y7OruruCyWaSan793MP3isUIe/2SK0TYeCu2Yy1zYas=;
        b=BkW5Uhtns6ij9Gfi1AwHkEjvK4sHTmKkGDZBaIvHHhqK3zvqzS6YynWSfP7EQPPk22
         EyS40MLBGT3tcdU1BIHtb9cgZa+odzU+n3574UIvVporhOstPgTWX8WEf3xc0GbingYk
         7T7zwOpeR88/qcgoVHAvXOgFmvpQxYZ8kEChGcK+2cZH5/mH1m5onGya94YCc4gSL/sx
         +KXyPsvrn8tEHOvZFcLlH89YYVF0nIw/zfdTPQaJ3qf3ClK8rUbubpm5ua2UiV1hQAEf
         zEl/Kp3/hK9RnqLWiSvGmzgaBdZUxkeaijePwZfhJX3CKggA+hVoTt71iPHkd/lJbQNm
         qg3w==
X-Gm-Message-State: AAQBX9dV6lh9145LKCz/xph93T4d9WxONrrSRMjKeREGDE0h6lLxtC6L
        pOnYCQ7WaiW8Hxa3ZfNxV0L19S/YSAuTjlaEV8Xm/2iylsly
X-Google-Smtp-Source: AKy350a3iundpBJrZ2/usBcSc4917ckQNlHlUflX+OekSLp/owPyj/xHnaeA+4ffXREVRfSpRS8TuzDyG1nQTKetvEEMFkXbfovY
MIME-Version: 1.0
X-Received: by 2002:a02:b1d9:0:b0:3a9:5ec2:ef41 with SMTP id
 u25-20020a02b1d9000000b003a95ec2ef41mr657115jah.3.1681203940869; Tue, 11 Apr
 2023 02:05:40 -0700 (PDT)
Date:   Tue, 11 Apr 2023 02:05:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0cabf05f90bcb15@google.com>
Subject: [syzbot] [ntfs3?] general protection fault in ni_readpage_cmpr
From:   syzbot <syzbot+af224b63e76b2d869bc3@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    aa318c48808c Merge tag 'gpio-fixes-for-v6.3-rc6' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10496611c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=adfc55aec6afccdd
dashboard link: https://syzkaller.appspot.com/bug?extid=af224b63e76b2d869bc3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f2cda6aed35/disk-aa318c48.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b3abc5d6e123/vmlinux-aa318c48.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5e21f7b0c192/bzImage-aa318c48.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+af224b63e76b2d869bc3@syzkaller.appspotmail.com

RBP: 00007f5102ac71d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0001000000201005 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd8c6b1d4f R14: 00007f5102ac7300 R15: 0000000000022000
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 21645 Comm: syz-executor.1 Not tainted 6.3.0-rc5-syzkaller-00153-gaa318c48808c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
RIP: 0010:_compound_head include/linux/page-flags.h:251 [inline]
RIP: 0010:unlock_page+0x25/0x130 mm/folio-compat.c:21
Code: 00 00 00 00 00 f3 0f 1e fa 41 54 55 48 89 fd 53 e8 c0 24 d2 ff 48 8d 7d 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 e4 00 00 00 4c 8b 65 08 31 ff 4c 89 e3 83 e3 01
RSP: 0018:ffffc900047e7520 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000008 RCX: ffffc90003b51000
RDX: 0000000000000001 RSI: ffffffff81afd3b0 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88801e052988 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f5102ac7700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5102ac8000 CR3: 000000007c8da000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ni_readpage_cmpr+0x44a/0xcd0 fs/ntfs3/frecord.c:2149
 ntfs_read_folio+0x101/0x1e0 fs/ntfs3/inode.c:703
 filemap_read_folio+0xdb/0x2c0 mm/filemap.c:2424
 filemap_create_folio mm/filemap.c:2552 [inline]
 filemap_get_pages+0x42a/0x1620 mm/filemap.c:2605
 filemap_read+0x35e/0xc70 mm/filemap.c:2693
 generic_file_read_iter+0x3ad/0x5b0 mm/filemap.c:2840
 ntfs_file_read_iter+0x1b8/0x270 fs/ntfs3/file.c:758
 call_read_iter include/linux/fs.h:1845 [inline]
 generic_file_splice_read+0x182/0x4b0 fs/splice.c:402
 do_splice_to+0x1b9/0x240 fs/splice.c:885
 splice_direct_to_actor+0x2ab/0x8a0 fs/splice.c:956
 do_splice_direct+0x1ab/0x280 fs/splice.c:1065
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5101c8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5102ac7168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f5101dabf80 RCX: 00007f5101c8c169
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00007f5102ac71d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0001000000201005 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd8c6b1d4f R14: 00007f5102ac7300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:_compound_head include/linux/page-flags.h:251 [inline]
RIP: 0010:unlock_page+0x25/0x130 mm/folio-compat.c:21
Code: 00 00 00 00 00 f3 0f 1e fa 41 54 55 48 89 fd 53 e8 c0 24 d2 ff 48 8d 7d 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 e4 00 00 00 4c 8b 65 08 31 ff 4c 89 e3 83 e3 01
RSP: 0018:ffffc900047e7520 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000008 RCX: ffffc90003b51000
RDX: 0000000000000001 RSI: ffffffff81afd3b0 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88801e052988 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f5102ac7700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5102ac8000 CR3: 000000007c8da000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	00 f3                	add    %dh,%bl
   6:	0f 1e fa             	nop    %edx
   9:	41 54                	push   %r12
   b:	55                   	push   %rbp
   c:	48 89 fd             	mov    %rdi,%rbp
   f:	53                   	push   %rbx
  10:	e8 c0 24 d2 ff       	callq  0xffd224d5
  15:	48 8d 7d 08          	lea    0x8(%rbp),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 e4 00 00 00    	jne    0x118
  34:	4c 8b 65 08          	mov    0x8(%rbp),%r12
  38:	31 ff                	xor    %edi,%edi
  3a:	4c 89 e3             	mov    %r12,%rbx
  3d:	83 e3 01             	and    $0x1,%ebx


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
