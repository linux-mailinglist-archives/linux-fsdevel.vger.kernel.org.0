Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBEA011006
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 01:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfEAXFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 19:05:01 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:50121 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfEAXFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 19:05:01 -0400
Received: by mail-qt1-f201.google.com with SMTP id w34so334299qtc.16
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 16:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=++IqKeBLqckP3pzOmVar4rTFxdL/ygBrsNe3aTLWHFw=;
        b=Mh4yNfHbU/r/hynANIpH/uBHmMlHKZNXH2yEHtO6ZZC18QRTV6NjLTD0oQA4RLSt+E
         9zxm4myKMxtoyylfxzctOfq6/wmUE47cqwwTwujoD7BntKXRRLrkdNjFNR03r7Xl6SLi
         ef0Oj4UO/rD2VyyJe2njl4Pav0uHqoc3LDxaSLZ9QA8MNsk8FBTic2QtzrfT+1femF9f
         kMNbw8OuB0ybOhfF0/CUaJ/pALKgjk8agsnIe4NGtcuzMP48GTU0XTTDwBIvryD27EP5
         8L3KWlvgTkHt477RyvSuLBaqZZdeIt6CfPZs1MXdW56e7bdqfQ6Ghre7zWFu0Tqe0etO
         1/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=++IqKeBLqckP3pzOmVar4rTFxdL/ygBrsNe3aTLWHFw=;
        b=EK6rX/k33WTEIhqa0TTu6jWkiiIRrwsQLEufaKknsh1k42o+BUM7pN3aTN5RazInGw
         X47psO2/0gog9PAzUSNcjHh8A89kG9c5BxE+AoBTVHsCrQlG/OqVBFDEmd7TYMbPK+ct
         GaMjSmfMuyFHerX4QoMn8B2rhZCBufkpH7Q+2Hkm+nopq9Y7JkZKgxAWY5pKDoe1G8jN
         4a0Mx6ICn1vVzGCu8OJH3uQ/9Mn4C7sZpylunkVWgW++yV6k8mlJZkwe4T21SfEzXHCT
         PmhGvOkS4SzPQwtTINATJvW25n7femK0DQ8lTLJ79ooMPFhGMXoNlloSxktaxt+xjjg3
         WNqQ==
X-Gm-Message-State: APjAAAX1eMO52I6tQZ1WP/AfwDbZ2yJ41d0OiPWydx2BrTEQK2o2VroQ
        OZqk5bJDhsol6IWRGnENES7NUtAzhSGP7ovVSbySLg==
X-Google-Smtp-Source: APXvYqxYOhEIiQvkotM+u1/2nPU9T6qCWImyl7hRlg584MNpx99ut/j31a6fba5mvJccBbafeTt79jt+YeSAwDMMlnVMqg==
X-Received: by 2002:ae9:ee15:: with SMTP id i21mr523362qkg.107.1556751899843;
 Wed, 01 May 2019 16:04:59 -0700 (PDT)
Date:   Wed,  1 May 2019 16:01:23 -0700
In-Reply-To: <20190501230126.229218-1-brendanhiggins@google.com>
Message-Id: <20190501230126.229218-15-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v2 14/17] Documentation: kunit: add documentation for KUnit
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
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
        Brendan Higgins <brendanhiggins@google.com>,
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
---
 Documentation/index.rst           |   1 +
 Documentation/kunit/api/index.rst |  16 ++
 Documentation/kunit/api/test.rst  |  15 +
 Documentation/kunit/faq.rst       |  46 +++
 Documentation/kunit/index.rst     |  80 ++++++
 Documentation/kunit/start.rst     | 180 ++++++++++++
 Documentation/kunit/usage.rst     | 447 ++++++++++++++++++++++++++++++
 7 files changed, 785 insertions(+)
 create mode 100644 Documentation/kunit/api/index.rst
 create mode 100644 Documentation/kunit/api/test.rst
 create mode 100644 Documentation/kunit/faq.rst
 create mode 100644 Documentation/kunit/index.rst
 create mode 100644 Documentation/kunit/start.rst
 create mode 100644 Documentation/kunit/usage.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 80a421cb935e7..264cfd613a774 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -65,6 +65,7 @@ merged much easier.
    kernel-hacking/index
    trace/index
    maintainer/index
+   kunit/index
 
 Kernel API documentation
 ------------------------
diff --git a/Documentation/kunit/api/index.rst b/Documentation/kunit/api/index.rst
new file mode 100644
index 0000000000000..c31c530088153
--- /dev/null
+++ b/Documentation/kunit/api/index.rst
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
+This section documents the KUnit kernel testing API. It is divided into 3
+sections:
+
+================================= ==============================================
+:doc:`test`                       documents all of the standard testing API
+                                  excluding mocking or mocking related features.
+================================= ==============================================
diff --git a/Documentation/kunit/api/test.rst b/Documentation/kunit/api/test.rst
new file mode 100644
index 0000000000000..7c926014f047c
--- /dev/null
+++ b/Documentation/kunit/api/test.rst
@@ -0,0 +1,15 @@
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
+
diff --git a/Documentation/kunit/faq.rst b/Documentation/kunit/faq.rst
new file mode 100644
index 0000000000000..cb8e4fb2257a0
--- /dev/null
+++ b/Documentation/kunit/faq.rst
@@ -0,0 +1,46 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================
+Frequently Asked Questions
+=========================================
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
diff --git a/Documentation/kunit/index.rst b/Documentation/kunit/index.rst
new file mode 100644
index 0000000000000..c6710211b647f
--- /dev/null
+++ b/Documentation/kunit/index.rst
@@ -0,0 +1,80 @@
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
+===================
+
+*   :doc:`start` - for new users of KUnit
+*   :doc:`usage` - for a more detailed explanation of KUnit features
+*   :doc:`api/index` - for the list of KUnit APIs used for testing
+
diff --git a/Documentation/kunit/start.rst b/Documentation/kunit/start.rst
new file mode 100644
index 0000000000000..5cdba5091905e
--- /dev/null
+++ b/Documentation/kunit/start.rst
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
+-------------------------
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
+==========================
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
+		{},
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
+=============
+*   Check out the :doc:`usage` page for a more
+    in-depth explanation of KUnit.
diff --git a/Documentation/kunit/usage.rst b/Documentation/kunit/usage.rst
new file mode 100644
index 0000000000000..5c83ea9e21bc5
--- /dev/null
+++ b/Documentation/kunit/usage.rst
@@ -0,0 +1,447 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+Using KUnit
+=============
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
+=================================
+
+This document is organized into two main sections: Testing and Isolating
+Behavior. The first covers what a unit test is and how to use KUnit to write
+them. The second covers how to use KUnit to isolate code and make it possible
+to unit test code that was otherwise un-unit-testable.
+
+Testing
+==========
+
+What is KUnit?
+------------------
+
+"K" is short for "kernel" so "KUnit" is the "(Linux) Kernel Unit Testing
+Framework." KUnit is intended first and foremost for writing unit tests; it is
+general enough that it can be used to write integration tests; however, this is
+a secondary goal. KUnit has no ambition of being the only testing framework for
+the kernel; for example, it does not intend to be an end-to-end testing
+framework.
+
+What is Unit Testing?
+-------------------------
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
+		{},
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
-- 
2.21.0.593.g511ec345e18-goog

