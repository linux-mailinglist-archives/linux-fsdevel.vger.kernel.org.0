Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE525E9365
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Sep 2022 15:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiIYNdv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Sep 2022 09:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiIYNdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Sep 2022 09:33:50 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF5930569;
        Sun, 25 Sep 2022 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1664112824; i=@fujitsu.com;
        bh=RdaWcPr3gci1Vc3szH+WaTgenDw7Cl3lU3kCYuJ1P+s=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=j8263QtK0f5wm59RNEGSfG82S3agxGs5ABCRhHJCo106ExtmIMli6uy4b4qX/iD/u
         zyG+/kmbH+0cNtkoGeQ2avr6FmWLelWB68MWk6Sv2fPFfoHCNqdjmHN3hvLKjoXu8Z
         RQfiMPS4qNnd/3X34p2HlmBYHb77dpbPVsUPvGfPXM5QQLQUrjuqZPzO91nPHW7u+w
         ZaefB1FGzIdIcGXpr1ovY+Zckxk5Qu++hYRtsmuGlnTu35vWzvfpUybjmFaVYmlh8E
         TZBMZ5C9lrqJqMVzFtRz5q9l7VJQisk0PXIlJ/nyNrM0q86SYf+YVOiQiYApr61UyW
         Kq24kixbDB7Ag==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRWlGSWpSXmKPExsViZ8ORqLstwiD
  ZYOUzHYvpUy8wWmw5do/R4vITPovTExYxWezZe5LF4vKuOWwW99b8Z7XY9WcHu8XKH39YHTg9
  Ti2S8Ni8Qstj8Z6XTB6bVnWyeWz6NInd48XmmYwenzfJBbBHsWbmJeVXJLBm7J9xkrFgIk9F+
  4129gbGPq4uRi4OIYEtjBI7nt9hgXCWM0lMmnKFCcLZyyixfON3xi5GTg42AR2JCwv+soIkRA
  QmMUocu3GTGSTBLJAg0f7lGhOILSxgLzHnw1GwOIuAqsSBU01gzbwCLhKXvixnAbElBBQkpjx
  8D1bDKeAqsXTKKrBeIaCanr1nmSDqBSVOznzCAjFfQuLgixdA9RxAvUoSM7vjIcZUSDROP8QE
  YatJXD23iXkCo+AsJN2zkHQvYGRaxWiVVJSZnlGSm5iZo2toYKBraGiqa6hrZGiul1ilm6iXW
  qpbnlpcomuol1herJdaXKxXXJmbnJOil5dasokRGEspxYw3dzC29v3UO8QoycGkJMp71M8gWY
  gvKT+lMiOxOCO+qDQntfgQowwHh5IE7wE3oJxgUWp6akVaZg4wrmHSEhw8SiK8hSCtvMUFibn
  FmekQqVOMxhxrGw7sZeaYOvvffmYhlrz8vFQpcd6V4UClAiClGaV5cINg6eYSo6yUMC8jAwOD
  EE9BalFuZgmq/CtGcQ5GJWFet2CgKTyZeSVw+14BncIEdIodnz7IKSWJCCmpBiaOA/pZz7f/D
  Iv6Fr7g8HIBh6TXK6faKgkdniolFCUtvOmRWtjb3pj0aoH7alKzGO6oCXgd3NfZKmDgfrPn8K
  WM9R9r06p5bVf9821weHDNyuGkVpl4y4U/R7V+T1zQvMkl0+9X1/a+gMff95mEPmueYLFJzsF
  gxQ/bna8XrLtUNvlTjzrfUsFZUjXbZ1b82vaDJVZ7ilOY6s/T28rCn7XX26+PyQ3O2vx9e27x
  v7bVHG8stXc/83mjbr8jxsa5oZnZr3Pj6QXnO5oC7vZMfvvH1mZe1pGSSA5m84laCnc4V5+7P
  Vt4/t//lkschA7O/pG8+VtxMMedVI6EiBulAgV9ty0W3nx0ZsrqeftLpASUWIozEg21mIuKEw
  E7hM7ssgMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-21.tower-591.messagelabs.com!1664112822!124698!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24092 invoked from network); 25 Sep 2022 13:33:42 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-21.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Sep 2022 13:33:42 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 470F5100194;
        Sun, 25 Sep 2022 14:33:42 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 3A53610018D;
        Sun, 25 Sep 2022 14:33:42 +0100 (BST)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sun, 25 Sep 2022 14:33:38 +0100
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <hch@infradead.org>
Subject: [PATCH 1/3] xfs: fix the calculation of length and end
Date:   Sun, 25 Sep 2022 13:33:21 +0000
Message-ID: <1664112803-57-2-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1664112803-57-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <1664112803-57-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
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
2.37.3

