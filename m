Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2699117BC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 00:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfLIXsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 18:48:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbfLIXsK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:48:10 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65596206D5;
        Mon,  9 Dec 2019 23:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575935289;
        bh=eiCg70Fe6DYiNfInLEyxRDc52uH42sEFX1ZX66Kv0a4=;
        h=From:To:Cc:Subject:Date:From;
        b=DGQ8vlaICxMlI0kCOZUfYp6yfFgNtg2UaPsagByv+pNhbnLYGSiV9Th8hXvF6jlro
         rdveNUET3L9mP91kDAFKwspkvEVJycsOnR8EVP88QxzyqmKM2WzEowToSomXw4la1F
         5Vtq9pzDth53VeZkmlHnkOc43ENy6x5aDLFW44OE=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/direct-io.c: include fs/internal.h for missing prototype
Date:   Mon,  9 Dec 2019 15:45:44 -0800
Message-Id: <20191209234544.128302-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Include fs/internal.h to address the following 'sparse' warning:

    fs/direct-io.c:591:5: warning: symbol 'sb_init_dio_done_wq' was not declared. Should it be static?

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

Hi Andrew, please consider applying this straightforward cleanup.
This has been sent to Al four times with no response.

 fs/direct-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 0ec4f270139f6..00b4d15bb811a 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -39,6 +39,8 @@
 #include <linux/atomic.h>
 #include <linux/prefetch.h>
 
+#include "internal.h"
+
 /*
  * How many user pages to map in one call to get_user_pages().  This determines
  * the size of a structure in the slab cache
-- 
2.24.0.393.g34dc348eaf-goog

