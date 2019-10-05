Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E2BCC71F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2019 03:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfJEBSS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 21:18:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38352 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJEBSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 21:18:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id w8so3918625plq.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Oct 2019 18:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q2oP8A+66Rac3wNrpkR8MWsLUwrIym5JWD2OWoQLn2I=;
        b=GPhhjUv+KkS/VzHR5+UKHbUpig67OUz+p2ab8gzDSHD3qWPn5BM1Y5BuX7lxM7j2sb
         kfHr9wmq/ZxD9CMSuGBeBnRcFNxBoNrc0jkNUB4Rgmx5E/OBumH+nRsrohMgMe+j/Rvr
         t8LXEhaVzelX3CPRpPkB2Y5G0/ztqK3oeYNRWvHYetjEo1eOHmWOT3CD6xhMJchs6eDb
         OxHBa5qEKGeZBHYqpxi4evGAx/VhufwkpQPNLZaEp4DWShmC9T8N6LCor4kERCu29UaE
         O+Yo2QExYcBHz7N8yqMIajJuvzJZ49QCOIBtYIj8yxzgyIBkwnbnqn5CemWWy9ROQDur
         OLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q2oP8A+66Rac3wNrpkR8MWsLUwrIym5JWD2OWoQLn2I=;
        b=GbXtI1wOfUXvmtphiKiwprLuKouMs9COH3UB7RIxe+fauvfK+wxWcLIkF+VQjPv5tm
         MuZxGnaBISU9SnLZ9DSWhoNsAygm6ItFruhtXeBCC7iWD3Lvh6ox2qJcKoC/NlSgsAi+
         MNxY4kdznzFHs3g0JXdl0VBBLm8udqbG4l7v77WhnV45eN+EXh2OUfHsbKI5B7bwKk6H
         LNKHYuBBMH9pI4M6x2fJYK/ay+y91Spx2+ae1+pVwcoJ4DMJiJ+bPEtu3ILudX87DziR
         VgPgR6ROa9VBRj8U6w9BkJ7yHgX8OmpfPaBEM9Q4ZCsZLTlY/qgHUd/voaUh29s0Qtee
         RgvQ==
X-Gm-Message-State: APjAAAU62FvTilvOcxYf0YmU2jayazEayNlZnXiOwf5UeeAETBUSEyat
        plqjkvksNMJe4szAkJj/ilxngS8pfhgBjXtmc668Gw==
X-Google-Smtp-Source: APXvYqxXIgL1V9Pz63bm5hrH1w7OGcZMj9O7xWX+0gLh6oom7FtSqHJPBvTviBg5NgEsO3lWv0/RgnZ1WUmPfaPcH/I=
X-Received: by 2002:a17:902:8f88:: with SMTP id z8mr18539665plo.232.1570238296215;
 Fri, 04 Oct 2019 18:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20191004213812.GA24644@mit.edu> <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
 <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org> <20191004222714.GA107737@google.com>
 <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org> <20191004232955.GC12012@mit.edu>
 <CAFd5g456rBSp177EkYAwsF+KZ0rxJa90mzUpW2M3R7tWbMAh9Q@mail.gmail.com>
 <63e59b0b-b51e-01f4-6359-a134a1f903fd@kernel.org> <CAFd5g47wji3T9RFmqBwt+jPY0tb83y46oj_ttOq=rTX_N1Ggyg@mail.gmail.com>
 <544bdfcb-fb35-5008-ec94-8d404a08fd14@kernel.org>
