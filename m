Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9874718F54
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 19:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfEIRjA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 13:39:00 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37597 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfEIRi7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 13:38:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id r10so2349098otd.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2019 10:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0VuxFpeT9DA70XmwW0AmbRmT5GsxrO9BRQcv/Ek49w=;
        b=jXRR9TYq3+d3jyuw/RgfG2HcJ0Vz9SmXqn06mlMrXGuWUnwlgtUIMnbQvbO5805a1e
         drEhMAYtD9gCXcLWFvUREi1DRhqNl88mkMXA/eh7neOdxQHJ+MCYdNho1AFukPPGeN6L
         6GblOrKkQAzN8qToDGpyGFjugBRhE08fsz6loOMsKRvj+PmAJxDtHCd9lLwfZhSS2HGW
         tn3gVQG265klHR9HUZVPMPYnTxEpEB7f5k+Vpss5r6WiL0MeTvzF7Hhdx3ArIyve+ASX
         ewT0IA8S4cWtIU21BBr6VN0nPATbl3/3EOwb/wQ3de/f5y6B0wFKspwOGCgk1Gk4RP+L
         FLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0VuxFpeT9DA70XmwW0AmbRmT5GsxrO9BRQcv/Ek49w=;
        b=iJYKMbzK4I5vAk5UyMUUrS5lL6U5PaZ0ui4ikTmGabSTN6zRM2DQODFHluzSysBRQ6
         H/PS9OZZNUBIrjJ4d9gNx7Bm81CV2d4e+v3+lEOfLRPpwvPNaKYr9dB+Uyli2kzeZ59M
         aUNGTehSnfuoqei6nVLb92WAa4r4pAbonlLwJUiqGRxpwSqIhRBfP4pny1wq0TqMMMvd
         5DR5owtMzcUhZumq2nvGoVqc8MZfihzDGBl6X79kHZvV5C6dr08Q+suc7nLbztBxJ09L
         ghpQvD2K1wNK5MrZV5h7brFnnOBbZotTo8It1yyTUKVtEBeq6ggnSOSp30R342noHoRm
         fGjw==
X-Gm-Message-State: APjAAAWZ53+mff97PVUHpDZXA7OSpyqBk8FjGnDPagA3Iz8KgTiddzyT
        xEfMrm5pVp6CE8hWzW5tcBtcZcGOjJVwv5nk6ZW16w==
X-Google-Smtp-Source: APXvYqyubWyHqbFDXiscXJdmsOtAENFPiVrPHmNzeTfVlvr8kdYn9Z/FJJa+YsFyguiWKexehWV8Cog75A4JetNj5ns=
X-Received: by 2002:a05:6830:14cd:: with SMTP id t13mr3352372otq.25.1557423538487;
 Thu, 09 May 2019 10:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-15-brendanhiggins@google.com> <498d42d8-0b8b-6ee4-c0ad-42760a7e89d4@infradead.org>
In-Reply-To: <498d42d8-0b8b-6ee4-c0ad-42760a7e89d4@infradead.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 9 May 2019 10:38:45 -0700
Message-ID: <CAFd5g45cd8AmHfmOu=N4y_XcvpjfwT=Z=dUzFqjQKJDr+OByUA@mail.gmail.com>
Subject: Re: [PATCH v2 14/17] Documentation: kunit: add documentation for KUnit
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Felix Guo <felixguoxiuping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Hi,
>
> On 5/1/19 4:01 PM, Brendan Higgins wrote:
> > Add documentation for KUnit, the Linux kernel unit testing framework.
> > - Add intro and usage guide for KUnit
> > - Add API reference
> >
> > Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  Documentation/index.rst           |   1 +
> >  Documentation/kunit/api/index.rst |  16 ++
> >  Documentation/kunit/api/test.rst  |  15 +
> >  Documentation/kunit/faq.rst       |  46 +++
> >  Documentation/kunit/index.rst     |  80 ++++++
> >  Documentation/kunit/start.rst     | 180 ++++++++++++
> >  Documentation/kunit/usage.rst     | 447 ++++++++++++++++++++++++++++++
> >  7 files changed, 785 insertions(+)
> >  create mode 100644 Documentation/kunit/api/index.rst
> >  create mode 100644 Documentation/kunit/api/test.rst
> >  create mode 100644 Documentation/kunit/faq.rst
> >  create mode 100644 Documentation/kunit/index.rst
> >  create mode 100644 Documentation/kunit/start.rst
> >  create mode 100644 Documentation/kunit/usage.rst
> >
>
> > diff --git a/Documentation/kunit/api/index.rst b/Documentation/kunit/api/index.rst
> > new file mode 100644
> > index 0000000000000..c31c530088153
> > --- /dev/null
> > +++ b/Documentation/kunit/api/index.rst
> > @@ -0,0 +1,16 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=============
> > +API Reference
> > +=============
> > +.. toctree::
> > +
> > +     test
> > +
> > +This section documents the KUnit kernel testing API. It is divided into 3
> > +sections:
> > +
> > +================================= ==============================================
> > +:doc:`test`                       documents all of the standard testing API
> > +                                  excluding mocking or mocking related features.
> > +================================= ==============================================
>
> What 3 sections does the above refer to?  seems to be missing.

