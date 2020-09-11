Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F62265C11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 10:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgIKI5Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 04:57:24 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:58877 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgIKI5G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599814626; x=1631350626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MWzomiudUXRpALqsd5z2KVHaNY/hDcGHCszrDMZwWbU=;
  b=HNXEZZoWMQuiVDXf166un3bkAIZFn93bUuWv3cop3SwnBp/fjh85tnlX
   ER9YVQyZv4qfQAC38+FHpqbD+I0grt621cM1J5ry0EVwDqsQkGjecBUr8
   GSvHeAEMUMaS7bqPFwdKUAiwWRlNkEobozyzxsJTjlHrTe5kL0CQNhpJN
   0MSls5Ct4aujd95RG4CgzXhavAOkBtveBGauAFcsHGxECl6P+iOkxfxuE
   cXJUabBpPadSsJjBZAbhk7zP+KMi8ybkjRt+VFfDefVH6msB0S+spY+TU
   SjAMiWLv6daINRFsHLtm2H4Guj27F722ZWccnbZh7LPmqZwh5Z2NuGHT+
   A==;
IronPort-SDR: t3nN57v9b0Zf9tpmLMTzX+YParhSZj3xFCEk+JALEtYHUuBX+Wam/xNjBwm8MSb2UuIW/p84gj
 iejjSkjiHkqNf52G0kIEEZs70HvQI5x0aZCQuJbCzxTHZKRNE+oWO0nKwoDfj/4z2Y3ultQwyA
 FDoNbsEkFwksJJLBTyEbCFEQtYxKh0VcsZGstxHuhCHdWtHd4uWQ1g6hOk1PSMwPpYPdDtpFo2
 MIhRdrkmJUYpxI10JAscs/DETn8ulR533GCwFHp4VX8qUGi1Tq1K0ucUoHn1AenHBmeI6vpaXa
 i+E=
X-IronPort-AV: E=Sophos;i="5.76,414,1592841600"; 
   d="scan'208";a="147041241"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 16:57:01 +0800
IronPort-SDR: KboUYO8WbzxOgNhUUuMP+GKVdVFtY7G1Q9ckkKd/oTugKwiwj6REH1DemZRpAVdXaTSmMyysmn
 jgqNLXqWO2QA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 01:44:18 -0700
IronPort-SDR: DW+wibrQUrf8hey4NqX8BKNhFEtVnYHhKiCQoaFsmLRKwZkZeGCh8kajdYYDcKuVIQfjXd5KqM
 6kzxlTAyOhOQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Sep 2020 01:57:00 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v5 4/4] zonefs: document the explicit-open mount option
Date:   Fri, 11 Sep 2020 17:56:51 +0900
Message-Id: <20200911085651.23526-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911085651.23526-1-johannes.thumshirn@wdc.com>
References: <20200911085651.23526-1-johannes.thumshirn@wdc.com>
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

