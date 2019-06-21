Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B641C4F136
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2019 01:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfFUXgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 19:36:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34121 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFUXgM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 19:36:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so3719665plt.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2019 16:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sb/H3tilyj0EK++EBKlbF8X4xe8yU07TZHy2A/fenNk=;
        b=prCrzdXSk30AJCMv+sSZXVQB3mmI52zCpk3QjvPfrXjbWUmkr5RJeHN3VW/8BA6CtD
         Jx+Y3u0DTDnIxHWzhNwKRF3g+yYiM0VQDnlPoGbWO6x9TECCHkj/zY2eNm2q4KwUaUZ/
         PQbESGU8dN38EnQdNQDuqjJhGeXZSEH6VjPKkplzJ14HM3z2D0OLGNiCDAFsVLWwXGiA
         7ZDc9Mw1C6t7AWgJLW2hxZEi1cehAPWXMRlpbHzdzBLMCJ0hGRQpxsZh6A2Mpc3unus3
         j1UcGGXHaAcBECA9lXClfSZsiNhKKKtWOOzJkNkzfY2AZmXyeX6TxWegDfm7bsaZxvCf
         PEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sb/H3tilyj0EK++EBKlbF8X4xe8yU07TZHy2A/fenNk=;
        b=pFS45A+N1JNQLjcXddtL3tVcnb0O8YM/9flagURZD/9PlSuuFcuP0J6Xv0vigVx3ga
         sgwHbT5dnrR/H8j1yto67gpFRZh6i5yGru+PN4gZOWyYMYYroR72VFpKCqrFEWqXRdZf
         7SUKGoioSTyMfEcb7vRXeOG9KbknbE2ZZ0mk9l1GTQX1xvdvSuOlSB73cb3znZrBfqDB
         PZ9NhVQG/e247T0byGSZ4yzI9bm57X8TyGOog3ZmVx6xCnzJF46594C70xp2fBu5eO9L
         PPIQDL15DmK0gbb8K+LieOv/O+rW6hL3AB4yyKOMRzlmrRBN6a0o7mgfC4Qgqsu97tTP
         vpjw==
X-Gm-Message-State: APjAAAXHp5CwhkITrpYImouKTrzYF99/4ymL7iiwwsbR21wLu8Knf3rJ
        20icFoJXDbHaRWHSM1CUxjVmEDm05rWbC0E8SXE2nw==
X-Google-Smtp-Source: APXvYqyDOITFnbEbjASefA/StmtDVD64C4tIs4B7EpCbn+epn4j9i0oWshY43Kw2oFG+/67p1uNjgDJBcCkm/XE/zVk=
X-Received: by 2002:a17:902:2006:: with SMTP id n6mr78068890pla.232.1561160170725;
 Fri, 21 Jun 2019 16:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com> <10feac3e-7621-65e5-fbf0-9c63fcbe09c9@gmail.com>
In-Reply-To: <10feac3e-7621-65e5-fbf0-9c63fcbe09c9@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 21 Jun 2019 16:35:59 -0700
Message-ID: <CAFd5g44S-3J+g328PT42HVd=v4Us-JAzFP0MuA7f_qJ-srddsg@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah <shuah@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
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

On Wed, Jun 19, 2019 at 6:17 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> Hi Brendan,
>
> I am only responding to this because you asked me to in the v4 thread.

Yes, I did! Thank you, I appreciate it!

> Thank you for evaluating my comments in the v4 thread and asking me to
> comment on v5

Of course, I feel as though I ought to address any and all valid comments.

