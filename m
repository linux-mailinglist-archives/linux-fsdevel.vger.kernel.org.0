Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3BB3721EE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 22:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhECUtz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 16:49:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:26371 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhECUtv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 16:49:51 -0400
IronPort-SDR: N/iY/JsGOPWTT0RX2WqA0iadbqGU7lp75em3gHahzyVBqJP82f0Rt/crnEcC1k0l6g4CV/6uF8
 kjYpvuTBeRSA==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="283233171"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="283233171"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 13:48:58 -0700
IronPort-SDR: uA+eHJNaoz9Q3tTyt3sRPlEcl8pvjbUQsK4na2VGBrdOwTOogGiKsc5ro0DEfu+3r7QH0eAxQT
 Y9pZvq2nShmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="530694822"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 May 2021 13:48:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 668E035E; Mon,  3 May 2021 23:49:11 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 07/12] lib/test-string_helpers: Print flags in hexadecimal format
Date:   Mon,  3 May 2021 23:49:02 +0300
Message-Id: <20210503204907.34013-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503204907.34013-1-andriy.shevchenko@linux.intel.com>
References: <20210503204907.34013-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since flags are bitmapped, it's better to print them in hexadecimal format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test-string_helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test-string_helpers.c b/lib/test-string_helpers.c
index 10360d4ea273..079fb12d59cc 100644
--- a/lib/test-string_helpers.c
+++ b/lib/test-string_helpers.c
@@ -19,7 +19,7 @@ static __init bool test_string_check_buf(const char *name, unsigned int flags,
 	if (q_real == q_test && !memcmp(out_test, out_real, q_test))
 		return true;
 
-	pr_warn("Test '%s' failed: flags = %u\n", name, flags);
+	pr_warn("Test '%s' failed: flags = %#x\n", name, flags);
 
 	print_hex_dump(KERN_WARNING, "Input: ", DUMP_PREFIX_NONE, 16, 1,
 		       in, p, true);
@@ -290,7 +290,7 @@ test_string_escape_overflow(const char *in, int p, unsigned int flags, const cha
 
 	q_real = string_escape_mem(in, p, NULL, 0, flags, esc);
 	if (q_real != q_test)
-		pr_warn("Test '%s' failed: flags = %u, osz = 0, expected %d, got %d\n",
+		pr_warn("Test '%s' failed: flags = %#x, osz = 0, expected %d, got %d\n",
 			name, flags, q_test, q_real);
 }
 
-- 
2.30.2

