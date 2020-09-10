Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88576263F3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 10:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgIJIA2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 04:00:28 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:52840 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgIJIAN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599724814; x=1631260814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sMgkTYfIVhjzdVujgdBcvqxrVYyGCgcXIKPhIxj2SRw=;
  b=lTm9Em/zkakI0ZPbY2QxL+ZFUkSV0v0tGa3mgtM+yemT/nL0bGMpbiZP
   ropu61bnBfcW23fVpzLqI7vCoxO1mhYLQA/OJgz5MJ9+nO1n2J/2H59rD
   InlUu2sGSOBQhkToT0faKEtQxgJC9QX3w+K2S6xAOPyr2VHOz6tOLq0SY
   y4Vn88BAG1bvLC5/uGy5A6slHaFxbReMP8hF3n1WtNQdipwr8FDEl6fiU
   W2gddBZU9k+ojMi7aNswQjTNgqu6k1/7iVUlNAai9TXkqeN+FWE6mkk44
   vSodwQasa/jYnB53LFIqRuKfDffJuQmw+CvHN1kiptXj6VwC9v6LxTA01
   Q==;
IronPort-SDR: HyEEx0XnKXgPPL2PHjVT/FnUPnXWRQV5bpTkvRAPGlKHn5Gi9JFCo6ptGQc72XPVPOU0PcnAnl
 CMJd+NUEaQwqVneFV8KgITGog3IiqsfSOemy4giQu5lz1yIzMSbv7pjANtzAHPwfPVJ5eoZucT
 PfPwklLYMUPV0ATZQDZnLc1esGzMCg4jTDlsR0xS7dOo8P3mxAuhcXtkImBKw2NxFtTCWS9R3T
 fSi6AOBQXH06lWzKsHYzkGNtr4Lhg3t4X4G9iBAMUvLT3WYL5x5aac1O0IzTE80lK5JSA/SvxQ
 WEA=
X-IronPort-AV: E=Sophos;i="5.76,412,1592841600"; 
   d="scan'208";a="148233444"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2020 16:00:13 +0800
IronPort-SDR: tnsv+kokqnAjehCZJ+hRj8uirtA+qfScgMQqpB/AEfzvKDhtbNJf/jklzWloB5S3eO+xZBQwkC
 wvZmUUoibQpg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 00:47:30 -0700
IronPort-SDR: Y0E5G24OEbuPKOjdh+sYszIrDE8g5TENzkXeypXy24HqT+1u+CmVfBomWvU5aerLRs6ktob6Kn
 DWDBPGMb3B+A==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 01:00:13 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v3 3/3] zonefs: document the explicit-open mount option
Date:   Thu, 10 Sep 2020 16:59:57 +0900
Message-Id: <20200910075957.7307-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910075957.7307-1-johannes.thumshirn@wdc.com>
References: <20200910075957.7307-1-johannes.thumshirn@wdc.com>
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

