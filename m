Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4821184B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 07:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfEIFJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 01:09:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40310 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfEIFJf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 01:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NNe0y+97iUcwK05a9nkV9wH7IZjVtahy0Z6vkV2mXOw=; b=jRbPPzof6Ktsnziebi6xfF99P
        SbTKPP2E6yzxvTH+okgPD0ip0bhGy70pW1AsI5bvKqzIZ1DSSiVC65bC2dlXBwhAo+lzguh6f0YAg
        B9eH/249VWBLWwUuwwqoYJFnnAnjXv7O80ITFrnaHCcSlOYz9iLYRABm4ujJMast4XC2iOhJQ4Lat
        HGI9/4sZ0KMUiOHBS27fuwKkZswSjGQ4pi8/fiCu4y9XvY2/Ncrct36VyIGXj+dae/U2j5CQxDVx9
        yG0agwwk1XN9QEOFvTejbgTxPFkhLo8zws5LpVUb8w4FoqOGU2ztE7ozh5i/gCrN3807NnWbNV0hd
        PISuuo7UA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hObIV-0004Ni-Pv; Thu, 09 May 2019 05:08:47 +0000
Subject: Re: [PATCH v2 14/17] Documentation: kunit: add documentation for
 KUnit
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com,
        Felix Guo <felixguoxiuping@gmail.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-15-brendanhiggins@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <498d42d8-0b8b-6ee4-c0ad-42760a7e89d4@infradead.org>
Date:   Wed, 8 May 2019 22:08:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501230126.229218-15-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 5/1/19 4:01 PM, Brendan Higgins wrote:
> Add documentation for KUnit, the Linux kernel unit testing framework.
> - Add intro and usage guide for KUnit
> - Add API reference
> 
> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  Documentation/index.rst           |   1 +
>  Documentation/kunit/api/index.rst |  16 ++
>  Documentation/kunit/api/test.rst  |  15 +
>  Documentation/kunit/faq.rst       |  46 +++
>  Documentation/kunit/index.rst     |  80 ++++++
>  Documentation/kunit/start.rst     | 180 ++++++++++++
>  Documentation/kunit/usage.rst     | 447 ++++++++++++++++++++++++++++++
>  7 files changed, 785 insertions(+)
>  create mode 100644 Documentation/kunit/api/index.rst
>  create mode 100644 Documentation/kunit/api/test.rst
>  create mode 100644 Documentation/kunit/faq.rst
>  create mode 100644 Documentation/kunit/index.rst
>  create mode 100644 Documentation/kunit/start.rst
>  create mode 100644 Documentation/kunit/usage.rst
> 

> diff --git a/Documentation/kunit/api/index.rst b/Documentation/kunit/api/index.rst
> new file mode 100644
> index 0000000000000..c31c530088153
> --- /dev/null
> +++ b/Documentation/kunit/api/index.rst
> @@ -0,0 +1,16 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============
> +API Reference
> +=============
> +.. toctree::
> +
> +	test
> +
> +This section documents the KUnit kernel testing API. It is divided into 3
> +sections:
> +
> +================================= ==============================================
> +:doc:`test`                       documents all of the standard testing API
> +                                  excluding mocking or mocking related features.
> +================================= ==============================================

What 3 sections does the above refer to?  seems to be missing.



> diff --git a/Documentation/kunit/start.rst b/Documentation/kunit/start.rst
> new file mode 100644
> index 0000000000000..5cdba5091905e
> --- /dev/null
> +++ b/Documentation/kunit/start.rst
> @@ -0,0 +1,180 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============
> +Getting Started
> +===============
> +
> +Installing dependencies
> +=======================
> +KUnit has the same dependencies as the Linux kernel. As long as you can build
> +the kernel, you can run KUnit.
> +
> +KUnit Wrapper
> +=============
> +Included with KUnit is a simple Python wrapper that helps format the output to
> +easily use and read KUnit output. It handles building and running the kernel, as
> +well as formatting the output.
> +
> +The wrapper can be run with:
> +
> +.. code-block:: bash
> +
> +   ./tools/testing/kunit/kunit.py
> +
> +Creating a kunitconfig
> +======================
> +The Python script is a thin wrapper around Kbuild as such, it needs to be

                                       around Kbuild. As such,

> +configured with a ``kunitconfig`` file. This file essentially contains the
> +regular Kernel config, with the specific test targets as well.
> +
> +.. code-block:: bash
> +
> +	git clone -b master https://kunit.googlesource.com/kunitconfig $PATH_TO_KUNITCONFIG_REPO
> +	cd $PATH_TO_LINUX_REPO
> +	ln -s $PATH_TO_KUNIT_CONFIG_REPO/kunitconfig kunitconfig
> +
> +You may want to add kunitconfig to your local gitignore.
> +
> +Verifying KUnit Works
> +-------------------------

I would expect Sphinx to complain about the underline length not being the
same as the header/title above it.

> +
> +To make sure that everything is set up correctly, simply invoke the Python
> +wrapper from your kernel repo:
> +
> +.. code-block:: bash
> +
> +	./tools/testing/kunit/kunit.py
> +
> +.. note::
> +   You may want to run ``make mrproper`` first.
> +
> +If everything worked correctly, you should see the following:
> +
> +.. code-block:: bash
> +
> +	Generating .config ...
> +	Building KUnit Kernel ...
> +	Starting KUnit Kernel ...
> +
> +followed by a list of tests that are run. All of them should be passing.
> +
> +.. note::
> +   Because it is building a lot of sources for the first time, the ``Building
> +   kunit kernel`` step may take a while.
> +
> +Writing your first test
> +==========================

