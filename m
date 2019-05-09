Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C39A218CD4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 17:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfEIPUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 11:20:04 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:62766 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfEIPUE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 11:20:04 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x49FJklU008070;
        Fri, 10 May 2019 00:19:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x49FJklU008070
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557415188;
        bh=/RmcGIvKlIeX5sautHUKWG9CqgOL/snHwlMz4C7RK7Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LpHPoAEd2po4sFlMrUGrNwEbOY28Aww4RDFL8YojNSo8sO3uY8ARSe11GyQZr8OUc
         PRXjmAA9Atra/ht71v0rHNXzigOrkVT34erRnwrRqUUVqzsgRkUrKxyr6wo4jKapXO
         x+D0BbHsXbe3nlzMrhdbo42vgj+AHOcWxsHTrvXbYr0d6fzsy1ol6RSHLUHYi3ayUH
         MOjWMWO+tHDDhtImH09a0PoueXUKhmfqqJyCQ57GfOsMfWyrvnUPEY+1c8oag+THsl
         aQtv59lraQ5Gmx3yk+TyXlcVHT55wTSMsVki/rd1We3cI4eZ1og6VgKylmkDa0tjDc
         q7H/XL+sV3XHw==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id q64so1671666vsd.1;
        Thu, 09 May 2019 08:19:47 -0700 (PDT)
X-Gm-Message-State: APjAAAWM3w7VKAifW8aL/3MwywEk4SKCrCfOlEDDoWjTqJKxEvzINsqX
        7Ec/mtowIRbMhQk5h45mNZWn5cHSgm5VS6znWuI=
X-Google-Smtp-Source: APXvYqx6QjKlJ2f+g4A6WK94eltfaSbhy0aZvu24LJigaNs8MefbVE61l1HSqEqjAJsc0x0q+dn5JmOY0plbpWccbg8=
X-Received: by 2002:a67:f109:: with SMTP id n9mr2430794vsk.181.1557415186326;
 Thu, 09 May 2019 08:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
In-Reply-To: <20190501230126.229218-1-brendanhiggins@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 10 May 2019 00:19:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNARzaeZ+ZNbDSii2cpFkk4bUqOu3keNq4qX0LhftuK8+MQ@mail.gmail.com>
Message-ID: <CAK7LNARzaeZ+ZNbDSii2cpFkk4bUqOu3keNq4qX0LhftuK8+MQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        keescook@google.com, kieran.bingham@ideasonboard.com,
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
        <linux-kselftest@vger.kernel.org>, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        Tim Bird <Tim.Bird@sony.com>, amir73il@gmail.com,
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
        Richard Weinberger <richard@nod.at>, rientjes@google.com,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 2, 2019 at 8:02 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> ## TLDR
>
> I rebased the last patchset on 5.1-rc7 in hopes that we can get this in
> 5.2.
>
> Shuah, I think you, Greg KH, and myself talked off thread, and we agreed
> we would merge through your tree when the time came? Am I remembering
> correctly?
>
> ## Background
>
> This patch set proposes KUnit, a lightweight unit testing and mocking
> framework for the Linux kernel.
>
> Unlike Autotest and kselftest, KUnit is a true unit testing framework;
> it does not require installing the kernel on a test machine or in a VM
> and does not require tests to be written in userspace running on a host
> kernel. Additionally, KUnit is fast: From invocation to completion KUnit
> can run several dozen tests in under a second. Currently, the entire
> KUnit test suite for KUnit runs in under a second from the initial
> invocation (build time excluded).
>
> KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> Googletest/Googlemock for C++. KUnit provides facilities for defining
> unit test cases, grouping related test cases into test suites, providing
> common infrastructure for running tests, mocking, spying, and much more.
>
> ## What's so special about unit testing?
>
> A unit test is supposed to test a single unit of code in isolation,
> hence the name. There should be no dependencies outside the control of
> the test; this means no external dependencies, which makes tests orders
> of magnitudes faster. Likewise, since there are no external dependencies,
> there are no hoops to jump through to run the tests. Additionally, this
> makes unit tests deterministic: a failing unit test always indicates a
> problem. Finally, because unit tests necessarily have finer granularity,
> they are able to test all code paths easily solving the classic problem
> of difficulty in exercising error handling code.
>
> ## Is KUnit trying to replace other testing frameworks for the kernel?
>
> No. Most existing tests for the Linux kernel are end-to-end tests, which
> have their place. A well tested system has lots of unit tests, a
> reasonable number of integration tests, and some end-to-end tests. KUnit
> is just trying to address the unit test space which is currently not
> being addressed.
>
> ## More information on KUnit
>
> There is a bunch of documentation near the end of this patch set that
> describes how to use KUnit and best practices for writing unit tests.
> For convenience I am hosting the compiled docs here:
> https://google.github.io/kunit-docs/third_party/kernel/docs/
> Additionally for convenience, I have applied these patches to a branch:
> https://kunit.googlesource.com/linux/+/kunit/rfc/v5.1-rc7/v1
> The repo may be cloned with:
> git clone https://kunit.googlesource.com/linux
> This patchset is on the kunit/rfc/v5.1-rc7/v1 branch.
>
> ## Changes Since Last Version
>
> None. I just rebased the last patchset on v5.1-rc7.
>
> --
> 2.21.0.593.g511ec345e18-goog
>

The following is the log of 'git am' of this series.
I see several 'new blank line at EOF' warnings.



masahiro@pug:~/workspace/bsp/linux$ git am ~/Downloads/*.patch
Applying: kunit: test: add KUnit test runner core
Applying: kunit: test: add test resource management API
Applying: kunit: test: add string_stream a std::stream like string builder
.git/rebase-apply/patch:223: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
Applying: kunit: test: add kunit_stream a std::stream like logger
Applying: kunit: test: add the concept of expectations
.git/rebase-apply/patch:475: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
Applying: kbuild: enable building KUnit
Applying: kunit: test: add initial tests
.git/rebase-apply/patch:203: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
Applying: kunit: test: add support for test abort
.git/rebase-apply/patch:453: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
Applying: kunit: test: add tests for kunit test abort
Applying: kunit: test: add the concept of assertions
.git/rebase-apply/patch:518: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
Applying: kunit: test: add test managed resource tests
Applying: kunit: tool: add Python wrappers for running KUnit tests
.git/rebase-apply/patch:457: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
Applying: kunit: defconfig: add defconfigs for building KUnit tests
Applying: Documentation: kunit: add documentation for KUnit
.git/rebase-apply/patch:71: new blank line at EOF.
+
.git/rebase-apply/patch:209: new blank line at EOF.
+
.git/rebase-apply/patch:848: new blank line at EOF.
+
warning: 3 lines add whitespace errors.
Applying: MAINTAINERS: add entry for KUnit the unit testing framework
Applying: kernel/sysctl-test: Add null pointer test for sysctl.c:proc_dointvec()
Applying: MAINTAINERS: add proc sysctl KUnit test to PROC SYSCTL section






--
Best Regards
Masahiro Yamada
