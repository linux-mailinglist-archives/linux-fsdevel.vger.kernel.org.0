Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D235113D68
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 09:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfLEI4m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 03:56:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34576 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbfLEI4l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 03:56:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so2509925wrr.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 00:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TG0HY+KpF4vMGkFbMLfrX7KldppQ0tPQ3SvG+kTPGWY=;
        b=ZibouDXjcM+vZN0ZC/B/P70jn4Yul92JKVsR7cd4AxKuXZYvG5CIfUJDGjUNlX02PF
         b+XtemH7+WabXVJtW2PNIk4y48F0lbc2k5BtDFXVIdx1d7eJiYKpnBCBewTO3wz+oXnK
         wSAAGf0SStUPH9uFJmkwnHvS/rLTtx20sdP/W0Ke2CdsEkG1Fp04alEIsG7wTD4fCDQK
         TALwa/E7UPPabJxbD4Iv+FEuu4VLfwj7W1iCKKyb5T8X6fn7Hp+csy0VhX+4ce3BC4HD
         5240WVfkWFzqPqANgSEURVuFUniRYQ2xnrRGFYHSO/gnAOk8DW6FfFkoa67Bkl7Ycy0i
         pGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TG0HY+KpF4vMGkFbMLfrX7KldppQ0tPQ3SvG+kTPGWY=;
        b=jPVhqol0VwzgbuI3HJNw60eUTsstyk/HZrCWDaG8KHAVprkolcax+EeYS8uxB4EiVN
         81Fkvw8ghEhmmRLt87tWUK6t1mZ7BKP3hwVPFZoxMS0YIB3cv3XmJLNiHSKLozcvWcrj
         MZR10oSdqmgjpO1CDaLFnyIvCgFtdhka75THaR0qHkNyhieTHl6J6PqjwLirh7+KkOWi
         nL5SerxjjCP00ot3Wz3uyAtJsnmsNuEFvL1tOB2cOR8D9RvTemHOpU+5KZI3Dfb/d3OD
         D887TlQwurk0jsgriPNmQhtsfElMyyj6pRN0zgmUty8rltNIH+uj3FoSdI45OwdHuYtt
         LFmQ==
X-Gm-Message-State: APjAAAVdAq1qXeuSI0YHmv8XalS4IjOAFfE+0VWl79FyywvjM2PmxOxo
        x3HgNm8rjxXUy7GgQwpH1G1+slEOi8qXQwPRAeX47w==
X-Google-Smtp-Source: APXvYqxngD+BCbp84mZSZGrVgY1rSc4U2mgNeiRcPsAthavnl8yoOdiboScqPBig7xAc2fRyFpHTL5MVA8Zt8bFZIfU=
X-Received: by 2002:adf:ef03:: with SMTP id e3mr9057850wro.216.1575536198468;
 Thu, 05 Dec 2019 00:56:38 -0800 (PST)
MIME-Version: 1.0
References: <0000000000008c72510598ee6ee7@google.com>
In-Reply-To: <0000000000008c72510598ee6ee7@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 5 Dec 2019 09:56:27 +0100
Message-ID: <CAG_fn=V=YbBXSAMYyTt3mtLyeZcMsrewOB6QPUdExQMSgkMjGg@mail.gmail.com>
Subject: Re: kmsan boot error: KMSAN: uninit-value in proc_task_name
To:     syzbot <syzbot+c0d17fd100b00692b701@syzkaller.appspotmail.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        bigeasy@linutronix.de, john.ogness@linutronix.de,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 5, 2019 at 6:45 AM syzbot
<syzbot+c0d17fd100b00692b701@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    818fcf71 Revert "kmsan: disable strscpy() optimization un=
d..
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D11b8bb7ae0000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfde150fb1e865=
232
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc0d17fd100b0069=
2b701
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit=
:
> Reported-by: syzbot+c0d17fd100b00692b701@syzkaller.appspotmail.com
#syz-fix: kmsan: disable strscpy() optimization under KMSAN

This is a false positive that was accidentally sent upstream.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in seq_commit include/linux/seq_file.h:89 [inlin=
e]
> BUG: KMSAN: uninit-value in proc_task_name+0x574/0x590 fs/proc/array.c:12=
1
> CPU: 1 PID: 5202 Comm: ps Not tainted 5.4.0-rc8-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1c9/0x220 lib/dump_stack.c:118
>   kmsan_report+0x128/0x220 mm/kmsan/kmsan_report.c:108
>   __msan_warning+0x57/0xa0 mm/kmsan/kmsan_instr.c:245
>   seq_commit include/linux/seq_file.h:89 [inline]
>   proc_task_name+0x574/0x590 fs/proc/array.c:121
>   do_task_stat+0x1a7b/0x3090 fs/proc/array.c:540
>   proc_tgid_stat+0xbe/0xf0 fs/proc/array.c:632
>   proc_single_show+0x1a8/0x2b0 fs/proc/base.c:756
>   seq_read+0xac6/0x1d90 fs/seq_file.c:229
>   __vfs_read+0x1a9/0xc90 fs/read_write.c:425
>   vfs_read+0x359/0x6f0 fs/read_write.c:461
>   ksys_read+0x265/0x430 fs/read_write.c:587
>   __do_sys_read fs/read_write.c:597 [inline]
>   __se_sys_read+0x92/0xb0 fs/read_write.c:595
>   __x64_sys_read+0x4a/0x70 fs/read_write.c:595
>   do_syscall_64+0xb6/0x160 arch/x86/entry/common.c:291
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7fd34fa40310
> Code: 73 01 c3 48 8b 0d 28 4b 2b 00 31 d2 48 29 c2 64 89 11 48 83 c8 ff e=
b
> ea 90 90 83 3d e5 a2 2b 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d 01 f0 ff
> ff 73 31 c3 48 83 ec 08 e8 6e 8a 01 00 48 89 04 24
> RSP: 002b:00007ffc157facf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007fd34fa40310
> RDX: 0000000000000fff RSI: 00007fd34ff0dd00 RDI: 0000000000000006
> RBP: 0000000000000fff R08: 0000000000000000 R09: 00007fd34fd08a10
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd34ff0dd00
> R13: 0000000001a59150 R14: 0000000000000005 R15: 0000000000000000
>
> Local variable description: ----tcomm@proc_task_name
> Variable was created at:
>   proc_task_name+0x8d/0x590 fs/proc/array.c:103
>   proc_task_name+0x8d/0x590 fs/proc/array.c:103
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
