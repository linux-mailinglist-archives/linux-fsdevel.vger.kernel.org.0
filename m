Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FF24103E6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 07:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241995AbhIRFGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Sep 2021 01:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238529AbhIRFGf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Sep 2021 01:06:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C09CC061757;
        Fri, 17 Sep 2021 22:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=q2+MnJ/oJog1W0Rk/dtsiaYdpoMihgX+djUDLDDhJ3E=; b=uUfkhq36ZNYHgaZ8euaXy/ld3F
        ehNPiASo6yRNvYoZ5k/9LDC76Z7r7iJyX4APIz0OVxZ7Y0jZjfn4fVU2m/97SYtnmEXdEYtrhWwgV
        70W1enzwQmsKtKNb5gJp5/ZErYiibbjVqjmL75+lXaxK3VDfSlSt3Vr9Mk01107bB/St6nNqhTOj5
        iRSG7I8y7iXrvsX6J41+qC/28dE8oCQ1ZrJUt8HydoVYdkdgpRTK3scA0lbn2cToUm/+BUU3wRlQz
        aSFlxE62O+qlFVzBi+tvJurYcGdgmdpx767ImIMAbMiIkImk5Ubnxyw1mP5zVRmSloW6jsaceYwY4
        LkgntUcA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRSWe-00FP4O-N9; Sat, 18 Sep 2021 05:04:32 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org
Cc:     rdunlap@infradead.org, rafael@kernel.org, masahiroy@kernel.org,
        ndesaulniers@google.com, yzaikin@google.com, nathan@kernel.org,
        ojeda@kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        vitor@massaru.org, elver@google.com, jarkko@kernel.org,
        glider@google.com, rf@opensource.cirrus.com,
        stephen@networkplumber.org, David.Laight@ACULAB.COM,
        bvanassche@acm.org, jolsa@kernel.org,
        andriy.shevchenko@linux.intel.com, trishalfonso@google.com,
        andreyknvl@gmail.com, jikos@kernel.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        mcgrof@kernel.org, reinette.chatre@intel.com, fenghua.yu@intel.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        daniel.vetter@ffwll.ch, bhelgaas@google.com, kw@linux.com,
        dan.j.williams@intel.com, senozhatsky@chromium.org, hch@lst.de,
        joe@perches.com, hkallweit1@gmail.com, axboe@kernel.dk,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, copyleft-next@lists.fedorahosted.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Kuno Woudt <kuno@frob.nl>,
        Richard Fontana <fontana@sharpeleven.org>,
        Ciaran Farrell <Ciaran.Farrell@suse.com>,
        Christopher De Nicolo <Christopher.DeNicolo@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: [PATCH v7 02/12] testing: use the copyleft-next-0.3.1 SPDX tag
Date:   Fri, 17 Sep 2021 22:04:20 -0700
Message-Id: <20210918050430.3671227-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210918050430.3671227-1-mcgrof@kernel.org>
References: <20210918050430.3671227-1-mcgrof@kernel.org>
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

