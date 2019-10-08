Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2F5DCFCEC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 16:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfJHO4q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 10:56:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33114 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfJHO4p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:56:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98En6JX089148;
        Tue, 8 Oct 2019 14:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=in2Wx3k+nUesmaQsjF1bcoCwQ7ksLAAPz2jKhu/xjuU=;
 b=WYusr7jq/9X4G6KU0hNDs1CXzz1OqIqk7Roan74h60HpBZTw89Cav8H0APDEdMwjnpul
 xHEfTqyahUfg5MvWq+avs5+rvUGjmE2ot1iBaSlhwcBr+rIURMQg8/iXrpTPgxGRYW28
 5NfrvYlucj6Dz6eh9n/ZFSiXS7f53xpeylj/cYSHarlscKeba+ydWScN5V9TQ56fUNJZ
 8OZLkMG/uvh0XixD5FjFj9BqiON8psBSVf+gKPIcW7q1pDqF5Zp2b25g4vXEwlsIkN0W
 +Qu7ehOWdh6zaGSTb+R72o6LJwo82gDX+1HOTAc37j5Gvenjhor9zyfKouSQqSvzKJeg gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vektrdmfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 14:56:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98EnBOo141555;
        Tue, 8 Oct 2019 14:56:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vgefarhtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 14:56:17 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x98EuFHv026443;
        Tue, 8 Oct 2019 14:56:15 GMT
Received: from dhcp-10-175-191-48.vpn.oracle.com (/10.175.191.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 14:56:14 +0000
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
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 linux-kselftest-test 0/3] kunit: support building core/tests as modules
Date:   Tue,  8 Oct 2019 15:55:43 +0100
Message-Id: <1570546546-549-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=38 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=38 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080134
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current kunit execution model is to provide base kunit functionality
and tests built-in to the kernel.  The aim of this series is to allow
building kunit itself and tests as modules.  This in turn allows a
simple form of selective execution; load the module you wish to test.
In doing so, kunit itself (if also built as a module) will be loaded as
an implicit dependency.

Because this requires a core API modification - if a module delivers
multiple suites, they must be declared with the kunit_test_suites()
macro - we're proposing this patch as a candidate to be applied to the
test tree before too many kunit consumers appear.  We attempt to deal
with existing consumers in patch 1.

Changes since v1:

- sent correct patch set; apologies, previous patch set was built
  prior to kunit move to lib/ and should be ignored.

Patch 1 consists changes needed to support loading tests as modules.
Patch 2 allows kunit itself to be loaded as a module.
Patch 3 documents module support.

Alan Maguire (3):
  kunit: allow kunit tests to be loaded as a module
  kunit: allow kunit to be loaded as a module
  kunit: update documentation to describe module-based build

 Documentation/dev-tools/kunit/faq.rst   |  3 ++-
 Documentation/dev-tools/kunit/index.rst |  3 +++
 Documentation/dev-tools/kunit/usage.rst | 16 ++++++++++++++++
 include/kunit/test.h                    | 30 +++++++++++++++++++++++-------
 kernel/sysctl-test.c                    |  6 +++++-
 lib/Kconfig.debug                       |  4 ++--
 lib/kunit/Kconfig                       |  6 +++---
 lib/kunit/Makefile                      |  4 +++-
 lib/kunit/assert.c                      |  8 ++++++++
 lib/kunit/example-test.c                |  6 +++++-
 lib/kunit/string-stream-test.c          |  9 +++++++--
 lib/kunit/string-stream.c               |  7 +++++++
 lib/kunit/test-test.c                   |  8 ++++++--
 lib/kunit/test.c                        | 12 ++++++++++++
 lib/kunit/try-catch.c                   |  8 ++++++--
 15 files changed, 108 insertions(+), 22 deletions(-)

-- 
1.8.3.1

