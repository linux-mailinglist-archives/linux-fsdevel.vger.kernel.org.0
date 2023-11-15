Return-Path: <linux-fsdevel+bounces-2922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827517ED593
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 22:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B638281376
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 21:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AC845BF0;
	Wed, 15 Nov 2023 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKM5LDsg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADB8B7;
	Wed, 15 Nov 2023 13:07:31 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c6b30aca06so978561fa.3;
        Wed, 15 Nov 2023 13:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700082449; x=1700687249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvwpMwO6HI2WfvadJARppQwZ/QUTldTSQZ/iy/GnHYs=;
        b=NKM5LDsgg0otD+GDQZ9SxmdHhpituod/XAvH5GbcoCXJb63QaWLyG5gt1omtfxHDZA
         cZdNzM708hOs8fsA57x20Z+F1C15CScWuOnJzEV8hqA/DMQzCmY9na45ACEH+kVh/3fl
         NUN7DO2dF4df1oMyJmri11WUh3ntlLWslScVxOOJfFWrXYxQui0cGiC1cYCp851TQM7C
         zOS6FIpO0oVBQqds0U8rFLb8gGGGNG0LGNPlxMDA0a8hQaS8dEO2XA9QJ7NBTqJrEAmm
         FBuQnUcibaE9uS5I2rcrq39XxRTHVIj+YLgQSk5auh1mr4mZfk2Bk7btIr3y8X3T6kWB
         s48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700082449; x=1700687249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvwpMwO6HI2WfvadJARppQwZ/QUTldTSQZ/iy/GnHYs=;
        b=fdWabm4GPLn/HWmP2XHOscXXDnvVqxIcDp6KNJL1/OlXZJk8XDL42cE/qVa8PRRz2B
         bvMrKL2gpVkie7p9srqLkzdCrTHl9kA8Jds+luK1w5g+nlWQcSsolNkX19lu5QWaM/IE
         Q8DQ5/rK+9wByjMNrELGZk5PItO2CHmhYKY7PrJjAKsztfES7/fbbjId24UxvmQV8MJF
         kZDbh/STZ75W7vbUXQQYnHV8tvCAmagGMU1cKQHBA2VV/V/sKTkwR490FgB8wAsF3dwt
         vfe+Xddqg6c66ib+TYEhGOFLiMihwMUmb2hoO9t2EQq8jadLqad/isfx7/288usgPyIq
         pHJA==
X-Gm-Message-State: AOJu0Yzcll43ndfuz6eDr40mT47DYJHmkQgRcAzz6EUm191Un8Qgqag0
	wlq0ZvgsamCMewoR0xTLD3aWrIk9sFuvbnmOgl8=
X-Google-Smtp-Source: AGHT+IGktgqjGpzpD9ZAZoeEz1QWvWxn7l3Wcp6CEEdcWaGSSkf/xEnqD4VnFvhLpbH6tPIReg75qb26j358eJFcHbY=
X-Received: by 2002:a2e:9b48:0:b0:2bc:c750:d9be with SMTP id
 o8-20020a2e9b48000000b002bcc750d9bemr5321914ljj.29.1700082449221; Wed, 15 Nov
 2023 13:07:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000773fa7060a31e2cc@google.com>
In-Reply-To: <000000000000773fa7060a31e2cc@google.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 15 Nov 2023 13:07:18 -0800
Message-ID: <CANaxB-yrvmv134dwTcMD9q5chXvm3YU1pDFhqvaRA8M1Gn7Guw@mail.gmail.com>
Subject: Re: [syzbot] [fs?] WARNING in pagemap_scan_pmd_entry
To: syzbot <syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com>, 
	Peter Xu <peterx@redhat.com>, Muhammad Usama Anjum <musamaanjum@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cc: Peter and Muhammad

On Wed, Nov 15, 2023 at 6:41=E2=80=AFAM syzbot
<syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c42d9eeef8e5 Merge tag 'hardening-v6.7-rc2' of git://git.=
k..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D13626650e8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D84217b7fc4acd=
c59
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De94c5aaf7890901=
ebf9b
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15d73be0e80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13670da8e8000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a595d90eb9af/dis=
k-c42d9eee.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c1e726fedb94/vmlinu=
x-c42d9eee.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/cb43ae262d09/b=
zImage-c42d9eee.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+e94c5aaf7890901ebf9b@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5071 at arch/x86/include/asm/pgtable.h:403 pte_uffd_=
wp arch/x86/include/asm/pgtable.h:403 [inline]
> WARNING: CPU: 1 PID: 5071 at arch/x86/include/asm/pgtable.h:403 pagemap_s=
can_pmd_entry+0x1d27/0x23f0 fs/proc/task_mmu.c:2146
> Modules linked in:
> CPU: 1 PID: 5071 Comm: syz-executor182 Not tainted 6.7.0-rc1-syzkaller-00=
019-gc42d9eeef8e5 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/10/2023
> RIP: 0010:pte_uffd_wp arch/x86/include/asm/pgtable.h:403 [inline]
> RIP: 0010:pagemap_scan_pmd_entry+0x1d27/0x23f0 fs/proc/task_mmu.c:2146
> Code: ff ff e8 5c 23 76 ff 48 89 e8 31 ff 83 e0 02 48 89 c6 48 89 04 24 e=
8 d8 1e 76 ff 48 8b 04 24 48 85 c0 74 25 e8 3a 23 76 ff 90 <0f> 0b 90 e9 71=
 ff ff ff 4c 89 74 24 68 4c 8b 74 24 10 c7 44 24 28
> RSP: 0018:ffffc9000392f870 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000020001000 RCX: ffffffff82116da8
> RDX: ffff88801aae8000 RSI: ffffffff82116db6 RDI: 0000000000000007
> RBP: 0000000012c7ac67 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000000002 R11: 0000000000000002 R12: dffffc0000000000
> R13: 0000000000000400 R14: 0000000000000000 R15: ffff8880745f4000
> FS:  00005555557a8380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000d60 CR3: 0000000074627000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  walk_pmd_range mm/pagewalk.c:143 [inline]
>  walk_pud_range mm/pagewalk.c:221 [inline]
>  walk_p4d_range mm/pagewalk.c:256 [inline]
>  walk_pgd_range+0xa48/0x1870 mm/pagewalk.c:293
>  __walk_page_range+0x630/0x770 mm/pagewalk.c:395
>  walk_page_range+0x626/0xa80 mm/pagewalk.c:521
>  do_pagemap_scan+0x40d/0xcd0 fs/proc/task_mmu.c:2437
>  do_pagemap_cmd+0x5e/0x80 fs/proc/task_mmu.c:2478
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:871 [inline]
>  __se_sys_ioctl fs/ioctl.c:857 [inline]
>  __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f9c3ea93669
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe1d95e918 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ffe1d95e920 RCX: 00007f9c3ea93669
> RDX: 0000000020000d40 RSI: 00000000c0606610 RDI: 0000000000000003
> RBP: 00007f9c3eb06610 R08: 65732f636f72702f R09: 65732f636f72702f
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffe1d95eb58 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

