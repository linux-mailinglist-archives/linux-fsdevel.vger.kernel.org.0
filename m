Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0DC688CC1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 02:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjBCBs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 20:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBCBsz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 20:48:55 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B7E889B4;
        Thu,  2 Feb 2023 17:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1675388929; i=@fujitsu.com;
        bh=XZoeibMLSMbZpYYv82E34P+KgYpreBj0SgHdJOuWtXI=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=MTudVFxK8fPxcdtmtj/8A9ienGdzabwYGy/uC14BQqJWrAn/Pvtd/tp2U95b29JFL
         a0bNsbzOGBi/rOfpf3Sx4QsXqvkNCgT1gsL/bhgefehDcVf0c624URKXaMs+lNKM0H
         MeQmOv2Shaw5iKKpEGey/42YxRRC4uFGo9JQ59AQ/DtIxTszCbBQGBjRrM7QEehjcB
         7X8WoiB91vA17f3QuiO5YQ7nLdbAGvUukvHD15iUmJWaohJi+7/TX4sD7zf5c/ae5W
         DYUUsuiUeinAAffrU/2OTE7jbP/gqTd2OhEeTBmEqC4R18zkPtnADLF5PpUzTpcN4t
         aUkeS8lO4OfIg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRWlGSWpSXmKPExsViZ8ORpPsj/U6
  ywYmlGhZz1q9hs5g+9QKjxZZj9xgtLj/hs9iz9ySLxa4/O9gtVv74w2rx+8ccNgcOj1OLJDw2
  r9DyWLznJZPHplWdbB4nZvxm8XixeSajx+dNcgHsUayZeUn5FQmsGTcfvmIqOMxa8XryUuYGx
  rMsXYxcHEICGxklrt/pY4NwljJJtJ/8CeXsZZS4ePsKUBknB5uAjsSFBX9ZQWwRgWiJNw8nsI
  PYzAKzGCX+LxMEsYUFvCT6zuwDi7MIqEj0Xp8OZvMKuEicXXOQCcSWEFCQmPLwPTNEXFDi5Mw
  nLBBzJCQOvngBFOcAqlGSmNkdD1FeKdH64RcLhK0mcfXcJuYJjPyzkHTPQtK9gJFpFaNpcWpR
  WWqRrrleUlFmekZJbmJmjl5ilW6iXmqpbnlqcYmukV5iebFeanGxXnFlbnJOil5easkmRmAUp
  BQrz9zBuKzvr94hRkkOJiVRXmOmO8lCfEn5KZUZicUZ8UWlOanFhxhlODiUJHg3JwPlBItS01
  Mr0jJzgBEJk5bg4FES4VUESfMWFyTmFmemQ6ROMSpKifNyA+NYSAAkkVGaB9cGSwKXGGWlhHk
  ZGRgYhHgKUotyM0tQ5V8xinMwKgnzLosGmsKTmVcCN/0V0GImoMV3rW+CLC5JREhJNTAZZU9c
  VbHa9v2p9293sJwSZglunlAqLn7OsUn0d7dy3jnnEobJl42213Qt9fwcdbU/s764aOvVbVeU1
  1ftmPLN4NgdEYFCfo5Dhy5W9aVnvTat2tzgsODCtcWM+UUtCy94cRk2XLA6sO+Ib01q/c2ejr
  iCM/6Bf2Unek5wWsLloN9jqOhUKP3o2BThwpuv/Nr/1h0+7nitvv9PaT/XxQL1KVFMMX7dKSu
  TUji9ks5H23vFdpYa6uqsWe2VcGbRtXORwfPOHPrqVLrFubu6x3HW1vpLj3X0FZUL5/zPSjq9
  fcnRA/OqxQKmRLySL7xxPjPy7zPGXfO8f294UmIWdjNp7eTpgera0SEtG5+XFiixFGckGmoxF
  xUnAgDpXNDNfQMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-6.tower-571.messagelabs.com!1675388920!66159!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21994 invoked from network); 3 Feb 2023 01:48:40 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-6.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 Feb 2023 01:48:40 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 5613F1AD;
        Fri,  3 Feb 2023 01:48:40 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 4A3C01AC;
        Fri,  3 Feb 2023 01:48:40 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 3 Feb 2023 01:48:36 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-xfs@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <ruansy.fnst@fujitsu.com>
Subject: [PATCH v2] fsdax: dax_unshare_iter() should return a valid length
Date:   Fri, 3 Feb 2023 01:48:26 +0000
Message-ID: <1675388906-50-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The copy_mc_to_kernel() will return 0 if it executed successfully.
Then the return value should be set to the length it copied.

Fixes: d984648e428b ("fsdax,xfs: port unshare to fsdax")
Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index c48a3a93ab29..3e457a16c7d1 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1271,8 +1271,9 @@ static s64 dax_unshare_iter(struct iomap_iter *iter)
 	if (ret < 0)
 		goto out_unlock;
 
-	ret = copy_mc_to_kernel(daddr, saddr, length);
-	if (ret)
+	if (copy_mc_to_kernel(daddr, saddr, length) == 0)
+		ret = length;
+	else
 		ret = -EIO;
 
 out_unlock:
-- 
2.39.1

