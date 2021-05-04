Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBFC3728F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 12:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhEDK2E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 06:28:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:31284 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230406AbhEDK16 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 06:27:58 -0400
IronPort-SDR: hKT8nMqZqEoyBo8DkddiRhh+CtcgStz4dzauDH2eIfZxiChAb+p9Kns5LxT9SbNY8I4xUWa5gT
 bmD+iU0BNFVQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="198001102"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="198001102"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 03:27:03 -0700
IronPort-SDR: Ou0/f3pTAymHfBa9XOuOS6U1hvuHfrsAcr6R+RS2MykNXeDnZUjDc2LIeRihGbnenJUGSPLUp2
 ipn1b13Q9yHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="396079657"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 04 May 2021 03:27:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A3B6C61D; Tue,  4 May 2021 13:27:17 +0300 (EEST)
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
Subject: [PATCH v2 07/14] lib/test-string_helpers: Print flags in hexadecimal format
Date:   Tue,  4 May 2021 13:26:41 +0300
Message-Id: <20210504102648.88057-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504102648.88057-1-andriy.shevchenko@linux.intel.com>
References: <20210504102648.88057-1-andriy.shevchenko@linux.intel.com>
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

