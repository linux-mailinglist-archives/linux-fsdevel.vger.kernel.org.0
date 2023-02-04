Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F6068AAC4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Feb 2023 15:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjBDO7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Feb 2023 09:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjBDO7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:59:21 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDA534C0D;
        Sat,  4 Feb 2023 06:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1675522744; i=@fujitsu.com;
        bh=dHPfdcvntcTuGRB7mplma0aCs7gQGflhDCMIDJ2bzmY=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=YvKFAEuatpTlK2jH5ZJqXLuKX8BrnMDOBfHPEFXj1DUIRTutS30RX0fV4Pgyv6V4I
         tIORfVl+merggHc1RDq6ey44Iw4vBD8PfpRiVNqOgQ7q5HXzfGpE3kZIpgTtJ3U5l+
         uq++2wxdNGRvqFbuKZeFftMzMr4YVzKEFXradHCbGkx1XwVYl9kqi3QwpuYnBbjX43
         Jf3ZhEfgMcLFPMUrnmWFswYzLDQU8MYNWswHU++bzIlpBw0frMiT1dgPI/ozGRT6mH
         zKC1F2jCGr1lTBc0hOEFSSmSYPwBhQgvrxn6eP6R+bAH6OGBlhnaZSXmtGWO/s6JJw
         0IcrouTun08UQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRWlGSWpSXmKPExsViZ8ORpLut6F6
  ywZ6FAhbTp15gtNhy7B6jxeUnfBanJyxistj9+iabxZ69J1ksLu+aw2Zxb81/Votdf3awW6z8
  8YfVgcvj1CIJj80rtDwW73nJ5LFpVSebx6ZPk9g9Xmyeyejx8ektFo/Pm+QCOKJYM/OS8isSW
  DMW7nzMXjCRp6Jt2V/mBsY+ri5GLg4hgY2MEhMebGWEcJYySRx/eYMJwtnLKHF23jm2LkZODj
  YBHYkLC/6ygiREBCYxShy7cZMZJMEsUC6xf+MNsCJhASeJmTP3sYLYLAIqEnM+rASr4RVwkVj
  V3glmSwgoSEx5+B7M5hRwlXj7/ixYrxBQTfOd30wQ9YISJ2c+YYGYLyFx8MULoHoOoF4liZnd
  8RBjKiVaP/xigbDVJK6e28Q8gVFwFpLuWUi6FzAyrWI0LU4tKkst0jXUSyrKTM8oyU3MzNFLr
  NJN1Est1S1PLS7RNdJLLC/WSy0u1iuuzE3OSdHLSy3ZxAiMqpRi5Yk7GFf0/tU7xCjJwaQkyt
  vvfzdZiC8pP6UyI7E4I76oNCe1+BCjDAeHkgTv9YJ7yUKCRanpqRVpmTnACIdJS3DwKInw/gZ
  J8xYXJOYWZ6ZDpE4x6nKsbTiwl1mIJS8/L1VKnLe1EKhIAKQoozQPbgQs2VxilJUS5mVkYGAQ
  4ilILcrNLEGVf8UozsGoJMx7C2QVT2ZeCdymV0BHMAEd0W1wF+SIkkSElFQDU9HDgz8N3qm0K
  qz6UfJEZaNVZtCK2n36uyLTWbSKV8VMO8WaKfJS+Ph5PqFGvYMXdnxce3jl4bDPInH1Gpef3j
  q3OeuvD4fDg82bI2Pu7Xpo1VE1IXjJu5cP6v/Zvt9QHnA00POAu/hq/VudDjGG7gt4kh0n/89
  /dPcy48Fb6ozT1SXrbHo2bmvqO2Ny9MG1p7KLlxzNFO2MNouc2/TgV6GX0t9fuxUEDF4se6ZY
  5b/297FzB7kSmO1Mb80uCFSNOZ3tc8DjwLbgc7YJU2MOneTRt9isEql0IN2W78WbPSXK327xW
  kbKhEiJ6D2//1VNzPH89M2sAVHTOT7HaIisjGNsZjP5WJf1tSBrm6vcKyWW4oxEQy3mouJEAL
  S5mr6xAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-7.tower-571.messagelabs.com!1675522742!175014!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25318 invoked from network); 4 Feb 2023 14:59:02 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-7.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Feb 2023 14:59:02 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id E6A831AD;
        Sat,  4 Feb 2023 14:59:01 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id D98EF1AC;
        Sat,  4 Feb 2023 14:59:01 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Sat, 4 Feb 2023 14:58:57 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v9 1/3] xfs: fix the calculation of length and end
Date:   Sat, 4 Feb 2023 14:58:36 +0000
Message-ID: <1675522718-88-2-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675522718-88-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <1675522718-88-1-git-send-email-ruansy.fnst@fujitsu.com>
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

The end should be start + length - 1.  Also fix the calculation of the
length when seeking for intersection of notify range and device.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_notify_failure.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index c4078d0ec108..3830f908e215 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -114,7 +114,7 @@ xfs_dax_notify_ddev_failure(
 	int			error = 0;
 	xfs_fsblock_t		fsbno = XFS_DADDR_TO_FSB(mp, daddr);
 	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
-	xfs_fsblock_t		end_fsbno = XFS_DADDR_TO_FSB(mp, daddr + bblen);
+	xfs_fsblock_t		end_fsbno = XFS_DADDR_TO_FSB(mp, daddr + bblen - 1);
 	xfs_agnumber_t		end_agno = XFS_FSB_TO_AGNO(mp, end_fsbno);
 
 	error = xfs_trans_alloc_empty(mp, &tp);
@@ -210,7 +210,7 @@ xfs_dax_notify_failure(
 	ddev_end = ddev_start + bdev_nr_bytes(mp->m_ddev_targp->bt_bdev) - 1;
 
 	/* Ignore the range out of filesystem area */
-	if (offset + len < ddev_start)
+	if (offset + len - 1 < ddev_start)
 		return -ENXIO;
 	if (offset > ddev_end)
 		return -ENXIO;
@@ -222,8 +222,8 @@ xfs_dax_notify_failure(
 		len -= ddev_start - offset;
 		offset = 0;
 	}
-	if (offset + len > ddev_end)
-		len -= ddev_end - offset;
+	if (offset + len - 1 > ddev_end)
+		len -= offset + len - 1 - ddev_end;
 
 	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
 			mf_flags);
-- 
2.39.1

