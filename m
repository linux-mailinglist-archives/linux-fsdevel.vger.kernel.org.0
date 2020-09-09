Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01036262D00
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 12:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgIIK0q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 06:26:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:43811 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgIIK0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599647196; x=1631183196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mw92ho8PPfqLP3dj3WwR/jhErPBWuGbZ4I7LMFxaQ/4=;
  b=H1EpbGtwAxltre6MqtuTjyMo4bNaInounkZlzi0a3sqLk5SjyBktztEt
   tMC2xRZ2jY2C3TyUThe5JQKo2aBo9fRvo6WVhcFnoohR2VnD6C1F3sQgY
   TcDepDwGCILRNcMLlQXxE78yXdrBglbn8ZlKciSuN1cgl2CJ0vFgtxcFh
   r+U/XgocdMyukoxnMbxsxk7ldODb5AgGms42K87TyphQ6Lg7ToVfZi/rh
   I1/+FXGg/CUzCPsEB5oMAOC1dmszvdncNX+1Pv7fOlPDyXSugkD1STPhH
   kmDzsCzfIHhmMeczOiqjz5IUANDSEo7bQ+cMzXBM+QiOKV+TElMNM5LJY
   w==;
IronPort-SDR: VpYXexOUQxLqWuUKC2thFtYk8gJwoEUC2qqI4bCaHepufOGll4+y9s56fvcHP9Vwuz5/R6Uk70
 lhPCjCDTQvwvlo9nYwmERw32NCXABCUtOwKDhk8faYYQLJGE+Ozv4RT9oDFZO43XPRvX6f8prg
 0gA1JYKUdauBpmJs4F1uWqgbsKZOswNyHWYIJVyicNAv5muAm+8sIMlPecM4KoyWWq2uA3Ez9T
 6mTdmVnHY7LtVssSqfEhwnvpnOMCWaJlmWnZmyGl4rQsncsKdcItjCGH9qPp1U+/czKzaFKs44
 Gfo=
X-IronPort-AV: E=Sophos;i="5.76,409,1592841600"; 
   d="scan'208";a="256500009"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2020 18:26:34 +0800
IronPort-SDR: XADWj5MnBUxFOuBpzmcbks74P7x0vHm0wrwMHPOwxew39PPZmFUS3vZNZp4M9Qt/YjNiMVRhRJ
 eDi+fJuaTeaw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 03:13:52 -0700
IronPort-SDR: XQ6lMlLohu3wAWFFDiLIYrbbPghflCgBvhj0YTkKKCmtUlyx541YqmsS78Rp0iVO7CnpE1+Am4
 agsahIA23Ddw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Sep 2020 03:26:33 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 3/3] zonefs: document the explicit-open mount option
Date:   Wed,  9 Sep 2020 19:26:14 +0900
Message-Id: <20200909102614.40585-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909102614.40585-1-johannes.thumshirn@wdc.com>
References: <20200909102614.40585-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Document the newly introduced explicit-open mount option.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

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

