Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF1F4C4DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 03:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbfFTBR4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 21:17:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37262 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFTBR4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 21:17:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id 145so632654pgh.4;
        Wed, 19 Jun 2019 18:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sQXeyT1HOJUOTqXAfF30wa5tl07vfC8Ho8QPiu+AUmU=;
        b=dz6cdwV/r75OnNKrL4gx8ZRnk9eJQrLc/XBVO5bKEiireDO4wNHpYHyldvXT0EiuWu
         ppu0kJyuD01pJK/yY9Sc0cQhFYNiWllaL1gpz4dsQcDPbgsuvQg1xo52piKPAn76gKBC
         08KBlwLQD/7WXZP9lcR2CJZtKaIFgJp0o4DAqo0v7DD0wD/oC8Z+0svZ/DpC5eB0IaQR
         532N8xHNVBADse1U1xTBdS0Hj/MtV1ZUgC2nk9tHgitGiz/gXQTMK9tavkBvV+CTU0q2
         k2Jn4dRSzsT8pQkXYEQbifzzrrxW+LHoOuvERF7zWX2TOhYnTCG3Sx2neEgKQvOSr3rn
         D3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sQXeyT1HOJUOTqXAfF30wa5tl07vfC8Ho8QPiu+AUmU=;
        b=kTITNNveMmy2IVphqXImq2/VN9y2LMycOe7FoJum4y631pXEoUYA6a1/oXolGduszb
         GkBquoscQATNfDcGX96NCoLMkdFRjoiRfY89zRE/M9fwYoizYDwbVzJVKoRt3cFhpp7t
         cR9KAMXTZaS4pL2JCAVGVKJRcMxOTDmpJwBwAoV6m9DiDtdH2Q5D1qWVUHdNMbjtK0iJ
         uYftcst826TUSm3iu70EsTvemZOddkPBbVr8vHI+j7Dp4v+o0fNzIfUVpwhwmkqfRCOO
         MKFAaPz6dH2MLGGsGe1UCtv3buSJhe2tOCXn+wXKPH10jz0F2mAqO1jGlpHWgm+kFE8K
         kHXA==
X-Gm-Message-State: APjAAAXCDOc8lPXmF1eDe/fahHamtkQ8IPCN/vSw1PURrKbH1ZLafrCd
        M1fzB4nGQuUOCzGRHy+k64E=
X-Google-Smtp-Source: APXvYqzdMj4/FazAQbDL48xqo25QTSXAVT2QkZe8UL8Q+0fAHJYZrYbIiEtG6+Jk3rLvO3Ba2D4w/A==
X-Received: by 2002:a63:5a1f:: with SMTP id o31mr10331504pgb.254.1560993475116;
        Wed, 19 Jun 2019 18:17:55 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id l68sm3115863pjb.8.2019.06.19.18.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 18:17:54 -0700 (PDT)
