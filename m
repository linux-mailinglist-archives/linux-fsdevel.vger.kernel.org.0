Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F13469AE53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 15:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjBQOtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 09:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjBQOtG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:49:06 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F046E66A;
        Fri, 17 Feb 2023 06:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1676645342; i=@fujitsu.com;
        bh=1Iu3u5+frabq+ciV1X7SE3/U2Roif2mChYvCwrIUtnA=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Av6mfMrFVUfHI5GVDJmpx/viKNG+rVkvMpN2k4ClfAKkbULLSEiuoQKKhlajxui9f
         fEiIPv72Ljgf0NlBGoxZCTwPoIsQfZjpYokBY4VGBvdGVUGq1upS63pT5e6+jHqEdl
         hKd58UH7f9+5De7pls8Hf93VeY1IeqjDvoHkFeLWVYOE9gwxbBSraj+p6rCsq7m35M
         OAIb+DGYvzQ9rI2CiRyeJ1a/vASRM3F7HsSwm+mNp55MMyarBSwkleixqg7kPakjBz
         WgBof1RljjpdAUNyVwXf/JvE6z4gaG5WvHfymvApEQRf7TNBlpL+Wa+kJ/aq2QUGGT
         jVVyqhSyNPr3A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRWlGSWpSXmKPExsViZ8ORpHt18vt
  kg/u3JSzmrF/DZjF96gVGiy3H7jFaXH7CZ3F6wiImi92vb7JZ7Nl7ksXi3pr/rBa7/uxgt1j5
  4w+rxe8fc9gcuD1OLZLw2LxCy2PxnpdMHptWdbJ5bPo0id3jxIzfLB4vNs9k9Pj49BaLx+dNc
  gGcUayZeUn5FQmsGbPvX2Ap6OKpeP1mN3MDYydXFyMXh5DARkaJvR0z2SCcpUwSB7auZYJw9j
  FKbJq8kLmLkZODTUBH4sKCv6wgtohAocSKU0dZQIqYBY4zSmxZvgmsSFjAWeLV7U1gRSwCqhK
  Lbt0DKuLg4BVwkdh1XxYkLCGgIDHl4Xuwck4BV4mlk0+ygdhCQCUH2k4wgti8AoISJ2c+YQGx
  mQUkJA6+eMEMMkZCQEliZnc8xJhKidYPv1ggbDWJq+c2MU9gFJyFpHsWku4FjEyrGM2LU4vKU
  ot0DU30kooy0zNKchMzc/QSq3QT9VJLdfPyi0oydA31EsuL9VKLi/WKK3OTc1L08lJLNjECYy
  2lOPH4DsZXfX/1DjFKcjApifIaJrxPFuJLyk+pzEgszogvKs1JLT7EKMPBoSTBe7ofKCdYlJq
  eWpGWmQOMe5i0BAePkgjv5HygNG9xQWJucWY6ROoUoy7H2oYDe5mFWPLy81KlxHlnTAIqEgAp
  yijNgxsBS0GXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzPp8INIUnM68EbtMroCOYgI5Yw
  PwW5IiSRISUVAOTaTRfr+IfkaSwtZzfHON+bF5quHnjy4Aty7ZKihmLduyO1tzwxtt/tmV3Kb
  9d7sej9/+VcsoyzLX9q26v/uS80CGnXhfrDMNWeWNn5xieOcpS/5q2Ne6r2tUTLC88bduxsuu
  CjKxzN69rfjV79QfWt0VnmP5qf/V83vJkkikfg5Nu/PdFH20LdmZeYX+c16N6RFNy0bVdeZFr
  zcOkWzUT7RiPb573tI37l9fbrtnzDt37WG10cdXFlp+cG65d/VfE+kJpc/L18pwoBeurLaVf+
  LltxdtnmIlMaLiVpWjIc/eM0FSPxE6uuYfCzO6U36jkla3l1XfmEWl/mLHscH7/D87nk9UWMj
  2S6r/ZbaDEUpyRaKjFXFScCAD6qMFzvAMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-17.tower-728.messagelabs.com!1676645332!261550!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6204 invoked from network); 17 Feb 2023 14:48:53 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-17.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 Feb 2023 14:48:53 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id C36931B5;
        Fri, 17 Feb 2023 14:48:52 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id B55641AC;
        Fri, 17 Feb 2023 14:48:52 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 17 Feb 2023 14:48:48 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-xfs@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <hch@infradead.org>,
        <jane.chu@oracle.com>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <ruansy.fnst@fujitsu.com>
Subject: [PATCH v10 1/3] xfs: fix the calculation of length and end
Date:   Fri, 17 Feb 2023 14:48:30 +0000
Message-ID: <1676645312-13-2-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1676645312-13-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <1676645312-13-1-git-send-email-ruansy.fnst@fujitsu.com>
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
index c4078d0ec108..7d46a7e4980f 100644
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
+		len = ddev_end - offset + 1;
 
 	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
 			mf_flags);
-- 
2.39.1

