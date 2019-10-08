Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7C28CFCF8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 16:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfJHO6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 10:58:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34806 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfJHO6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:58:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98EnAa2089216;
        Tue, 8 Oct 2019 14:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=/P+uORyC+xIaC1IrzTzZKPatt1FDmQI8eceQUtAHl6w=;
 b=TqBLoisEttWViHviH6+7vCTIU1WSOy0My6f7dNgmxprS7eoudzSJHUgWRMv7PcoVls7i
 W+bFZjPVibKURAmxHY2eFdJ2CLQnwKjNOAKRFAbM+svcC7kpUFmjVO56XVYRmIOGqYpB
 t1eLvedx4bX7UHKPNhMxChahqcio9gumfSuD3CkH/YH3ol80CR09IdRzX/sQiL3fL8KX
 ZngX72S0r+4HYTJ8Kq4YIOql1cdN/tyl/m0aNmNMGrsgvEl82b6hZwBe5Nlkthh026Vp
 mpW3vWgU321eZxwaNBqzDQmlylzTkAsb4KgSwf0J99VYBA4//9OUpnyNOjs2SQiwkf2A pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vektrdmkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 14:56:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98En8Lj141448;
        Tue, 8 Oct 2019 14:56:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vgefarjuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 14:56:52 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x98EupIe026779;
        Tue, 8 Oct 2019 14:56:51 GMT
Received: from dhcp-10-175-191-48.vpn.oracle.com (/10.175.191.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 14:56:51 +0000
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
Subject: [PATCH v2 linux-kselftest-test 3/3] kunit: update documentation to describe module-based build
Date:   Tue,  8 Oct 2019 15:55:46 +0100
Message-Id: <1570546546-549-4-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570546546-549-1-git-send-email-alan.maguire@oracle.com>
References: <1570546546-549-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=43 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=43 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080134
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Documentation should describe how to build kunit and tests as
modules.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>

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

