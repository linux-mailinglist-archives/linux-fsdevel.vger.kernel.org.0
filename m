Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2AAFB30D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 16:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfKMPAh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 10:00:37 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46594 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbfKMPAg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 10:00:36 -0500
Received: by mail-ot1-f66.google.com with SMTP id n23so1819543otr.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 07:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hn0rE8EvQLayCzvR+VM/mjAxPaLh9HP6Et6bUGhBo8g=;
        b=HBHsCShKPxflrvZ7COZyam7cSyPMVSE2Df2KInwngnmj3XC6CG1iIdad+zrmgxjpoL
         pSxx4/TtFbnMa8p0ZzauIadXVwYEW8KF0fCHGOYcggwDmdl//Oog+V52wV3Flug/P1xp
         tGL4mvdwDE/9Y8unvP2kivCJXLeetnnoiVjsYJwtZwlp7+cp3seRr7udcMQLGDVX8Xus
         p3tPTd4KIL68djgdYqFrWe1NHLSxqA25dDRo8Ax/Ah0RoEO4FcK3d6EL95e6TVEyJJ1V
         QnX0eZljqiSf+2Rb+ggZUNKxx58eTL0jxZ4uByrkKDFwEZe6fUdBiGg6md11I/g/g5Cx
         FCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hn0rE8EvQLayCzvR+VM/mjAxPaLh9HP6Et6bUGhBo8g=;
        b=oy+6qibxdQA0mTzrQN2olczm9Q3LgDIswv3yNwbEfOnS+5yrOH4vcG8FGvIPUWsmQR
         NxJIXbKT0ARyyNiFTZgl50LDyPzLdF/zgXEcyDHVwSLWFCpFD7FmN9YeZ/uXN9SH7GKw
         suEUBYK4J71XEu6S6UxvjkmbnyD8XIbfSzxMtIxbCHKKIZLeizOmIiLZCL6m0oB4W/8I
         W+SLCDbLMnqF3NZmEDoDBK/is10jULp6ZTcHso7o0da1E4jxkYHARhVfbsMiQ3uENfGh
         zOubOZcK7g2xIz624+ZQirp3EL3cFqBESNAnfejOSQEkz/FdmFxzHrtjssqRcmyF00QB
         6IHA==
X-Gm-Message-State: APjAAAUgIIDzj2jsVhyAfblp8oE+Dry4AqCnDqnJhMBQt7KY18g/GM0b
        TBvXqm2jfN1HehsPaUph+lXVMJuQ2C1rgU1l4a6Z4A==
X-Google-Smtp-Source: APXvYqxJ3c6MEZ0/2hGP2/5UKDNPX6bPtZFJ9h4viwgj5WeAEavitL5ck3Xe6xnzWLwZazm4TAy56EBFRkAq0wZABQk=
X-Received: by 2002:a9d:69cf:: with SMTP id v15mr3119489oto.251.1573657235271;
 Wed, 13 Nov 2019 07:00:35 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com>
 <Pine.LNX.4.44L0.1911121639540.1567-100000@iolanthe.rowland.org>
 <CANn89iKjWH86kChzPiVtCgVpt3GookwGk2x1YCTMeBSPpKU+Ww@mail.gmail.com>
 <20191112224441.2kxmt727qy4l4ncb@ast-mbp.dhcp.thefacebook.com>
 <CANn89iKLy-5rnGmVt-nzf6as4MvXgZzSH+BSReXZKpSTjhoWAw@mail.gmail.com> <CAHk-=wj_rFOPF9Sw_-h-6J93tP9qO_UOEvd-e02z9+DEDs2kLQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj_rFOPF9Sw_-h-6J93tP9qO_UOEvd-e02z9+DEDs2kLQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 13 Nov 2019 16:00:21 +0100
Message-ID: <CANpmjNNkbWoqckyPfhq52W4WfJWR2=rt8WXzs+WXEZzv9xxL0g@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Linus Torvalds <torvalds@linux-foundation.org>
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

On Wed, 13 Nov 2019 at 00:41, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Nov 12, 2019 at 3:18 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > Hmm we have the ' volatile'  attribute on jiffies, and it causes
> > confusion already :p
>
> The jiffies case is partly historical, but partly also because it's
> one of the very very few data structures where 99% of all uses are
> unlocked and for convenience reasons we really don't want to force
> those legacy cases to do anything special about it.
>
> "jiffies" really is very special for those kinds of legacy reasons.
> Look at the kinds of games we play with it on 32-bit architectures:
> the "real" storage is "jiffies_64", but nobody actually wants to use
> that, and because of load tearing issues it's actually hard to use
> too. So what everybody _uses_ is just the low 32 bits, and 'jiffies'
> isn't a real variable, it's done with linker tricks in our
> vmlinux.lds.S files. So, for example, on sparc32, you find this:
>
>     jiffies = jiffies_64 + 4;
>
> in the vmlinux.lds.S file, because it's big-endian, and the lower 32
> bits are at offset 4 from the real 64-bit variable.
>
> Note that to actually read the "true" full 64-bit value, you have to
> then call a function that does the proper sequence counter stuff etc.
> But nobody really wants it, since what everybody actually _uses_ is
> the "time_after(x,jiffies+10)" kind of thing, which is only done in
> the wrapping "unsigned long" time base. So the odd "linker tricks with
> the atomic low bits marked as a volatile data structure" is actually
> exactly what we want, but people should realize that this is not
> normal.
>
> So 'jiffies' is really really special.
>
> And absolutely nothing else should use 'volatile' on data structures
> and be that special.  In the case of jiffies, the rule ends up being
> that nobody should ever write to it (you write to the real
> jiffies_64), and the real jiffies_64 thing gets the real locking, and
> 'jiffies' is a read-only volatile thing.
>
> So "READ_ONCE()" is indeed unnecessary with jiffies, but it won't
> hurt. It's not really "confusion" - there's nothing _wrong_ with using
> READ_ONCE() on volatile data, but we just normally don't do volatile
> data in the kernel (because our normal model is that data is never
> really volatile in general - there may be locked and unlocked accesses
> to it, so it's stable or volatile depending on context, and thus the
> 'volatile' goes on the _code_, not on the data structure)
>
> But while jiffies READ_ONCE() accesses isn't _wrong_, it is also not
> really paired with any WRITE_ONCE(), because the real update is to
> technically not even to the same full data structure.
>
> So don't look to jiffies for how to do things. It's an odd one-off.
>
> That said, for "this might be used racily", if there are annotations
> for clang to just make it shut up about one particular field in a
> structure, than I think that would be ok. As long as it doesn't then
> imply special code generation (outside of the checking, of course).

There are annotations that work for globals only. This limitation is
because once you take a pointer of a variable, and just pass around
the address, the attribute will be lost. So sometimes you might do the
right thing, but other times you might not.

Just to summarize the options we've had so far:
1. Add a comment, and let the tool parse it somehow.
2. Add attribute to variables.
3. Add some new macro to use with expressions, which doesn't do
anything if the tool is disabled. E.g. "racy__(counter++)",
"lossy__(counter++);" or any suitable name.

1 and 3 are almost equivalent, except that 3 introduces "structured"
comments that are much easier to understand for tooling. Both 1 and 2
need compiler support.

Right now both gcc and clang support KCSAN, and doing 1 or 2 would
probably imply dropping one of them. Both 1 and 2 are also brittle: 1
because comments are not forced to be structured, and 2 because
attributes on variables do not propagate through pointers.

From our perspective, macro-based annotations would be most reliable.

Thanks,
-- Marco