Whoops, that references documentation added in a later patch (not
included in this patchset). Thanks for pointing this out, will fix in
next revision.

> > diff --git a/Documentation/kunit/start.rst b/Documentation/kunit/start.rst
> > new file mode 100644
> > index 0000000000000..5cdba5091905e
> > --- /dev/null
> > +++ b/Documentation/kunit/start.rst
> > @@ -0,0 +1,180 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +===============
> > +Getting Started
> > +===============
> > +
> > +Installing dependencies
> > +=======================
> > +KUnit has the same dependencies as the Linux kernel. As long as you can build
> > +the kernel, you can run KUnit.
> > +
> > +KUnit Wrapper
> > +=============
> > +Included with KUnit is a simple Python wrapper that helps format the output to
> > +easily use and read KUnit output. It handles building and running the kernel, as
> > +well as formatting the output.
> > +
> > +The wrapper can be run with:
> > +
> > +.. code-block:: bash
> > +
> > +   ./tools/testing/kunit/kunit.py
> > +
> > +Creating a kunitconfig
> > +======================
> > +The Python script is a thin wrapper around Kbuild as such, it needs to be
>
>                                        around Kbuild. As such,
>
> > +configured with a ``kunitconfig`` file. This file essentially contains the
> > +regular Kernel config, with the specific test targets as well.
> > +
> > +.. code-block:: bash
> > +
> > +     git clone -b master https://kunit.googlesource.com/kunitconfig $PATH_TO_KUNITCONFIG_REPO
> > +     cd $PATH_TO_LINUX_REPO
> > +     ln -s $PATH_TO_KUNIT_CONFIG_REPO/kunitconfig kunitconfig
> > +
> > +You may want to add kunitconfig to your local gitignore.
> > +
> > +Verifying KUnit Works
> > +-------------------------
>
> I would expect Sphinx to complain about the underline length not being the
> same as the header/title above it.

Hmmm...I am pretty sure it wasn't complaining to me, but that might
just be because I didn't build with the right verbosity options or
something.

My experience mostly comes from Markdown which doesn't care about this.

In any case, after some random spot checks it looks like everyone else
uniformly keeps the line under sections to be the same length. So it
looks like I need to fix this regardless.

Will fix in the next revision. Thanks for pointing this out!

