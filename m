Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3124CC6EE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2019 02:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbfJEAdU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 20:33:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45328 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfJEAdU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 20:33:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so4835731pfb.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Oct 2019 17:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D46P+pVFfxgwgDsZx7SQOen52ll2cZjAnqUT3X3NgW0=;
        b=pfJammvnqsEMehjoLkxaDxOUGpDw9sMZZncjKjevQVD06AywjDWgKxI3wf/rjLvej+
         UMstuf7cZplWndCtVzElsJOLS9g3ywukZExpQOCwhcvJdVD/JBab/7OxMaqUq+VMf8uB
         HAlF4ShFAU0DFBIxJWc0azVVvQ3Wy3f/oPQ9fuPzdpvWA0iIdowJ2c5Zbg/9JFOECY68
         O0WE57VT7qGlC8/9NlRmT3cO731/aVh8fcnZ5D//mK4n1CuG+yjNV9JbOBBcB23LSygI
         0TQKj3Hpc++fct7e7Rz4uTtgBBwkQmtKSHbbFGBlPsmvEeBSrzgLlq+QG4ouGMdfYcWZ
         C2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D46P+pVFfxgwgDsZx7SQOen52ll2cZjAnqUT3X3NgW0=;
        b=DK1287Ud5del7a1dDo1MnmK1hANJXeggGdwM4l8Nt1o5RFLOTuy5+NX1jxu9WKKaOi
         3mOSiIt+Rp0Kw4XwJaOb7laFzMD6mGDpQ9BCcgT4dfUxkvurrW24ryyyQYWIglQU5wwC
         rmRPebQHakzd5yyUYT7KufGUAMJQGs4OCsFwJ81z0krxYUXfLnWpiNwCLGHKTMppmpnN
         fknu/7cxIj4S5krjlLIVX084NpAIgGUXWgmycVymfyQkXFEzN6SddqryGzu6mzYzcA2S
         7UTL7a7Axs88tJhkmo0Q2duLB5Q6YEP6A2wtoVJ/NQWgTJyKlR8IQxHPpypJynaP5D1z
         M5yQ==
X-Gm-Message-State: APjAAAXES9UVqhpvf3m6tvcfGCFX04ziLcrdu4gZfqPZjle4/sP6LioM
        wAMtHMLlnsMtEdkYcbUz4WW/SQJz7MkH+KdXobodMw==
X-Google-Smtp-Source: APXvYqw66A3fhEGGLREG4yw4Pr+r6ZvkAOqsm8j0EV5rRDrFLbH6NKzALIarwIy5UgNm5Ny2R6LZT6ifOs8an8aRKWI=
X-Received: by 2002:a63:ba47:: with SMTP id l7mr17994364pgu.201.1570235599104;
 Fri, 04 Oct 2019 17:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20191004213812.GA24644@mit.edu> <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
 <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org> <20191004222714.GA107737@google.com>
 <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org> <20191004232955.GC12012@mit.edu>
 <CAFd5g456rBSp177EkYAwsF+KZ0rxJa90mzUpW2M3R7tWbMAh9Q@mail.gmail.com> <63e59b0b-b51e-01f4-6359-a134a1f903fd@kernel.org>
In-Reply-To: <63e59b0b-b51e-01f4-6359-a134a1f903fd@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 4 Oct 2019 17:33:07 -0700
Message-ID: <CAFd5g47wji3T9RFmqBwt+jPY0tb83y46oj_ttOq=rTX_N1Ggyg@mail.gmail.com>
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

On Fri, Oct 4, 2019 at 4:57 PM shuah <shuah@kernel.org> wrote:
>
> On 10/4/19 5:52 PM, Brendan Higgins wrote:
> > On Fri, Oct 4, 2019 at 4:30 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >>
> >> On Fri, Oct 04, 2019 at 04:47:09PM -0600, shuah wrote:
> >>>> However, if I encourage arbitrary tests/improvements into my KUnit
> >>>> branch, it further diverges away from torvalds/master, and is more
> >>>> likely that there will be a merge conflict or issue that is not related
> >>>> to the core KUnit changes that will cause the whole thing to be
> >>>> rejected again in v5.5.
> >>>
> >>> The idea is that the new development will happen based on kunit in
> >>> linux-kselftest next. It will work just fine. As we accepts patches,
> >>> they will go on top of kunit that is in linux-next now.
> >>
> >> I don't see how this would work.  If I add unit tests to ext4, they
> >> would be in fs/ext4.  And to the extent that I need to add test mocks
> >> to allow the unit tests to work, they will involve changes to existing
> >> files in fs/ext4.  I can't put them in the ext4.git tree without
> >> pulling in the kunit changes into the ext4 git tree.  And if they ext4
> >> unit tests land in the kunit tree, it would be a receipe for large
> >> numbers of merge conflicts.
> >
> > That's where I was originally coming from.
> >
> > So here's a dumb idea: what if we merged KUnit through the ext4 tree?
> > I imagine that could potentially get very confusing when we go back to
> > sending changes in through the kselftest tree, but at least it means
> > that ext4 can use it in the meantime, which means that it at least
> > gets to be useful to one group of people. Also, since Ted seems pretty
> > keen on using this, I imagine it is much more likely to produce real
> > world, immediately useful tests not written by me (I'm not being lazy,
> > I just think it is better to get other people's experiences other than
> > my own).
> >
>
> That doesn't make sense does it? The tests might not be limited to
> fs/ext4. We might have other sub-systems that add tests.

Well, I have some small isolated examples that I think would probably
work no matter what, so we can get some usage outside of ext4. Also,
if we want to limit the number of tests, then we don't expect to get
much usage outside of ext4 before v5.5 anyway. I just figure, it's
better to make it work for one person than no one, right?

In any case, I admit it is not a great idea. I just thought it had
some interesting advantages over going in through linux-kselftest that
were worth exploring.

> So, we will have to work to make linux-next as the base for new
> development and limit the number of tests to where it will be
> easier work in this mode for 5.5. We can stage the pull requests
> so that kunit lands first followed by tests.

So we are going to encourage maintainers to allow tests in their tree
based on KUnit on the assumption that KUnit will get merged before
there changes? That sounds like a huge burden, not just on us, but on
other maintainers and users.

I think if we are going to allow tests before KUnit is merged, we
should have the tests come in through the same tree as KUnit.

> We have a similar situation with kselftest as well. Sub-systems
> send tests that depend on their tress separately.

Well it is different if the maintainer wants to send the test in
through their tree, right? Otherwise, it won't matter what the state
of linux-next is and it won't matter when linux-kselftest gets merged.
Or am I not understanding you?
