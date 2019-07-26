Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03F3B76321
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 12:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfGZKHC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 06:07:02 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40440 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfGZKHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:07:01 -0400
Received: by mail-yb1-f195.google.com with SMTP id j6so10911233ybm.7;
        Fri, 26 Jul 2019 03:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+L/PTQ5WefhhdGJICPJZTWREq0FzbcuJty7GGMjdHkY=;
        b=VCSujiP21xYdy1ahpgC2+dtBp0wr/0BcqKSe0AyyDa7PJ/965UyFMFXClC2mfLFgdh
         7eP6Oa/iHbhqLOKFabXsBfbS9JYT/Zl6e678J4G04tv0S2jALsqqDqr/cob7t+YQHVKp
         eJXA4h4Ytfwc+lTDzl8cmEUcKkjRLBon17tBkbFNpvpBRzzdVqhT4OlmtlhrgnzlFdIm
         jgh/vl20N+VXetQSRMzcutCOjSJL3LJFqC8i1Hg+rm9YQiwU2viX7FLxsMGryPYwQQ8j
         9P9Pvqs0setZ1hmzfdXqM/4gv7XXVG5FHIiLOLepvtgMkKzG5ROyBvZ/1qpZSaANLir/
         58Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+L/PTQ5WefhhdGJICPJZTWREq0FzbcuJty7GGMjdHkY=;
        b=HW7W4MzEvCgnB3ZN+hRHBiQnedctpiiyFxvJY6JbcXhxAp7xyrJt9YO2R8Mz/avxg2
         RF0JOfK+VLe/Wru9psmbK3MuLcA6eepaCAwJphScXg4aupyNrjYZEbqk18Vd8AqoADaM
         ++LAcfS1TogDedFr9VF0JRLfrEsrMpnR2LQiCob5HCvV3Iv8MY+37dZjPxun7WE4v2F+
         PkM1qyi5nsmgSvKbTMfjvV+STi0ByFzNOdLn2ANjenG00vGBbgHORWPTwMXepIwbDhHL
         S8lD7Fz/RWRt87+xht7dfZaupaCuMYp6rfoj6gx2QKBQbtHhoHMu5MZkZG4Z6IJ8zSMN
         ph4Q==
X-Gm-Message-State: APjAAAXIBaRjttCm4HoN+vk6fxg31aVu8yC+ESCd6j9sMSsScVOC6iYS
        0zyGnBB39fizKeiawlzyBi+tTlxQb5I625iVyQM=
X-Google-Smtp-Source: APXvYqwtGACaDY+AapAm+Wv/BOPD5Rnehn08Yr74B0c+I+jtRM5nQVUAvFIqqMFPNG69TtvPmBICsA0wdkx6WsfhCNA=
X-Received: by 2002:a25:7683:: with SMTP id r125mr56699420ybc.144.1564135620396;
 Fri, 26 Jul 2019 03:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004a3a63058e722b94@google.com> <00000000000086c732058e79cb59@google.com>
 <CAOQ4uxhAi6sqBR2219ZvzX7izeF_RezN+VKRrHiQ04P=t0uiOg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhAi6sqBR2219ZvzX7izeF_RezN+VKRrHiQ04P=t0uiOg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 26 Jul 2019 13:06:48 +0300
Message-ID: <CAOQ4uxhRWzjY=RcgFtFZL4VUg7Y8EyRa2eaWuqtVOHDZWWO1PQ@mail.gmail.com>
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

On Fri, Jul 26, 2019 at 11:11 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Jul 25, 2019 at 7:24 AM syzbot
> <syzbot+032bc63605089a199d30@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this bug to:
> >
> > commit 387e3746d01c34457d6a73688acd90428725070b
> > Author: Amir Goldstein <amir73il@gmail.com>
> > Date:   Fri Jun 7 14:24:38 2019 +0000
> >
> >      locks: eliminate false positive conflicts for write lease
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a79594600000
> > start commit:   c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=17a79594600000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13a79594600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3c8985c08e1f9727
> > dashboard link: https://syzkaller.appspot.com/bug?extid=032bc63605089a199d30
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15855334600000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fcc4c8600000
> >
> > Reported-by: syzbot+032bc63605089a199d30@syzkaller.appspotmail.com
> > Fixes: 387e3746d01c ("locks: eliminate false positive conflicts for write
> > lease")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> The repro:
> #{"repeat":true,"procs":1,"sandbox":"none","fault_call":-1,"cgroups":true,"close_fds":true,"tmpdir":true}
> mkdir(&(0x7f0000000100)='./file0\x00', 0x0)
> mkdirat$cgroup_root(0xffffffffffffff9c,
> &(0x7f0000000000)='./cgroup.net/syz1\x00', 0x1ff)
> mount$fuse(0x20000000, &(0x7f0000000140)='./file0\x00', 0x0, 0x1004, 0x0)
> mount$overlay(0x400000, &(0x7f0000000100)='./file0\x00',
> &(0x7f00000001c0)='overlay\x00', 0x0,
> &(0x7f0000000040)=ANY=[@ANYBLOB=',lowerdir=.:file0'])
> r0 = open(&(0x7f0000000500)='./file0\x00', 0x0, 0x0)
> r1 = openat$cgroup_procs(r0, &(0x7f00000004c0)='cgroup.procs\x00', 0x48, 0x0)
> dup3(r1, r0, 0x0)
> fcntl$setlease(r0, 0x400, 0x1)
> lseek(r0, 0x4, 0x0)
>
> I though we would stop these family of overlapping layers fuzzers with:
> 146d62e5a586 ("ovl: detect overlapping layers")
>
> But syzbot got the upper hand, because we do not check for overlapping layers
> that cross fs boundary. Not sure if we should (?).

No, we shouldn't care about that.
overlayfs doesn't follow cross-fs in underlying layers.

>
> ./ is a tmpfs dir and ./file0/ is some kind of fuse mount (?)
> then after one cycle, ./file0/ itself is an overlapping overlay mount
> (lowerdir=./:./file0/)
> and after another cycle, ./file0/ is a nested overlapping overlayfs mount.
> Fine. Whatever.

But damage can still be created if a lower overlayfs layer
overlaps with the another nested overlay lower underlying layer.
It actually shouldn't be too hard to add a guard also on the
nested overlay lower underlying layer inode.

>
> What I don't understand is if dup3 succeeds r0 should not be an overlayfs fd
> and even if dup3 fails r0 should be an overlayfs directory fd (./file0/), so how
> the hell did we get to ovl_llseek => ... ovl_change_flags() with this repro??
>
> There is not a single regular file in this test.
>

I was wrong here of course.
./file0/cgroup.procs is a regular overlayfs file (I was confused by the name)
which is later also exposed at ./file0/file0/cgroup.procs in the nested
overlay mount.

Still not sure about the rest of the way to ovl_change_flags() failure,
but I think I'll try to block this new syzbot overlap attack.

Thanks,
Amir.
