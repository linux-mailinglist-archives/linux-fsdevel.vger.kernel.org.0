Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F922F7E6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 20:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfKKTDm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 14:03:42 -0500
Received: from mail-il1-f182.google.com ([209.85.166.182]:40403 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729777AbfKKSoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:44:54 -0500
Received: by mail-il1-f182.google.com with SMTP id d83so13019158ilk.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 10:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4BpCjYzPkx26Lry+SSYhIxQ+3eUNFix400wW4/08qQ=;
        b=fykSer/Nt12/oYUdAecve96EfZTE//MBbtTG4FkrK4dRROCaVT8fpeZFAYJzSbeMxO
         rOWo+yxd0tosbFqAsh5bPDuDKBMvvqDlvwBqgTgV7uku2N16SLVk41LoXrgI7jeMaiSq
         2i5CNda2++JlhpdIuyI4zcTC+fd9qJJq9B+7bm4UEdR/FPBmQWK5+xh8zuUkV8hEMVS8
         BCMrROkBrUOOAmiSig4g9/Pq71FzTcRcVdJ7KwstUr1O+GDT/VTqUmF4rJZDe/kNHfKL
         U5A8dQe5fxNixxg//Usggoq173wp6UQsVUO1zEwXSTD86cn6IVL+UJtjmDnLwycW60fj
         2JSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4BpCjYzPkx26Lry+SSYhIxQ+3eUNFix400wW4/08qQ=;
        b=Zj0U7K5x+azkQEtD8z9PaBsFJrR3Spf3AOWTaVJJ3dvx0DV/BdOtNdu6qmCObHadME
         fI611wvYbKANtuZVwO8+HNB0ajwqJ/q/TK0JsN2c34+honj6z+RVYK3tpZBhsPTqqOoy
         N6Jn2WCTRKt5yLFNeogN59kRM6LXlyPp7lGPpBuDxzz/BjOlo7quUrgtw4ChxHha8trT
         ph61EjAmSBk/4LjX+fkoRYgI9jm693b9C/Gs8HPCiTXQt/mtcLgU+CyEMOca+RMXJL2X
         YPx32l3ByNOHpTMG/Jj3L0VRWS27a/LkYuwtlNlQENMY0I8BgJWdPF9gifVgTKu7BGTQ
         vZ2Q==
X-Gm-Message-State: APjAAAUkd4rg3yMCiae1oga2KFDEb8WLkAvvUObTb4HTWURUH+yNFEmH
        WtSpyzEdvFIVq2HbU+nx0+yyK/59IYXc4BKacf8d+Q==
X-Google-Smtp-Source: APXvYqxZu5qGd+xUFwg7SMnSekBxnWYvigjk8QXdOJkg6GuKnqYxiS3POTOk/MiaTkcf1jIZUsnONLZwYJGSXtWsVMs=
X-Received: by 2002:a92:ba1b:: with SMTP id o27mr32680944ili.269.1573497892803;
 Mon, 11 Nov 2019 10:44:52 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com> <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
In-Reply-To: <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 11 Nov 2019 10:44:41 -0800
Message-ID: <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com>
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

On Mon, Nov 11, 2019 at 10:31 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Mon, Nov 11, 2019 at 10:05 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, Nov 11, 2019 at 9:52 AM Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > Now I wonder what to do with the ~400 KCSAN reports sitting in
> > > pre-moderation queue.
> >
> > So regular KASAN reports are fairly easy to deal with: they report
> > actual bugs. They may be hard to hit, but generally there's no
> > question about something like a use-after-free or whatever.
> >
> > The problem with KCSAN is that it's not clear how many of the reports
> > have been actual real honest-to-goodness bugs that could cause
> > problems, and how many of them are "this isn't actually a bug, but an
> > annotation will shut up KCSAN".
> >
> > My gut feeling would be that it would be best to ignore the ones that
> > are "an annotation will shut up KCSAN", and look at the ones that are
> > real bugs.
> >
> > Is there a pattern to those real bugs? Is there perhaps a way to make
> > KCSAN notice _that_ pattern in particular, and suppress the ones that
> > are "we can shut these up with annotations that don't really change
> > the code"?
> >
> > I think it would be much better for the kernel - and much better for
> > KCSAN - if the problem reports KCSAN reports are real problems that
> > can actually be triggered as problems, and that it behaves much more
> > like KASAN in that respect.
> >
> > Yes, yes, then once the *real* problems have been handled, maybe we
> > can expand the search to be "stylistic issues" and "in theory, this
> > could cause problems with a compiler that did X" issues.
> >
> > But I think the "just annotate" thing makes people more likely to
> > dismiss KCSAN issues, and I don't think it's healthy.
> >
>
> Problem is that KASAN/KCSAN stops as soon as one issue is hit,
> regardless of it being a false positive or not.
>
> (Same happens with LOCKDEP seeing only one issue, then disabling itself)
>
> If we do not annotate the false positive, the real issues might be
> hidden for years.
>
> There is no pattern really, only a lot of noise (small ' bugs'  that
> have no real impact)

An interesting case is the race in ksys_write()

if (ppos) {
     pos = *ppos; // data-race
     ppos = &pos;
}
ret = vfs_write(f.file, buf, count, ppos);
if (ret >= 0 && ppos)
    f.file->f_pos = pos;  // data-race

BUG: KCSAN: data-race in ksys_write / ksys_write

write to 0xffff8880a9c29568 of 8 bytes by task 27477 on cpu 1:
 ksys_write+0x101/0x1b0 fs/read_write.c:613
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write fs/read_write.c:620 [inline]
 __x64_sys_write+0x4c/0x60 fs/read_write.c:620
 do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
