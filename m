Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A5C99857
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 17:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbfHVPkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 11:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731690AbfHVPkP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:40:15 -0400
Received: from zzz.localdomain (ip-173-136-158-138.anahca.spcsdns.net [173.136.158.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28B26206B7;
        Thu, 22 Aug 2019 15:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566488414;
        bh=kTqTs38cytQpm3wnWwtoSaNdABq+7CByh1nrkGkTrT4=;
        h=From:To:Subject:Date:From;
        b=r6i80dyR8ARJNM/3REcuhWabT/vibj5Js09ndEG06G76NGu69Hm5rNq6WnhmZPBBe
         LWXhu31xrxW90s/F/XpPdUyHSuZX/bqo+z0dYIqxhWXBEyymunx+Mk55bqNDB2DHj7
         mfasTvOLTGfQF8XF2u8X2/E7Y6TkWbzSNYMeBFC8=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RESEND] fs/direct-io.c: include fs/internal.h for missing prototype
Date:   Thu, 22 Aug 2019 08:39:52 -0700
Message-Id: <20190822153952.14350-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.1
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
index fbe885d68035..227acbb88ac4 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -38,6 +38,8 @@
 #include <linux/atomic.h>
 #include <linux/prefetch.h>
 
+#include "internal.h"
+
 /*
  * How many user pages to map in one call to get_user_pages().  This determines
  * the size of a structure in the slab cache
-- 
2.22.1

