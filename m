Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B74849B684
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 20:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389518AbfHWS4R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 14:56:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42735 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733187AbfHWS4Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 14:56:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id i30so7017729pfk.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2019 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s/+aPLXaaGZm0z/f+opsuLonUw7MdHLn7J6CRhMZwFI=;
        b=aLqCki7OFRYb/zbxlgpGpa4MLZg24uOYeXo+bf759ur8hv1j2TRWPaLstl3a5bk10n
         k9gZHsbj7RxEFvNm/UBw4x6AHMOqoIf/ZGCxlxIps6H1nGB4dHIYzRm+iwSZsHo9cyep
         NQSVwGP5NR+YSOXJmM805vzb7tKcZoohUkGLv2BSmjPrKeneCaMQK2eneKbObMLvTYkP
         lUd9iMs9dZblf94k6Ei365fYzU3AUwiPyeM1OqmPPs95PxMEymqhlGu1BcqjfCV5P0OP
         qkLQ4DDcSRoXYkgDNbUMDsSyuoKrdlN3EVmPRXJtcw1zjcwJLDnJgdEsctFaR5HmJxC5
         nJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/+aPLXaaGZm0z/f+opsuLonUw7MdHLn7J6CRhMZwFI=;
        b=CjhlyZyQ+d2P3gCtdvOAom8ydNj/KTCezxYcMyejLUvGsy7Pq37xVkrCjLHyc3e4tW
         Wz4S/MZhYHamjJwwCKO5wXR1q8FXC8p2fVc4y4gRw7C+z18roEfqV6twrSw4grDgGxFj
         vnvtqRGm46/D6Wx9oD4eDsuZll//Lz1UT5q+OlCGQSaT9ndbAxtYm9xMqCia+jjiKRTA
         qsh1s9icS0dXKY9svaRgYcCgLgkfKFfs+HOrX51oCGy95HUSx8zR4FDs7TcuAO5a0Ivu
         dJgSHWIl2+QaHfVS0nwFzxtcd8w7wvDf71Q/C5+oQp2JwJhoIymf3StZanygcLxyCxRE
         6Unw==
X-Gm-Message-State: APjAAAUvEnENwXeHjzAMmqmGXKg+J2dKzYW1lKFjbHHc2m7UB+cC076T
        yd03Uk4Y55FUmkEJDB6FpI7vNGrEmdgvHX3OIBLCRA==
X-Google-Smtp-Source: APXvYqwVWo6KNiW0mQ1ETfauvPQKOgX6Abfum/nAPgc5t6Yzc0edHSPUqib3OQFJdFu2HNr4tJqGaSMlXFS9ixOmggs=
X-Received: by 2002:a17:90a:25ea:: with SMTP id k97mr6804556pje.131.1566586575337;
 Fri, 23 Aug 2019 11:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190820232046.50175-1-brendanhiggins@google.com>
 <20190820232046.50175-2-brendanhiggins@google.com> <7f2c8908-75f6-b793-7113-ad57c51777ce@kernel.org>
 <CAFd5g44mRK9t4f58i_YMEt=e9RTxwrrhFY_V2LW_E7bUwR3cdg@mail.gmail.com>
 <4513d9f3-a69b-a9a4-768b-86c2962b62e0@kernel.org> <CAFd5g446J=cVW4QW+QeZMLDi+ANqshAW6KTrFFBTusPcdr6-GA@mail.gmail.com>
 <42c6235c-c586-8de1-1913-7cf1962c6066@kernel.org> <CAFd5g44hLgeqPtNw1zQ5k_+apBm=ri_6=wAgHk=oPOvQs6xgNg@mail.gmail.com>
 <54f3c011-d666-e828-5e77-359b7a7374e7@kernel.org>
In-Reply-To: <54f3c011-d666-e828-5e77-359b7a7374e7@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 23 Aug 2019 11:56:03 -0700
Message-ID: <CAFd5g44NAs6KK0_sG9itgT5qxujpyx36XV6tT8=zMynG-ZyVhQ@mail.gmail.com>
Subject: Re: [PATCH v14 01/18] kunit: test: add KUnit test runner core
To:     shuah <shuah@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
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

