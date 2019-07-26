Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D458676F29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 18:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfGZQbq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 12:31:46 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44632 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbfGZQbq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:31:46 -0400
Received: by mail-yw1-f66.google.com with SMTP id l79so20507631ywe.11;
        Fri, 26 Jul 2019 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z0sxhqsLtrLqL5nO6S6ZuBF359LlUdJOnMzgT01lnW8=;
        b=f3ceHyXwvFBmRmD62TXyO/zGUI8cPi3pY3YE82VSSX50q+WVfSaqeKzbTcPnurD4QW
         uAAsA9IpyG1m/u+SQirHr9Bq+kSDcDW25WQQXfQigBtJQ/8ByxTomFxhrW9Qn9l9wJPo
         GeZQENTtOY28dpc0/gBXgkMzQwLvgqx1+1fZZqx2L5kOLlcRwsB9JY7fEVkurO1SlVvz
         hrFgepqDKMnbPnGT7OVOfHQCl/Mc+gKfhadlhOSoqZ6EUAlz8tow7tPQYYKHUxEmm7hs
         LndLLn9bmlfDxE8TIDJlRXV4d/YUZobeuZeuRq3uChq15MNLQ5gE0RvHboH9fNkr1vv0
         r54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0sxhqsLtrLqL5nO6S6ZuBF359LlUdJOnMzgT01lnW8=;
        b=V4aDOIE3J6hs+3g+G5kO6rpr8ujYlYERDhOCFXEmkNkSXmDJ5TN9WEHfzc9ojLrnoR
         UsCpZBM7bDDQJG74rcR46rht7U1hIXDwkRBHLd6qkRxiLKxNDw1T/UCTZGJiPYCke3c9
         E7/FJjTJN/veBQsnex/HrIvubdRgezxRX7vLXggVPhwxmGH2HEiGty6rMwDsssFqbjVa
         rERblUlTUliGVwTh7gmxfyu04+/ziBgtbJllMw9DMChxnG7P5KxSvdAcCrrui0fRkDpo
         lfAMSwd8CBq92rYun6XoQC8mxT52Tc8Vt5ASxBHsk+wOsuUf752k38mAJuLkJhj+6W+I
         aPpQ==
X-Gm-Message-State: APjAAAUOUH3kEgS0W6GPrubCYQMLD9A0laaarZKURo+5EtTywP/yJUCD
        8PbRnYHhuroHYrTZTDW5obJGpnoB/lwizuVsmvc=
X-Google-Smtp-Source: APXvYqwaU9ADwfRQsmwTfz+0RuMQLZIJ+JrrpflGJmMw3xCWYowUHSxrXqWNIv8OG/ROp1Uyuv+fsK8O1vzccRFe2JA=
X-Received: by 2002:a81:13d4:: with SMTP id 203mr58331909ywt.181.1564158705661;
 Fri, 26 Jul 2019 09:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004a3a63058e722b94@google.com> <00000000000086c732058e79cb59@google.com>
 <CAOQ4uxhAi6sqBR2219ZvzX7izeF_RezN+VKRrHiQ04P=t0uiOg@mail.gmail.com> <CAOQ4uxhRWzjY=RcgFtFZL4VUg7Y8EyRa2eaWuqtVOHDZWWO1PQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhRWzjY=RcgFtFZL4VUg7Y8EyRa2eaWuqtVOHDZWWO1PQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 26 Jul 2019 19:31:34 +0300
Message-ID: <CAOQ4uxi1w0uJkJzJOMQgeoQXZ0aQqYpwSLyQQmB779DjdY3D_Q@mail.gmail.com>
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

On Fri, Jul 26, 2019 at 1:06 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, Jul 26, 2019 at 11:11 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Thu, Jul 25, 2019 at 7:24 AM syzbot
> > <syzbot+032bc63605089a199d30@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot has bisected this bug to:
> > >
> > > commit 387e3746d01c34457d6a73688acd90428725070b
> > > Author: Amir Goldstein <amir73il@gmail.com>
> > > Date:   Fri Jun 7 14:24:38 2019 +0000
> > >
> > >      locks: eliminate false positive conflicts for write lease
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a79594600000
> > > start commit:   c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
> > > git tree:       upstream
> > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=17a79594600000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=13a79594600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3c8985c08e1f9727
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=032bc63605089a199d30
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15855334600000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fcc4c8600000
> > >
> > > Reported-by: syzbot+032bc63605089a199d30@syzkaller.appspotmail.com
> > > Fixes: 387e3746d01c ("locks: eliminate false positive conflicts for write
> > > lease")
> > >
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> >
> > The repro:
> > #{"repeat":true,"procs":1,"sandbox":"none","fault_call":-1,"cgroups":true,"close_fds":true,"tmpdir":true}
> > mkdir(&(0x7f0000000100)='./file0\x00', 0x0)
> > mkdirat$cgroup_root(0xffffffffffffff9c,
> > &(0x7f0000000000)='./cgroup.net/syz1\x00', 0x1ff)
> > mount$fuse(0x20000000, &(0x7f0000000140)='./file0\x00', 0x0, 0x1004, 0x0)
> > mount$overlay(0x400000, &(0x7f0000000100)='./file0\x00',
> > &(0x7f00000001c0)='overlay\x00', 0x0,
> > &(0x7f0000000040)=ANY=[@ANYBLOB=',lowerdir=.:file0'])
> > r0 = open(&(0x7f0000000500)='./file0\x00', 0x0, 0x0)
> > r1 = openat$cgroup_procs(r0, &(0x7f00000004c0)='cgroup.procs\x00', 0x48, 0x0)
> > dup3(r1, r0, 0x0)
> > fcntl$setlease(r0, 0x400, 0x1)
> > lseek(r0, 0x4, 0x0)
> >
> > I though we would stop these family of overlapping layers fuzzers with:
> > 146d62e5a586 ("ovl: detect overlapping layers")
> >
> > But syzbot got the upper hand, because we do not check for overlapping layers
> > that cross fs boundary. Not sure if we should (?).
>
> No, we shouldn't care about that.
> overlayfs doesn't follow cross-fs in underlying layers.
>
> >
> > ./ is a tmpfs dir and ./file0/ is some kind of fuse mount (?)
> > then after one cycle, ./file0/ itself is an overlapping overlay mount
> > (lowerdir=./:./file0/)
> > and after another cycle, ./file0/ is a nested overlapping overlayfs mount.
> > Fine. Whatever.
>
> But damage can still be created if a lower overlayfs layer
> overlaps with the another nested overlay lower underlying layer.
> It actually shouldn't be too hard to add a guard also on the
> nested overlay lower underlying layer inode.
>

Here's a draft

#syz test: https://github.com/amir73il/linux.git ovl-check-nested-overlap

Thanks,
Amir.
