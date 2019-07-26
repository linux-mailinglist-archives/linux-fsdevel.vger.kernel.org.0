Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF9276076
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 10:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbfGZIMH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 04:12:07 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36390 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZIMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:12:06 -0400
Received: by mail-yb1-f195.google.com with SMTP id d9so12928163ybf.3;
        Fri, 26 Jul 2019 01:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vmBpjNDhJwUDOB0lGmNRoTPfd43L0Sn4ODcKKKUbOmM=;
        b=mIALu21ZBeMXuckck4xlGcqV9AA5UQ4bsUW7TTl4SJTo7Z95P3nxecL1tpeK8LkKpQ
         XkEglqpnOkS8WsdxKo0LoFuq9wNGDmaXYUUoO858XFBkFdLuu2rQ1uTYqEIUEOTIdcGh
         rb3fJPBFd0ZLNN38fLZEPgTBuaUeLeHUXj+dH+87bdKzttkdn9/GwX3qqwNT8wr8Blax
         5ASCuJLfXaQuDrvqHMNS0ve4I5rZx6wzJg9qKLX0DSUTPiBnMQrlDIUT1T35ewlOpNhH
         2iHxu/7QscjUkvwiEuWK2PeGC8YZQF46Ef7VDsh3lsmE/epticltMbQDARWic8ribhVD
         ZHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vmBpjNDhJwUDOB0lGmNRoTPfd43L0Sn4ODcKKKUbOmM=;
        b=Q7aAZa/VukAzvUEQpQzfbFdf3Y6eO/4HAL7/FlHvdYZs5VjH+urhSWxihmqp73DnVC
         J9bMspgImd+Wk6g3EHsN+fJnzYUFoAE8vFmlutflwfdyja5rJkwPoWZJZwZrX+6Ai1uu
         AuTJoWJ3gGLQkWc9Wic4/eg9MqYF+YytoXouBW3F7VFyYIAxWgT0G2v2qFDgqNWcY0Ia
         c1l3/BveJIxbOyK41PqNZONHm+Oe3EiFIMt5i9il3BDBkg/ECNCGdewab9i+pBk/R66r
         dcgugr3Ql9wsd/E0MnnMJwAhmnbRwgSi4qpCdGdIFYrGu/fa11f4dCqaFHbPR0ntDn8R
         c9XA==
X-Gm-Message-State: APjAAAUCcc6jnyV9JClcekewhgladQC/DV0lTvguwY92If0jOhJx4Cch
        eZKYZGzMsCtIZC9R+XIYKzUxJh1QVGBiGaBmdYg=
X-Google-Smtp-Source: APXvYqztY8eFq1kaRFQkHIwcfLnV6ZCxgmid8Dna5//7nQoy5ay57jl3phP+eytBDrll6njHguTUS152WRnfUKBvdEo=
X-Received: by 2002:a25:c486:: with SMTP id u128mr57822964ybf.428.1564128725840;
 Fri, 26 Jul 2019 01:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004a3a63058e722b94@google.com> <00000000000086c732058e79cb59@google.com>
In-Reply-To: <00000000000086c732058e79cb59@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 26 Jul 2019 11:11:54 +0300
Message-ID: <CAOQ4uxhAi6sqBR2219ZvzX7izeF_RezN+VKRrHiQ04P=t0uiOg@mail.gmail.com>
Subject: Re: WARNING in ovl_real_fdget_meta
To:     syzbot <syzbot+032bc63605089a199d30@syzkaller.appspotmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 25, 2019 at 7:24 AM syzbot
<syzbot+032bc63605089a199d30@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 387e3746d01c34457d6a73688acd90428725070b
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Fri Jun 7 14:24:38 2019 +0000
>
>      locks: eliminate false positive conflicts for write lease
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a79594600000
> start commit:   c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=17a79594600000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13a79594600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3c8985c08e1f9727
> dashboard link: https://syzkaller.appspot.com/bug?extid=032bc63605089a199d30
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15855334600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fcc4c8600000
>
> Reported-by: syzbot+032bc63605089a199d30@syzkaller.appspotmail.com
> Fixes: 387e3746d01c ("locks: eliminate false positive conflicts for write
> lease")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

The repro:
#{"repeat":true,"procs":1,"sandbox":"none","fault_call":-1,"cgroups":true,"close_fds":true,"tmpdir":true}
mkdir(&(0x7f0000000100)='./file0\x00', 0x0)
mkdirat$cgroup_root(0xffffffffffffff9c,
&(0x7f0000000000)='./cgroup.net/syz1\x00', 0x1ff)
mount$fuse(0x20000000, &(0x7f0000000140)='./file0\x00', 0x0, 0x1004, 0x0)
mount$overlay(0x400000, &(0x7f0000000100)='./file0\x00',
&(0x7f00000001c0)='overlay\x00', 0x0,
&(0x7f0000000040)=ANY=[@ANYBLOB=',lowerdir=.:file0'])
r0 = open(&(0x7f0000000500)='./file0\x00', 0x0, 0x0)
r1 = openat$cgroup_procs(r0, &(0x7f00000004c0)='cgroup.procs\x00', 0x48, 0x0)
dup3(r1, r0, 0x0)
fcntl$setlease(r0, 0x400, 0x1)
lseek(r0, 0x4, 0x0)

I though we would stop these family of overlapping layers fuzzers with:
146d62e5a586 ("ovl: detect overlapping layers")

But syzbot got the upper hand, because we do not check for overlapping layers
that cross fs boundary. Not sure if we should (?).

./ is a tmpfs dir and ./file0/ is some kind of fuse mount (?)
then after one cycle, ./file0/ itself is an overlapping overlay mount
(lowerdir=./:./file0/)
and after another cycle, ./file0/ is a nested overlapping overlayfs mount.
Fine. Whatever.

What I don't understand is if dup3 succeeds r0 should not be an overlayfs fd
and even if dup3 fails r0 should be an overlayfs directory fd (./file0/), so how
the hell did we get to ovl_llseek => ... ovl_change_flags() with this repro??

There is not a single regular file in this test.

Thanks,
Amir.
