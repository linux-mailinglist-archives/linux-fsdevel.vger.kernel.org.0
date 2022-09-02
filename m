Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A155AAC8A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 12:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbiIBKgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 06:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbiIBKgd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:36:33 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C04EBC11E;
        Fri,  2 Sep 2022 03:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1662114990; i=@fujitsu.com;
        bh=swdErYyi7Si91FvqA0QbntZe2uXVEMXrPiLsnL32AkU=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=AtAyGO1GHcar7f6llATm1xWR4yKuYaCKsE+pIXF/eqSXLaIqu+iG2GOm0sKU7onP5
         lONHlTUInm9zgi+fm1pdl7M9EAGaUzHbZcEdE90lJ5IlBIVOW/55cixNO2LNNIWgKR
         nUdmF7r6yLsdvbbK7fJNkXrD+xe2CZhrj8G3I9hPWTFXlqqrs2j5hr6/8JBLmVmb/a
         X9p9P4eChJSWWiXV/AEHMdg/Dc9Qi7CZVXe9GylFuWUirt5+BwkOJwZkVhLZtJXhlu
         Oe+2L1jvs0tFXhbA/BVeXorRtA5ARX2yDJj7YypcBN6TtFrRxeK38vHOcioeMXk0aF
         WHulqFuScwZjA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRWlGSWpSXmKPExsViZ8OxWXftHcF
  kgznHjC2mT73AaLHl2D1Gi8tP+CxOT1jEZLH79U02iz17T7JYXN41h83i3pr/rBa7/uxgt1j5
  4w+rA5fHqUUSHptXaHks3vOSyWPTqk42j02fJrF7vNg8k9Hj49NbLB6fN8kFcESxZuYl5Vcks
  Gb8b7rPUvCAu2LG+m+MDYyPOLsYuTiEBDYwSjTv+cgC4Sxmkuh/0cUE4exhlJh36gprFyMnB5
  uAjsSFBX9ZQRIiApMYJY7duMkMkmAWKJfYv/EGG4gtLGAvMefDUbA4i4CKxK53V1lAbF4BF4n
  Gh+/YQWwJAQWJKQ/fg9VwCrhKbO+5DbSNA2hbhcTq7RwQ5YISJ2c+YYEYLyFx8MULZpASCQEl
  iZnd8RBTKiQapx9igrDVJK6e28Q8gVFwFpLuWUi6FzAyrWK0SirKTM8oyU3MzNE1NDDQNTQ01
  TXQNTI01Uus0k3USy3VLU8tLtE11EssL9ZLLS7WK67MTc5J0ctLLdnECIyulGKG6zsYJ/b91D
  vEKMnBpCTKm3hLMFmILyk/pTIjsTgjvqg0J7X4EKMMB4eSBC8/SE6wKDU9tSItMwcY6TBpCQ4
  eJRHeMJA0b3FBYm5xZjpE6hSjMcfahgN7mTmmzv63n1mIJS8/L1VKnPcFSKkASGlGaR7cIFgC
  usQoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmPcZyBSezLwSuH2vgE5hAjpl+kx+kFNKEhFSU
  g1M8/QL9V/Zzv54hSP9bGva24XmC6c8Xqe5ouSPn176KxWGueHPWOtCuGbf2axq3PqmJoJrZ5
  TVgtKdb6fwT4pWs4xfIqBo2Oxn8zwtlXce3zbdsz8vJfJItGoZGsY4LdipxrwgQUrbvelm4i5
  G8RObxNo1lSz7757QU20IT5Q8/uWN0RytF37zv4lKnWVLvHThcy1/pmGmyQOVgwZdG5zz167R
  ehW6xCa7JfxyxFHdF4wRystnbRTLkGOSSbg4Z0v4t68/tDhSOGyzfi2ZWcsY+a+ixvxRWNx5C
  W2Ojf/PVyccmfone8Oqu4LOJR42Ek88i498FPRd/4BtKbNA5BaNyTs619kGbmI5vDj04Bcllu
  KMREMt5qLiRADWYqdJuwMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-6.tower-587.messagelabs.com!1662114989!100401!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28576 invoked from network); 2 Sep 2022 10:36:29 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-6.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 Sep 2022 10:36:29 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 6AA3F7B;
        Fri,  2 Sep 2022 11:36:29 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 5D4D173;
        Fri,  2 Sep 2022 11:36:29 +0100 (BST)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 2 Sep 2022 11:36:25 +0100
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH 1/3] xfs: fix the calculation of length and end
Date:   Fri, 2 Sep 2022 10:35:59 +0000
Message-ID: <1662114961-66-2-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1662114961-66-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <9e9521a4-6e07-e226-2814-b78a2451656b@fujitsu.com>
 <1662114961-66-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
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

The end should be start + length - 1.  Also fix the calculation of the
length when seeking for intersection of notify range and device.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
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
2.37.2

