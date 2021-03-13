Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31E333A1DF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Mar 2021 00:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhCMXNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 18:13:49 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41396 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbhCMXNX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 18:13:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 54CBC1F472EA
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     krisman@collabora.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     kernel@collabora.com, gustavo.padovan@collabora.com,
        andre.almeida@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH 2/3] fs: unicode: Rename utf8-core file to unicode-core
Date:   Sun, 14 Mar 2021 04:42:12 +0530
Message-Id: <20210313231214.383576-3-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210313231214.383576-1-shreeya.patel@collabora.com>
References: <20210313231214.383576-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename the file name from utf8-core to unicode-core for transformation of
utf8-core file into the unicode subsystem layer file and also for better
understanding.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 fs/unicode/Makefile                        | 2 +-
 fs/unicode/{utf8-core.c => unicode-core.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename fs/unicode/{utf8-core.c => unicode-core.c} (100%)

diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
index b88aecc86550..fbf9a629ed0d 100644
--- a/fs/unicode/Makefile
+++ b/fs/unicode/Makefile
@@ -3,7 +3,7 @@
 obj-$(CONFIG_UNICODE) += unicode.o
 obj-$(CONFIG_UNICODE_NORMALIZATION_SELFTEST) += utf8-selftest.o
 
-unicode-y := utf8-norm.o utf8-core.o
+unicode-y := utf8-norm.o unicode-core.o
 
 $(obj)/utf8-norm.o: $(obj)/utf8data.h
 
diff --git a/fs/unicode/utf8-core.c b/fs/unicode/unicode-core.c
similarity index 100%
rename from fs/unicode/utf8-core.c
rename to fs/unicode/unicode-core.c
-- 
2.30.1

