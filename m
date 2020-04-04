Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0076519E790
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Apr 2020 22:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgDDUgT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Apr 2020 16:36:19 -0400
Received: from mx2.yrkesakademin.fi ([85.134.45.195]:7347 "EHLO
        mx2.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgDDUgT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Apr 2020 16:36:19 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Apr 2020 16:36:19 EDT
From:   Thomas Backlund <tmb@mageia.org>
To:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Thomas Backlund <tmb@mageia.org>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Subject: [PATCH v2] exfat: add missing MODULE_ALIAS_FS()
Date:   Sat, 4 Apr 2020 23:35:42 +0300
Message-ID: <20200404203541.367106-1-tmb@mageia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the necessary MODULE_ALIAS_FS() to exfat so the module gets
automatically loaded when an exfat filesystem is mounted.

Signed-off-by: Thomas Backlund <tmb@mageia.org>
Cc: Namjae Jeon <namjae.jeon@samsung.com>
Cc: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 16ed202ef527..b4a4063a0272 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -717,6 +717,7 @@ static void __exit exit_exfat_fs(void)
 module_init(init_exfat_fs);
 module_exit(exit_exfat_fs);
 
+MODULE_ALIAS_FS("exfat");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("exFAT filesystem support");
 MODULE_AUTHOR("Samsung Electronics Co., Ltd.");
-- 
2.26.0

