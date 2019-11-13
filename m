Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB57CFB5CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 17:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfKMQ6N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 11:58:13 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:37567 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfKMQ6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:58:12 -0500
Received: by mail-lj1-f182.google.com with SMTP id d5so3396344ljl.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 08:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZYEg/h4QSDcgUnlMwh4w5+X6tHq85c+NTIUoiTVyRk=;
        b=U7ravdDyiBjUVP8ErfMB91io1YhXvWHGVKa77PMeGvwn8vFpkMlRNnDUtYyuCdHy/V
         eXLqYfmp5YyTims+8tWu7mnnzxTheo9yQBk18/JI9FYSjBx2+5iIJS2FdZCXQkrg9sy+
         PAqMgVt9H/TKePAImEEkVIthOmiQ0+tOoY2sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZYEg/h4QSDcgUnlMwh4w5+X6tHq85c+NTIUoiTVyRk=;
        b=um22aozmvgjrPf4YmS2kIOkSl2eEgVg1gGQuJj54DiHw9riKU5D6m63wa7dQGHsgwa
         bCkmY4HrZ7msUvaOPZ4TVL5Jk7W8eZmiJ9CJ66WS7yQHq4GPrMv/W4RP4LHDVbSgHJDr
         I/CLOT+UhRxHWtP9Ol8A0QIHso/NhJw+1ibxVtrvqDUgUMeagFfAeArNZ8Ov2DmuvMsU
         jNVQjzsx+0/Y4E/7ihwLm4+KsJRdeguW7+jlZz9UMvpCe99RP14nn4oJiR7OSLM71RGe
         C8QEJj4Cok7wQ1ZC0p4fdtV9rUcYT+H0GZmXktzlyNdLeB3rvTyC1A4VhtW5b+kqYJ71
         9+yg==
X-Gm-Message-State: APjAAAUe7SSCDRfabvnqZ4zV3yTGOl8/A1EcmrtxlTBQom2CPq21cNGl
        Gl6nSwA+i88p0trRs5cA1Pat0V1ZS2c=
X-Google-Smtp-Source: APXvYqyzBQRFcZJHiMPZvfxtzODz6JCNqOvRNlhzA99n8aemfW20kQAoC6vGaybikS6aXrxOiAFArA==
X-Received: by 2002:a2e:96cc:: with SMTP id d12mr3317666ljj.210.1573664288818;
        Wed, 13 Nov 2019 08:58:08 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id i30sm1385572lfp.39.2019.11.13.08.58.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 08:58:06 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id y23so3361178ljh.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 08:58:05 -0800 (PST)
X-Received: by 2002:a2e:8919:: with SMTP id d25mr3368745lji.97.1573664285540;
 Wed, 13 Nov 2019 08:58:05 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com>
 <Pine.LNX.4.44L0.1911121639540.1567-100000@iolanthe.rowland.org>
 <CANn89iKjWH86kChzPiVtCgVpt3GookwGk2x1YCTMeBSPpKU+Ww@mail.gmail.com>
 <20191112224441.2kxmt727qy4l4ncb@ast-mbp.dhcp.thefacebook.com>
 <CANn89iKLy-5rnGmVt-nzf6as4MvXgZzSH+BSReXZKpSTjhoWAw@mail.gmail.com>
 <CAHk-=wj_rFOPF9Sw_-h-6J93tP9qO_UOEvd-e02z9+DEDs2kLQ@mail.gmail.com> <CANpmjNNkbWoqckyPfhq52W4WfJWR2=rt8WXzs+WXEZzv9xxL0g@mail.gmail.com>
In-Reply-To: <CANpmjNNkbWoqckyPfhq52W4WfJWR2=rt8WXzs+WXEZzv9xxL0g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Nov 2019 08:57:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg5CkOEF8DTez1Qu0XTEFw_oHhxN98bDnFqbY7HL5AB2g@mail.gmail.com>
Message-ID: <CAHk-=wg5CkOEF8DTez1Qu0XTEFw_oHhxN98bDnFqbY7HL5AB2g@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Marco Elver <elver@google.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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

On Wed, Nov 13, 2019 at 7:00 AM Marco Elver <elver@google.com> wrote:
>
> Just to summarize the options we've had so far:
> 1. Add a comment, and let the tool parse it somehow.
> 2. Add attribute to variables.
> 3. Add some new macro to use with expressions, which doesn't do
> anything if the tool is disabled. E.g. "racy__(counter++)",
> "lossy__(counter++);" or any suitable name.

I guess I could live with "data_race(x)" or something simple like
that, assuming we really can just surround a whole expression with it,
and we don't have to make a hundred different versions for the
different cases ("racy plain assignment" vs "racy statistics update"
vs "racy u64 addition" etc etc).

I just want the source code to be very legible, which is one of the
problems with the ugly READ_ONCE() conversions.

Part of that "legible source code" implies no crazy double
underscores. But a plain "data_race(x)" might not look too bad, and
would be easy to grep for, and doesn't seem to exist in the current
kernel as anything else.

One question is if it would be a statement expression or an actual
expression. I think the expression would read much better, IOW you
could do

    val = data_race(p->field);

instead of having to write it as

    data_race(val = p->field);

to really point out the race. But at the same time, maybe you need to
surround several statements, ie

    // intentionally racy xchg because we don't care and it generates
better code
    data_race(a = p->field; p->field = b);

which all would work fine with a non-instrumented macro something like this:

    #define data_race(x) ({ x; })

which would hopefully give the proper syntax rules.

But that might be very very inconvenient for KCSAN, depending on how
you annotate the thing.

So I _suspect_ that what you actually want is to do it as a statement,
not as an expression. What's the actual underlying syntax for "ignore
this code for thread safety checking"?

                    Linus
