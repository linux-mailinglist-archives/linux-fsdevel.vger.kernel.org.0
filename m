Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9949DF8184
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfKKUrX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:47:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37670 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfKKUrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:47:21 -0500
Received: by mail-lj1-f196.google.com with SMTP id d5so5782462ljl.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 12:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OaEDXSnozFKU9AfcCmi3n5mppwBp0l4bFT/aQieMhC0=;
        b=Zs8Zzq88VsL2T86KxW7IgVWl6ZhIIzNKAf9FuqchaKJtKHaYsoAYP+TPoclakBI6l3
         ljes5eRvglTxez5EmHsBrnpio1cu+VIFH8/TCGhqHn3GzE608nn3f94tnbKbNvbVffrZ
         6m3v2QDJ6S7Hl1KbBOeyM4E0K5JCKzaUiZKxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OaEDXSnozFKU9AfcCmi3n5mppwBp0l4bFT/aQieMhC0=;
        b=k4nExj3dMRi9e7ULPtFXTSGMNTIxR30/2FhzGfpj4qx6r3AX6ZfOOHjAkGsVybH4dI
         Os607/QFS2LUfvBZ6GcN/mUEfJKTIeadg9hJhIB2K0wtm2OrvtuqMtzvykGyQY7Nh9Vy
         u2l38CByRqpIHMV/h/7mGg0OEOYOBnGKQ06nNAyttMP69VTlYxdRHlZDn4cT8GDGZEsB
         pFdF8RxC8HXiXEiROymjD8SOb/MTBKpqjMS/WPivufwQ6h6L8BfpQAice8dJinI7StjB
         3qnh4YAuZQqg7VaATrLeK0LkupPf33klpLqang0XkZvHLaQ8IYf7eljiog9tCqyWTfrT
         4LBA==
X-Gm-Message-State: APjAAAVTRWqkQcvz73FbKLQuN9jaFGGOT/d3y+bTllXx1GLEc1hL4z3J
        XxUL+lNYw9ddIEsB3HBsT0w9UXcOP/U=
X-Google-Smtp-Source: APXvYqy3T10NBNYfeIROCIhA7ALcMFiq2rpeNBk7OoIEMCLo9G9Vg789UWo+MT6fA56Vyunz2lQSnA==
X-Received: by 2002:a2e:975a:: with SMTP id f26mr12657223ljj.74.1573505237167;
        Mon, 11 Nov 2019 12:47:17 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id t7sm7266179ljg.59.2019.11.11.12.47.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 12:47:14 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id e9so15243504ljp.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 12:47:14 -0800 (PST)
X-Received: by 2002:a2e:982:: with SMTP id 124mr9131365ljj.48.1573505233789;
 Mon, 11 Nov 2019 12:47:13 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
 <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
 <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com>
 <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com>
 <CANn89i+x7Yxjxr4Fdaow-51-A-oBK3MqTscbQ4VXQuk4pX9aCg@mail.gmail.com> <CAHk-=whRQuSrstW+cwNmUdLNwkZsKsXuie_1uTqJeKjMBWmr6Q@mail.gmail.com>
In-Reply-To: <CAHk-=whRQuSrstW+cwNmUdLNwkZsKsXuie_1uTqJeKjMBWmr6Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Nov 2019 12:46:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=whWNkk7vCQr7LLshcB6B_=ikmpMXQ7RtO2FyDx-Np_UKg@mail.gmail.com>
Message-ID: <CAHk-=whWNkk7vCQr7LLshcB6B_=ikmpMXQ7RtO2FyDx-Np_UKg@mail.gmail.com>
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

On Mon, Nov 11, 2019 at 12:43 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yeah, maybe we could have some model for marking "this is statistics,
> doesn't need to be exact".

Side note: that marking MUST NOT be "READ_ONCE + WRITE_ONCE", because
that makes gcc create horrible code, and only makes the race worse.

At least with a regular add, it might stay as a single r-m-w
instruction on architectures that have that, and makes the quality of
the statistics slightly better (no preemption etc).

So that's an excellent example of where changing code to use
WRITE_ONCE actually makes the code objectively worse in practice -
even if it might be the same in theory.

                Linus
