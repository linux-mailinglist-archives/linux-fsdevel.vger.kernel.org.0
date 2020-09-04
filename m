Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D022625D738
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 13:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgIDL2M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 07:28:12 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15789 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730194AbgIDL0C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599218783; x=1630754783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3uVXhrmM9lVseoqCCNkXi5hMoQew9zMqh4unsQMP2UU=;
  b=X2qtsnVpOV1tIAV38+Eh4YMzVBcj+SlnYx+mAB7x4Tqc5rcSdthntAoz
   EngaOemOnURDIUJZ44vhFnj4Xwi4JHJVsPZQY0ROEq1xAXQ7sFTu2N2aI
   D2vYrziQK+PpMhaBIXxAI5MrSA7Yr8hCGD1XwPr49zGIFRzmQd/G3eiwF
   x8NaPpJJerFyhdJG6/HXw8eQ6n6JIS5Ps+kO+ofXeFGSo3xOH9jt34pnw
   2hWLVJ8kjYLrL/sB0t1s1g4naga3zcgNrFhS8Ti2mZ+uQ3AV9O8ARo79t
   uq5J+yhiYSCsiJVqbCY+h5U++vPls2Bvye/wiIFOzLYlJCU2lMBlQ5h8D
   Q==;
IronPort-SDR: ecaYSj3/ZFG/Qv7DwoIc7Tm26L0/EalRv2lYElOfdWZZfCVSEP0f7bw4/5Zppba7LcGlhlzVVp
 ghZthH23N2GGNq6YQ8567GBjgC/C2Wt8m+1iXZ9ArWc2FtG+vK3Jbk0yKjPALdUzKmSrW1Mobx
 hWCOw6j7PM3XrB1Q9Mb/yQqRYbcFoWZfKSmc0Jm6zVfKGco2rKGpuL6fFxh0ClnJzki1htH28F
 DFEoIgbGSwJjlkH3yEo1RMzwFYaDdaldV86GW90bcKKjAHgT+gElAfcXPJVtLeYx91guu5BrSf
 3Sw=
X-IronPort-AV: E=Sophos;i="5.76,389,1592841600"; 
   d="scan'208";a="249852279"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 19:24:16 +0800
IronPort-SDR: OiMigiTAjdCgkEyfgvhkvxhdC9ni+UcA+0W8mANhBy1zQQaeWix5dIOkPUK5TaxDuGlpSYNcVM
 PzfAXy0WAmTA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 04:10:10 -0700
IronPort-SDR: sd2rpEhQyAECxTs77BhZBu8WhdzjFZv50BMHoaZhKNVTpzJpfENJnFoxT5LXare4dge2Y98Zi8
 Wdm983zziPww==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Sep 2020 04:23:36 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/3] zonefs: document the explicit-open mount option
Date:   Fri,  4 Sep 2020 20:23:28 +0900
Message-Id: <20200904112328.28887-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904112328.28887-1-johannes.thumshirn@wdc.com>
References: <20200904112328.28887-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Document the newly introduced explicit-open mount option.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 Documentation/filesystems/zonefs.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/filesystems/zonefs.rst b/Documentation/filesystems/zonefs.rst
index 6c18bc8ce332..ff8bc3634bad 100644
--- a/Documentation/filesystems/zonefs.rst
+++ b/Documentation/filesystems/zonefs.rst
@@ -326,6 +326,21 @@ discover the amount of data that has been written to the zone. In the case of a
 read-only zone discovered at run-time, as indicated in the previous section.
 The size of the zone file is left unchanged from its last updated value.
 
+A zoned block device (e.g. a NVMe Zoned Namespace device) may have
+limits on the number of zones that can be active, that is, zones that
+are in the the implicit open, explicit open or closed conditions.
+This potential limitation translate into a risk for applications to see
+write IO errors due to this limit being exceeded if the zone of a file
+is not already active when a write request is issued by the user.
+
+To avoid these potential errors, the "explicit-open" mount option
+forces zones to be made active using an open zone command when a file
+is open for writing for the first time. If the zone open command
+succeeds, the application is then guaranteed that write requests can be
+processed. Conversely, the "explicit-open" mount option will result in
+a zone close command being issued to the device on the last close() of
+a zone file if the zone is not full nor empty.
+
 Zonefs User Space Tools
 =======================
 
-- 
2.26.2

