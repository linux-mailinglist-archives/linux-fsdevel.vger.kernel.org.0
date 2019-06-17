Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCF247CC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2019 10:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfFQI2E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 04:28:04 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:50440 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfFQI16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:27:58 -0400
Received: by mail-oi1-f201.google.com with SMTP id p83so3267581oih.17
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jun 2019 01:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wSkZYrvSq1cksjTyH9bWh2tBvA7evGw1wj+jYRTIasY=;
        b=T3uuSVcv0SEhXJp+pRMHKcS8jV2O3JAkwL3CCvcsc+95jv+EIB8ynBrSVZYfGHDqrV
         rb33lmClM7HLP+MqaIf47n2UDCRe60autUlCB2uOETtMLZCGvAOM44BjYH+x+HzUmqNU
         ObSgK74SpGRFVOs9SL9MTHG5lPxMufr2pz7PtYWnAT3A8q9AAd1mp2+bTla1hQInejLd
         a1ZYJBe+CPAOrOCLN+/+ikEYTVDWp89ZTB+rykPGM7BmS2uEJVhMnWPtc6DHfo/EH20O
         4ctx/gOq04isMutTk+26oAOOQIjZy7O7/ApCR+twXvEWbkiVsK11JFRjyI1lhhyUkBSN
         Ng+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wSkZYrvSq1cksjTyH9bWh2tBvA7evGw1wj+jYRTIasY=;
        b=IMHlhLpDdULUHnQ6XOJkgvw+R892fFQdyPLkcSpje/cIvLIpEqVgUQ0/WXpuh5JCrr
         GRa9CcV7wiU3Ikm8A9fmmq3OMgJtwhkwppCNjCX6Wqz4lfc88lzG7NnrKhq1yIcx5MrP
         vB6SSPHZji62QKydwPojc1fh8v+n7fOQo1d84a31mb8YJTZclMQ1VpfXOWeHYbry+lDQ
         6a+gvyuKkR9NdzjB64mQUvKKKi+/dm9a8fPwyFcK8/3kspVgVcmlGNfnTqj/XnOFaLlK
         gotfI6bOzeh7IOVn16qOjphjmRldwMzMhgpAYhuKOK4NvDk7cmFNE5TyibDcH3xg7mbj
         b/Yg==
X-Gm-Message-State: APjAAAUFsUPmRVXEHvISRsOY6LFPfuMyK/NuodDCimI1/VsGmkU36Xc5
        fyX4ihzz6mJ/jYS4Swj3b/7u9yeltF9ir8cKXWqdww==
X-Google-Smtp-Source: APXvYqz1t0ulqHEGWx159j7vkPcReqwrANWuCrPIaQlsPQ95RAgIe8oNWoXhrRkyLyTzUN4975tnQLbNwtCfXlVsSM+BfQ==
X-Received: by 2002:aca:c4d5:: with SMTP id u204mr9426043oif.131.1560760076581;
 Mon, 17 Jun 2019 01:27:56 -0700 (PDT)
Date:   Mon, 17 Jun 2019 01:26:10 -0700
In-Reply-To: <20190617082613.109131-1-brendanhiggins@google.com>
Message-Id: <20190617082613.109131-16-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 15/18] Documentation: kunit: add documentation for KUnit
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com,
        Jonathan Corbet <corbet@lwn.net>
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
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>,
        Felix Guo <felixguoxiuping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add documentation for KUnit, the Linux kernel unit testing framework.
- Add intro and usage guide for KUnit
- Add API reference

Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 Documentation/dev-tools/index.rst           |   1 +
 Documentation/dev-tools/kunit/api/index.rst |  16 +
 Documentation/dev-tools/kunit/api/test.rst  |  14 +
 Documentation/dev-tools/kunit/faq.rst       |  62 +++
 Documentation/dev-tools/kunit/index.rst     |  79 +++
 Documentation/dev-tools/kunit/start.rst     | 180 ++++++
 Documentation/dev-tools/kunit/usage.rst     | 575 ++++++++++++++++++++
 7 files changed, 927 insertions(+)
 create mode 100644 Documentation/dev-tools/kunit/api/index.rst
 create mode 100644 Documentation/dev-tools/kunit/api/test.rst
 create mode 100644 Documentation/dev-tools/kunit/faq.rst
 create mode 100644 Documentation/dev-tools/kunit/index.rst
 create mode 100644 Documentation/dev-tools/kunit/start.rst
 create mode 100644 Documentation/dev-tools/kunit/usage.rst

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index b0522a4dd1073..09dee10d25928 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -24,6 +24,7 @@ whole; patches welcome!
    gdb-kernel-debugging
    kgdb
    kselftest
+   kunit/index
 
 
 .. only::  subproject and html
diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
new file mode 100644
index 0000000000000..9b9bffe5d41a0
--- /dev/null
+++ b/Documentation/dev-tools/kunit/api/index.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+API Reference
+=============
+.. toctree::
+
+	test
+
+This section documents the KUnit kernel testing API. It is divided into the
+following sections:
+
+================================= ==============================================
+:doc:`test`                       documents all of the standard testing API
+                                  excluding mocking or mocking related features.
+================================= ==============================================
diff --git a/Documentation/dev-tools/kunit/api/test.rst b/Documentation/dev-tools/kunit/api/test.rst
new file mode 100644
index 0000000000000..d0ce19b1e1185
--- /dev/null
+++ b/Documentation/dev-tools/kunit/api/test.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========
+Test API
+========
+
+This file documents all of the standard testing API excluding mocking or mocking
+related features.
+
+.. kernel-doc:: include/kunit/test.h
+   :internal:
+
+.. kernel-doc:: include/kunit/kunit-stream.h
+   :internal:
diff --git a/Documentation/dev-tools/kunit/faq.rst b/Documentation/dev-tools/kunit/faq.rst
new file mode 100644
index 0000000000000..bf2095112d899
--- /dev/null
+++ b/Documentation/dev-tools/kunit/faq.rst
@@ -0,0 +1,62 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+Frequently Asked Questions
+==========================
+
+How is this different from Autotest, kselftest, etc?
+====================================================
+KUnit is a unit testing framework. Autotest, kselftest (and some others) are
+not.
+
+A `unit test <https://martinfowler.com/bliki/UnitTest.html>`_ is supposed to
+test a single unit of code in isolation, hence the name. A unit test should be
+the finest granularity of testing and as such should allow all possible code
+paths to be tested in the code under test; this is only possible if the code
+under test is very small and does not have any external dependencies outside of
+the test's control like hardware.
+
+There are no testing frameworks currently available for the kernel that do not
+require installing the kernel on a test machine or in a VM and all require
+tests to be written in userspace and run on the kernel under test; this is true
+for Autotest, kselftest, and some others, disqualifying any of them from being
+considered unit testing frameworks.
+
+Does KUnit support running on architectures other than UML?
+===========================================================
+
+Yes, well, mostly.
+
+For the most part, the KUnit core framework (what you use to write the tests)
+can compile to any architecture; it compiles like just another part of the
+kernel and runs when the kernel boots. However, there is some infrastructure,
+like the KUnit Wrapper (``tools/testing/kunit/kunit.py``) that does not support
+other architectures.
+
+In short, this means that, yes, you can run KUnit on other architectures, but
+it might require more work than using KUnit on UML.
+
+For more information, see :ref:`kunit-on-non-uml`.
+
+What is the difference between a unit test and these other kinds of tests?
+==========================================================================
+Most existing tests for the Linux kernel would be categorized as an integration
+test, or an end-to-end test.
+
+- A unit test is supposed to test a single unit of code in isolation, hence the
+  name. A unit test should be the finest granularity of testing and as such
+  should allow all possible code paths to be tested in the code under test; this
+  is only possible if the code under test is very small and does not have any
+  external dependencies outside of the test's control like hardware.
+- An integration test tests the interaction between a minimal set of components,
+  usually just two or three. For example, someone might write an integration
+  test to test the interaction between a driver and a piece of hardware, or to
+  test the interaction between the userspace libraries the kernel provides and
+  the kernel itself; however, one of these tests would probably not test the
+  entire kernel along with hardware interactions and interactions with the
+  userspace.
+- An end-to-end test usually tests the entire system from the perspective of the
+  code under test. For example, someone might write an end-to-end test for the
+  kernel by installing a production configuration of the kernel on production
+  hardware with a production userspace and then trying to exercise some behavior
+  that depends on interactions between the hardware, the kernel, and userspace.
diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
new file mode 100644
index 0000000000000..a317ab45bfe2d
--- /dev/null
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -0,0 +1,79 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================
+KUnit - Unit Testing for the Linux Kernel
+=========================================
+
+.. toctree::
+	:maxdepth: 2
+
+	start
+	usage
+	api/index
+	faq
+
+What is KUnit?
+==============
+
+KUnit is a lightweight unit testing and mocking framework for the Linux kernel.
+These tests are able to be run locally on a developer's workstation without a VM
+or special hardware.
+
+KUnit is heavily inspired by JUnit, Python's unittest.mock, and
+Googletest/Googlemock for C++. KUnit provides facilities for defining unit test
+cases, grouping related test cases into test suites, providing common
+infrastructure for running tests, and much more.
+
+Get started now: :doc:`start`
+
+Why KUnit?
+==========
+
+A unit test is supposed to test a single unit of code in isolation, hence the
+name. A unit test should be the finest granularity of testing and as such should
+allow all possible code paths to be tested in the code under test; this is only
+possible if the code under test is very small and does not have any external
+dependencies outside of the test's control like hardware.
+
+Outside of KUnit, there are no testing frameworks currently
+available for the kernel that do not require installing the kernel on a test
+machine or in a VM and all require tests to be written in userspace running on
+the kernel; this is true for Autotest, and kselftest, disqualifying
+any of them from being considered unit testing frameworks.
+
+KUnit addresses the problem of being able to run tests without needing a virtual
+machine or actual hardware with User Mode Linux. User Mode Linux is a Linux
+architecture, like ARM or x86; however, unlike other architectures it compiles
+to a standalone program that can be run like any other program directly inside
+of a host operating system; to be clear, it does not require any virtualization
+support; it is just a regular program.
+
+KUnit is fast. Excluding build time, from invocation to completion KUnit can run
+several dozen tests in only 10 to 20 seconds; this might not sound like a big
+deal to some people, but having such fast and easy to run tests fundamentally
+changes the way you go about testing and even writing code in the first place.
+Linus himself said in his `git talk at Google
+<https://gist.github.com/lorn/1272686/revisions#diff-53c65572127855f1b003db4064a94573R874>`_:
+
+	"... a lot of people seem to think that performance is about doing the
+	same thing, just doing it faster, and that is not true. That is not what
+	performance is all about. If you can do something really fast, really
+	well, people will start using it differently."
+
+In this context Linus was talking about branching and merging,
+but this point also applies to testing. If your tests are slow, unreliable, are
+difficult to write, and require a special setup or special hardware to run,
+then you wait a lot longer to write tests, and you wait a lot longer to run
+tests; this means that tests are likely to break, unlikely to test a lot of
+things, and are unlikely to be rerun once they pass. If your tests are really
+fast, you run them all the time, every time you make a change, and every time
+someone sends you some code. Why trust that someone ran all their tests
+correctly on every change when you can just run them yourself in less time than
+it takes to read his / her test log?
+
+How do I use it?
+================
+
+*   :doc:`start` - for new users of KUnit
+*   :doc:`usage` - for a more detailed explanation of KUnit features
+*   :doc:`api/index` - for the list of KUnit APIs used for testing
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
new file mode 100644
index 0000000000000..852c8c70ca42c
--- /dev/null
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -0,0 +1,180 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+Getting Started
+===============
+
+Installing dependencies
+=======================
+KUnit has the same dependencies as the Linux kernel. As long as you can build
+the kernel, you can run KUnit.
+
+KUnit Wrapper
+=============
+Included with KUnit is a simple Python wrapper that helps format the output to
+easily use and read KUnit output. It handles building and running the kernel, as
+well as formatting the output.
+
+The wrapper can be run with:
+
+.. code-block:: bash
+
+   ./tools/testing/kunit/kunit.py
+
+Creating a kunitconfig
+======================
+The Python script is a thin wrapper around Kbuild as such, it needs to be
+configured with a ``kunitconfig`` file. This file essentially contains the
+regular Kernel config, with the specific test targets as well.
+
+.. code-block:: bash
+
+	git clone -b master https://kunit.googlesource.com/kunitconfig $PATH_TO_KUNITCONFIG_REPO
+	cd $PATH_TO_LINUX_REPO
+	ln -s $PATH_TO_KUNIT_CONFIG_REPO/kunitconfig kunitconfig
+
+You may want to add kunitconfig to your local gitignore.
+
+Verifying KUnit Works
+---------------------
+
+To make sure that everything is set up correctly, simply invoke the Python
+wrapper from your kernel repo:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py
+
+.. note::
+   You may want to run ``make mrproper`` first.
+
+If everything worked correctly, you should see the following:
+
+.. code-block:: bash
+
+	Generating .config ...
+	Building KUnit Kernel ...
+	Starting KUnit Kernel ...
+
+followed by a list of tests that are run. All of them should be passing.
+
+.. note::
+   Because it is building a lot of sources for the first time, the ``Building
+   kunit kernel`` step may take a while.
+
+Writing your first test
+=======================
+
+In your kernel repo let's add some code that we can test. Create a file
+``drivers/misc/example.h`` with the contents:
+
+.. code-block:: c
+
+	int misc_example_add(int left, int right);
+
+create a file ``drivers/misc/example.c``:
+
+.. code-block:: c
+
+	#include <linux/errno.h>
+
+	#include "example.h"
+
+	int misc_example_add(int left, int right)
+	{
+		return left + right;
+	}
+
+Now add the following lines to ``drivers/misc/Kconfig``:
+
+.. code-block:: kconfig
+
+	config MISC_EXAMPLE
+		bool "My example"
+
+and the following lines to ``drivers/misc/Makefile``:
+
+.. code-block:: make
+
+	obj-$(CONFIG_MISC_EXAMPLE) += example.o
+
+Now we are ready to write the test. The test will be in
+``drivers/misc/example-test.c``:
+
+.. code-block:: c
+
+	#include <kunit/test.h>
+	#include "example.h"
+
+	/* Define the test cases. */
+
+	static void misc_example_add_test_basic(struct kunit *test)
+	{
+		KUNIT_EXPECT_EQ(test, 1, misc_example_add(1, 0));
+		KUNIT_EXPECT_EQ(test, 2, misc_example_add(1, 1));
+		KUNIT_EXPECT_EQ(test, 0, misc_example_add(-1, 1));
+		KUNIT_EXPECT_EQ(test, INT_MAX, misc_example_add(0, INT_MAX));
+		KUNIT_EXPECT_EQ(test, -1, misc_example_add(INT_MAX, INT_MIN));
+	}
+
+	static void misc_example_test_failure(struct kunit *test)
+	{
+		KUNIT_FAIL(test, "This test never passes.");
+	}
+
+	static struct kunit_case misc_example_test_cases[] = {
+		KUNIT_CASE(misc_example_add_test_basic),
+		KUNIT_CASE(misc_example_test_failure),
+		{}
+	};
+
+	static struct kunit_module misc_example_test_module = {
+		.name = "misc-example",
+		.test_cases = misc_example_test_cases,
+	};
+	module_test(misc_example_test_module);
+
+Now add the following to ``drivers/misc/Kconfig``:
+
+.. code-block:: kconfig
+
+	config MISC_EXAMPLE_TEST
+		bool "Test for my example"
+		depends on MISC_EXAMPLE && KUNIT
+
+and the following to ``drivers/misc/Makefile``:
+
+.. code-block:: make
+
+	obj-$(CONFIG_MISC_EXAMPLE_TEST) += example-test.o
+
+Now add it to your ``kunitconfig``:
+
+.. code-block:: none
+
+	CONFIG_MISC_EXAMPLE=y
+	CONFIG_MISC_EXAMPLE_TEST=y
+
+Now you can run the test:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py
+
+You should see the following failure:
+
+.. code-block:: none
+
+	...
+	[16:08:57] [PASSED] misc-example:misc_example_add_test_basic
+	[16:08:57] [FAILED] misc-example:misc_example_test_failure
+	[16:08:57] EXPECTATION FAILED at drivers/misc/example-test.c:17
+	[16:08:57] 	This test never passes.
+	...
+
+Congrats! You just wrote your first KUnit test!
+
+Next Steps
+==========
+*   Check out the :doc:`usage` page for a more
+    in-depth explanation of KUnit.
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
new file mode 100644
index 0000000000000..c61b4f69d8837
--- /dev/null
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -0,0 +1,575 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========
+Using KUnit
+===========
+
+The purpose of this document is to describe what KUnit is, how it works, how it
+is intended to be used, and all the concepts and terminology that are needed to
+understand it. This guide assumes a working knowledge of the Linux kernel and
+some basic knowledge of testing.
+
+For a high level introduction to KUnit, including setting up KUnit for your
+project, see :doc:`start`.
+
+Organization of this document
+=============================
+
+This document is organized into two main sections: Testing and Isolating
+Behavior. The first covers what a unit test is and how to use KUnit to write
+them. The second covers how to use KUnit to isolate code and make it possible
+to unit test code that was otherwise un-unit-testable.
+
+Testing
+=======
+
+What is KUnit?
+--------------
+
+"K" is short for "kernel" so "KUnit" is the "(Linux) Kernel Unit Testing
+Framework." KUnit is intended first and foremost for writing unit tests; it is
+general enough that it can be used to write integration tests; however, this is
+a secondary goal. KUnit has no ambition of being the only testing framework for
+the kernel; for example, it does not intend to be an end-to-end testing
+framework.
+
+What is Unit Testing?
+---------------------
+
+A `unit test <https://martinfowler.com/bliki/UnitTest.html>`_ is a test that
+tests code at the smallest possible scope, a *unit* of code. In the C
+programming language that's a function.
+
+Unit tests should be written for all the publicly exposed functions in a
+compilation unit; so that is all the functions that are exported in either a
+*class* (defined below) or all functions which are **not** static.
+
+Writing Tests
+-------------
+
+Test Cases
+~~~~~~~~~~
+
+The fundamental unit in KUnit is the test case. A test case is a function with
+the signature ``void (*)(struct kunit *test)``. It calls a function to be tested
+and then sets *expectations* for what should happen. For example:
+
+.. code-block:: c
+
+	void example_test_success(struct kunit *test)
+	{
+	}
+
+	void example_test_failure(struct kunit *test)
+	{
+		KUNIT_FAIL(test, "This test never passes.");
+	}
+
+In the above example ``example_test_success`` always passes because it does
+nothing; no expectations are set, so all expectations pass. On the other hand
+``example_test_failure`` always fails because it calls ``KUNIT_FAIL``, which is
+a special expectation that logs a message and causes the test case to fail.
+
+Expectations
+~~~~~~~~~~~~
+An *expectation* is a way to specify that you expect a piece of code to do
+something in a test. An expectation is called like a function. A test is made
+by setting expectations about the behavior of a piece of code under test; when
+one or more of the expectations fail, the test case fails and information about
+the failure is logged. For example:
+
+.. code-block:: c
+
+	void add_test_basic(struct kunit *test)
+	{
+		KUNIT_EXPECT_EQ(test, 1, add(1, 0));
+		KUNIT_EXPECT_EQ(test, 2, add(1, 1));
+	}
+
+In the above example ``add_test_basic`` makes a number of assertions about the
+behavior of a function called ``add``; the first parameter is always of type
+``struct kunit *``, which contains information about the current test context;
+the second parameter, in this case, is what the value is expected to be; the
+last value is what the value actually is. If ``add`` passes all of these
+expectations, the test case, ``add_test_basic`` will pass; if any one of these
+expectations fail, the test case will fail.
+
+It is important to understand that a test case *fails* when any expectation is
+violated; however, the test will continue running, potentially trying other
+expectations until the test case ends or is otherwise terminated. This is as
+opposed to *assertions* which are discussed later.
+
+To learn about more expectations supported by KUnit, see :doc:`api/test`.
+
+.. note::
+   A single test case should be pretty short, pretty easy to understand,
+   focused on a single behavior.
+
+For example, if we wanted to properly test the add function above, we would
+create additional tests cases which would each test a different property that an
+add function should have like this:
+
+.. code-block:: c
+
+	void add_test_basic(struct kunit *test)
+	{
+		KUNIT_EXPECT_EQ(test, 1, add(1, 0));
+		KUNIT_EXPECT_EQ(test, 2, add(1, 1));
+	}
+
+	void add_test_negative(struct kunit *test)
+	{
+		KUNIT_EXPECT_EQ(test, 0, add(-1, 1));
+	}
+
+	void add_test_max(struct kunit *test)
+	{
+		KUNIT_EXPECT_EQ(test, INT_MAX, add(0, INT_MAX));
+		KUNIT_EXPECT_EQ(test, -1, add(INT_MAX, INT_MIN));
+	}
+
+	void add_test_overflow(struct kunit *test)
+	{
+		KUNIT_EXPECT_EQ(test, INT_MIN, add(INT_MAX, 1));
+	}
+
+Notice how it is immediately obvious what all the properties that we are testing
+for are.
+
+Assertions
+~~~~~~~~~~
+
+KUnit also has the concept of an *assertion*. An assertion is just like an
+expectation except the assertion immediately terminates the test case if it is
+not satisfied.
+
+For example:
+
+.. code-block:: c
+
+	static void mock_test_do_expect_default_return(struct kunit *test)
+	{
+		struct mock_test_context *ctx = test->priv;
+		struct mock *mock = ctx->mock;
+		int param0 = 5, param1 = -5;
+		const char *two_param_types[] = {"int", "int"};
+		const void *two_params[] = {&param0, &param1};
+		const void *ret;
+
+		ret = mock->do_expect(mock,
+				      "test_printk", test_printk,
+				      two_param_types, two_params,
+				      ARRAY_SIZE(two_params));
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
+		KUNIT_EXPECT_EQ(test, -4, *((int *) ret));
+	}
+
+In this example, the method under test should return a pointer to a value, so
+if the pointer returned by the method is null or an errno, we don't want to
+bother continuing the test since the following expectation could crash the test
+case. `ASSERT_NOT_ERR_OR_NULL(...)` allows us to bail out of the test case if
+the appropriate conditions have not been satisfied to complete the test.
+
+Modules / Test Suites
+~~~~~~~~~~~~~~~~~~~~~
+
+Now obviously one unit test isn't very helpful; the power comes from having
+many test cases covering all of your behaviors. Consequently it is common to
+have many *similar* tests; in order to reduce duplication in these closely
+related tests most unit testing frameworks provide the concept of a *test
+suite*, in KUnit we call it a *test module*; all it is is just a collection of
+test cases for a unit of code with a set up function that gets invoked before
+every test cases and then a tear down function that gets invoked after every
+test case completes.
+
+Example:
+
+.. code-block:: c
+
+	static struct kunit_case example_test_cases[] = {
+		KUNIT_CASE(example_test_foo),
+		KUNIT_CASE(example_test_bar),
+		KUNIT_CASE(example_test_baz),
+		{}
+	};
+
+	static struct kunit_module example_test_module = {
+		.name = "example",
+		.init = example_test_init,
+		.exit = example_test_exit,
+		.test_cases = example_test_cases,
+	};
+	module_test(example_test_module);
+
+In the above example the test suite, ``example_test_module``, would run the test
+cases ``example_test_foo``, ``example_test_bar``, and ``example_test_baz``, each
+would have ``example_test_init`` called immediately before it and would have
+``example_test_exit`` called immediately after it.
+``module_test(example_test_module)`` registers the test suite with the KUnit
+test framework.
+
+.. note::
+   A test case will only be run if it is associated with a test suite.
+
+For a more information on these types of things see the :doc:`api/test`.
+
+Isolating Behavior
+==================
+
+The most important aspect of unit testing that other forms of testing do not
+provide is the ability to limit the amount of code under test to a single unit.
+In practice, this is only possible by being able to control what code gets run
+when the unit under test calls a function and this is usually accomplished
+through some sort of indirection where a function is exposed as part of an API
+such that the definition of that function can be changed without affecting the
+rest of the code base. In the kernel this primarily comes from two constructs,
+classes, structs that contain function pointers that are provided by the
+implementer, and architecture specific functions which have definitions selected
+at compile time.
+
+Classes
+-------
+
+Classes are not a construct that is built into the C programming language;
+however, it is an easily derived concept. Accordingly, pretty much every project
+that does not use a standardized object oriented library (like GNOME's GObject)
+has their own slightly different way of doing object oriented programming; the
+Linux kernel is no exception.
+
+The central concept in kernel object oriented programming is the class. In the
+kernel, a *class* is a struct that contains function pointers. This creates a
+contract between *implementers* and *users* since it forces them to use the
+same function signature without having to call the function directly. In order
+for it to truly be a class, the function pointers must specify that a pointer
+to the class, known as a *class handle*, be one of the parameters; this makes
+it possible for the member functions (also known as *methods*) to have access
+to member variables (more commonly known as *fields*) allowing the same
+implementation to have multiple *instances*.
+
+Typically a class can be *overridden* by *child classes* by embedding the
+*parent class* in the child class. Then when a method provided by the child
+class is called, the child implementation knows that the pointer passed to it is
+of a parent contained within the child; because of this, the child can compute
+the pointer to itself because the pointer to the parent is always a fixed offset
+from the pointer to the child; this offset is the offset of the parent contained
+in the child struct. For example:
+
+.. code-block:: c
+
+	struct shape {
+		int (*area)(struct shape *this);
+	};
+
+	struct rectangle {
+		struct shape parent;
+		int length;
+		int width;
+	};
+
+	int rectangle_area(struct shape *this)
+	{
+		struct rectangle *self = container_of(this, struct shape, parent);
+
+		return self->length * self->width;
+	};
+
+	void rectangle_new(struct rectangle *self, int length, int width)
+	{
+		self->parent.area = rectangle_area;
+		self->length = length;
+		self->width = width;
+	}
+
+In this example (as in most kernel code) the operation of computing the pointer
+to the child from the pointer to the parent is done by ``container_of``.
+
+Faking Classes
+~~~~~~~~~~~~~~
+
+In order to unit test a piece of code that calls a method in a class, the
+behavior of the method must be controllable, otherwise the test ceases to be a
+unit test and becomes an integration test.
+
+A fake just provides an implementation of a piece of code that is different than
+what runs in a production instance, but behaves identically from the standpoint
+of the callers; this is usually done to replace a dependency that is hard to
+deal with, or is slow.
+
+A good example for this might be implementing a fake EEPROM that just stores the
+"contents" in an internal buffer. For example, let's assume we have a class that
+represents an EEPROM:
+
+.. code-block:: c
+
+	struct eeprom {
+		ssize_t (*read)(struct eeprom *this, size_t offset, char *buffer, size_t count);
+		ssize_t (*write)(struct eeprom *this, size_t offset, const char *buffer, size_t count);
+	};
+
+And we want to test some code that buffers writes to the EEPROM:
+
+.. code-block:: c
+
+	struct eeprom_buffer {
+		ssize_t (*write)(struct eeprom_buffer *this, const char *buffer, size_t count);
+		int flush(struct eeprom_buffer *this);
+		size_t flush_count; /* Flushes when buffer exceeds flush_count. */
+	};
+
+	struct eeprom_buffer *new_eeprom_buffer(struct eeprom *eeprom);
+	void destroy_eeprom_buffer(struct eeprom *eeprom);
+
+We can easily test this code by *faking out* the underlying EEPROM:
+
+.. code-block:: c
+
+	struct fake_eeprom {
+		struct eeprom parent;
+		char contents[FAKE_EEPROM_CONTENTS_SIZE];
+	};
+
+	ssize_t fake_eeprom_read(struct eeprom *parent, size_t offset, char *buffer, size_t count)
+	{
+		struct fake_eeprom *this = container_of(parent, struct fake_eeprom, parent);
+
+		count = min(count, FAKE_EEPROM_CONTENTS_SIZE - offset);
+		memcpy(buffer, this->contents + offset, count);
+
+		return count;
+	}
+
+	ssize_t fake_eeprom_write(struct eeprom *this, size_t offset, const char *buffer, size_t count)
+	{
+		struct fake_eeprom *this = container_of(parent, struct fake_eeprom, parent);
+
+		count = min(count, FAKE_EEPROM_CONTENTS_SIZE - offset);
+		memcpy(this->contents + offset, buffer, count);
+
+		return count;
+	}
+
+	void fake_eeprom_init(struct fake_eeprom *this)
+	{
+		this->parent.read = fake_eeprom_read;
+		this->parent.write = fake_eeprom_write;
+		memset(this->contents, 0, FAKE_EEPROM_CONTENTS_SIZE);
+	}
+
+We can now use it to test ``struct eeprom_buffer``:
+
+.. code-block:: c
+
+	struct eeprom_buffer_test {
+		struct fake_eeprom *fake_eeprom;
+		struct eeprom_buffer *eeprom_buffer;
+	};
+
+	static void eeprom_buffer_test_does_not_write_until_flush(struct kunit *test)
+	{
+		struct eeprom_buffer_test *ctx = test->priv;
+		struct eeprom_buffer *eeprom_buffer = ctx->eeprom_buffer;
+		struct fake_eeprom *fake_eeprom = ctx->fake_eeprom;
+		char buffer[] = {0xff};
+
+		eeprom_buffer->flush_count = SIZE_MAX;
+
+		eeprom_buffer->write(eeprom_buffer, buffer, 1);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[0], 0);
+
+		eeprom_buffer->write(eeprom_buffer, buffer, 1);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[1], 0);
+
+		eeprom_buffer->flush(eeprom_buffer);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[0], 0xff);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[1], 0xff);
+	}
+
+	static void eeprom_buffer_test_flushes_after_flush_count_met(struct kunit *test)
+	{
+		struct eeprom_buffer_test *ctx = test->priv;
+		struct eeprom_buffer *eeprom_buffer = ctx->eeprom_buffer;
+		struct fake_eeprom *fake_eeprom = ctx->fake_eeprom;
+		char buffer[] = {0xff};
+
+		eeprom_buffer->flush_count = 2;
+
+		eeprom_buffer->write(eeprom_buffer, buffer, 1);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[0], 0);
+
+		eeprom_buffer->write(eeprom_buffer, buffer, 1);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[0], 0xff);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[1], 0xff);
+	}
+
+	static void eeprom_buffer_test_flushes_increments_of_flush_count(struct kunit *test)
+	{
+		struct eeprom_buffer_test *ctx = test->priv;
+		struct eeprom_buffer *eeprom_buffer = ctx->eeprom_buffer;
+		struct fake_eeprom *fake_eeprom = ctx->fake_eeprom;
+		char buffer[] = {0xff, 0xff};
+
+		eeprom_buffer->flush_count = 2;
+
+		eeprom_buffer->write(eeprom_buffer, buffer, 1);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[0], 0);
+
+		eeprom_buffer->write(eeprom_buffer, buffer, 2);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[0], 0xff);
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[1], 0xff);
+		/* Should have only flushed the first two bytes. */
+		KUNIT_EXPECT_EQ(test, fake_eeprom->contents[2], 0);
+	}
+
+	static int eeprom_buffer_test_init(struct kunit *test)
+	{
+		struct eeprom_buffer_test *ctx;
+
+		ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+		ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+		ctx->fake_eeprom = kunit_kzalloc(test, sizeof(*ctx->fake_eeprom), GFP_KERNEL);
+		ASSERT_NOT_ERR_OR_NULL(test, ctx->fake_eeprom);
+
+		ctx->eeprom_buffer = new_eeprom_buffer(&ctx->fake_eeprom->parent);
+		ASSERT_NOT_ERR_OR_NULL(test, ctx->eeprom_buffer);
+
+		test->priv = ctx;
+
+		return 0;
+	}
+
+	static void eeprom_buffer_test_exit(struct kunit *test)
+	{
+		struct eeprom_buffer_test *ctx = test->priv;
+
+		destroy_eeprom_buffer(ctx->eeprom_buffer);
+	}
+
+.. _kunit-on-non-uml:
+
+KUnit on non-UML architectures
+==============================
+
+By default KUnit uses UML as a way to provide dependencies for code under test.
+Under most circumstances KUnit's usage of UML should be treated as an
+implementation detail of how KUnit works under the hood. Nevertheless, there
+are instances where being able to run architecture specific code, or test
+against real hardware is desirable. For these reasons KUnit supports running on
+other architectures.
+
+Running existing KUnit tests on non-UML architectures
+-----------------------------------------------------
+
+There are some special considerations when running existing KUnit tests on
+non-UML architectures:
+
+*   Hardware may not be deterministic, so a test that always passes or fails
+    when run under UML may not always do so on real hardware.
+*   Hardware and VM environments may not be hermetic. KUnit tries its best to
+    provide a hermetic environment to run tests; however, it cannot manage state
+    that it doesn't know about outside of the kernel. Consequently, tests that
+    may be hermetic on UML may not be hermetic on other architectures.
+*   Some features and tooling may not be supported outside of UML.
+*   Hardware and VMs are slower than UML.
+
+None of these are reasons not to run your KUnit tests on real hardware; they are
+only things to be aware of when doing so.
+
+The biggest impediment will likely be that certain KUnit features and
+infrastructure may not support your target environment. For example, at this
+time the KUnit Wrapper (``tools/testing/kunit/kunit.py``) does not work outside
+of UML. Unfortunately, there is no way around this. Using UML (or even just a
+particular architecture) allows us to make a lot of assumptions that make it
+possible to do things which might otherwise be impossible.
+
+Nevertheless, all core KUnit framework features are fully supported on all
+architectures, and using them is straightforward: all you need to do is to take
+your kunitconfig, your Kconfig options for the tests you would like to run, and
+merge them into whatever config your are using for your platform. That's it!
+
+For example, let's say you have the following kunitconfig:
+
+.. code-block:: none
+
+	CONFIG_KUNIT=y
+	CONFIG_KUNIT_EXAMPLE_TEST=y
+
+If you wanted to run this test on an x86 VM, you might add the following config
+options to your ``.config``:
+
+.. code-block:: none
+
+	CONFIG_KUNIT=y
+	CONFIG_KUNIT_EXAMPLE_TEST=y
+	CONFIG_SERIAL_8250=y
+	CONFIG_SERIAL_8250_CONSOLE=y
+
+All these new options do is enable support for a common serial console needed
+for logging.
+
+Next, you could build a kernel with these tests as follows:
+
+
+.. code-block:: bash
+
+	make ARCH=x86 olddefconfig
+	make ARCH=x86
+
+Once you have built a kernel, you could run it on QEMU as follows:
+
+.. code-block:: bash
+
+	qemu-system-x86_64 -enable-kvm \
+			   -m 1024 \
+			   -kernel arch/x86_64/boot/bzImage \
+			   -append 'console=ttyS0' \
+			   --nographic
+
+Interspersed in the kernel logs you might see the following:
+
+.. code-block:: none
+
+	TAP version 14
+		# Subtest: example
+		1..1
+		# example_simple_test: initializing
+		ok 1 - example_simple_test
+	ok 1 - example
+
+Congratulations, you just ran a KUnit test on the x86 architecture!
+
+Writing new tests for other architectures
+-----------------------------------------
+
+The first thing you must do is ask yourself whether it is necessary to write a
+KUnit test for a specific architecture, and then whether it is necessary to
+write that test for a particular piece of hardware. In general, writing a test
+that depends on having access to a particular piece of hardware or software (not
+included in the Linux source repo) should be avoided at all costs.
+
+Even if you only ever plan on running your KUnit test on your hardware
+configuration, other people may want to run your tests and may not have access
+to your hardware. If you write your test to run on UML, then anyone can run your
+tests without knowing anything about your particular setup, and you can still
+run your tests on your hardware setup just by compiling for your architecture.
+
+.. important::
+   Always prefer tests that run on UML to tests that only run under a particular
+   architecture, and always prefer tests that run under QEMU or another easy
+   (and monitarily free) to obtain software environment to a specific piece of
+   hardware.
+
+Nevertheless, there are still valid reasons to write an architecture or hardware
+specific test: for example, you might want to test some code that really belongs
+in ``arch/some-arch/*``. Even so, try your best to write the test so that it
+does not depend on physical hardware: if some of your test cases don't need the
+hardware, only require the hardware for tests that actually need it.
+
+Now that you have narrowed down exactly what bits are hardware specific, the
+actual procedure for writing and running the tests is pretty much the same as
+writing normal KUnit tests. One special caveat is that you have to reset
+hardware state in between test cases; if this is not possible, you may only be
+able to run one test case per invocation.
+
+.. TODO(brendanhiggins@google.com): Add an actual example of an architecture
+   dependent KUnit test.
-- 
2.22.0.410.gd8fdbe21b5-goog

