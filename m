Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7D699B638
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 20:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404909AbfHWScS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 14:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730788AbfHWScR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 14:32:17 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE6B820850;
        Fri, 23 Aug 2019 18:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566585136;
        bh=OphVK+Oj0NCE57doJUamX1ycmaZZJs0vBSwvonrMDJo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=0h6u0d4NuYP6VaSFcLNAuad38vRWJ57eWJLXxGtQ4JJHO88PWzl8oJ4tJq7FaMxjA
         Yz29nK0VmL9IqtZXRvwCyQXs+EroYz8qcgzVVSON4ehFiyFj8cdhmlzoTksNyRyciT
         zrPV2Cc4zlsDpETknamqTofuiYeQBy1EKbMMqw/M=
Subject: Re: [PATCH v14 01/18] kunit: test: add KUnit test runner core
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
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
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        shuah <shuah@kernel.org>
References: <20190820232046.50175-1-brendanhiggins@google.com>
 <20190820232046.50175-2-brendanhiggins@google.com>
 <7f2c8908-75f6-b793-7113-ad57c51777ce@kernel.org>
 <CAFd5g44mRK9t4f58i_YMEt=e9RTxwrrhFY_V2LW_E7bUwR3cdg@mail.gmail.com>
 <4513d9f3-a69b-a9a4-768b-86c2962b62e0@kernel.org>
 <CAFd5g446J=cVW4QW+QeZMLDi+ANqshAW6KTrFFBTusPcdr6-GA@mail.gmail.com>
 <42c6235c-c586-8de1-1913-7cf1962c6066@kernel.org>
 <CAFd5g44hLgeqPtNw1zQ5k_+apBm=ri_6=wAgHk=oPOvQs6xgNg@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <54f3c011-d666-e828-5e77-359b7a7374e7@kernel.org>
