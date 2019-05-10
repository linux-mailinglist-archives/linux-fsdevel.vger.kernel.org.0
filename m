Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1ED1A4F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 23:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfEJVxE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 17:53:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36301 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbfEJVxE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 17:53:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so3617170pgb.3;
        Fri, 10 May 2019 14:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tFQucziH/lNpMmCcgKVO4AJ9nWDnZZYR8eghVDzNA1E=;
        b=lu0yqBfjEUNykl0U3da7rDRSpylPzpL2esQSx+UgL+mdERRPAU4+xSvga6nSALkV1C
         Vvc4NdibXWAAVaSbYf6uxE1gsLvFZrw+b0/PAjtbQdtHbfBRJoGx47qNrchXGSG7p9hp
         St8BSU/crFi2UHaW3O9piIxNoA33Gt+dJlsghtUYECOaEjpTQ9xSEhrLZ0dM2esT8S9K
         66dGNW6vK0dCcb9R1rXyTOjsLQymtPuYzRol6D7JEYW2UAVIX4Z7As1Q+zA5Va7ce431
         3xZByQCYxXFTpgGMOLBuLRbBwhkwzRkd2YZC+KgYIjVAYPxdOcw+fHI7wbek34gTZGXR
         JWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tFQucziH/lNpMmCcgKVO4AJ9nWDnZZYR8eghVDzNA1E=;
        b=qKiHMD78wsaPlBjGUHnoyTiqsoXD0iwTVEg5zydoMpkr1fiK+/CnXsRjRAxz1qovdN
         qWkDXb5/WBH/NNYA4BB22ZHKEXsHrU61T4nHwzCFUAWw1PCeX0VXXt806lvoY4WAs2ws
         DfzGWa02m2STTcCz28jnhuFkfQkCUvSXFWs/HkXjYbnkm6EpFf/FY1K4WyKowv6z93x5
         k23hdXBsFrCRYghdkeRPQfbSAScjXEZJahJugHoxELAId9oSqYAX3lVBexuVG7E91Bmp
         r5/fo5/x1+f6hQagVXtXHPQclb82bBrTZ0MaJ0my6fBp6HBas2BJBpMm/FHTRiuPC49m
         8iPg==
X-Gm-Message-State: APjAAAXg6idhJvsJsk36wKBjqJkF3udP6oFpMrtcmiS7eh8VAhfmy99g
        QIDH4F/79DAUiDVZGWIqqHw=
X-Google-Smtp-Source: APXvYqwEz5hPUpoWTUMGr3bgCwxUY3Qej1r0J2tlMznKnGbw+2kNjU9uUppsop4MP14VK4tl3E1lkw==
X-Received: by 2002:a62:b40a:: with SMTP id h10mr9753966pfn.216.1557525183210;
        Fri, 10 May 2019 14:53:03 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id v66sm259259pfa.38.2019.05.10.14.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 14:53:02 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Logan Gunthorpe <logang@deltatee.com>,
        Theodore Ts'o <tytso@mit.edu>, Tim.Bird@sony.com,
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
 <b09ba170-229b-fde4-3e9a-e50d6ab4c1b5@deltatee.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <2aed675e-0408-c812-3e1a-b90710c528f2@gmail.com>
Date:   Fri, 10 May 2019 14:52:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b09ba170-229b-fde4-3e9a-e50d6ab4c1b5@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/9/19 3:20 PM, Logan Gunthorpe wrote:
> 
> 
> On 2019-05-09 3:42 p.m., Theodore Ts'o wrote:
>> On Thu, May 09, 2019 at 11:12:12AM -0700, Frank Rowand wrote:
>>>
>>>     "My understanding is that the intent of KUnit is to avoid booting a kernel on
>>>     real hardware or in a virtual machine.  That seems to be a matter of semantics
>>>     to me because isn't invoking a UML Linux just running the Linux kernel in
>>>     a different form of virtualization?
>>>
>>>     So I do not understand why KUnit is an improvement over kselftest.
>>>
>>>     ...
>>> 
>>> What am I missing?"
>> 
>> One major difference: kselftest requires a userspace environment;
>> it starts systemd, requires a root file system from which you can
>> load modules, etc.  Kunit doesn't require a root file system;
>> doesn't require that you start systemd; doesn't allow you to run
>> arbitrary perl, python, bash, etc. scripts.  As such, it's much
>> lighter weight than kselftest, and will have much less overhead
>> before you can start running tests.  So it's not really the same
>> kind of virtualization.

I'm back to reply to this subthread, after a delay, as promised.


> I largely agree with everything Ted has said in this thread, but I
> wonder if we are conflating two different ideas that is causing an
> impasse. From what I see, Kunit actually provides two different
> things:

> 1) An execution environment that can be run very quickly in userspace
> on tests in the kernel source. This speeds up the tests and gives a
> lot of benefit to developers using those tests because they can get
> feedback on their code changes a *lot* quicker.

kselftest in-kernel tests provide exactly the same when the tests are
configured as "built-in" code instead of as modules.


> 2) A framework to write unit tests that provides a lot of the same
> facilities as other common unit testing frameworks from userspace
> (ie. a runner that runs a list of tests and a bunch of helpers such
> as KUNIT_EXPECT_* to simplify test passes and failures).

> The first item from Kunit is novel and I see absolutely no overlap
> with anything kselftest does. It's also the valuable thing I'd like
> to see merged and grow.

The first item exists in kselftest.


> The second item, arguably, does have significant overlap with
> kselftest. Whether you are running short tests in a light weight UML
> environment or higher level tests in an heavier VM the two could be
> using the same framework for writing or defining in-kernel tests. It
> *may* also be valuable for some people to be able to run all the UML
> tests in the heavy VM environment along side other higher level
> tests.
> 
> Looking at the selftests tree in the repo, we already have similar
> items to what Kunit is adding as I described in point (2) above.
> kselftest_harness.h contains macros like EXPECT_* and ASSERT_* with
> very similar intentions to the new KUNIT_EXECPT_* and KUNIT_ASSERT_*
> macros.

I might be wrong here because I have not dug deeply enough into the
code!!!  Does this framework apply to the userspace tests, the
in-kernel tests, or both?  My "not having dug enough GUESS" is that
these are for the user space tests (although if so, they could be
extended for in-kernel use also).

So I think this one maybe does not have an overlap between KUnit
and kselftest.


> However, the number of users of this harness appears to be quite
> small. Most of the code in the selftests tree seems to be a random
> mismash of scripts and userspace code so it's not hard to see it as
> something completely different from the new Kunit:
> $ git grep --files-with-matches kselftest_harness.h *
> Documentation/dev-tools/kselftest.rst
> MAINTAINERS
> tools/testing/selftests/kselftest_harness.h
> tools/testing/selftests/net/tls.c
> tools/testing/selftests/rtc/rtctest.c
> tools/testing/selftests/seccomp/Makefile
> tools/testing/selftests/seccomp/seccomp_bpf.c
> tools/testing/selftests/uevent/Makefile
> tools/testing/selftests/uevent/uevent_filtering.c


> Thus, I can personally see a lot of value in integrating the kunit
> test framework with this kselftest harness. There's only a small
> number of users of the kselftest harness today, so one way or another
> it seems like getting this integrated early would be a good idea.
> Letting Kunit and Kselftests progress independently for a few years
> will only make this worse and may become something we end up
> regretting.

Yes, this I agree with.

-Frank

> 
> Logan
