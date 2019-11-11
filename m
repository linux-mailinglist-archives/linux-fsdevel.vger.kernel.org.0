Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECD62F7CE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 19:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfKKSun (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 13:50:43 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35681 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbfKKSun (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:50:43 -0500
Received: by mail-lf1-f67.google.com with SMTP id y6so10703580lfj.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 10:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tzwj0Bcu0+gyIzlUlN7XJHfbOaRzWPHagplExJJIvPs=;
        b=ew5m8ZL/3PZXEH82FW7NciyTpX79pXMZzxowB+MlMPaTW/kiutG2GumvXkfpUaRgOq
         P2W1GftekPzYO7cncT0B3PbtH2mr6stdJFhMeleFIDj20NSRAHa/lpsPd2tHpgwHBNki
         C9b4sV+Ddh67bYfuCFNneVQaMCjOafWrdcZl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzwj0Bcu0+gyIzlUlN7XJHfbOaRzWPHagplExJJIvPs=;
        b=gD9iZ8IWWSVgvd+Jy/rOGWfVBkvTMLH4RtM9MyPsCCYbH1/nSCMPykuARUnS/JCxs0
         3SX63hK7P+Iq1XtwetrJ/T6iIUGcR54kMO6pFFIdQeUOdEbSRVFwA3R/2GCNjxj7dVSl
         8smZe+bVfU0uSrQTTNDf1nqZvZw4FqbM58Vo2Q/13+65Vkhw0Cbp8o7qyb4TjZfjWF+1
         SSU7clOjrLXEPLrWH0LFUJ7KgU7Fh2QIP8J5ig3Y3m8wtoEMFsJEb2hdsBvMQcjG+W02
         8LS9J27RL/zit/bjNczZ8Svo2wo6gvJKBQPOvcZ76sI0+pVwwC14BuqQFzAX19buHf1M
         6dQQ==
X-Gm-Message-State: APjAAAWu9T3P/hllsSu7XhowLxhahpMLVZtHakmtLOxx3wMskWyxFP06
        BuVDTUgCLdglf66XUfnzXnN7ewbWOCI=
X-Google-Smtp-Source: APXvYqx8NBZspFU+7JVUIzocCRZnb0gNMaQ5qLo1yUB9MGVgKI2bfqdOg6zsakvqntEK1rN4KupTdA==
X-Received: by 2002:a19:3fcd:: with SMTP id m196mr16404726lfa.118.1573498240175;
        Mon, 11 Nov 2019 10:50:40 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id u67sm9610415lja.78.2019.11.11.10.50.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 10:50:39 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id v8so10655703lfa.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 10:50:38 -0800 (PST)
X-Received: by 2002:a19:c790:: with SMTP id x138mr16826204lff.61.1573498238697;
 Mon, 11 Nov 2019 10:50:38 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com> <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
In-Reply-To: <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Nov 2019 10:50:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgWf7Ma+iWuJTTr9HW1-yP26vEswC1Gids-A=eOP7LaOQ@mail.gmail.com>
Message-ID: <CAHk-=wgWf7Ma+iWuJTTr9HW1-yP26vEswC1Gids-A=eOP7LaOQ@mail.gmail.com>
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

On Mon, Nov 11, 2019 at 10:31 AM Eric Dumazet <edumazet@google.com> wrote:
>
> Problem is that KASAN/KCSAN stops as soon as one issue is hit,
> regardless of it being a false positive or not.

So mayb e that - together with the known huge base of false positives
- just means that KCSAN needs some more work before it can be used as
a basis for sending out patches.

Maybe the reporting needs to create a hash of the location, and report
once per location? Or something like that.

Maybe KCSAN needs a way to filter out known false positives on a KCSAN
side, without having to change the source for a tool that gives too
much noise?

> If we do not annotate the false positive, the real issues might be
> hidden for years.

I don't think "change the kernel source for a tool that isn't good
enough" is the solution.

> There is no pattern really, only a lot of noise (small ' bugs'  that
> have no real impact)

Yeah, if it hasn't shown any real bugs so far, that just strengthens
the "it needs much fewer false positives to be useful".

KASAN and lockdep can afford to stop after the first problem, because
the problems they report - and the additional annotations you might
want to add - are quality problems and annotations.

                Linus
