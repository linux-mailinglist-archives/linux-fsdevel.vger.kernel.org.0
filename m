Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB04F6B90
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2019 22:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKJVLC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Nov 2019 16:11:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42105 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfKJVLB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:11:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id n5so11575537ljc.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2019 13:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sw0pGWOp+H0Cc/o3nartd+rrdu30v5KC8Ks0EukSTW0=;
        b=RAfCRzWXqkBygzjvTQF7B/q3F9bZcWhNFKa+vgcKxcPhwpgR7QOlK6Eii8RWszMJSj
         /GKxKFp6PJbUk5mDWk1Rs08zEWAX5Km6Ng5cuqqTumC+Wxu94ZiBemBAFzFqqkBvwDF2
         D0F/g+SzyQvat+TyfcmfcY6DipCQs83wis1FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sw0pGWOp+H0Cc/o3nartd+rrdu30v5KC8Ks0EukSTW0=;
        b=gEia3GM4r4v5SnLD1LR4dzTdQa63VY/EekdNtmSSu3cW1wTlxLrLer8eW/FeWHe8zB
         RKXae9HGuYAPxiJypcprVeUKQVyA9AbEOyLPFi1yny/ZulSoV3pP7VBeRlnhEHrVhLIw
         VIQxltirKY4NBPiQUL4EZ0WOX6H2tzSnHiUsKBA17y4Q+9J2JHTS7welViNcMzQNctXH
         tT/Vwi+Wp+R6qxVcPpM4O4nhMXiQZOP1I4CjWStmRPC8pODfLjrszUCkU8IR228wskAr
         hxv2ikKGHilXhOtlfv8aPIZB0yoSY7Fjibo+nSqRj9GhJrHKVETPYG4al5g2um7hJfis
         n5gw==
X-Gm-Message-State: APjAAAViVKmx0yQdQ2hGzHiO43FB6CxqcX8qgROqFcEG4BTqrmpiZjIq
        dtmhTFuhAGAdD8eJHXXAEuq4dUWIkZE=
X-Google-Smtp-Source: APXvYqx8Tl6qPZNLN9gtGuyycchXo1GLNqIM+eJltlItlP32L2j0F1aTjgK1DWu+5+yWmUtUUzlYag==
X-Received: by 2002:a2e:984f:: with SMTP id e15mr13769240ljj.109.1573420259295;
        Sun, 10 Nov 2019 13:10:59 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 190sm7674421ljj.72.2019.11.10.13.10.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2019 13:10:56 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id k15so11597158lja.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2019 13:10:56 -0800 (PST)
X-Received: by 2002:a2e:8809:: with SMTP id x9mr13861151ljh.82.1573420256107;
 Sun, 10 Nov 2019 13:10:56 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjB61GNmqpX0BLA5tpL4tsjWV7akaTc2Roth7uGgax+mw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911101034180.29192-100000@netrider.rowland.org>
 <CAHk-=wjErHCwkcgO-=NReU0KR4TFozrFktbhh2rzJ=mPgRO0-g@mail.gmail.com>
 <CAHk-=wghq7rmtskFj7EbngpXUTJfc4H9sDcx10E6kMHoH2EsKA@mail.gmail.com> <20191110204442.GA2865@paulmck-ThinkPad-P72>
In-Reply-To: <20191110204442.GA2865@paulmck-ThinkPad-P72>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Nov 2019 13:10:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjm40mcf7tk9DZQXd=dftZw_VpmE837c7pTZ1_cR+t4Mw@mail.gmail.com>
Message-ID: <CAHk-=wjm40mcf7tk9DZQXd=dftZw_VpmE837c7pTZ1_cR+t4Mw@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 10, 2019 at 12:44 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> But will "one size fits all" be practical and useful?

Oh, I do agree that if KCSAN has some mode where it says "I'll ignore
repeated writes with the same value" (or whatever), it could/should
likely be behind some flag.

I don't think it should be a subsystem flag, though. More of a "I'm
willing to actually analyze and ignore false positives" flag. Because
I don't think it's so much about the code, as it is about the person
who looks at the results.

For example, we're already getting push-back from people on some of
the KCSAN-inspired patches. If we have people sending patches to add
READ_ONCE/WRITE_ONCE to random places to shut up KCSAN reports, I
don't think that's good.

But if we have people who _work_ on memory ordering issues etc, and
want to see a strict mode, knowing there are false positives and able
to handle them, that's a completely different thing..

No?

              Linus