On Fri, Aug 23, 2019 at 11:32 AM shuah <shuah@kernel.org> wrote:
>
> On 8/23/19 11:54 AM, Brendan Higgins wrote:
> > On Fri, Aug 23, 2019 at 10:34 AM shuah <shuah@kernel.org> wrote:
> >>
> >> On 8/23/19 11:27 AM, Brendan Higgins wrote:
> >>> On Fri, Aug 23, 2019 at 10:05 AM shuah <shuah@kernel.org> wrote:
> >>>>
> >>>> On 8/23/19 10:48 AM, Brendan Higgins wrote:
> >>>>> On Fri, Aug 23, 2019 at 8:33 AM shuah <shuah@kernel.org> wrote:
> >>>>>>
> >>>>>> Hi Brendan,
> >>>>>>
> >>>>>> On 8/20/19 5:20 PM, Brendan Higgins wrote:
> >>>>>>> Add core facilities for defining unit tests; this provides a common way
> >>>>>>> to define test cases, functions that execute code which is under test
> >>>>>>> and determine whether the code under test behaves as expected; this also
> >>>>>>> provides a way to group together related test cases in test suites (here
> >>>>>>> we call them test_modules).
> >>>>>>>
> >>>>>>> Just define test cases and how to execute them for now; setting
> >>>>>>> expectations on code will be defined later.
> >>>>>>>
> >>>>>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> >>>>>>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>>>>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> >>>>>>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> >>>>>>> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> >>>>>>> ---
> >>>>>>>      include/kunit/test.h | 179 ++++++++++++++++++++++++++++++++++++++++
> >>>>>>>      kunit/Kconfig        |  17 ++++
> >>>>>>>      kunit/Makefile       |   1 +
> >>>>>>>      kunit/test.c         | 191 +++++++++++++++++++++++++++++++++++++++++++
> >>>>>>>      4 files changed, 388 insertions(+)
> >>>>>>>      create mode 100644 include/kunit/test.h
> >>>>>>>      create mode 100644 kunit/Kconfig
> >>>>>>>      create mode 100644 kunit/Makefile
> >>>>>>>      create mode 100644 kunit/test.c
> >>>>>>>
> >>>>>>> diff --git a/include/kunit/test.h b/include/kunit/test.h
> >>>>>>> new file mode 100644
> >>>>>>> index 0000000000000..e0b34acb9ee4e
> >>>>>>> --- /dev/null
> >>>>>>> +++ b/include/kunit/test.h
> >>>>>>> @@ -0,0 +1,179 @@
> >>>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>>>>>> +/*
> >>>>>>> + * Base unit test (KUnit) API.
> >>>>>>> + *
> >>>>>>> + * Copyright (C) 2019, Google LLC.
> >>>>>>> + * Author: Brendan Higgins <brendanhiggins@google.com>
> >>>>>>> + */
> >>>>>>> +
> >>>>>>> +#ifndef _KUNIT_TEST_H
> >>>>>>> +#define _KUNIT_TEST_H
> >>>>>>> +
> >>>>>>> +#include <linux/types.h>
> >>>>>>> +
> >>>>>>> +struct kunit;
> >>>>>>> +
> >>>>>>> +/**
> >>>>>>> + * struct kunit_case - represents an individual test case.
> >>>>>>> + * @run_case: the function representing the actual test case.
> >>>>>>> + * @name: the name of the test case.
> >>>>>>> + *
> >>>>>>> + * A test case is a function with the signature, ``void (*)(struct kunit *)``
> >>>>>>> + * that makes expectations (see KUNIT_EXPECT_TRUE()) about code under test. Each
> >>>>>>> + * test case is associated with a &struct kunit_suite and will be run after the
> >>>>>>> + * suite's init function and followed by the suite's exit function.
> >>>>>>> + *
> >>>>>>> + * A test case should be static and should only be created with the KUNIT_CASE()
> >>>>>>> + * macro; additionally, every array of test cases should be terminated with an
> >>>>>>> + * empty test case.
> >>>>>>> + *
> >>>>>>> + * Example:
> >>>>>>
> >>>>>> Can you fix these line continuations. It makes it very hard to read.
> >>>>>> Sorry for this late comment. These comments lines are longer than 80
> >>>>>> and wrap.
> >>>>>
> >>>>> None of the lines in this commit are over 80 characters in column
> >>>>> width. Some are exactly 80 characters (like above).
> >>>>>
> >>>>> My guess is that you are seeing the diff added text (+ ), which when
> >>>>> you add that to a line which is exactly 80 char in length ends up
> >>>>> being over 80 char in email. If you apply the patch you will see that
> >>>>> they are only 80 chars.
> >>>>>
> >>>>>>
> >>>>>> There are several comment lines in the file that are way too long.
> >>>>>
> >>>>> Note that checkpatch also does not complain about any over 80 char
> >>>>> lines in this file.
> >>>>>
> >>>>> Sorry if I am misunderstanding what you are trying to tell me. Please
> >>>>> confirm either way.
> >>>>>
> >>>>
> >>>> WARNING: Avoid unnecessary line continuations
> >>>> #258: FILE: include/kunit/test.h:137:
> >>>> +                */                                                            \
> >>>>
> >>>> total: 0 errors, 2 warnings, 388 lines checked
> >>>
> >>> Ah, okay so you don't like the warning about the line continuation.
> >>> That's not because it is over 80 char, but because there is a line
> >>> continuation after a comment. I don't really see a way to get rid of
> >>> it without removing the comment from inside the macro.
> >>>
> >>> I put this TODO there in the first place a Luis' request, and I put it
> >>> in the body of the macro because this macro already had a kernel-doc
> >>> comment and I didn't think that an implementation detail TODO belonged
> >>> in the user documentation.
> >>>
> >>>> Go ahead fix these. It appears there are few lines that either longer
> >>>> than 80. In general, I keep them around 75, so it is easier read.
> >>>
> >>> Sorry, the above is the only checkpatch warning other than the
> >>> reminder to update the MAINTAINERS file.
> >>>
> >>> Are you saying you want me to go through and make all the lines fit in
> >>> 75 char column width? I hope not because that is going to be a pretty
> >>> substantial change to make.
> >>>
> >>
> >> There are two things with these comment lines. One is checkpatch
> >> complaining and the other is general readability.
> >
> > So for the checkpatch warning, do you want me to move the comment out
> > of the macro body into the kernel-doc comment? I don't really think it
> > is the right place for a comment of this nature, but I think it is
> > probably better than dropping it entirely (I don't see how else to do
> > it without just removing the comment entirely).
> >
>
> Don't drop the comments. It makes perfect sense to turn this into a
> kernel-doc comment.

I am fine with that. I will do that in a subsequent revision once we
figure out the column limit issue.

> We are going back forth on this a lot. I see several lines 81+ in
> this file. I am at 5.3-rc5 and my commit hooks aren't happy. I am
> fine with it if you want to convert these to kernel-doc comments.
> I think it makes perfect sense.

Okay, so this is interesting. When I look at the applied patches in my
local repo, I don't see any 81+ lines. So it seems that something
interesting is going on here.

To be clear (sorry for the stupid question) you are seeing the issue
after you applied the patch, and not in the patch file itself?

Since we are still at OSS, would you mind if we meet up this afternoon
so I can see this issue you are seeing? I imagine we should get this
figured out pretty quickly.

Cheers
