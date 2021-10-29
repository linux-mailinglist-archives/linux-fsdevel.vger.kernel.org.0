Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93B9440260
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 20:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhJ2Srx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 14:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhJ2Sri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 14:47:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D66C061570;
        Fri, 29 Oct 2021 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=r84288GmeDVjDY3xNymFGbcisITDhLv6aqXTm20aeME=; b=LYqJ7TMrp0MnnPGfgthGg9vbez
        DXw1vHhNAWrrkUSwCZHMibvX7XZ/iK0yLFkMcC0G781lrWojDAbU49dyJN1tn+7q5cph5UEPKjisV
        24HJwTwf31sjtiKdDIlB4jFuevHg6RcnNeh4iCnYK0BBEGPgXKH6S6HHscKerZiijAic8nralXx3e
        ro22kqhCUaLezXVMAc7Ll8TPHd1D7BdbHCrXg4HxUUPTLSZUIH3TunoEiraK/BQucC3/S8RBCyd2K
        8ihq4M5xXvbJ11WDYfvR+h0vIMGEu+qSh3zuB8kv6KAQFluYRGHjmgzONCix8thYKEhWKBy8g9YFe
        7uBU6PeA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgWsA-00Bq0O-6h; Fri, 29 Oct 2021 18:45:02 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, jeyu@kernel.org, shuah@kernel.org
Cc:     bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, mcgrof@kernel.org, keescook@chromium.org,
        rostedt@goodmis.org, minchan@kernel.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Kuno Woudt <kuno@frob.nl>,
        Richard Fontana <fontana@sharpeleven.org>,
        copyleft-next@lists.fedorahosted.org,
        Ciaran Farrell <Ciaran.Farrell@suse.com>,
        Christopher De Nicolo <Christopher.DeNicolo@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: [PATCH v9 2/6] testing: use the copyleft-next-0.3.1 SPDX tag
Date:   Fri, 29 Oct 2021 11:44:56 -0700
Message-Id: <20211029184500.2821444-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211029184500.2821444-1-mcgrof@kernel.org>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Two selftests drivers exist under the copyleft-next license.
These drivers were added prior to SPDX practice taking full swing
in the kernel. Now that we have an SPDX tag for copylef-next-0.3.1
documented, embrace it and remove the boiler plate.

Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc: Kuno Woudt <kuno@frob.nl>
Cc: Richard Fontana <fontana@sharpeleven.org>
Cc: copyleft-next@lists.fedorahosted.org
Cc: Ciaran Farrell <Ciaran.Farrell@suse.com>
Cc: Christopher De Nicolo <Christopher.DeNicolo@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 lib/test_kmod.c                          | 12 +-----------
 lib/test_sysctl.c                        | 12 +-----------
 tools/testing/selftests/kmod/kmod.sh     | 13 +------------
 tools/testing/selftests/sysctl/sysctl.sh | 12 +-----------
 4 files changed, 4 insertions(+), 45 deletions(-)

diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index ce1589391413..d62afd89dc63 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -1,18 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
 /*
  * kmod stress test driver
  *
  * Copyright (C) 2017 Luis R. Rodriguez <mcgrof@kernel.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or at your option any
- * later version; or, when distributed separately from the Linux kernel or
- * when incorporated into other software packages, subject to the following
- * license:
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of copyleft-next (version 0.3.1 or later) as published
- * at http://copyleft-next.org/.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 3750323973f4..9e5bd10a930a 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -1,18 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
 /*
  * proc sysctl test driver
  *
  * Copyright (C) 2017 Luis R. Rodriguez <mcgrof@kernel.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or at your option any
- * later version; or, when distributed separately from the Linux kernel or
- * when incorporated into other software packages, subject to the following
- * license:
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of copyleft-next (version 0.3.1 or later) as published
- * at http://copyleft-next.org/.
  */
 
 /*
diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index afd42387e8b2..7189715d7960 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -1,18 +1,7 @@
 #!/bin/bash
-#
+# SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
 # Copyright (C) 2017 Luis R. Rodriguez <mcgrof@kernel.org>
 #
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of the GNU General Public License as published by the Free
-# Software Foundation; either version 2 of the License, or at your option any
-# later version; or, when distributed separately from the Linux kernel or
-# when incorporated into other software packages, subject to the following
-# license:
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of copyleft-next (version 0.3.1 or later) as published
-# at http://copyleft-next.org/.
-
 # This is a stress test script for kmod, the kernel module loader. It uses
 # test_kmod which exposes a series of knobs for the API for us so we can
 # tweak each test in userspace rather than in kernelspace.
diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 19515dcb7d04..2046c603a4d4 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -1,16 +1,6 @@
 #!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
 # Copyright (C) 2017 Luis R. Rodriguez <mcgrof@kernel.org>
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of the GNU General Public License as published by the Free
-# Software Foundation; either version 2 of the License, or at your option any
-# later version; or, when distributed separately from the Linux kernel or
-# when incorporated into other software packages, subject to the following
-# license:
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of copyleft-next (version 0.3.1 or later) as published
-# at http://copyleft-next.org/.
 
 # This performs a series tests against the proc sysctl interface.
 
-- 
2.30.2

