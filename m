Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96944E921F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 11:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbiC1J7t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 05:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240108AbiC1J7s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:59:48 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB77B3F;
        Mon, 28 Mar 2022 02:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1648461485; i=@fujitsu.com;
        bh=tIPy4adwYZIuoOjNmuljqHfyDRJc1g60N4qT6SaNBec=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Y1s6vN3gC6Qf+fIMHENMqG6brvL6y8AjKhk1PnQKp9U1C70QCIV7ovdfLC7FTSIyC
         4dXejIpnIKnfzlVwgDd/GfCiIl8PfkiuIoNFxxRiRP34sXKfkC081h8qAUR5NyISZN
         BfTeNc1tAa70NPfYPFXNwiSDmP7BQjWJToTXZLogyFzxPE5OUWaJKrqCxxt3E68sOK
         o7aM3qE1potG3wX7/XOwMldfDGTxWDIqvJa70AOswMjMxeaZpckr4bOZ23uYJOVnYG
         3rLIviJcSNpVYLWsujZhIF4N1CDsZd979foP8gEUnYwdNTs6q+UNYJngRsEwndwtH8
         RnkRxjYMLZW7g==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRWlGSWpSXmKPExsViZ8MxSXdtm2O
  SwdE2eYsPNycxWWw5do/R4ueyVewWe/aeZLE4//c4qwOrx6lFEh6bVnWyeXzeJOex6clbpgCW
  KNbMvKT8igTWjNOrvjMV9LJVdCzxamDsZe1i5OIQEtjCKPHqxlEmCGcBk8TXKQvZIJw9jBJPO
  2aydzFycrAJaEo861zADGKLCDhKvGifwQJiMwsUSNw9M5cVxBYWCJZ4cWw5WA2LgKrE0/XtQI
  M4OHgFPCQmdhaChCUEFCSmPHwPVsIrIChxcuYTqDESEgdfvGCGqFGUuNTxjRHCrpCYNauNCcJ
  Wk7h6bhPzBEb+WUjaZyFpX8DItIrROqkoMz2jJDcxM0fX0MBA19DQVNfYXNfQzEgvsUo3US+1
  VLc8tbhEF8gtL9ZLLS7WK67MTc5J0ctLLdnECAzrlGLVRTsY96/6qXeIUZKDSUmU1yjTMUmIL
  yk/pTIjsTgjvqg0J7X4EKMMB4eSBO+tZqCcYFFqempFWmYOMMZg0hIcPEoivKZNQGne4oLE3O
  LMdIjUKUZFKXHehlaghABIIqM0D64NFteXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzurQ
  ATeHJzCuBm/4KaDET0OK172xBFpckIqSkGpgWhOoEHDH826fyYPFLqXV3V6X/L9ws8b7my9FI
  v78VjX67sjfm52pc4hRaumXyCaVlZ1Uv1+/6cqOZS/Xv5X3mXA4zngo6W6o0TfrA6PEgeU3A4
  Q8O9pKWTVzx7a7RbbJ6+0x3W36bIdDCMO+iSGii4+XQnXHl8pvl+3xmqk7btPQpe9vZWTd+Kd
  w5xMYR3TT9K/dum9SnXLfTftc/l8kwS+I7dULpHSPbpzszLZds1ixRFYqIT5Xhuae6stav68O
  ax6uiW/lnZv3sXbytvTtJd6WvjlNJZ9qBS3EPc2Nbdy2dNlHq+S3Vjbv2pXfXbj40aeMDuQeJ
  X8JO/Lp5mSNr0671b+xvpfw6svRh68wqJZbijERDLeai4kQAHBxUwGYDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-19.tower-565.messagelabs.com!1648461485!185071!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26699 invoked from network); 28 Mar 2022 09:58:05 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-19.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 28 Mar 2022 09:58:05 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 19A2E100440;
        Mon, 28 Mar 2022 10:58:05 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 0CDDD100331;
        Mon, 28 Mar 2022 10:58:05 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 28 Mar 2022 10:57:52 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <jlayton@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v1 3/3] ceph: Remove S_ISGID clear code in ceph_finish_async_create
Date:   Mon, 28 Mar 2022 17:58:29 +0800
Message-ID: <1648461509-2330-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
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

Since vfs has stripped S_ISGID, we don't need this code any more.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/ceph/file.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index bbed3224ad68..f69dafabb65b 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -620,10 +620,6 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
 		/* Directories always inherit the setgid bit. */
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
-		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
-			 !in_group_p(dir->i_gid) &&
-			 !capable_wrt_inode_uidgid(&init_user_ns, dir, CAP_FSETID))
-			mode &= ~S_ISGID;
 	} else {
 		in.gid = cpu_to_le32(from_kgid(&init_user_ns, current_fsgid()));
 	}
-- 
2.27.0