> > +
> > +To make sure that everything is set up correctly, simply invoke the Python
> > +wrapper from your kernel repo:
> > +
> > +.. code-block:: bash
> > +
> > +     ./tools/testing/kunit/kunit.py
> > +
> > +.. note::
> > +   You may want to run ``make mrproper`` first.
> > +
> > +If everything worked correctly, you should see the following:
> > +
> > +.. code-block:: bash
> > +
> > +     Generating .config ...
> > +     Building KUnit Kernel ...
> > +     Starting KUnit Kernel ...
> > +
> > +followed by a list of tests that are run. All of them should be passing.
> > +
> > +.. note::
> > +   Because it is building a lot of sources for the first time, the ``Building
> > +   kunit kernel`` step may take a while.
> > +
> > +Writing your first test
> > +==========================
>
> underline length warning?
>
> > +
> > +In your kernel repo let's add some code that we can test. Create a file
> > +``drivers/misc/example.h`` with the contents:
> > +
> > +.. code-block:: c
> > +
> > +     int misc_example_add(int left, int right);
> > +
> > +create a file ``drivers/misc/example.c``:
> > +
> > +.. code-block:: c
> > +
> > +     #include <linux/errno.h>
> > +
> > +     #include "example.h"
> > +
> > +     int misc_example_add(int left, int right)
> > +     {
> > +             return left + right;
> > +     }
> > +
> > +Now add the following lines to ``drivers/misc/Kconfig``:
> > +
> > +.. code-block:: kconfig
> > +
> > +     config MISC_EXAMPLE
> > +             bool "My example"
> > +
> > +and the following lines to ``drivers/misc/Makefile``:
> > +
> > +.. code-block:: make
> > +
> > +     obj-$(CONFIG_MISC_EXAMPLE) += example.o
> > +
> > +Now we are ready to write the test. The test will be in
> > +``drivers/misc/example-test.c``:
> > +
> > +.. code-block:: c
> > +
> > +     #include <kunit/test.h>
> > +     #include "example.h"
> > +
> > +     /* Define the test cases. */
> > +
> > +     static void misc_example_add_test_basic(struct kunit *test)
> > +     {
> > +             KUNIT_EXPECT_EQ(test, 1, misc_example_add(1, 0));
> > +             KUNIT_EXPECT_EQ(test, 2, misc_example_add(1, 1));
> > +             KUNIT_EXPECT_EQ(test, 0, misc_example_add(-1, 1));
> > +             KUNIT_EXPECT_EQ(test, INT_MAX, misc_example_add(0, INT_MAX));
> > +             KUNIT_EXPECT_EQ(test, -1, misc_example_add(INT_MAX, INT_MIN));
> > +     }
> > +
> > +     static void misc_example_test_failure(struct kunit *test)
> > +     {
> > +             KUNIT_FAIL(test, "This test never passes.");
> > +     }
> > +
> > +     static struct kunit_case misc_example_test_cases[] = {
> > +             KUNIT_CASE(misc_example_add_test_basic),
> > +             KUNIT_CASE(misc_example_test_failure),
> > +             {},
> > +     };
> > +
> > +     static struct kunit_module misc_example_test_module = {
> > +             .name = "misc-example",
> > +             .test_cases = misc_example_test_cases,
> > +     };
> > +     module_test(misc_example_test_module);
> > +
> > +Now add the following to ``drivers/misc/Kconfig``:
> > +
> > +.. code-block:: kconfig
> > +
> > +     config MISC_EXAMPLE_TEST
> > +             bool "Test for my example"
> > +             depends on MISC_EXAMPLE && KUNIT
> > +
> > +and the following to ``drivers/misc/Makefile``:
> > +
> > +.. code-block:: make
> > +
> > +     obj-$(CONFIG_MISC_EXAMPLE_TEST) += example-test.o
> > +
> > +Now add it to your ``kunitconfig``:
> > +
> > +.. code-block:: none
> > +
> > +     CONFIG_MISC_EXAMPLE=y
> > +     CONFIG_MISC_EXAMPLE_TEST=y
> > +
> > +Now you can run the test:
> > +
> > +.. code-block:: bash
> > +
> > +     ./tools/testing/kunit/kunit.py
> > +
> > +You should see the following failure:
> > +
> > +.. code-block:: none
> > +
> > +     ...
> > +     [16:08:57] [PASSED] misc-example:misc_example_add_test_basic
> > +     [16:08:57] [FAILED] misc-example:misc_example_test_failure
> > +     [16:08:57] EXPECTATION FAILED at drivers/misc/example-test.c:17
> > +     [16:08:57]      This test never passes.
> > +     ...
> > +
> > +Congrats! You just wrote your first KUnit test!
> > +
> > +Next Steps
> > +=============
>
> underline length warning. (?)
>
> > +*   Check out the :doc:`usage` page for a more
> > +    in-depth explanation of KUnit.
> > diff --git a/Documentation/kunit/usage.rst b/Documentation/kunit/usage.rst
> > new file mode 100644
> > index 0000000000000..5c83ea9e21bc5
> > --- /dev/null
> > +++ b/Documentation/kunit/usage.rst
> > @@ -0,0 +1,447 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=============
> > +Using KUnit
> > +=============
>
> over/underline length warnings?
>
> > +
> > +The purpose of this document is to describe what KUnit is, how it works, how it
> > +is intended to be used, and all the concepts and terminology that are needed to
> > +understand it. This guide assumes a working knowledge of the Linux kernel and
> > +some basic knowledge of testing.
> > +
> > +For a high level introduction to KUnit, including setting up KUnit for your
> > +project, see :doc:`start`.
> > +
> > +Organization of this document
> > +=================================
>
> underline length?  (and more below, but not being marked)
>
> > +
> > +This document is organized into two main sections: Testing and Isolating
> > +Behavior. The first covers what a unit test is and how to use KUnit to write
> > +them. The second covers how to use KUnit to isolate code and make it possible
> > +to unit test code that was otherwise un-unit-testable.
> > +
> > +Testing
> > +==========
> > +
> > +What is KUnit?
> > +------------------
> > +
> > +"K" is short for "kernel" so "KUnit" is the "(Linux) Kernel Unit Testing
> > +Framework." KUnit is intended first and foremost for writing unit tests; it is
> > +general enough that it can be used to write integration tests; however, this is
> > +a secondary goal. KUnit has no ambition of being the only testing framework for
> > +the kernel; for example, it does not intend to be an end-to-end testing
> > +framework.
> > +
> > +What is Unit Testing?
> > +-------------------------

Thanks!