> On 6/17/19 1:25 AM, Brendan Higgins wrote:
> > ## TL;DR
> >
> > A not so quick follow-up to Stephen's suggestions on PATCH v4. Nothing
> > that really changes any functionality or usage with the minor exception
> > of a couple public functions that Stephen asked me to rename.
> > Nevertheless, a good deal of clean up and fixes. See changes below.
> >
> > As for our current status, right now we got Reviewed-bys on all patches
> > except:
> >
> > - [PATCH v5 08/18] objtool: add kunit_try_catch_throw to the noreturn
> >   list
> >
> > However, it would probably be good to get reviews/acks from the
> > subsystem maintainers on:
> >
> > - [PATCH v5 06/18] kbuild: enable building KUnit
> > - [PATCH v5 08/18] objtool: add kunit_try_catch_throw to the noreturn
> >   list
> > - [PATCH v5 15/18] Documentation: kunit: add documentation for KUnit
> > - [PATCH v5 17/18] kernel/sysctl-test: Add null pointer test for
> >   sysctl.c:proc_dointvec()
> > - [PATCH v5 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
> >   SYSCTL section
> >
> > Other than that, I think we should be good to go.
> >
> > One last thing, I updated the background to include my thoughts on KUnit
> > vs. in kernel testing with kselftest in the background sections as
> > suggested by Frank in the discussion on PATCH v2.
> >
> > ## Background
> >
> > This patch set proposes KUnit, a lightweight unit testing and mocking
> > framework for the Linux kernel.
> >
> > Unlike Autotest and kselftest, KUnit is a true unit testing framework;
> > it does not require installing the kernel on a test machine or in a VM
> > (however, KUnit still allows you to run tests on test machines or in VMs
> > if you want[1]) and does not require tests to be written in userspace
> > running on a host kernel. Additionally, KUnit is fast: From invocation
> > to completion KUnit can run several dozen tests in under a second.
> > Currently, the entire KUnit test suite for KUnit runs in under a second
> > from the initial invocation (build time excluded).
> >
> > KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> > Googletest/Googlemock for C++. KUnit provides facilities for defining
> > unit test cases, grouping related test cases into test suites, providing
> > common infrastructure for running tests, mocking, spying, and much more.
> >
>
> I looked only at this section, as was specifically requested:
>
> > ### But wait! Doesn't kselftest support in kernel testing?!
> >
> > In a previous version of this patchset Frank pointed out that kselftest
> > already supports writing a test that resides in the kernel using the
> > test module feature[2]. LWN did a really great summary on this
> > discussion here[3].
> >
> > Kselftest has a feature that allows a test module to be loaded into a
> > kernel using the kselftest framework; this does allow someone to write
> > tests against kernel code not directly exposed to userland; however, it
> > does not provide much of a framework around how to structure the tests.
> > The kselftest test module feature just provides a header which has a
> > standardized way of reporting test failures,
>
>
> > and then provides
> > infrastructure to load and run the tests using the kselftest test
> > harness.
>
> The in-kernel tests can also be invoked at boot time if they are
> configured (Kconfig) as in-kernel instead of as modules.  I did not
> check how many of the tests have tri-state configuration to allow
> this, but the few that I looked at did.
>
> >
> > The kselftest test module does not seem to be opinionated at all in
> > regards to how tests are structured, how they check for failures, how
> > tests are organized. Even in the method it provides for reporting
> > failures is pretty simple; it doesn't have any more advanced failure
> > reporting or logging features. Given what's there, I think it is fair to
> > say that it is not actually a framework, but a feature that makes it
> > possible for someone to do some checks in kernel space.
>
> I would call that description a little dismissive.  The set of in-kernel
> tests that I looked like followed a common pattern and reported results
> in a uniform manner.

I didn't mean to sound dismissive. I was only referring to what was
present in the actual header itself. There really isn't much there; it
provides a function which takes an expression, evaluates it,
increments a counter of all tests, and if false, prints out a warning;
also, it provides a module init which runs the user defined test
function called selftest(), and then prints the number of tests that
passed and the number of tests that failed; that's it. I was just
trying to make the point that it is pretty bare bones, and isn't
really much of a framework.

> >
> > Furthermore, kselftest test module has very few users. I checked for all
> > the tests that use it using the following grep command:
> >
> > grep -Hrn -e 'kselftest_module\.h'
> >
> > and only got three results: lib/test_strscpy.c, lib/test_printf.c, and
> > lib/test_bitmap.c.
>
> You missed many tests.  I listed much more than that in the v4 thread, and
> someone else also listed more in the v4 thread.

Oh, sorry, I forgot that more were listed in the thread.

> >
> > So despite kselftest test module's existence, there really is no feature
> > overlap between kselftest and KUnit, save one: that you can use either
> > to write an in-kernel test, but this is a very small feature in
> > comparison to everything that KUnit allows you to do. KUnit is a full
> > x-unit style unit testing framework, whereas kselftest looks a lot more
> > like an end-to-end/functional testing framework, with a feature that
> > makes it possible to write in-kernel tests.
>
> The description does not give enough credit to what is in kselftest.

You are right about me missing a number of the tests, but there really
is not much infrastructure in kselftest for this at all. It really
doesn't impose any structure of any kind other than that there must be
exactly one static function named selftest() that takes no arguments;
and then you use KSTM_CHECK_ZERO() to do some checks; that's it. It
doesn't have anything else in the actual kselftest module stuff.

>
> It does not matter whether KUnit provides additional things, relative
> to kselftest.  The point I was making is that there appears to be
> _some_ overlap between kselftest and KUnit, and if there is overlap
> then it is worth considering whether the overlap can be unified instead
> of duplicated.

I think I understand what you are saying, but the point I was trying
to make here is that it is so simplistic, it doesn't really
conceptually overlap since it is so limited in what structure and
features it provides. It's kind of like what Ted said previously about
how you have C so you can technically do whatever you want, but there
is nothing inherent to the kselftest test module that does any of
those things (other than what I mentioned above).

> I don't have a dog in this fight and the discussion in the v4 thread
> went way off track.  Thus I am not going to get sucked back into a
> pointless debate in this thread.

Sure, I don't want to debate the point further either (I had a hard
time understanding what the point was at the end myself).

