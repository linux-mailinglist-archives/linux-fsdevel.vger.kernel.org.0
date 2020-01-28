Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E73CC14B92F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 15:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387512AbgA1O2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 09:28:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:50006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732487AbgA1O2b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:28:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C4A50AAA6;
        Tue, 28 Jan 2020 14:28:29 +0000 (UTC)
Date:   Tue, 28 Jan 2020 15:28:26 +0100
From:   Petr Tesarik <ptesarik@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/Kconfig: default to no mandatory locking
Message-ID: <20200128152826.48fc71a6@ezekiel.suse.cz>
Organization: SUSE Linux, s.r.o.
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the help text says this code is dead, the option itself should
not default to y.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 fs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 7b623e9fc1b0..fc60b8bbebc2 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -103,7 +103,7 @@ config FILE_LOCKING
 config MANDATORY_FILE_LOCKING
 	bool "Enable Mandatory file locking"
 	depends on FILE_LOCKING
-	default y
+	default n
 	help
 	  This option enables files appropriately marked files on appropriely
 	  mounted filesystems to support mandatory locking.
-- 
2.16.4

