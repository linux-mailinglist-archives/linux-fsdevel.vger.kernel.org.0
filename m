Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E727A4784D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 07:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhLQGPy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 01:15:54 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:64151 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhLQGPw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 01:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639721752; x=1671257752;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bcH//bFReovW+B5mkN9mSG9a/F2ohxc55/4UJQ0ME/Y=;
  b=jQo4SMsDSGSqZkbKoWLTw3RKNgZmuiaQbD48ccrtZy2pDeNLfw+9dzGo
   k4w8Rr0hRrEHnsdIKCTUXdzJKxLdRdffZGq10QinminOWx9i/v/EgSl/2
   kuL/BJAAsYisW1VRGswW2uQ3qP4e22RYp2/GPBoPNP4k0kDw6AT3qedpR
   zpvTYMxTQyKi8HK8yPb7KMTz5ew/QUUU0jt2jxp3MEIOzqmh1aFfY4Bb1
   /IRADP2cZEe05qJWogHyJvNgaiGulrT2+aoE2Fs8CsH0RZXh96xNzdAFN
   DH8hU6iBxRg+VeSl6rLLW5+w90r5M2ZlTG1f8C4vo7ok/Vm0wuu8NJ5In
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,213,1635177600"; 
   d="scan'208";a="292484066"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2021 14:15:51 +0800
IronPort-SDR: Hd52772Th9aFJBp09ks4R0DkhxCVIDg71ZjiE1yll/+pjFAZjAkwuYxn6x+b0i36c2odxUd45G
 LhsDD7IqCdOA7EZWP8vW8S+dL7DIHsMexD3a+D1xpDztZU9Lil6+xaZlk6KrHqApb3+5jYQk81
 WZasIJMPIreKxqsF57+mKHCJIv8eVcEU8zVN8rbzC5gngAubp119W4xcN7YGVvaKf5nB0aL8yd
 Jt2H9GXpuJOpa8QNJrZBIsh8KCmHbN7t+79tE1QHhXKK146P3BcQLMIRlPfITj1Ovm/CsWCLo8
 hEY5TIJJvo7uy08thcqoOJR6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 21:48:45 -0800
IronPort-SDR: +udgxBoc7VCRJNpj95ue9r/k9F1fa/yPFEWw/wOyZzmAKHnqbvPUgbp8EHFqlTdNzQTikJvFfc
 Jn8F9UkkGoTKy/FnaedPyG23amjFza9EKwcMVyIR4lu7V+/nipnH7cEnbgYsCnLV2aLxkpgCzN
 5TYKMjKxtbIeq2MCd/moMaNc5Xx+QooIltl+wEzcJNTLxYKl2FHliniQEp39sSVU3w1nXYoDvW
 /iWZa/QkCZQMs2lgBwtjwqxyKfpxIB6w4KEMjJRpuuBg1qtKY9U2yaIQbaSbS4hrx/pZjXWC4o
 RQ8=
WDCIronportException: Internal
Received: from 7vqj6g3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.126])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Dec 2021 22:15:51 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] zonefs: add MODULE_ALIAS_FS
Date:   Fri, 17 Dec 2021 15:15:45 +0900
Message-Id: <20211217061545.2843674-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add MODULE_ALIAS_FS() to load the module automatically when you do "mount
-t zonefs".

Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")
Cc: stable <stable@vger.kernel.org> # 5.6+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
- v2
  - Add Fixes and Cc tags
---
 fs/zonefs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 259ee2bda492..b76dfb310ab6 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1787,5 +1787,6 @@ static void __exit zonefs_exit(void)
 MODULE_AUTHOR("Damien Le Moal");
 MODULE_DESCRIPTION("Zone file system for zoned block devices");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_FS("zonefs");
 module_init(zonefs_init);
 module_exit(zonefs_exit);
-- 
2.34.1