In-Reply-To: <544bdfcb-fb35-5008-ec94-8d404a08fd14@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 4 Oct 2019 18:18:04 -0700
Message-ID: <CAFd5g467PkfELixpU0JbaepEAAD_ugAA340-uORngC-eXsQQ-g@mail.gmail.com>
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     shuah <shuah@kernel.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 4, 2019 at 5:49 PM shuah <shuah@kernel.org> wrote:
>
> On 10/4/19 6:33 PM, Brendan Higgins wrote:
> > On Fri, Oct 4, 2019 at 4:57 PM shuah <shuah@kernel.org> wrote:
> >>
> >> On 10/4/19 5:52 PM, Brendan Higgins wrote:
> >>> On Fri, Oct 4, 2019 at 4:30 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >>>>
> >>>> On Fri, Oct 04, 2019 at 04:47:09PM -0600, shuah wrote:
> >>>>>> However, if I encourage arbitrary tests/improvements into my KUnit
> >>>>>> branch, it further diverges away from torvalds/master, and is more
> >>>>>> likely that there will be a merge conflict or issue that is not related
> >>>>>> to the core KUnit changes that will cause the whole thing to be
> >>>>>> rejected again in v5.5.
> >>>>>
> >>>>> The idea is that the new development will happen based on kunit in
> >>>>> linux-kselftest next. It will work just fine. As we accepts patches,
> >>>>> they will go on top of kunit that is in linux-next now.
> >>>>
> >>>> I don't see how this would work.  If I add unit tests to ext4, they
> >>>> would be in fs/ext4.  And to the extent that I need to add test mocks
> >>>> to allow the unit tests to work, they will involve changes to existing
> >>>> files in fs/ext4.  I can't put them in the ext4.git tree without
> >>>> pulling in the kunit changes into the ext4 git tree.  And if they ext4
> >>>> unit tests land in the kunit tree, it would be a receipe for large
> >>>> numbers of merge conflicts.
> >>>
> >>> That's where I was originally coming from.
> >>>
> >>> So here's a dumb idea: what if we merged KUnit through the ext4 tree?
> >>> I imagine that could potentially get very confusing when we go back to
> >>> sending changes in through the kselftest tree, but at least it means
> >>> that ext4 can use it in the meantime, which means that it at least
> >>> gets to be useful to one group of people. Also, since Ted seems pretty
> >>> keen on using this, I imagine it is much more likely to produce real
> >>> world, immediately useful tests not written by me (I'm not being lazy,
> >>> I just think it is better to get other people's experiences other than
> >>> my own).
> >>>
> >>
> >> That doesn't make sense does it? The tests might not be limited to
> >> fs/ext4. We might have other sub-systems that add tests.
> >
> > Well, I have some small isolated examples that I think would probably
> > work no matter what, so we can get some usage outside of ext4. Also,
> > if we want to limit the number of tests, then we don't expect to get
> > much usage outside of ext4 before v5.5 anyway. I just figure, it's
> > better to make it work for one person than no one, right?
> >
> > In any case, I admit it is not a great idea. I just thought it had
> > some interesting advantages over going in through linux-kselftest that
> > were worth exploring.
> >
> >> So, we will have to work to make linux-next as the base for new
> >> development and limit the number of tests to where it will be
> >> easier work in this mode for 5.5. We can stage the pull requests
> >> so that kunit lands first followed by tests.
> >
> > So we are going to encourage maintainers to allow tests in their tree
> > based on KUnit on the assumption that KUnit will get merged before
> > there changes? That sounds like a huge burden, not just on us, but on
> > other maintainers and users.
> >
> > I think if we are going to allow tests before KUnit is merged, we
> > should have the tests come in through the same tree as KUnit.
> >
> >> We have a similar situation with kselftest as well. Sub-systems
> >> send tests that depend on their tress separately.
> >
> > Well it is different if the maintainer wants to send the test in
> > through their tree, right? Otherwise, it won't matter what the state
> > of linux-next is and it won't matter when linux-kselftest gets merged.
> > Or am I not understanding you?
> >
>
> Let's talk about current state. Right now kunit is in linux-next and
> we want to add a few more tests. We will have to coordinate the effort.
> Once kunit get into mainline, then the need for this coordination goes
> down.

Sure, I was just thinking that getting other people to write the tests
would be better. Since not only is it then useful to someone else, it
provides the best possible exercise of KUnit.

Nevertheless, it would probably just be easier to get a handful of
example tests, and it is less likely to result in any issues for v5.5,
so that's probably better. (I think that is what you are hinting at
here. ;-) )

Hey Ted, do you know if that ext4 timestamp test can go in through
linux-kselftest? It seemed fairly self-contained. Or is that what you
were saying wouldn't work for you?

> Let's focus on the next few weeks first so we can get this into mainline
> in 5.5.

I agree. That is the most important thing.

> The two of us can chat next week and come up with a plan.

Sure.

Cheers!
