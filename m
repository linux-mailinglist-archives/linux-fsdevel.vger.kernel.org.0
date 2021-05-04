Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C958372F89
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 20:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhEDSKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 14:10:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:4503 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232262AbhEDSJF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 14:09:05 -0400
IronPort-SDR: a9nVJRRMEs2maSMH6CrQzR5RYa7YiAz7HBtgFdqyooCzr11WkEE/Z5VkE89PbFEHSAZoL59TLI
 rsfntDYpOCqQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="198102780"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="198102780"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 11:08:10 -0700
IronPort-SDR: V5HfvSqKutDJd67XnLWWCUmRRshC4Yg3mdNf4ZKEAlGqqQavw4TRdapbvawAkipIjPzR65yF3B
 k3c9W0x9dZnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="621628453"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 04 May 2021 11:08:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DE6B5417; Tue,  4 May 2021 21:08:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 07/15] lib/test-string_helpers: Print flags in hexadecimal format
Date:   Tue,  4 May 2021 21:08:11 +0300
Message-Id: <20210504180819.73127-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
References: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
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

