Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8678CF9E3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 00:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKLXlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 18:41:14 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42491 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfKLXlO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:41:14 -0500
Received: by mail-lf1-f68.google.com with SMTP id z12so301735lfj.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 15:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EUXLb1uu1dcQwvM3XnfVOQS/u8rpUwxsukE0911wRv8=;
        b=BlxyQF/k0RbNlmXP5IB58F/0Xz3h4ttVpHaMWy/tA5ZBmhF0Hc9KKgINDE4bq+7VOV
         zqj7K+B23f5rkrn/XHC7xsbbzsc8AsUGEmABEH/wooLD/jCPv801/xBfUCp/v8T8n//8
         yAvsBxLJ7ZGLbzPhrSobnyjECGiABuvCmT8hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EUXLb1uu1dcQwvM3XnfVOQS/u8rpUwxsukE0911wRv8=;
        b=bRpi0QlMRiVgcPlV9lwnrMVgsIRRHU8OcvJ7ld5lQ5V400X/1pjc7VlaqvwCYo7nCL
         TJ009TUcX5XmzlJtc77XF1e4YbcnbpPHEl8oypggLObs0MU/L0TMoHDKcUgoIOV0ezM+
         noGHWONXHTgca87KDxgZ012wg7lXTrDOj5B8K5lYpnCYycLX69YB1UtNzG4LF0GRRDDH
         HTCfSsiost2vw2GMAtzG28ZkSvqdr0X/lx6KVuNYOVybHlykeFhd57YwH6ppwkZQBlHF
         b3zB9Xa9m7Pc9DyR09KlBPrcIeF5nh7ydYpkFw1oFNZdx0WIJggSxThXlkPH1BUOFvPQ
         OqHQ==
X-Gm-Message-State: APjAAAXGghiHcLsbnWyyoIikMLXh8xQyrXglQxHqC74ErRybYnvFPTVJ
        aVf3kfFipHId571O5qK1def8gIISAcg=
X-Google-Smtp-Source: APXvYqwuhuP0poM4pxYbmhLanzN0L4ECTYcmyj+X7gWm48b7NdCJje2FI0LO/QeHjw5AzYBItBDS1g==
X-Received: by 2002:a19:41c8:: with SMTP id o191mr296234lfa.101.1573602070825;
        Tue, 12 Nov 2019 15:41:10 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id j8sm80628lja.32.2019.11.12.15.41.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 15:41:09 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id k15so409558lja.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 15:41:08 -0800 (PST)
X-Received: by 2002:a2e:22c1:: with SMTP id i184mr233777lji.1.1573602068124;
 Tue, 12 Nov 2019 15:41:08 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com>
 <Pine.LNX.4.44L0.1911121639540.1567-100000@iolanthe.rowland.org>
 <CANn89iKjWH86kChzPiVtCgVpt3GookwGk2x1YCTMeBSPpKU+Ww@mail.gmail.com>
 <20191112224441.2kxmt727qy4l4ncb@ast-mbp.dhcp.thefacebook.com> <CANn89iKLy-5rnGmVt-nzf6as4MvXgZzSH+BSReXZKpSTjhoWAw@mail.gmail.com>
In-Reply-To: <CANn89iKLy-5rnGmVt-nzf6as4MvXgZzSH+BSReXZKpSTjhoWAw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Nov 2019 15:40:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj_rFOPF9Sw_-h-6J93tP9qO_UOEvd-e02z9+DEDs2kLQ@mail.gmail.com>
Message-ID: <CAHk-=wj_rFOPF9Sw_-h-6J93tP9qO_UOEvd-e02z9+DEDs2kLQ@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Eric Dumazet <edumazet@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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

On Tue, Nov 12, 2019 at 3:18 PM Eric Dumazet <edumazet@google.com> wrote:
>
> Hmm we have the ' volatile'  attribute on jiffies, and it causes
> confusion already :p

The jiffies case is partly historical, but partly also because it's
one of the very very few data structures where 99% of all uses are
unlocked and for convenience reasons we really don't want to force
those legacy cases to do anything special about it.

"jiffies" really is very special for those kinds of legacy reasons.
Look at the kinds of games we play with it on 32-bit architectures:
the "real" storage is "jiffies_64", but nobody actually wants to use
that, and because of load tearing issues it's actually hard to use
too. So what everybody _uses_ is just the low 32 bits, and 'jiffies'
isn't a real variable, it's done with linker tricks in our
vmlinux.lds.S files. So, for example, on sparc32, you find this:

    jiffies = jiffies_64 + 4;

in the vmlinux.lds.S file, because it's big-endian, and the lower 32
bits are at offset 4 from the real 64-bit variable.

Note that to actually read the "true" full 64-bit value, you have to
then call a function that does the proper sequence counter stuff etc.
But nobody really wants it, since what everybody actually _uses_ is
the "time_after(x,jiffies+10)" kind of thing, which is only done in
the wrapping "unsigned long" time base. So the odd "linker tricks with
the atomic low bits marked as a volatile data structure" is actually
exactly what we want, but people should realize that this is not
normal.

So 'jiffies' is really really special.

And absolutely nothing else should use 'volatile' on data structures
and be that special.  In the case of jiffies, the rule ends up being
that nobody should ever write to it (you write to the real
jiffies_64), and the real jiffies_64 thing gets the real locking, and
'jiffies' is a read-only volatile thing.

So "READ_ONCE()" is indeed unnecessary with jiffies, but it won't
hurt. It's not really "confusion" - there's nothing _wrong_ with using
READ_ONCE() on volatile data, but we just normally don't do volatile
data in the kernel (because our normal model is that data is never
really volatile in general - there may be locked and unlocked accesses
to it, so it's stable or volatile depending on context, and thus the
'volatile' goes on the _code_, not on the data structure)

But while jiffies READ_ONCE() accesses isn't _wrong_, it is also not
really paired with any WRITE_ONCE(), because the real update is to
technically not even to the same full data structure.

So don't look to jiffies for how to do things. It's an odd one-off.

That said, for "this might be used racily", if there are annotations
for clang to just make it shut up about one particular field in a
structure, than I think that would be ok. As long as it doesn't then
imply special code generation (outside of the checking, of course).

                 Linus
