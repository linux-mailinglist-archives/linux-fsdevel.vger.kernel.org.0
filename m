Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC602651CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 23:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgIJVCW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 17:02:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23587 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbgIJOj5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599748798; x=1631284798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sMgkTYfIVhjzdVujgdBcvqxrVYyGCgcXIKPhIxj2SRw=;
  b=nscvXckDDzYdHhuXAetRhHzVwf0vE0I4NxlucXUpQ0ISY6DVry+f8JX7
   XeJDjJQpR36gZzLfY9uZ9nlVGXhtGVJcM6f1gzwMvjB4Fsl2qj1sOs0iw
   gyrOUl/ijA+uK61F5oyVl8K6lstVPkdJN7i4GEvhZtJLEFL24CVHG5hR8
   X0Ez8d7i8kZThy3E5ohDyUQvC+Ck0gOmt+uWNvMwuewN7Onre/pCJ3mxS
   aeLNUJDvknwoRmnCJdc2zRLf+j89lWNVIaPZLsY8iLt3hbsdE8ZtEAlAx
   x2SCt9/Zwqorm5KEA01bTxXjTTR+K30SaqaEmtMaFstqxemRS0AtmZMrA
   A==;
IronPort-SDR: 3xKIxmwk5hxoyO662i6ntNCJ1GYvXvGXFqOUSYB7Bajgr/9WRZ50aXr0AYFQukeIjlsdyQ/cxJ
 e5p1OTaaGAecx1ojOwmK8VLzC91EmT/nkmiYQkj+nt2r2wn6UTUvr+QkiPayMJr+q2tVA7nBaR
 oWM8eW3ufJ4OFH4QzK1va6S0M7fkvcjRJZmn9f8dhMefVny8cskQpgKBhLP9Lg5QAuUrz7ltxX
 vVdGJNicfSyiLiyOpbLTk+QDNPS0pNX1p0ZKs9NX6KU2NaxyHAa+KcqNq/CLeTXe2huobaAF5C
 qnI=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; 
   d="scan'208";a="148261191"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2020 22:37:54 +0800
IronPort-SDR: 3tfMdBMf/VKQJjgt8ZKIBYUQidn8U9rH5VNaWoW8cw1edbeQrY2SU8wYb4JpTEnId2UXm5Osyi
 04e4x2ZvLHIA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 07:24:17 -0700
IronPort-SDR: XTi0IzPlit9jotM42rAwAveKy9ryYzRXccOILl9wVFXlCwjI40ozkYcAlw5hY1FIftBkIg2liU
 vWyd8150/pHg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Sep 2020 07:37:53 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v4 4/4] zonefs: document the explicit-open mount option
Date:   Thu, 10 Sep 2020 23:37:44 +0900
Message-Id: <20200910143744.17295-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910143744.17295-1-johannes.thumshirn@wdc.com>
References: <20200910143744.17295-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Document the newly introduced explicit-open mount option.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
---
Changes to v1:
- Address Randy's comments
---
 Documentation/filesystems/zonefs.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/filesystems/zonefs.rst b/Documentation/filesystems/zonefs.rst
index 6c18bc8ce332..6b213fe9a33e 100644
--- a/Documentation/filesystems/zonefs.rst
+++ b/Documentation/filesystems/zonefs.rst
@@ -326,6 +326,21 @@ discover the amount of data that has been written to the zone. In the case of a
 read-only zone discovered at run-time, as indicated in the previous section.
 The size of the zone file is left unchanged from its last updated value.
 
+A zoned block device (e.g. an NVMe Zoned Namespace device) may have limits on
+the number of zones that can be active, that is, zones that are in the
+implicit open, explicit open or closed conditions.  This potential limitation
+translates into a risk for applications to see write IO errors due to this
+limit being exceeded if the zone of a file is not already active when a write
+request is issued by the user.
+
+To avoid these potential errors, the "explicit-open" mount option forces zones
+to be made active using an open zone command when a file is opened for writing
+for the first time. If the zone open command succeeds, the application is then
+guaranteed that write requests can be processed. Conversely, the
+"explicit-open" mount option will result in a zone close command being issued
+to the device on the last close() of a zone file if the zone is not full nor
+empty.
+
 Zonefs User Space Tools
 =======================
 
-- 
2.26.2