underline length warning?

> +
> +In your kernel repo let's add some code that we can test. Create a file
> +``drivers/misc/example.h`` with the contents:
> +
> +.. code-block:: c
> +
> +	int misc_example_add(int left, int right);
> +
> +create a file ``drivers/misc/example.c``:
> +
> +.. code-block:: c
> +
> +	#include <linux/errno.h>
> +
> +	#include "example.h"
> +
> +	int misc_example_add(int left, int right)
> +	{
> +		return left + right;
> +	}
> +
> +Now add the following lines to ``drivers/misc/Kconfig``:
> +
> +.. code-block:: kconfig
> +
> +	config MISC_EXAMPLE
> +		bool "My example"
> +
> +and the following lines to ``drivers/misc/Makefile``:
> +
> +.. code-block:: make
> +
> +	obj-$(CONFIG_MISC_EXAMPLE) += example.o
> +
> +Now we are ready to write the test. The test will be in
> +``drivers/misc/example-test.c``:
> +
> +.. code-block:: c
> +
> +	#include <kunit/test.h>
> +	#include "example.h"
> +
> +	/* Define the test cases. */
> +
> +	static void misc_example_add_test_basic(struct kunit *test)
> +	{
> +		KUNIT_EXPECT_EQ(test, 1, misc_example_add(1, 0));
> +		KUNIT_EXPECT_EQ(test, 2, misc_example_add(1, 1));
> +		KUNIT_EXPECT_EQ(test, 0, misc_example_add(-1, 1));
> +		KUNIT_EXPECT_EQ(test, INT_MAX, misc_example_add(0, INT_MAX));
> +		KUNIT_EXPECT_EQ(test, -1, misc_example_add(INT_MAX, INT_MIN));
> +	}
> +
> +	static void misc_example_test_failure(struct kunit *test)
> +	{
> +		KUNIT_FAIL(test, "This test never passes.");
> +	}
> +
> +	static struct kunit_case misc_example_test_cases[] = {
> +		KUNIT_CASE(misc_example_add_test_basic),
> +		KUNIT_CASE(misc_example_test_failure),
> +		{},
> +	};
> +
> +	static struct kunit_module misc_example_test_module = {
> +		.name = "misc-example",
> +		.test_cases = misc_example_test_cases,
> +	};
> +	module_test(misc_example_test_module);
> +
> +Now add the following to ``drivers/misc/Kconfig``:
> +
> +.. code-block:: kconfig
> +
> +	config MISC_EXAMPLE_TEST
> +		bool "Test for my example"
> +		depends on MISC_EXAMPLE && KUNIT
> +
> +and the following to ``drivers/misc/Makefile``:
> +
> +.. code-block:: make
> +
> +	obj-$(CONFIG_MISC_EXAMPLE_TEST) += example-test.o
> +
> +Now add it to your ``kunitconfig``:
> +
> +.. code-block:: none
> +
> +	CONFIG_MISC_EXAMPLE=y
> +	CONFIG_MISC_EXAMPLE_TEST=y
> +
> +Now you can run the test:
> +
> +.. code-block:: bash
> +
> +	./tools/testing/kunit/kunit.py
> +
> +You should see the following failure:
> +
> +.. code-block:: none
> +
> +	...
> +	[16:08:57] [PASSED] misc-example:misc_example_add_test_basic
> +	[16:08:57] [FAILED] misc-example:misc_example_test_failure
> +	[16:08:57] EXPECTATION FAILED at drivers/misc/example-test.c:17
> +	[16:08:57] 	This test never passes.
> +	...
> +
> +Congrats! You just wrote your first KUnit test!
> +
> +Next Steps
> +=============

underline length warning. (?)

> +*   Check out the :doc:`usage` page for a more
> +    in-depth explanation of KUnit.
> diff --git a/Documentation/kunit/usage.rst b/Documentation/kunit/usage.rst
> new file mode 100644
> index 0000000000000..5c83ea9e21bc5
> --- /dev/null
> +++ b/Documentation/kunit/usage.rst
> @@ -0,0 +1,447 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============
> +Using KUnit
> +=============

over/underline length warnings?

> +
> +The purpose of this document is to describe what KUnit is, how it works, how it
> +is intended to be used, and all the concepts and terminology that are needed to
> +understand it. This guide assumes a working knowledge of the Linux kernel and
> +some basic knowledge of testing.
> +
> +For a high level introduction to KUnit, including setting up KUnit for your
> +project, see :doc:`start`.
> +
> +Organization of this document
> +=================================

underline length?  (and more below, but not being marked)

> +
> +This document is organized into two main sections: Testing and Isolating
> +Behavior. The first covers what a unit test is and how to use KUnit to write
> +them. The second covers how to use KUnit to isolate code and make it possible
> +to unit test code that was otherwise un-unit-testable.
> +
> +Testing
> +==========
> +
> +What is KUnit?
> +------------------
> +
> +"K" is short for "kernel" so "KUnit" is the "(Linux) Kernel Unit Testing
> +Framework." KUnit is intended first and foremost for writing unit tests; it is
> +general enough that it can be used to write integration tests; however, this is
> +a secondary goal. KUnit has no ambition of being the only testing framework for
> +the kernel; for example, it does not intend to be an end-to-end testing
> +framework.
> +
> +What is Unit Testing?
> +-------------------------


thanks.
-- 
~Randy
