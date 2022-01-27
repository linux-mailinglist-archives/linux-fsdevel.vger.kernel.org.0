Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326B549E29B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 13:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241444AbiA0Mlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 07:41:35 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35632 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236396AbiA0Mlc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:41:32 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AHl23Na8W7L7+TAqH+V7pDrUD/3+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUpwgjRWyWdOCzzSOPiKYzGjc492aou18BwCv5GEzoJkGVdlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4Ef9WlTdhSMkj/vQH+CjULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt8pswdNWpNq+T?=
 =?us-ascii?q?xw1FqPRmuUBSAQeGCZ7VUFD0OadeSnm6pbMlCUqdFOpmZ2CFnoeMYQG++pfD3t?=
 =?us-ascii?q?J8PsCIjERKBuEgoqewLm7YuhqiN4qIMTiMMUYoH4I5T3QC7AkB4/CR6HL7NpD9?=
 =?us-ascii?q?DY2ms1KW/3ZYqIxZThwaxLPSx5CIFEaDNQ5hujArn3+dSBI7VeQjakp6mPQigt?=
 =?us-ascii?q?r39DFNsTZe9mPbcFUhVqD4GbH+XnpRB0XKrS3yTGF2na3mqnDkEvTWosUGfuz9?=
 =?us-ascii?q?uNCh0eazWgeThYRUDOTpfi/l177VclTJlIZ/gIwoqUosk+mVN/wW1u/unHslho?=
 =?us-ascii?q?dXcdAVu438geAzoLK7AuDQGsJVDhMbJohrsBebTgr0EKZ2sPnHhRxv7CPD3GQ7?=
 =?us-ascii?q?LGZqXW1Iyd9EIOoTUfoViNcu5+6/t511UmJE75e/GeOpoWdMVnNL/qi8UDSX4k?=
 =?us-ascii?q?usPM=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ApteDtqk5QNnvxXiheMZMrT45H57pDfIQ3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzsCWYtN9/Yh8dcK+7UpVoLUm8yXcX2/h1AV7BZniEhI?=
 =?us-ascii?q?LAFugLgrcKqAeQeREWmNQ86Y5QN4B6CPDVSWNxlNvG5mCDeOoI8Z2q97+JiI7l?=
 =?us-ascii?q?o0tQcQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,320,1635177600"; 
   d="scan'208";a="120913273"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Jan 2022 20:41:07 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id BF5584D169C7;
        Thu, 27 Jan 2022 20:41:02 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 27 Jan 2022 20:41:04 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 27 Jan 2022 20:41:03 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 27 Jan 2022 20:41:00 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v10 4/9] fsdax: fix function description
Date:   Thu, 27 Jan 2022 20:40:53 +0800
Message-ID: <20220127124058.1172422-5-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com>
References: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: BF5584D169C7.A1C08
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function name has been changed, so the description should be updated
too.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index cd03485867a7..c8d57080c1aa 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -390,7 +390,7 @@ static struct page *dax_busy_page(void *entry)
 }
 
 /*
- * dax_lock_mapping_entry - Lock the DAX entry corresponding to a page
+ * dax_lock_page - Lock the DAX entry corresponding to a page
  * @page: The page whose entry we want to lock
  *
  * Context: Process context.
-- 
2.34.1



