Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE7FE19532
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 00:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfEIWU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 18:20:58 -0400
Received: from ale.deltatee.com ([207.54.116.67]:36450 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfEIWU6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 18:20:58 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.141])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hOrOj-00055b-MR; Thu, 09 May 2019 16:20:18 -0600
To:     Theodore Ts'o <tytso@mit.edu>,
        Frank Rowand <frowand.list@gmail.com>, Tim.Bird@sony.com,
        knut.omang@oracle.com, gregkh@linuxfoundation.org,
        brendanhiggins@google.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, sboyd@kernel.org, shuah@kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, amir73il@gmail.com,
        dan.carpenter@oracle.com, dan.j.williams@intel.com,
        daniel@ffwll.ch, jdike@addtoit.com, joel@jms.id.au,
        julia.lawall@lip6.fr, khilman@baylibre.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com
References: <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
 <20190507080119.GB28121@kroah.com>
 <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
 <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b09ba170-229b-fde4-3e9a-e50d6ab4c1b5@deltatee.com>
Date:   Thu, 9 May 2019 16:20:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509214233.GA20877@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: wfg@linux.intel.com, rostedt@goodmis.org, rientjes@google.com, richard@nod.at, pmladek@suse.com, mpe@ellerman.id.au, khilman@baylibre.com, julia.lawall@lip6.fr, joel@jms.id.au, jdike@addtoit.com, daniel@ffwll.ch, dan.j.williams@intel.com, dan.carpenter@oracle.com, amir73il@gmail.com, Alexander.Levin@microsoft.com, linux-um@lists.infradead.org, linux-nvdimm@lists.01.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, shuah@kernel.org, sboyd@kernel.org, robh@kernel.org, mcgrof@kernel.org, kieran.bingham@ideasonboard.com, keescook@google.com, brendanhiggins@google.com, gregkh@linuxfoundation.org, knut.omang@oracle.com, Tim.Bird@sony.com, frowand.list@gmail.com, tytso@mit.edu
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019-05-09 3:42 p.m., Theodore Ts'o wrote:
> On Thu, May 09, 2019 at 11:12:12AM -0700, Frank Rowand wrote:
>>
>>     "My understanding is that the intent of KUnit is to avoid booting a kernel on
>>     real hardware or in a virtual machine.  That seems to be a matter of semantics
>>     to me because isn't invoking a UML Linux just running the Linux kernel in
>>     a different form of virtualization?
>>
>>     So I do not understand why KUnit is an improvement over kselftest.
>>
>>     ...
>>
>>     What am I missing?"
> 
> One major difference: kselftest requires a userspace environment; it
> starts systemd, requires a root file system from which you can load
> modules, etc.  Kunit doesn't require a root file system; doesn't
> require that you start systemd; doesn't allow you to run arbitrary
> perl, python, bash, etc. scripts.  As such, it's much lighter weight
> than kselftest, and will have much less overhead before you can start
> running tests.  So it's not really the same kind of virtualization.

I largely agree with everything Ted has said in this thread, but I 
wonder if we are conflating two different ideas that is causing an 
impasse. From what I see, Kunit actually provides two different things:

1) An execution environment that can be run very quickly in userspace on 
tests in the kernel source. This speeds up the tests and gives a lot of 
benefit to developers using those tests because they can get feedback on 
their code changes a *lot* quicker.

2) A framework to write unit tests that provides a lot of the same 
facilities as other common unit testing frameworks from userspace (ie. a 
runner that runs a list of tests and a bunch of helpers such as 
KUNIT_EXPECT_* to simplify test passes and failures).

The first item from Kunit is novel and I see absolutely no overlap with 
anything kselftest does. It's also the valuable thing I'd like to see 
merged and grow.

The second item, arguably, does have significant overlap with kselftest. 
Whether you are running short tests in a light weight UML environment or 
higher level tests in an heavier VM the two could be using the same 
framework for writing or defining in-kernel tests. It *may* also be 
valuable for some people to be able to run all the UML tests in the 
heavy VM environment along side other higher level tests.

Looking at the selftests tree in the repo, we already have similar items 
to what Kunit is adding as I described in point (2) above. 
kselftest_harness.h contains macros like EXPECT_* and ASSERT_* with very 
similar intentions to the new KUNIT_EXECPT_* and KUNIT_ASSERT_* macros.

However, the number of users of this harness appears to be quite small. 
Most of the code in the selftests tree seems to be a random mismash of 
scripts and userspace code so it's not hard to see it as something 
completely different from the new Kunit:

$ git grep --files-with-matches kselftest_harness.h *
Documentation/dev-tools/kselftest.rst
MAINTAINERS
tools/testing/selftests/kselftest_harness.h
tools/testing/selftests/net/tls.c
tools/testing/selftests/rtc/rtctest.c
tools/testing/selftests/seccomp/Makefile
tools/testing/selftests/seccomp/seccomp_bpf.c
tools/testing/selftests/uevent/Makefile
tools/testing/selftests/uevent/uevent_filtering.c

Thus, I can personally see a lot of value in integrating the kunit test 
framework with this kselftest harness. There's only a small number of 
users of the kselftest harness today, so one way or another it seems 
like getting this integrated early would be a good idea. Letting Kunit 
and Kselftests progress independently for a few years will only make 
this worse and may become something we end up regretting.

Logan







