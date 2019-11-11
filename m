Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 187A4F7F8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 20:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfKKTN1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 14:13:27 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41762 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfKKTN1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:13:27 -0500
Received: by mail-io1-f68.google.com with SMTP id r144so15792159iod.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 11:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/VuShNsnnLijV7FTC/n5bXISdKsCNAaXvgZUSZTI2M=;
        b=LJD0mvfv2cmwh1rKoSNdTEkyl/8Q60pawfFcL1Kw3tYIjHphsWJZb2VHREb0zO65uc
         hZvetOs6fqaX3107UfQ4zOYB7AaO45SnC7PkhUH4Kz31DyCORaPOy/9C6foVMLwO3D4p
         7nt8q35NszzZrsPBZ8zY+O1iykoiIXmVu6glWUVlsHKfTAhoBU+4nR8qgwsgvBK6FfcO
         LD+1TXFb6raocmGQk4b9Sh4KZObiELFVAoi4YgJ8I69l515pvcQGtQuRnIFnZlBpY8yP
         HBSP3doCHTYo2Vgd8uGO38qecy2wPBX/Z5xB5jfDRmFU9N290xmG7r5aVThn9dt8MaIY
         yHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/VuShNsnnLijV7FTC/n5bXISdKsCNAaXvgZUSZTI2M=;
        b=f/UBFFz0a/9j3LtiiEhEFn8PzE42ekcEOqrd2e2TPO3cRTBsFJ8PmVe41wsC9s85FM
         eHDFYW2TZDi3b3rYAtRJM4JRxXDLRIAqAjpYeVnZg06St+PeKbuJC/RMLVxmY78I6g7e
         JND6GUhguNnIbFASHBARzLDASnvaSm19TE+vF7tWsQsqDlbapw7AdkLgHE/drrq7XlTZ
         Kxtp7Nm8Ocdl+xLdYOIAMspWVb1Qv3eWp7vnaPmHCF1vbmBipi5itGjcwcX0xIvfTvoR
         Xu7TC0ZoaLFAiEfPkQn7n6gl7pOuCwBx0UwbkJCqqYOydODX/rWXOuvC0VTNHOUFyeoA
         YqIA==
X-Gm-Message-State: APjAAAU1C4kQg2D/nxqg+HTOu1PLEXZAU/g/g82GCJ8z6WtYL93Q8Ymu
        cx4QHgc8VVhgDArwvtZ75n3BFZ1a/tI5MLxxdeOXCg==
X-Google-Smtp-Source: APXvYqwYT2bnWA0uOOetpBpSlXqEyNb8DbeCdss54JdYY85ZOwBw8QacpCiJTlDrPqsRtQrjpsB4m/+bxWyN8bzIj2Y=
X-Received: by 2002:a05:6638:a27:: with SMTP id 7mr25838960jao.114.1573499604758;
 Mon, 11 Nov 2019 11:13:24 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
 <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
 <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com> <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com>
In-Reply-To: <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 11 Nov 2019 11:13:13 -0800
Message-ID: <CANn89i+x7Yxjxr4Fdaow-51-A-oBK3MqTscbQ4VXQuk4pX9aCg@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 11, 2019 at 11:01 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Nov 11, 2019 at 10:44 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > An interesting case is the race in ksys_write()
>
> Not really.
>
> > if (ppos) {
> >      pos = *ppos; // data-race
>
> That code uses "fdget_pos().
>
> Which does mutual exclusion _if_ the file is something we care about
> pos for, and if it has more than one process using it.
>
> Basically the rule there is that we don't care about the data race in
> certain circumstances. We don't care about non-regular files, for
> example, because those are what POSIX gives guarantees for.
>
> (We have since moved towards FMODE_STREAM handling instead of the
> older FMODE_ATOMIC_POS which does this better, and it's possible we
> should get rid of the FMODE_ATOMIC_POS behavior in favor of
> FMODE_STREAM entirely)
>
> Again, that's pretty hard to tell something like KCSAN.

Well, this is hard to explain to humans... Probably less than 10 on
this planet could tell that.

What about this other one, it looks like multiple threads can
manipulate tsk->min_flt++; at the same time  in faultin_page()

Should we not care, or should we mirror min_flt with a second
atomic_long_t, or simply convert min_flt to atomic_long_t ?

BUG: KCSAN: data-race in __get_user_pages / __get_user_pages

read to 0xffff8880b0b8f650 of 8 bytes by task 11553 on cpu 1:
 faultin_page mm/gup.c:653 [inline]
 __get_user_pages+0x78f/0x1160 mm/gup.c:845
 __get_user_pages_locked mm/gup.c:1023 [inline]
 get_user_pages_remote+0x206/0x3e0 mm/gup.c:1163
 process_vm_rw_single_vec mm/process_vm_access.c:109 [inline]
 process_vm_rw_core.isra.0+0x3a4/0x8c0 mm/process_vm_access.c:216
 process_vm_rw+0x1c4/0x1e0 mm/process_vm_access.c:284
 __do_sys_process_vm_writev mm/process_vm_access.c:306 [inline]
 __se_sys_process_vm_writev mm/process_vm_access.c:301 [inline]
 __x64_sys_process_vm_writev+0x8b/0xb0 mm/process_vm_access.c:301
 do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

write to 0xffff8880b0b8f650 of 8 bytes by task 11531 on cpu 0:
 faultin_page mm/gup.c:653 [inline]
 __get_user_pages+0x7b1/0x1160 mm/gup.c:845
 __get_user_pages_locked mm/gup.c:1023 [inline]
 get_user_pages_remote+0x206/0x3e0 mm/gup.c:1163
 process_vm_rw_single_vec mm/process_vm_access.c:109 [inline]
 process_vm_rw_core.isra.0+0x3a4/0x8c0 mm/process_vm_access.c:216
 process_vm_rw+0x1c4/0x1e0 mm/process_vm_access.c:284
 __do_sys_process_vm_writev mm/process_vm_access.c:306 [inline]
 __se_sys_process_vm_writev mm/process_vm_access.c:301 [inline]
 __x64_sys_process_vm_writev+0x8b/0xb0 mm/process_vm_access.c:301
 do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 11531 Comm: syz-executor.4 Not tainted 5.4.0-rc6+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/01/2011
