Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D236658F854
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 09:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiHKH3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 03:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbiHKH3h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:29:37 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F18C923EC
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Aug 2022 00:29:35 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id w6-20020a056e021a6600b002dea6904708so11972876ilv.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Aug 2022 00:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=R8kRDpyv1KxLfdIZhodJDLBZ48C/DQoHZuuLF1/xG3w=;
        b=RSn7QOV/S1oiMcp4eGByiSh6Rnxpvqh3vqr1r5YEsnir1WcC/CJorico2g2KJbYFxB
         2kbZ+TMmYKl8Ok4Wf4DF861UxB8xrO+iKyBopmbN7hsy5Dr4Mqsg0bkfMECCZApwJXiW
         smyQ7qu4zH8Lr6LP4N4TqrNWQlAJbbhnw0Rb+RzXqYVTIzL71Av+MYwhZxhH8I50AbjC
         KUUX7qWwvw/M/BhKsrkg/XTKZDkkdmiKkbGhWIygsxSrErwbFXFF9qmCpdVEor0Fzuok
         d4fRXteOraz/CEVnFgjWR/Q6FAFD33qwPyPfaIgb5hpZkncUkDn+KomRyj2rE5MExCuY
         gvLA==
X-Gm-Message-State: ACgBeo3yQ01tE+gfvUAlxBGce/q1rsKTG4V0iT9WduWVS+l99J2Y/j2J
        cSgU+d2nUq62VXfcx63OVFqJ7FinfAgGZuMk4Zzp5zpa3aTT
X-Google-Smtp-Source: AA6agR7L1DUjhU6F02s7AAt5sji6PtqXhx0b5pUdphzTPinmukU0FSYeGyQ2f6yixWmrnIjWMVWbP6Oy0XOovVCZUMBtMwb4ke+B
MIME-Version: 1.0
X-Received: by 2002:a5d:8b8c:0:b0:67b:8779:753b with SMTP id
 p12-20020a5d8b8c000000b0067b8779753bmr12954415iol.57.1660202974446; Thu, 11
 Aug 2022 00:29:34 -0700 (PDT)
Date:   Thu, 11 Aug 2022 00:29:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c0ba505e5f22066@google.com>
Subject: [syzbot] linux-next boot error: BUG: unable to handle kernel paging
 request in kernel_execve
From:   syzbot <syzbot+3250d9c8925ef29e975f@syzkaller.appspotmail.com>
To:     ebiederm@xmission.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bc6c6584ffb2 Add linux-next specific files for 20220810
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=115034c3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5784be4315a4403b
dashboard link: https://syzkaller.appspot.com/bug?extid=3250d9c8925ef29e975f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3250d9c8925ef29e975f@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 1100 Comm: kworker/u4:5 Not tainted 5.19.0-next-20220810-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:strnlen+0x3b/0x70 lib/string.c:504
Code: 74 3c 48 bb 00 00 00 00 00 fc ff df 49 89 fc 48 89 f8 eb 09 48 83 c0 01 48 39 e8 74 1e 48 89 c2 48 89 c1 48 c1 ea 03 83 e1 07 <0f> b6 14 1a 38 ca 7f 04 84 d2 75 11 80 38 00 75 d9 4c 29 e0 48 83
RSP: 0000:ffffc90005c5fe10 EFLAGS: 00010246
RAX: ffff000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: 0000000000020000 RDI: ffff000000000000
RBP: ffff000000020000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000006 R11: 0000000000000000 R12: ffff000000000000
R13: ffff88814764cc00 R14: ffff000000000000 R15: ffff88814764cc00
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000000 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 strnlen include/linux/fortify-string.h:119 [inline]
 copy_string_kernel+0x26/0x250 fs/exec.c:616
 copy_strings_kernel+0xb3/0x190 fs/exec.c:655
 kernel_execve+0x377/0x500 fs/exec.c:1998
 call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
CR2: ffffdc0000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:strnlen+0x3b/0x70 lib/string.c:504
Code: 74 3c 48 bb 00 00 00 00 00 fc ff df 49 89 fc 48 89 f8 eb 09 48 83 c0 01 48 39 e8 74 1e 48 89 c2 48 89 c1 48 c1 ea 03 83 e1 07 <0f> b6 14 1a 38 ca 7f 04 84 d2 75 11 80 38 00 75 d9 4c 29 e0 48 83
RSP: 0000:ffffc90005c5fe10 EFLAGS: 00010246
RAX: ffff000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: 0000000000020000 RDI: ffff000000000000
RBP: ffff000000020000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000006 R11: 0000000000000000 R12: ffff000000000000
R13: ffff88814764cc00 R14: ffff000000000000 R15: ffff88814764cc00
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000000 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	74 3c                	je     0x3e
   2:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
   9:	fc ff df
   c:	49 89 fc             	mov    %rdi,%r12
   f:	48 89 f8             	mov    %rdi,%rax
  12:	eb 09                	jmp    0x1d
  14:	48 83 c0 01          	add    $0x1,%rax
  18:	48 39 e8             	cmp    %rbp,%rax
  1b:	74 1e                	je     0x3b
  1d:	48 89 c2             	mov    %rax,%rdx
  20:	48 89 c1             	mov    %rax,%rcx
  23:	48 c1 ea 03          	shr    $0x3,%rdx
  27:	83 e1 07             	and    $0x7,%ecx
* 2a:	0f b6 14 1a          	movzbl (%rdx,%rbx,1),%edx <-- trapping instruction
  2e:	38 ca                	cmp    %cl,%dl
  30:	7f 04                	jg     0x36
  32:	84 d2                	test   %dl,%dl
  34:	75 11                	jne    0x47
  36:	80 38 00             	cmpb   $0x0,(%rax)
  39:	75 d9                	jne    0x14
  3b:	4c 29 e0             	sub    %r12,%rax
  3e:	48                   	rex.W
  3f:	83                   	.byte 0x83


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
