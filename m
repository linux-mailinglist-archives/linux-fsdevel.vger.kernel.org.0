Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0555FCFCBB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 16:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfJHOpy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 10:45:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48700 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfJHOpx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:45:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98ESp9c070052;
        Tue, 8 Oct 2019 14:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=bmUUyXdPet1IcRfhw6Xp6Zh40UK2k91Okb0Yfi2nf3I=;
 b=q+TsZBhQZK1mG82uogKprFD4wzpJfpLeZNkjHKJrya+W4l0Ew/IIymnaoOPVmkdVVl+n
 3rXrlXEabI7amMxsUyYe9Hb/Wu2KoLQuSFuvzlfGevSA++/V8rHKOTktzvLUYEZRcjnI
 fCPz6mwunGgJ2lCXnFAuvMdCT9DcFrcc/DSk1ghVsoK1kvlw4IonWNHzwi8/hUxWtNlF
 a2NgxopA6ENRMnRLmCprRF/60AlDXRnZPkbGDl3PZFc/lKlSuR5ftNZwaY3+jbA83LL+
 S/Bolo2aqdLWb/vbJsQcSgQCA5Pk5ooSr5KTIfKm8rLUc+xJ/9fnFBFPSLc+57a2EI91 zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vektrdhtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 14:44:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98ERt6S047811;
        Tue, 8 Oct 2019 14:44:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vgeuy2976-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 14:44:30 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x98EiPf2031757;
        Tue, 8 Oct 2019 14:44:25 GMT
Received: from dhcp-10-175-191-48.vpn.oracle.com (/10.175.191.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 14:44:24 +0000
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
Subject: [PATCH linux-kselftest-test 0/3] kunit: support module-based build
Date:   Tue,  8 Oct 2019 15:43:49 +0100
Message-Id: <1570545832-32326-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=38 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=899
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=38 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=976 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080133
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For consumers wishing to run kunit on real hardware, it would be
ideal if the kunit framework and tests supported module-based builds.
This is an advantage as it reduces the test task to running
"modprobe mytests.ko", and CONFIG_KUNIT* options can be "always on"
(or rather "always m").  KUnit based tests will load the kunit module
as an implicit dependency.

Alan Maguire (3):
  kunit: allow kunit tests to be loaded as a module
  kunit: allow kunit to be loaded as a module
  kunit: update documentation to describe module-based build

 Documentation/dev-tools/kunit/faq.rst   |  3 ++-
 Documentation/dev-tools/kunit/index.rst |  3 +++
 Documentation/dev-tools/kunit/usage.rst | 16 +++++++++++++++
 include/kunit/test.h                    | 36 ++++++++++++++++++++++++---------
 kernel/sysctl-test.c                    |  6 +++++-
 kunit/Kconfig                           |  6 +++---
 kunit/Makefile                          |  9 +++++++++
 kunit/assert.c                          |  8 ++++++++
 kunit/example-test.c                    |  6 +++++-
 kunit/string-stream-test.c              |  9 +++++++--
 kunit/string-stream.c                   |  7 +++++++
 kunit/test-test.c                       |  8 ++++++--
 kunit/test.c                            | 12 +++++++++++
 kunit/try-catch.c                       |  8 ++++++--
 lib/Kconfig.debug                       |  4 ++--
 15 files changed, 117 insertions(+), 24 deletions(-)

-- 
1.8.3.1

