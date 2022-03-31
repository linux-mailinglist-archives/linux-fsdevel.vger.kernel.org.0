Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905E44ED6EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 11:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiCaJaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 05:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiCaJag (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:30:36 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4390203A63;
        Thu, 31 Mar 2022 02:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1648718888; i=@fujitsu.com;
        bh=Ws9HhmWwP1sg/MJi353iJBVOr7t8+QgQ8rvucPbJZgE=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Dj1ROLcc6zW264WS/lCGttVW2wkgzvcUgWeG27Qq7o7TZYZXB86lxhiogVpvEQSH8
         yp5m0esA8nHQ3WAbt6xRULH1qv3+eTfhwQYR7ptd9K5fo/GjWnxjS2E1jH9Da8tD+J
         i2eNo7FLBSe/34mwH0ytshQpqEUwnqIf/GXrbEUYSnthr4FU7xhh4rEAs+FKilBL4m
         PHFuMZeOXDeIdqLWZ4cZca62wWK39ltqnz+JJ4HVA3jsjJSfRjtP/HiEGpfb8b7rKi
         Ktmew8/0TDLmU0cXQqWBNgufnsYBtLYCfKd6YUPk7PIfBOVPTUuJmDi5SEF23HfSPV
         uH5DDdGYUkTYg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRWlGSWpSXmKPExsViZ8ORqKtR4pp
  ksGwyh8Xrw58YLbYcu8docfkJn8Xplr3sFnv2nmRxYPU4tUjCY9OqTjaPz5vkApijWDPzkvIr
  Elgzfs58zFiwk6Ni6vL7rA2MvexdjJwcQgJbGCVm/MiGsBcwSfzosehi5AKy9zBKrD9+iQUkw
  SagKfGscwEziC0i4CLxbf9fNhCbWSBFouF8E2MXIweHsICPxIQP1SBhFgFVibkdW5lAbF4BD4
  krXVdYQWwJAQWJKQ/fg43hFPCU+LZpPTNIqxBQzbRbgRDlghInZz5hgZguIXHwxQtmiFZFiUs
  d3xgh7AqJWbPamCBsNYmr5zYxT2AUnIWkfRaS9gWMTKsYrZOKMtMzSnITM3N0DQ0MdA0NTXWN
  TXSNDC30Eqt0E/VSS3XLU4tLdI30EsuL9VKLi/WKK3OTc1L08lJLNjECwz6lWOnWDsYNq37qH
  WKU5GBSEuV1CnBNEuJLyk+pzEgszogvKs1JLT7EKMPBoSTBW18AlBMsSk1PrUjLzAHGIExago
  NHSYQ3FCTNW1yQmFucmQ6ROsWoKCXOO7sQKCEAksgozYNrg8X9JUZZKWFeRgYGBiGegtSi3Mw
  SVPlXjOIcjErCvFeLgKbwZOaVwE1/BbSYCWhx3WNHkMUliQgpqQam/nLuj6dyzmv9nbXl52Ym
  vduH1R/LyMncj7x4IKT2ofqfvfZvDkUsvhGx8orUsc0xHlHMvAoZlzXFH3R+vhb/T+nj1r2dn
  5LNehdsTUmtSnl7qkXyPE+yyGnhRZkPX9gUzHRoT8//87vAiTEuQ1Bs8aT8Z6fW9xaci1g/cU
  LvNrE/7zI99VQW333uz9nn89617aTIp6SL+/zOGr/SmLF+RtwRXq3K9Z8YbvJsWO75LlJi8cS
  lCzS+3kqereF/a/HenjVPFiTv0YzhLVGdlViZ8lmvT/iD87mn7bN6vpa8CH7hMOFlmZ5Fdqa2
  xf/rwnyb3p6N4udf8GSqSvfdhVs3559LWaHr6yWwZ+nfk/OPBSuxFGckGmoxFxUnAgCbulbVd
  gMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-32.tower-565.messagelabs.com!1648718887!166249!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14123 invoked from network); 31 Mar 2022 09:28:08 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-32.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 31 Mar 2022 09:28:08 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 4E26B1001AE;
        Thu, 31 Mar 2022 10:28:07 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id BC0301001B1;
        Thu, 31 Mar 2022 10:28:06 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 31 Mar 2022 10:28:00 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <brauner@kernel.org>, <djwong@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <fstests@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v1 2/2] idmapped-mounts: Add umask before test setgid_create
Date:   Thu, 31 Mar 2022 17:28:22 +0800
Message-ID: <1648718902-2319-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1648718902-2319-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1648718902-2319-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since stipping S_SIGID should check S_IXGRP, so umask it to check whether
works well.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
If we enable acl on parent directory, then umask is useless, maybe we
also add setfacl on parent directory because we may change the order
about strip S_ISGID and posix_acl setup. Any idea?

 src/idmapped-mounts/idmapped-mounts.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 1e2f3904..30292426 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -7843,6 +7843,7 @@ static int setgid_create(void)
 	int file1_fd = -EBADF;
 	pid_t pid;
 
+	umask(S_IXGRP);
 	if (!caps_supported())
 		return 0;
 
@@ -8040,6 +8041,8 @@ static int setgid_create_idmapped(void)
 	};
 	pid_t pid;
 
+	umask(S_IXGRP);
+
 	if (!caps_supported())
 		return 0;
 
@@ -8166,6 +8169,7 @@ static int setgid_create_idmapped_in_userns(void)
 	};
 	pid_t pid;
 
+	umask(S_IXGRP);
 	if (!caps_supported())
 		return 0;
 
-- 
2.27.0

