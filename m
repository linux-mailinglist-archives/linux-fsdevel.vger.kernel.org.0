Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3026BBDB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 23:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502964AbfIWVSu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 17:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387437AbfIWVSu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 17:18:50 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEFE921655;
        Mon, 23 Sep 2019 21:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569273528;
        bh=uZGy9vlY/pn+dPb1iZcKXB9oWJ1CxU/IxDEL/lnY++Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SGo9W/cpUNl7KLgBfpJognPZxmFKKR4dEP6cA4jJHfYUQWpe3l2mgKE4k6iQx35cy
         ofpQ0Ztxh76B0jNkARdk9GCqGBkkj5Tzt6rUZCw261tq2nb9i+caRKzISInhCp2Dgx
         eN+urP1l4CUPMZHARnlboLegMC/L9Vk8rfBD2WVE=
Subject: Re: [PATCH v18 15/19] Documentation: kunit: add documentation for
 KUnit
To:     Randy Dunlap <rdunlap@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Felix Guo <felixguoxiuping@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, shuah <shuah@kernel.org>
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20190923090249.127984-16-brendanhiggins@google.com>
 <d87eba35-ae09-0c53-bbbe-51ee9dc9531f@infradead.org>
 <CAFd5g45y-NWzbn8E8hUg=n4U5E+N6_4D8eCXhQ74Y0N4zqVW=w@mail.gmail.com>
 <d7a61045-8fe6-a104-ece9-67b69c379425@infradead.org>
From:   shuah <shuah@kernel.org>
Message-ID: <d5dc04ab-9be5-b258-c302-29f8045d6aaa@kernel.org>
Date:   Mon, 23 Sep 2019 15:18:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d7a61045-8fe6-a104-ece9-67b69c379425@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/23/19 1:49 PM, Randy Dunlap wrote:
> On 9/23/19 11:06 AM, Brendan Higgins wrote:
>> On Mon, Sep 23, 2019 at 8:48 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>> On 9/23/19 2:02 AM, Brendan Higgins wrote:
>>>> Add documentation for KUnit, the Linux kernel unit testing framework.
>>>> - Add intro and usage guide for KUnit
>>>> - Add API reference
>>>>
>>>> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
>>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>>>> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>>>> ---
>>>>   Documentation/dev-tools/index.rst           |   1 +
>>>>   Documentation/dev-tools/kunit/api/index.rst |  16 +
>>>>   Documentation/dev-tools/kunit/api/test.rst  |  11 +
>>>>   Documentation/dev-tools/kunit/faq.rst       |  62 +++
>>>>   Documentation/dev-tools/kunit/index.rst     |  79 +++
>>>>   Documentation/dev-tools/kunit/start.rst     | 180 ++++++
>>>>   Documentation/dev-tools/kunit/usage.rst     | 576 ++++++++++++++++++++
>>>>   7 files changed, 925 insertions(+)
>>>>   create mode 100644 Documentation/dev-tools/kunit/api/index.rst
>>>>   create mode 100644 Documentation/dev-tools/kunit/api/test.rst
>>>>   create mode 100644 Documentation/dev-tools/kunit/faq.rst
>>>>   create mode 100644 Documentation/dev-tools/kunit/index.rst
>>>>   create mode 100644 Documentation/dev-tools/kunit/start.rst
>>>>   create mode 100644 Documentation/dev-tools/kunit/usage.rst
>>>
>>>
>>>> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
>>>> new file mode 100644
>>>> index 000000000000..6dc229e46bb3
>>>> --- /dev/null
>>>> +++ b/Documentation/dev-tools/kunit/start.rst
>>>> @@ -0,0 +1,180 @@
>>>> +.. SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +===============
>>>> +Getting Started
>>>> +===============
>>>> +
>>>> +Installing dependencies
>>>> +=======================
>>>> +KUnit has the same dependencies as the Linux kernel. As long as you can build
>>>> +the kernel, you can run KUnit.
>>>> +
>>>> +KUnit Wrapper
>>>> +=============
>>>> +Included with KUnit is a simple Python wrapper that helps format the output to
>>>> +easily use and read KUnit output. It handles building and running the kernel, as
>>>> +well as formatting the output.
>>>> +
>>>> +The wrapper can be run with:
>>>> +
>>>> +.. code-block:: bash
>>>> +
>>>> +   ./tools/testing/kunit/kunit.py run
>>>> +
>>>> +Creating a kunitconfig
>>>> +======================
>>>> +The Python script is a thin wrapper around Kbuild as such, it needs to be
>>>
>>>                                         around Kbuild. As such,
>>
>> Thanks for pointing this out.
>>
>>>
>>>> +configured with a ``kunitconfig`` file. This file essentially contains the
>>>> +regular Kernel config, with the specific test targets as well.
>>>> +
>>>> +.. code-block:: bash
>>>> +
>>>> +     git clone -b master https://kunit.googlesource.com/kunitconfig $PATH_TO_KUNITCONFIG_REPO
>>>> +     cd $PATH_TO_LINUX_REPO
>>>> +     ln -s $PATH_TO_KUNIT_CONFIG_REPO/kunitconfig kunitconfig
>>>> +
>>>> +You may want to add kunitconfig to your local gitignore.
>>>> +
>>>> +Verifying KUnit Works
>>>> +---------------------
>>>> +
>>>> +To make sure that everything is set up correctly, simply invoke the Python
>>>> +wrapper from your kernel repo:
>>>> +
>>>> +.. code-block:: bash
>>>> +
>>>> +     ./tools/testing/kunit/kunit.py
>>>> +
>>>> +.. note::
>>>> +   You may want to run ``make mrproper`` first.
>>>
>>> I normally use O=builddir when building kernels.
>>> Does this support using O=builddir ?
>>
>> Yep, it supports specifying a separate build directory.
>>
>>>> +
>>>> +If everything worked correctly, you should see the following:
>>>> +
>>>> +.. code-block:: bash
>>>> +
>>>> +     Generating .config ...
>>>> +     Building KUnit Kernel ...
>>>> +     Starting KUnit Kernel ...
>>>> +
>>>> +followed by a list of tests that are run. All of them should be passing.
>>>> +
>>>> +.. note::
>>>> +   Because it is building a lot of sources for the first time, the ``Building
>>>> +   kunit kernel`` step may take a while.
>>>> +
>>>> +Writing your first test
>>>> +=======================
>>>
>>> [snip]
>>>
>>>> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
>>>> new file mode 100644
>>>> index 000000000000..c6e69634e274
>>>> --- /dev/null
>>>> +++ b/Documentation/dev-tools/kunit/usage.rst
>>>
>>> TBD...
>>
>> What did you mean by this comment?
> 
> I plan to review usage.rst soon... (To Be Done :)
> 

I would like to apply the series very soon so it gets some soak time
after this move in linux-next and it can still make the rc1.

Since there changes can be addressed after rc1, I would like to not
require Brendan to do another version before I apply.

Hope you are okay with that Randy!

thanks,
-- Shuah
