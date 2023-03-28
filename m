Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6489D6CBB51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 11:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjC1Jm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 05:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjC1Jma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:42:30 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B8C1739;
        Tue, 28 Mar 2023 02:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1679996545; i=@fujitsu.com;
        bh=NWTW4/kpXmg0Rl6jB3nA+9P+up6W+4F1Qd6JkH4PPnc=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Pa1LIuGfl6OXsOtMCyUaQCxmL78UatAYsSbK+3EIFk7IW6ZANlkmrmBfnxjze2UqK
         yn2/iBx8P0yBQmqyNSzIXtE33FygpkrY+JyIYEblVU2Yev0pjkAm5lPsFM1ETyrw0N
         EM/NHy9HltswQjb+YakmIR/7EhvU4YOjyczLbBGok956x3mTCWpDIipcnce9m8Ay69
         j5KWa4h05fivetAJH6B+CR4JfYhmHCuuKFILcUlSzpKWODW5HW0C268OIwUkqx5Zf5
         58Tf1mz9ImOHnycKJ2CDrM6giwmHSbhY1e0OGPfPaIRMB0mt8ERi8NnOmxhohJqQdW
         8pCQkPO08JGzA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRWlGSWpSXmKPExsViZ8ORpNuwTSn
  FYNIpWYs569ewWUyfeoHR4vITPovZ05uZLPbsPclicW/Nf1aLXX92sFus/PGH1eL3jzlsDpwe
  m1doeSze85LJY9OqTjaPTZ8msXucmPGbxePF5pmMHmcWHGH3+LxJLoAjijUzLym/IoE148idb
  taCtXwV7e1LGRsY/3N3MXJxCAlsZJT4fOccE4SzhEni0uyrbBDOMUaJZafPsncxcnKwCehIXF
  jwlxXEFhEolNiz9B0LiM0sUCHRuOgfM4gtLOAsMWvFO7AaFgFViV339oDZvEDxaVs2gNkSAgo
  SUx6+B6vnFHCRePulBcjmAFrmLHGt2x6iXFDi5MwnUOMlJA6+eMEM0aokcfHrHagxQGunH2KC
  sNUkrp7bxDyBUXAWkvZZSNoXMDKtYjQvTi0qSy3SNTTRSyrKTM8oyU3MzNFLrNJN1Est1c3LL
  yrJ0DXUSywv1kstLtYrrsxNzknRy0st2cQIjKeU4sTjOxhf9f3VO8QoycGkJMrbz6mYIsSXlJ
  9SmZFYnBFfVJqTWnyIUYaDQ0mCV2WLUoqQYFFqempFWmYOMLZh0hIcPEoivNdWA6V5iwsSc4s
  z0yFSpxh1OdY2HNjLLMSSl5+XKiXOm74VqEgApCijNA9uBCzNXGKUlRLmZWRgYBDiKUgtys0s
  QZV/xSjOwagkzBu4GWgKT2ZeCdymV0BHMAEd8a1AAeSIkkSElFQDk++Wjc03Ze8/TnfafT59b
  0XR5gtr104NM66esGWmoar2vrt339js3pwSEiQRm6dTe+X6mjP+P0Tkd8/fwv+xrpzNyTBF9N
  icLV2fmk5umRe7UbfKh8cy/aN2a+GnFfIz/81n5F/dZBRcZnNkrk3ZpeDV++NNIrvPd87oKNr
  26a4Lm51tS9qqQl/z8jMbfkRtY427YMPqn6OdI1Y1WehfXXNyJNei1a/Tq17ck5zsb/l2jSHn
  5b3yzZvmzz28OnbblwyDxd7/xKqO8PqU7/7s+z7XrKJ1UcqpKqHGp97vvryLK3/NqmiveMBAR
  OXcmY9Xp0fHTVrsE6mp7Wy6OyJ6yje11p0veXz+2K25bsZxSomlOCPRUIu5qDgRAAs+n0iuAw
  AA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-16.tower-732.messagelabs.com!1679996544!272759!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12672 invoked from network); 28 Mar 2023 09:42:24 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-16.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 28 Mar 2023 09:42:24 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id C774E1B0;
        Tue, 28 Mar 2023 10:42:23 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id BBD3B1AF;
        Tue, 28 Mar 2023 10:42:23 +0100 (BST)
Received: from 692d629b0116.g08.fujitsu.local (10.167.234.230) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 28 Mar 2023 10:42:20 +0100
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
        <akpm@linux-foundation.org>, <djwong@kernel.org>
Subject: [PATCH v11 1/2] xfs: fix the calculation of length and end
Date:   Tue, 28 Mar 2023 09:41:45 +0000
Message-ID: <1679996506-2-2-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1679996506-2-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <1679996506-2-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.234.230]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 fs/xfs/xfs_notify_failure.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index c4078d0ec108..1e2eddb8f90f 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -61,7 +61,7 @@ xfs_failure_pgcnt(
 	end_notify = notify->startblock + notify->blockcount;
 	end_cross = min(end_rec, end_notify);
 
-	return XFS_FSB_TO_B(mp, end_cross - start_cross) >> PAGE_SHIFT;
+	return XFS_FSB_TO_B(mp, end_cross - start_cross + 1) >> PAGE_SHIFT;
 }
 
 static int
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
+		len = ddev_end - offset + 1;
 
 	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
 			mf_flags);
-- 
2.39.2

