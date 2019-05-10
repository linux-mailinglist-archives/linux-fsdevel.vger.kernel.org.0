Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C74C19B8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 12:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfEJKZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 06:25:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33718 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfEJKZU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 06:25:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id 66so5132059otq.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2019 03:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iI9UjzWLOTz9GmvdS5N+dD4tpC8SGzYvR6XlaJd6X3w=;
        b=RWz50WjGVhE778RI5E/gnmwHtyGZ0gaAmZ0iZ0plK5kWhBoeeKOWqyMXplH8fTtUsP
         YFZpCe51wfH5rpKYyGn5ULLWDdnHqiz/qOEV7NBjxq+KfO41fJG4qhtbH5TVMqmlTXuD
         b5rf6YzechDPYqaa7IxCgG1hq1vCZ1jw2HsD3qL0n5got4d9IQUHA7ngtw1jru23KETZ
         S2a1Yzky70EiE/cKvmqv3j36xHYkNkJZpgW2MH+/MVDg0jSJzsPJ2n3uuvsMbcTdrYqq
         lTHYE5RDq+PIvvcx+UdbW+CJ6Tf73MUjggBvl433KWXT2rTGYfdgh08GkTh9dkD5qrWP
         Kl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iI9UjzWLOTz9GmvdS5N+dD4tpC8SGzYvR6XlaJd6X3w=;
        b=BJ6Z6PIZxAn512Bk59QUc4kZqPGIOYD9AC8jgi812RHTJo/AqnO04qGEWx9pZzUaJg
         qVrwxpzIQdV4e+p5jTAJIzSVtIRlysWd5q7P0zecKLqS1rSLW5a0k+dUx+VPtnv966SR
         4ND0s/VM5Hnq/oK9LgfOeFVbFBD1zbhjAbP6vNtOZrs796w7SX14SGwnZRLnigliKI8r
         ggg3V0samMtC3F51EIcgwB35iIpm6KHebL6Hs6iKA8U2JV+f1qUJzCEVuhDhklAbOpE5
         M5apWB/G4PXxlhbX0XGoSu5wHYHosuU1y+hj1jIuiIBi5eqsE3irCo4R3etUjpOSuWA7
         Cxbw==
X-Gm-Message-State: APjAAAV0fVllKlD98zLxca/LVdDRVbXyOMV6PnVcqraSf1NrwGcHmMtI
        HwQBZHYsTL0CGL5R4t+x36XJ991BlQFp2fLqt6dmxw==
X-Google-Smtp-Source: APXvYqxXdPfUlpaL4uIAwV7G2qrVEfAWWo/p1axPqhCLsuZp8oSxIViDaU9/ZJAkWQ8RAXvu3wGakIwT/norp7EOSwY=
X-Received: by 2002:a9d:640f:: with SMTP id h15mr622694otl.338.1557483918605;
 Fri, 10 May 2019 03:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com> <CAK7LNARzaeZ+ZNbDSii2cpFkk4bUqOu3keNq4qX0LhftuK8+MQ@mail.gmail.com>
In-Reply-To: <CAK7LNARzaeZ+ZNbDSii2cpFkk4bUqOu3keNq4qX0LhftuK8+MQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 10 May 2019 03:25:06 -0700
Message-ID: <CAFd5g47iaxW5Nk+sELxgasnbpNX7O6kwUTT7gMWoN3gA=_we6Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "Cc: Shuah Khan" <shuah@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Tim Bird <Tim.Bird@sony.com>,
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
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Thu, May 2, 2019 at 8:02 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > ## TLDR
> >
> > I rebased the last patchset on 5.1-rc7 in hopes that we can get this in
> > 5.2.
> >
> > Shuah, I think you, Greg KH, and myself talked off thread, and we agreed
> > we would merge through your tree when the time came? Am I remembering
> > correctly?
> >
> > ## Background
> >
> > This patch set proposes KUnit, a lightweight unit testing and mocking
> > framework for the Linux kernel.
> >
> > Unlike Autotest and kselftest, KUnit is a true unit testing framework;
> > it does not require installing the kernel on a test machine or in a VM
> > and does not require tests to be written in userspace running on a host
> > kernel. Additionally, KUnit is fast: From invocation to completion KUnit
> > can run several dozen tests in under a second. Currently, the entire
> > KUnit test suite for KUnit runs in under a second from the initial
> > invocation (build time excluded).
> >
> > KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> > Googletest/Googlemock for C++. KUnit provides facilities for defining
> > unit test cases, grouping related test cases into test suites, providing
> > common infrastructure for running tests, mocking, spying, and much more.
> >
> > ## What's so special about unit testing?
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
> > ## Is KUnit trying to replace other testing frameworks for the kernel?
> >
> > No. Most existing tests for the Linux kernel are end-to-end tests, which
> > have their place. A well tested system has lots of unit tests, a
> > reasonable number of integration tests, and some end-to-end tests. KUnit
> > is just trying to address the unit test space which is currently not
> > being addressed.
> >
> > ## More information on KUnit
> >
> > There is a bunch of documentation near the end of this patch set that
> > describes how to use KUnit and best practices for writing unit tests.
> > For convenience I am hosting the compiled docs here:
> > https://google.github.io/kunit-docs/third_party/kernel/docs/
> > Additionally for convenience, I have applied these patches to a branch:
> > https://kunit.googlesource.com/linux/+/kunit/rfc/v5.1-rc7/v1
> > The repo may be cloned with:
> > git clone https://kunit.googlesource.com/linux
> > This patchset is on the kunit/rfc/v5.1-rc7/v1 branch.
> >
> > ## Changes Since Last Version
> >
> > None. I just rebased the last patchset on v5.1-rc7.
> >
> > --
> > 2.21.0.593.g511ec345e18-goog
> >
>
> The following is the log of 'git am' of this series.
> I see several 'new blank line at EOF' warnings.
>
>
>
> masahiro@pug:~/workspace/bsp/linux$ git am ~/Downloads/*.patch
> Applying: kunit: test: add KUnit test runner core
> Applying: kunit: test: add test resource management API
> Applying: kunit: test: add string_stream a std::stream like string builder
> .git/rebase-apply/patch:223: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: kunit: test: add kunit_stream a std::stream like logger
> Applying: kunit: test: add the concept of expectations
> .git/rebase-apply/patch:475: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: kbuild: enable building KUnit
> Applying: kunit: test: add initial tests
> .git/rebase-apply/patch:203: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: kunit: test: add support for test abort
> .git/rebase-apply/patch:453: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: kunit: test: add tests for kunit test abort
> Applying: kunit: test: add the concept of assertions
> .git/rebase-apply/patch:518: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: kunit: test: add test managed resource tests
> Applying: kunit: tool: add Python wrappers for running KUnit tests
> .git/rebase-apply/patch:457: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
> Applying: kunit: defconfig: add defconfigs for building KUnit tests
> Applying: Documentation: kunit: add documentation for KUnit
> .git/rebase-apply/patch:71: new blank line at EOF.
> +
> .git/rebase-apply/patch:209: new blank line at EOF.
> +
> .git/rebase-apply/patch:848: new blank line at EOF.
> +
> warning: 3 lines add whitespace errors.
> Applying: MAINTAINERS: add entry for KUnit the unit testing framework
> Applying: kernel/sysctl-test: Add null pointer test for sysctl.c:proc_dointvec()
> Applying: MAINTAINERS: add proc sysctl KUnit test to PROC SYSCTL section

Sorry about this! I will have it fixed on the next revision.
