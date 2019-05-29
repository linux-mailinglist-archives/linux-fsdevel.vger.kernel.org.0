Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4336F2E756
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 23:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfE2VVE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 17:21:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbfE2VVE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 17:21:04 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECD3F241F8;
        Wed, 29 May 2019 21:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559164864;
        bh=EZsbpWPJYoAn6xYCicS/qMrHZDPRTvsGsB4LB5FMfBI=;
        h=From:To:Subject:Date:From;
        b=sPyfeSwqQhffurBDkaxdQaqtfs/cQJaSHeonxLOFgXcZv+NfFMwcjAGdxKhOOMpdT
         Rpjr2cQUwuV4zxOpPEXtNRQKLVNgjz22P3KNwmrA236xTsVXDsZ2Qt8agPJ7kMeWS2
         ZIll328Rdt440XHJ3AG+7/9lJ53rkoBgpkFinPC0=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] fs/direct-io.c: include fs/internal.h for missing prototype
Date:   Wed, 29 May 2019 14:21:00 -0700
Message-Id: <20190529212100.164185-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Include fs/internal.h to address the following 'sparse' warning:

    fs/direct-io.c:622:5: warning: symbol 'sb_init_dio_done_wq' was not declared. Should it be static?

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/direct-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index ac7fb19b6ade5..601b402829239 100644
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
2.22.0.rc1.257.g3120a18244-goog