Date:   Fri, 23 Aug 2019 12:32:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g44hLgeqPtNw1zQ5k_+apBm=ri_6=wAgHk=oPOvQs6xgNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/23/19 11:54 AM, Brendan Higgins wrote:
> On Fri, Aug 23, 2019 at 10:34 AM shuah <shuah@kernel.org> wrote:
>>
>> On 8/23/19 11:27 AM, Brendan Higgins wrote:
>>> On Fri, Aug 23, 2019 at 10:05 AM shuah <shuah@kernel.org> wrote:
>>>>
>>>> On 8/23/19 10:48 AM, Brendan Higgins wrote:
>>>>> On Fri, Aug 23, 2019 at 8:33 AM shuah <shuah@kernel.org> wrote:
>>>>>>
>>>>>> Hi Brendan,
>>>>>>
>>>>>> On 8/20/19 5:20 PM, Brendan Higgins wrote:
>>>>>>> Add core facilities for defining unit tests; this provides a common way
>>>>>>> to define test cases, functions that execute code which is under test
>>>>>>> and determine whether the code under test behaves as expected; this also
>>>>>>> provides a way to group together related test cases in test suites (here
>>>>>>> we call them test_modules).
>>>>>>>
>>>>>>> Just define test cases and how to execute them for now; setting
>>>>>>> expectations on code will be defined later.
>>>>>>>
>>>>>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>>>>>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>>>>>>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>>>>>>> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>>>>>>> ---
>>>>>>>      include/kunit/test.h | 179 ++++++++++++++++++++++++++++++++++++++++
>>>>>>>      kunit/Kconfig        |  17 ++++
>>>>>>>      kunit/Makefile       |   1 +
>>>>>>>      kunit/test.c         | 191 +++++++++++++++++++++++++++++++++++++++++++
>>>>>>>      4 files changed, 388 insertions(+)
>>>>>>>      create mode 100644 include/kunit/test.h
>>>>>>>      create mode 100644 kunit/Kconfig
>>>>>>>      create mode 100644 kunit/Makefile
>>>>>>>      create mode 100644 kunit/test.c
>>>>>>>
>>>>>>> diff --git a/include/kunit/test.h b/include/kunit/test.h
>>>>>>> new file mode 100644
>>>>>>> index 0000000000000..e0b34acb9ee4e
>>>>>>> --- /dev/null
>>>>>>> +++ b/include/kunit/test.h
>>>>>>> @@ -0,0 +1,179 @@
>>>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>>>> +/*
>>>>>>> + * Base unit test (KUnit) API.
>>>>>>> + *
>>>>>>> + * Copyright (C) 2019, Google LLC.
>>>>>>> + * Author: Brendan Higgins <brendanhiggins@google.com>
>>>>>>> + */
>>>>>>> +
>>>>>>> +#ifndef _KUNIT_TEST_H
>>>>>>> +#define _KUNIT_TEST_H
>>>>>>> +
>>>>>>> +#include <linux/types.h>
>>>>>>> +
>>>>>>> +struct kunit;
>>>>>>> +
>>>>>>> +/**
>>>>>>> + * struct kunit_case - represents an individual test case.
>>>>>>> + * @run_case: the function representing the actual test case.
>>>>>>> + * @name: the name of the test case.
>>>>>>> + *
>>>>>>> + * A test case is a function with the signature, ``void (*)(struct kunit *)``
>>>>>>> + * that makes expectations (see KUNIT_EXPECT_TRUE()) about code under test. Each
>>>>>>> + * test case is associated with a &struct kunit_suite and will be run after the
>>>>>>> + * suite's init function and followed by the suite's exit function.
>>>>>>> + *
>>>>>>> + * A test case should be static and should only be created with the KUNIT_CASE()
>>>>>>> + * macro; additionally, every array of test cases should be terminated with an
>>>>>>> + * empty test case.
>>>>>>> + *
>>>>>>> + * Example:
>>>>>>
>>>>>> Can you fix these line continuations. It makes it very hard to read.
>>>>>> Sorry for this late comment. These comments lines are longer than 80
>>>>>> and wrap.
>>>>>
>>>>> None of the lines in this commit are over 80 characters in column
>>>>> width. Some are exactly 80 characters (like above).
>>>>>
>>>>> My guess is that you are seeing the diff added text (+ ), which when
>>>>> you add that to a line which is exactly 80 char in length ends up
>>>>> being over 80 char in email. If you apply the patch you will see that
>>>>> they are only 80 chars.
>>>>>
>>>>>>
>>>>>> There are several comment lines in the file that are way too long.
>>>>>
>>>>> Note that checkpatch also does not complain about any over 80 char
>>>>> lines in this file.
>>>>>
>>>>> Sorry if I am misunderstanding what you are trying to tell me. Please
>>>>> confirm either way.
>>>>>
>>>>
>>>> WARNING: Avoid unnecessary line continuations
>>>> #258: FILE: include/kunit/test.h:137:
>>>> +                */                                                            \
>>>>
>>>> total: 0 errors, 2 warnings, 388 lines checked
>>>
>>> Ah, okay so you don't like the warning about the line continuation.
>>> That's not because it is over 80 char, but because there is a line
>>> continuation after a comment. I don't really see a way to get rid of
>>> it without removing the comment from inside the macro.
>>>
>>> I put this TODO there in the first place a Luis' request, and I put it
>>> in the body of the macro because this macro already had a kernel-doc
>>> comment and I didn't think that an implementation detail TODO belonged
>>> in the user documentation.
>>>
>>>> Go ahead fix these. It appears there are few lines that either longer
>>>> than 80. In general, I keep them around 75, so it is easier read.
>>>
>>> Sorry, the above is the only checkpatch warning other than the
>>> reminder to update the MAINTAINERS file.
>>>
>>> Are you saying you want me to go through and make all the lines fit in
>>> 75 char column width? I hope not because that is going to be a pretty
>>> substantial change to make.
>>>
>>
>> There are two things with these comment lines. One is checkpatch
>> complaining and the other is general readability.
> 
> So for the checkpatch warning, do you want me to move the comment out
> of the macro body into the kernel-doc comment? I don't really think it
> is the right place for a comment of this nature, but I think it is
> probably better than dropping it entirely (I don't see how else to do
> it without just removing the comment entirely).
> 

Don't drop the comments. It makes perfect sense to turn this into a
kernel-doc comment.

We are going back forth on this a lot. I see several lines 81+ in
this file. I am at 5.3-rc5 and my commit hooks aren't happy. I am
fine with it if you want to convert these to kernel-doc comments.
I think it makes perfect sense.

I would like it if you take a look and fix the lines that are longer
than 80. If you think you would rather spend time converting them to
kernel-doc, I am fine with it.

thanks,
-- Shuah
