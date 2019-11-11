Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 192B7F7E16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 20:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfKKTBK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 14:01:10 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:37662 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbfKKTBJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:01:09 -0500
Received: by mail-lf1-f54.google.com with SMTP id b20so10717385lfp.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 11:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7X+i/K/e1sfyo/sSNSz4o3Zk6I09VNaSQEUuToduhok=;
        b=IfGf7e0vnSjr5D5/DFnDtseZozwEmG+KD34J8cRx2xf34AIG9uoiU23s5fCGgXqEK5
         pSM5R4LyfWGXW4tT+suDhlW+bfiQEQkNQpZTYlGHKMQ/MYDHAI4BuxjcbA3OnkuY9PoG
         2YgxBEu1RUtZ1BQ8hGZGSjXauXMoa4FK+6ZBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7X+i/K/e1sfyo/sSNSz4o3Zk6I09VNaSQEUuToduhok=;
        b=Puj88vcFwbJw2wWWWIyAXeB0OZYhUXNztC3V+ZOX4aB/n2RsMHEjuRN0lQ2ovyXpPQ
         msYhJNE8lMvk5SNtr5a7sNtdE7fJllMChDe0LIIrZ7Mqu+40HBclvvpT15bTSy5bx4HY
         CVtie3BgooTSboAxXPAm932J0z/lKdfCyTkdUlX5plEFPx77zYOqci5qMJIqVXx+itkN
         HoRbGHsVx/AIP6RkWL88iTkMcBSCVE3thqw1XhfU1J7aI8ZVVXtCIcCGF5W/bnO0V525
         Ib4JU3rkt78CgfYMvvEmuIS3D1JLM0joA0EX+n+CnZ/OkhR2RSXq3vawBLBbhgdWaM28
         xbrw==
X-Gm-Message-State: APjAAAWbHA0iNN28xfVTe5RAVA4Y3bDk2KulZmp7lBl8/WFmuAPYIA5N
        YU2gR3mr7l66KxpT3x1VJZhrH2Yn7tI=
X-Google-Smtp-Source: APXvYqyH0Vp7mcLf8qSzQTpWTEh9m7arqvc8Aq0sSzqJyT/N9ADuZYLtwTcbHDw6nFh3LUmM8GrcsA==
X-Received: by 2002:ac2:4c86:: with SMTP id d6mr16656918lfl.106.1573498866359;
        Mon, 11 Nov 2019 11:01:06 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r19sm7271241lfi.13.2019.11.11.11.01.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 11:01:05 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id q2so14999956ljg.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 11:01:04 -0800 (PST)
X-Received: by 2002:a2e:982:: with SMTP id 124mr8876387ljj.48.1573498864524;
 Mon, 11 Nov 2019 11:01:04 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
 <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com> <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com>
In-Reply-To: <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Nov 2019 11:00:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com>
Message-ID: <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Eric Dumazet <edumazet@google.com>
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

On Mon, Nov 11, 2019 at 10:44 AM Eric Dumazet <edumazet@google.com> wrote:
>
> An interesting case is the race in ksys_write()

Not really.

> if (ppos) {
>      pos = *ppos; // data-race

That code uses "fdget_pos().

Which does mutual exclusion _if_ the file is something we care about
pos for, and if it has more than one process using it.

Basically the rule there is that we don't care about the data race in
certain circumstances. We don't care about non-regular files, for
example, because those are what POSIX gives guarantees for.

(We have since moved towards FMODE_STREAM handling instead of the
older FMODE_ATOMIC_POS which does this better, and it's possible we
should get rid of the FMODE_ATOMIC_POS behavior in favor of
FMODE_STREAM entirely)

Again, that's pretty hard to tell something like KCSAN.

Of course, it's then questionable whether our rules for not caring are
necessarily the _right_ rules for not caring. For example, if you have
threads, the "more than one process opening it" doesn't trigger. It's
literally just atomicity across processes that we guarantee. That's
certainly a bit questionable. But that's a higher-level decision.

               Linus
