Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0F45A282E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 15:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343637AbiHZNEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 09:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHZNEJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:04:09 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3938CCE0D;
        Fri, 26 Aug 2022 06:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1661519046; i=@fujitsu.com;
        bh=wWvBCXMEH6wzI5PnHydTv1CfXLX40IQaWvNZ4+BNya0=;
        h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type:
         Content-Transfer-Encoding;
        b=ZhvxqgGAsts9EtF9DEY7yQmOvlbNQG0XHjSNzI5u8C8AflA13tEACwd+i98E+aWuD
         FeUkyjGQuGi0CxJcB9PjCgPVy1a07cNpBuCVh1i7XeYYLIaaA8CCHOq7tY9Pg35AzF
         WX6A90o2MJM8vVsA4un5agdYM5HpwbsmQ/7MkekOyjkw3D/cS8NmGIdpsFs6393pmX
         XtnJw3vBf3He1i8Dx9EJV3+xE69zkn8hYRgnkA/SXHZ/Eto1iAqZHfMYSiCkudVXwI
         xpDUdhOoGRMxUr30ebB/fgdFJux3SV1Z0Z0ztBRjEn/c+uBcfqu+rie/j7UMpTlsCV
         1uqzlOEgmKkOw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRWlGSWpSXmKPExsViZ8OxWffoEY5
  kg3v3JCymT73AaLHl2D1Gi8tP+CxOT1jEZLH79U02iz17T7JYXN41h83i3pr/rBa7/uxgt1j5
  4w+rA5fHqUUSHptXaHks3vOSyWPTqk42j02fJrF7vNg8k9Hj49NbLB6fN8kFcESxZuYl5Vcks
  GY8eHCareCaXMWnFToNjMcluxi5OIQENjJKnJ/1ghHCWcIk8XP6ZChnK6PE8v51TF2MnBy8An
  YSzw9vA7NZBFQlvm3oYYOIC0qcnPmEBcQWFUiWuHt4PZjNJqAjcWHBX1YQW1jAVWL6n8tMIEN
  FBOYySXy//YYZxGEWeMEoseJjA1gHs4CFxOI3B9khbHmJ7W/nMIPYEgIKEjcmrWKBsCslWj/8
  grLVJK6e28Q8gVFgFpJDZiEZNQvJqAWMzKsYrZOKMtMzSnITM3N0DQ0MdA0NTXWNjXQNjcz0E
  qt0E/VSS3XLU4tLdI30EsuL9VKLi/WKK3OTc1L08lJLNjECYyylWKFuB+O1lT/1DjFKcjApif
  IKr+FIFuJLyk+pzEgszogvKs1JLT7EKMPBoSTBe2UvUE6wKDU9tSItMwcY7zBpCQ4eJRFe+0N
  Aad7igsTc4sx0iNQpRkuOtQ0H9jJzLL56BUhOnf1vP7MQS15+XqqUOK8kSIMASENGaR7cOFhK
  usQoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmNfiMNAUnsy8Eritr4AOYgI6SGoDO8hBJYkIK
  akGpqlrHwsyfC1fImCxkPm+2oFZehOdz69S1tzZ/0x/8e+VgaV8C317N2zzua+nxZhm/V/Nht
  P/R+OESSeyg3y/5PfN5Figc+bernUBrgc/Wvz+eMShc8rSayKV7lzRCgwbloiJG7XfW/l3Uld
  d3LU2ba+zexne3f6eVtO5dlv/7smui7aqNug9km7x1LzrmL3PnF+v+UrJ9+h/HkH9kgYFj5Y+
  j7j+8u2OpntN8SbPVDvKIz/lHufbJxNxTlHsLl+s/TSe8xttOuvvHDGz8Ize6uS9ruPGn7vHf
  78ptTd7fu+Oo68rl5ruqQd62YdjHzvvZDnwWek9V8bstv5TMe0vf4vNlH5m1X/tZNLnmI1VzE
  osxRmJhlrMRcWJAJaOUG7EAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-2.tower-565.messagelabs.com!1661519045!208260!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8723 invoked from network); 26 Aug 2022 13:04:05 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-2.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Aug 2022 13:04:05 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 0DCC5150;
        Fri, 26 Aug 2022 14:04:05 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id F3EA57B;
        Fri, 26 Aug 2022 14:04:04 +0100 (BST)