Subject: Re: [PATCH v5 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>,
        gregkh@linuxfoundation.org, jpoimboe@redhat.com,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, peterz@infradead.org, robh@kernel.org,
        sboyd@kernel.org, shuah@kernel.org, tytso@mit.edu,
        yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com
References: <20190617082613.109131-1-brendanhiggins@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <10feac3e-7621-65e5-fbf0-9c63fcbe09c9@gmail.com>
Date:   Wed, 19 Jun 2019 18:17:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617082613.109131-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Brendan,

I am only responding to this because you asked me to in the v4 thread.

Thank you for evaluating my comments in the v4 thread and asking me to
comment on v5

On 6/17/19 1:25 AM, Brendan Higgins wrote:
> ## TL;DR
> 
> A not so quick follow-up to Stephen's suggestions on PATCH v4. Nothing
> that really changes any functionality or usage with the minor exception
> of a couple public functions that Stephen asked me to rename.
> Nevertheless, a good deal of clean up and fixes. See changes below.
> 
> As for our current status, right now we got Reviewed-bys on all patches
> except:
> 
> - [PATCH v5 08/18] objtool: add kunit_try_catch_throw to the noreturn
>   list
> 
> However, it would probably be good to get reviews/acks from the
> subsystem maintainers on:
> 
> - [PATCH v5 06/18] kbuild: enable building KUnit
> - [PATCH v5 08/18] objtool: add kunit_try_catch_throw to the noreturn
>   list
> - [PATCH v5 15/18] Documentation: kunit: add documentation for KUnit
> - [PATCH v5 17/18] kernel/sysctl-test: Add null pointer test for
>   sysctl.c:proc_dointvec()
> - [PATCH v5 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
>   SYSCTL section
> 
> Other than that, I think we should be good to go.
> 
> One last thing, I updated the background to include my thoughts on KUnit
> vs. in kernel testing with kselftest in the background sections as
> suggested by Frank in the discussion on PATCH v2.
> 
> ## Background
> 
> This patch set proposes KUnit, a lightweight unit testing and mocking
> framework for the Linux kernel.
> 
> Unlike Autotest and kselftest, KUnit is a true unit testing framework;
> it does not require installing the kernel on a test machine or in a VM
> (however, KUnit still allows you to run tests on test machines or in VMs
> if you want[1]) and does not require tests to be written in userspace
> running on a host kernel. Additionally, KUnit is fast: From invocation
> to completion KUnit can run several dozen tests in under a second.
> Currently, the entire KUnit test suite for KUnit runs in under a second
> from the initial invocation (build time excluded).
> 
> KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> Googletest/Googlemock for C++. KUnit provides facilities for defining
> unit test cases, grouping related test cases into test suites, providing
> common infrastructure for running tests, mocking, spying, and much more.
> 

I looked only at this section, as was specifically requested:

> ### But wait! Doesn't kselftest support in kernel testing?!
> 
> In a previous version of this patchset Frank pointed out that kselftest
> already supports writing a test that resides in the kernel using the
> test module feature[2]. LWN did a really great summary on this
> discussion here[3].
> 
> Kselftest has a feature that allows a test module to be loaded into a
> kernel using the kselftest framework; this does allow someone to write
> tests against kernel code not directly exposed to userland; however, it
> does not provide much of a framework around how to structure the tests.
> The kselftest test module feature just provides a header which has a
> standardized way of reporting test failures, 


> and then provides
> infrastructure to load and run the tests using the kselftest test
> harness.

The in-kernel tests can also be invoked at boot time if they are
configured (Kconfig) as in-kernel instead of as modules.  I did not
check how many of the tests have tri-state configuration to allow
this, but the few that I looked at did.

> 
> The kselftest test module does not seem to be opinionated at all in
> regards to how tests are structured, how they check for failures, how
> tests are organized. Even in the method it provides for reporting
> failures is pretty simple; it doesn't have any more advanced failure
> reporting or logging features. Given what's there, I think it is fair to
> say that it is not actually a framework, but a feature that makes it
> possible for someone to do some checks in kernel space.

I would call that description a little dismissive.  The set of in-kernel
tests that I looked like followed a common pattern and reported results
in a uniform manner.

> 
> Furthermore, kselftest test module has very few users. I checked for all
> the tests that use it using the following grep command:
> 
> grep -Hrn -e 'kselftest_module\.h'
> 
> and only got three results: lib/test_strscpy.c, lib/test_printf.c, and
> lib/test_bitmap.c.

You missed many tests.  I listed much more than that in the v4 thread, and
someone else also listed more in the v4 thread.


> 
> So despite kselftest test module's existence, there really is no feature
> overlap between kselftest and KUnit, save one: that you can use either
> to write an in-kernel test, but this is a very small feature in
> comparison to everything that KUnit allows you to do. KUnit is a full
> x-unit style unit testing framework, whereas kselftest looks a lot more
> like an end-to-end/functional testing framework, with a feature that
> makes it possible to write in-kernel tests.

The description does not give enough credit to what is in kselftest.

It does not matter whether KUnit provides additional things, relative
to kselftest.  The point I was making is that there appears to be
_some_ overlap between kselftest and KUnit, and if there is overlap
then it is worth considering whether the overlap can be unified instead
of duplicated.

I don't have a dog in this fight and the discussion in the v4 thread
went way off track.  Thus I am not going to get sucked back into a
pointless debate in this thread.

Thanks for adding this section to address the issue.

-Frank


> 
> ### What's so special about unit testing?
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
> ### Is KUnit trying to replace other testing frameworks for the kernel?
> 
> No. Most existing tests for the Linux kernel are end-to-end tests, which
> have their place. A well tested system has lots of unit tests, a
> reasonable number of integration tests, and some end-to-end tests. KUnit
> is just trying to address the unit test space which is currently not
> being addressed.
> 
> ### More information on KUnit
> 
> There is a bunch of documentation near the end of this patch set that
> describes how to use KUnit and best practices for writing unit tests.
> For convenience I am hosting the compiled docs here[4].
> 
> Additionally for convenience, I have applied these patches to a
> branch[5]. The repo may be cloned with:
> git clone https://kunit.googlesource.com/linux
> This patchset is on the kunit/rfc/v5.2-rc4/v5 branch.
> 
> ## Changes Since Last Version
> 
> Aside from a couple public function renames, there isn't really anything
> in here that changes any functionality.
> 
> - Went through and fixed a couple of anti-patterns suggested by Stephen
>   Boyd. Things like:
>   - Dropping an else clause at the end of a function.
>   - Dropping the comma on the closing sentinel, `{}`, of a list.
> - Inlines a bunch of functions in the test case running logic in patch
>   01/18 to make it more readable as suggested by Stephen Boyd
> - Found and fixed bug in resource deallocation logic in patch 02/18. Bug
>   was discovered as a result of making a change suggested by Stephen
>   Boyd. This does not substantially change how any of the code works
>   conceptually.
> - Renamed new_string_stream() to alloc_string_stream() as suggested by
>   Stephen Boyd.
> - Made string-stream a KUnit managed object - based on a suggestion made
>   by Stephen Boyd.
> - Renamed kunit_new_stream() to alloc_kunit_stream() as suggested by
>   Stephen Boyd.
> - Removed the ability to set log level after allocating a kunit_stream,
>   as suggested by Stephen Boyd.
> 
> [1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
> [2] https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html#test-module
> [3] https://lwn.net/Articles/790235/
> [4] https://google.github.io/kunit-docs/third_party/kernel/docs/
> [5] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.2-rc4/v5
> 

