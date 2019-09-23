Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 397A5BBC76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 21:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502309AbfIWTuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 15:50:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51074 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbfIWTug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eUUUPJp8Q+5PlAv7/AOGceOtoVnI1K3PZLVv987cVRU=; b=IWsVG8Im3Z8uUrSD/S3h+TdHQ
        xHv1A9gVSzgMJ+kavZxPZT1xVWv/jjm2sfWSXfFzdZXciz5sTxLQIXQbckhIgFNYBWXOW56MeYtce
        RDRk8PXLYa9JQjzqNAneuoj1DvrREkcaGQzDzLU/3LMcEVdSMIHU76lE/eq38yRXFCg081K4ExSo1
        3FzbuLuNzJemUVQmfTaqi81/oFTUI+Th3OPTWOS6vX+oxZcGfA5LtBulYnbTXPP5bCHavi6YOqx9z
        e56+yGYscXzBmfqZYNNhNJZMvVMvRWVJ5BD1Js8eMwTSDhc/tN/DGap0FCPAVWCU6SvBatYXJP2Hz
        KnM7z0gbQ==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCULM-0004hv-CB; Mon, 23 Sep 2019 19:49:56 +0000
Subject: Re: [PATCH v18 15/19] Documentation: kunit: add documentation for
 KUnit
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah <shuah@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
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
        Jonathan Corbet <corbet@lwn.net>
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20190923090249.127984-16-brendanhiggins@google.com>
 <d87eba35-ae09-0c53-bbbe-51ee9dc9531f@infradead.org>
 <CAFd5g45y-NWzbn8E8hUg=n4U5E+N6_4D8eCXhQ74Y0N4zqVW=w@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d7a61045-8fe6-a104-ece9-67b69c379425@infradead.org>
Date:   Mon, 23 Sep 2019 12:49:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g45y-NWzbn8E8hUg=n4U5E+N6_4D8eCXhQ74Y0N4zqVW=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/23/19 11:06 AM, Brendan Higgins wrote:
> On Mon, Sep 23, 2019 at 8:48 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 9/23/19 2:02 AM, Brendan Higgins wrote:
>>> Add documentation for KUnit, the Linux kernel unit testing framework.
>>> - Add intro and usage guide for KUnit
>>> - Add API reference
>>>
>>> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>>> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>>> ---
>>>  Documentation/dev-tools/index.rst           |   1 +
>>>  Documentation/dev-tools/kunit/api/index.rst |  16 +
>>>  Documentation/dev-tools/kunit/api/test.rst  |  11 +
>>>  Documentation/dev-tools/kunit/faq.rst       |  62 +++
>>>  Documentation/dev-tools/kunit/index.rst     |  79 +++
>>>  Documentation/dev-tools/kunit/start.rst     | 180 ++++++
>>>  Documentation/dev-tools/kunit/usage.rst     | 576 ++++++++++++++++++++
>>>  7 files changed, 925 insertions(+)
>>>  create mode 100644 Documentation/dev-tools/kunit/api/index.rst
>>>  create mode 100644 Documentation/dev-tools/kunit/api/test.rst
>>>  create mode 100644 Documentation/dev-tools/kunit/faq.rst
>>>  create mode 100644 Documentation/dev-tools/kunit/index.rst
>>>  create mode 100644 Documentation/dev-tools/kunit/start.rst
>>>  create mode 100644 Documentation/dev-tools/kunit/usage.rst
>>
>>
>>> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
>>> new file mode 100644
>>> index 000000000000..6dc229e46bb3
>>> --- /dev/null
>>> +++ b/Documentation/dev-tools/kunit/start.rst
>>> @@ -0,0 +1,180 @@
>>> +.. SPDX-License-Identifier: GPL-2.0
>>> +
>>> +===============
>>> +Getting Started
>>> +===============
>>> +
>>> +Installing dependencies
>>> +=======================
>>> +KUnit has the same dependencies as the Linux kernel. As long as you can build
>>> +the kernel, you can run KUnit.
>>> +
>>> +KUnit Wrapper
>>> +=============
>>> +Included with KUnit is a simple Python wrapper that helps format the output to
>>> +easily use and read KUnit output. It handles building and running the kernel, as
>>> +well as formatting the output.
>>> +
>>> +The wrapper can be run with:
>>> +
>>> +.. code-block:: bash
>>> +
>>> +   ./tools/testing/kunit/kunit.py run
>>> +
>>> +Creating a kunitconfig
>>> +======================
>>> +The Python script is a thin wrapper around Kbuild as such, it needs to be
>>
>>                                        around Kbuild. As such,
> 
> Thanks for pointing this out.
> 
>>
>>> +configured with a ``kunitconfig`` file. This file essentially contains the
>>> +regular Kernel config, with the specific test targets as well.
>>> +
>>> +.. code-block:: bash
>>> +
>>> +     git clone -b master https://kunit.googlesource.com/kunitconfig $PATH_TO_KUNITCONFIG_REPO
>>> +     cd $PATH_TO_LINUX_REPO
>>> +     ln -s $PATH_TO_KUNIT_CONFIG_REPO/kunitconfig kunitconfig
>>> +
>>> +You may want to add kunitconfig to your local gitignore.
>>> +
>>> +Verifying KUnit Works
>>> +---------------------
>>> +
>>> +To make sure that everything is set up correctly, simply invoke the Python
>>> +wrapper from your kernel repo:
>>> +
>>> +.. code-block:: bash
>>> +
>>> +     ./tools/testing/kunit/kunit.py
>>> +
>>> +.. note::
>>> +   You may want to run ``make mrproper`` first.
>>
>> I normally use O=builddir when building kernels.
>> Does this support using O=builddir ?
> 
> Yep, it supports specifying a separate build directory.
> 
>>> +
>>> +If everything worked correctly, you should see the following:
>>> +
>>> +.. code-block:: bash
>>> +
>>> +     Generating .config ...
>>> +     Building KUnit Kernel ...
>>> +     Starting KUnit Kernel ...
>>> +
>>> +followed by a list of tests that are run. All of them should be passing.
>>> +
>>> +.. note::
>>> +   Because it is building a lot of sources for the first time, the ``Building
>>> +   kunit kernel`` step may take a while.
>>> +
>>> +Writing your first test
>>> +=======================
>>
>> [snip]
>>
>>> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
>>> new file mode 100644
>>> index 000000000000..c6e69634e274
>>> --- /dev/null
>>> +++ b/Documentation/dev-tools/kunit/usage.rst
>>
>> TBD...
> 
> What did you mean by this comment?

I plan to review usage.rst soon... (To Be Done :)

-- 
~Randy