Received: from [10.167.201.2] (10.167.201.2) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 26 Aug 2022 14:03:59 +0100
Message-ID: <9e9521a4-6e07-e226-2814-b78a2451656b@fujitsu.com>
Date:   Fri, 26 Aug 2022 21:03:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: [PATCH v7] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.201.2]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
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

This patch is inspired by Dan's "mm, dax, pmem: Introduce
dev_pagemap_failure()"[1].  With the help of dax_holder and
->notify_failure() mechanism, the pmem driver is able to ask filesystem
(or mapped device) on it to unmap all files in use and notify processes
who are using those files.

Call trace:
trigger unbind
  -> unbind_store()
   -> ... (skip)
    -> devres_release_all()
     -> kill_dax()
      -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
       -> xfs_dax_notify_failure()

Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
event.  So do not shutdown filesystem directly if something not
supported, or if failure range includes metadata area.  Make sure all
files and processes are handled correctly.

==
Changes since v6:
   1. Rebase on 6.0-rc2 and Darrick's patch[2].

Changes since v5:
   1. Renamed MF_MEM_REMOVE to MF_MEM_PRE_REMOVE
   2. hold s_umount before sync_filesystem()
   3. do sync_filesystem() after SB_BORN check
   4. Rebased on next-20220714

[1]: 
https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
[2]: https://lore.kernel.org/linux-xfs/Yv5wIa2crHioYeRr@magnolia/

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
  drivers/dax/super.c         |  3 ++-
  fs/xfs/xfs_notify_failure.c | 15 +++++++++++++++
  include/linux/mm.h          |  1 +
  3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 9b5e2a5eb0ae..cf9a64563fbe 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -323,7 +323,8 @@ void kill_dax(struct dax_device *dax_dev)
  		return;
   	if (dax_dev->holder_data != NULL)
-		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
+		dax_holder_notify_failure(dax_dev, 0, U64_MAX,
+				MF_MEM_PRE_REMOVE);
   	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
  	synchronize_srcu(&dax_srcu);
diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index 65d5eb20878e..a9769f17e998 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -77,6 +77,9 @@ xfs_dax_failure_fn(
   	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
  	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
+		/* Do not shutdown so early when device is to be removed */
+		if (notify->mf_flags & MF_MEM_PRE_REMOVE)
+			return 0;
  		notify->want_shutdown = true;
  		return 0;
  	}
@@ -182,12 +185,22 @@ xfs_dax_notify_failure(
  	struct xfs_mount	*mp = dax_holder(dax_dev);
  	u64			ddev_start;
  	u64			ddev_end;
+	int			error;
   	if (!(mp->m_sb.sb_flags & SB_BORN)) {
  		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
  		return -EIO;
  	}
  +	if (mf_flags & MF_MEM_PRE_REMOVE) {
+		xfs_info(mp, "device is about to be removed!");
+		down_write(&mp->m_super->s_umount);
+		error = sync_filesystem(mp->m_super);
+		up_write(&mp->m_super->s_umount);
+		if (error)
+			return error;
+	}
+
  	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_daxdev == dax_dev) {
  		xfs_warn(mp,
  			 "notify_failure() not supported on realtime device!");
@@ -196,6 +209,8 @@ xfs_dax_notify_failure(
   	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
  	    mp->m_logdev_targp != mp->m_ddev_targp) {
+		if (mf_flags & MF_MEM_PRE_REMOVE)
+			return 0;
  		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
  		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
  		return -EFSCORRUPTED;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 982f2607180b..2c7c132e6512 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3176,6 +3176,7 @@ enum mf_flags {
  	MF_UNPOISON = 1 << 4,
  	MF_SW_SIMULATED = 1 << 5,
  	MF_NO_RETRY = 1 << 6,
+	MF_MEM_PRE_REMOVE = 1 << 7,
  };
  int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
  		      unsigned long count, int mf_flags);
-- 
2.37.2

