Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC7EBCFCB0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 16:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfJHOpZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 10:45:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41912 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfJHOpZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:45:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98ESmbn041740;
        Tue, 8 Oct 2019 14:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=6simcc1A7X0q4K8SZt/71FEhzObgYlOmPpnvxhl2O8E=;
 b=Uv4DBZ7OjHnb8yReW59vb/MfJWxxYuRRttKfUDHFEPywXdBQ/fSaeZiBxM6rkROu5F8Z
 UC4Ywsun0Ie/JU7vPXF1FEf+1RWZo+8d+UplmY9H5HfUltdjOLjXUshihGqE+t2lfiFD
 95myj69c5bSEJ7qqNEHoC3/VYcYBBWtfbmJ0EOz5gitDsqQFXUUo4e944blcDqvJAGi0
 Bn3UuHCoOaGYTanESCPiTkcnrFYj+MXxot4WNH0a6Yz022IP6n0hv3p1ThGI8qvfAoin
 XLLNH7nV5SRrb3rwADjT2bpz8WfbUUnp0Gd85jZ1cf0OoAo2+DYA2QeUnWOqMCQ5sy+K dQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vek4qdqtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 14:44:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98ET4Eg070439;
        Tue, 8 Oct 2019 14:44:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vg1yw2rd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 14:44:46 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x98Eii6Y031958;
        Tue, 8 Oct 2019 14:44:44 GMT
Received: from dhcp-10-175-191-48.vpn.oracle.com (/10.175.191.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 14:44:44 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     linux-kselftest@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        changbin.du@intel.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Knut Omang <knut.omang@oracle.com>
Subject: [PATCH linux-kselftest-test 3/3] kunit: update documentation to describe module-based build
Date:   Tue,  8 Oct 2019 15:43:52 +0100
Message-Id: <1570545832-32326-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570545832-32326-1-git-send-email-alan.maguire@oracle.com>
References: <1570545832-32326-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=43 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=43 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080133
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Documentation should describe how to build kunit and tests as
modules.

Signed-off-by: Knut Omang <knut.omang@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 Documentation/dev-tools/kunit/faq.rst   |  3 ++-
 Documentation/dev-tools/kunit/index.rst |  3 +++
 Documentation/dev-tools/kunit/usage.rst | 16 ++++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/faq.rst b/Documentation/dev-tools/kunit/faq.rst
index bf20951..ea55b24 100644
--- a/Documentation/dev-tools/kunit/faq.rst
+++ b/Documentation/dev-tools/kunit/faq.rst
@@ -29,7 +29,8 @@ Yes, well, mostly.
 
 For the most part, the KUnit core framework (what you use to write the tests)
 can compile to any architecture; it compiles like just another part of the
-kernel and runs when the kernel boots. However, there is some infrastructure,
+kernel and runs when the kernel boots, or when built as a module, when the
+module is loaded.  However, there is some infrastructure,
 like the KUnit Wrapper (``tools/testing/kunit/kunit.py``) that does not support
 other architectures.
 
diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index 26ffb46..7ddc385 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -48,6 +48,9 @@ to a standalone program that can be run like any other program directly inside
 of a host operating system; to be clear, it does not require any virtualization
 support; it is just a regular program.
 
+Alternatively, kunit and kunit tests can be built as modules and tests will
+run when the test module is loaded.
+
 KUnit is fast. Excluding build time, from invocation to completion KUnit can run
 several dozen tests in only 10 to 20 seconds; this might not sound like a big
 deal to some people, but having such fast and easy to run tests fundamentally
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index c6e6963..fa0f03f 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -539,6 +539,22 @@ Interspersed in the kernel logs you might see the following:
 
 Congratulations, you just ran a KUnit test on the x86 architecture!
 
+In a similar manner, kunit and kunit tests can also be built as modules,
+so if you wanted to run tests in this way you might add the following config
+options to your ``.config``:
+
+.. code-block:: none
+
+        CONFIG_KUNIT=m
+        CONFIG_KUNIT_EXAMPLE_TEST=m
+
+Once the kernel is built and installed, a simple
+
+.. code-block:: bash
+	modprobe example-test
+
+...will run the tests.
+
 Writing new tests for other architectures
 -----------------------------------------
 
-- 
1.8.3.1

