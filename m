Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DED2D8DB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 12:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbfJPKTd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 06:19:33 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:45890 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfJPKTd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:19:33 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKgOu-0003GE-JE; Wed, 16 Oct 2019 11:19:28 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKgOt-0003Wc-T8; Wed, 16 Oct 2019 11:19:27 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/direct-io: include internal.h for sb_init_dio_done_wq
Date:   Wed, 16 Oct 2019 11:19:26 +0100
Message-Id: <20191016101927.13507-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sb_init_dio_done_wq() is declared in internal.h but
fs/direct-io.c does not include this file. Fix the warning
by including internal.h

fs/direct-io.c:612:5: warning: symbol 'sb_init_dio_done_wq' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/direct-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 9329ced91f1d..babdc9ed2cc0 100644
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
2.23.0