Nevertheless, I do want to make sure that I addressed this because I
think you did indeed have a point that was worth addressing, and I
don't want to waste anyone's time in the future by not addressing it.

Nevertheless, like I said, I don't want to get too detailed on the
topic otherwise like Shuah suggests later, it might end up just
leading people to draw a comparison that doesn't need to be made, but
I also don't want to misrepresent anything. In anycase, I will follow
up on this point directly with Shuah.

> Thanks for adding this section to address the issue.

No need to thank me; that is what I felt is the correct thing to do. I
didn't address the point before and it caused you and other to spend a
lot of time debating the point.

Also, it looks like Shuah is asking me to drop the section. I will
discuss this point further there.

Thanks!

> -Frank
>
>
> >
> > ### What's so special about unit testing?
> >
> > A unit test is supposed to test a single unit of code in isolation,
> > hence the name. There should be no dependencies outside the control of
> > the test; this means no external dependencies, which makes tests orders
> > of magnitudes faster. Likewise, since there are no external dependencies,
> > there are no hoops to jump through to run the tests. Additionally, this
> > makes unit tests deterministic: a failing unit test always indicates a
> > problem. Finally, because unit tests necessarily have finer granularity,
> > they are able to test all code paths easily solving the classic problem
> > of difficulty in exercising error handling code.
> >
> > ### Is KUnit trying to replace other testing frameworks for the kernel?
> >
> > No. Most existing tests for the Linux kernel are end-to-end tests, which
> > have their place. A well tested system has lots of unit tests, a
> > reasonable number of integration tests, and some end-to-end tests. KUnit
> > is just trying to address the unit test space which is currently not
> > being addressed.
> >
> > ### More information on KUnit
> >
> > There is a bunch of documentation near the end of this patch set that
> > describes how to use KUnit and best practices for writing unit tests.
> > For convenience I am hosting the compiled docs here[4].
> >
> > Additionally for convenience, I have applied these patches to a
> > branch[5]. The repo may be cloned with:
> > git clone https://kunit.googlesource.com/linux
> > This patchset is on the kunit/rfc/v5.2-rc4/v5 branch.
> >
> > ## Changes Since Last Version
> >
> > Aside from a couple public function renames, there isn't really anything
> > in here that changes any functionality.
> >
> > - Went through and fixed a couple of anti-patterns suggested by Stephen
> >   Boyd. Things like:
> >   - Dropping an else clause at the end of a function.
> >   - Dropping the comma on the closing sentinel, `{}`, of a list.
> > - Inlines a bunch of functions in the test case running logic in patch
> >   01/18 to make it more readable as suggested by Stephen Boyd
> > - Found and fixed bug in resource deallocation logic in patch 02/18. Bug
> >   was discovered as a result of making a change suggested by Stephen
> >   Boyd. This does not substantially change how any of the code works
> >   conceptually.
> > - Renamed new_string_stream() to alloc_string_stream() as suggested by
> >   Stephen Boyd.
> > - Made string-stream a KUnit managed object - based on a suggestion made
> >   by Stephen Boyd.
> > - Renamed kunit_new_stream() to alloc_kunit_stream() as suggested by
> >   Stephen Boyd.
> > - Removed the ability to set log level after allocating a kunit_stream,
> >   as suggested by Stephen Boyd.
> >
> > [1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
> > [2] https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html#test-module
> > [3] https://lwn.net/Articles/790235/
> > [4] https://google.github.io/kunit-docs/third_party/kernel/docs/
> > [5] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.2-rc4/v5
> >
>
