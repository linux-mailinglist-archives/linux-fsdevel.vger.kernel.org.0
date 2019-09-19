Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68E80B7023
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 02:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfISAiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 20:38:17 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:49038 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725909AbfISAiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:38:17 -0400
Received: from mr2.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x8J0cGBj003547
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 20:38:16 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x8J0cBpx027847
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 20:38:16 -0400
Received: by mail-qt1-f198.google.com with SMTP id w9so2089488qto.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 17:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=Tl2rf6JeocaEFmRZvibly+0M3bTjf3OySViDdJOt7sQ=;
        b=Di8rkA0jLjYcK8aaZVcvIvGZFPq7LTxSymOZCWrAMmdGXMeudZKpetgw9tj8wvm3pj
         huivBMNLu0ZfhADii2KMXz8hLVM7sIU6I8wpML4XGtnCXIwk1oDvmjarL3UhP7LCGeH4
         637Nb4Gn3gx2LkbPwei2wfNqRMeTu2OFO5TsuHT9nVysS7zHxex110l2mJlLd0S+39ah
         rmSb5I84plmQM/rkKwogbhqlti+qA6Myh1tuMe0wEYGn+U+1gKC3zOcmgGBaDzmdz1d0
         0l5l2seX67p8S1DDJtpjN5NMH3zhv/SPN/LcwpNUdBxD0stjGcqFeF4ii6p8+VgNl6xL
         kCBg==
X-Gm-Message-State: APjAAAX/KR/ByYS/yrv3oNiTzsiNhwPw7xmqkTJ2umkNYSnWrvAzDj9l
        bn2CIhFKH+LOguXQHJDWydn5zeYWeKum4ryGEd4pAk7jjdFkkgsSEGZXTRl34Eom+rM8JQjBo3G
        NPkFNJmuzbR08Yd1GmZzK/jZvBzw4gGibtceK
X-Received: by 2002:ac8:6918:: with SMTP id e24mr607959qtr.60.1568853490863;
        Wed, 18 Sep 2019 17:38:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwbVJ7JccYjBIOVP6gw0tP+9nusUoCzA7tXMjWWGK9/gnCwov29CnPCfQeW7sp7UY9KzPbpAA==
X-Received: by 2002:ac8:6918:: with SMTP id e24mr607940qtr.60.1568853490520;
        Wed, 18 Sep 2019 17:38:10 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id v4sm3091126qkj.28.2019.09.18.17.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 17:38:09 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] drivers/staging/exfat - fix SPDX tags..
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 18 Sep 2019 20:38:08 -0400
Message-ID: <122590.1568853488@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The copyright notices as I got them said "GPLv2 or later", which I
screwed up when putting in the SPDX tags.  Fix them to match the
license I got the code under.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

---
diff --git a/drivers/staging/exfat/Makefile b/drivers/staging/exfat/Makefile
index 84944dfbae28..6c90aec83feb 100644
--- a/drivers/staging/exfat/Makefile
+++ b/drivers/staging/exfat/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-2.0-or-later
 
 obj-$(CONFIG_EXFAT_FS) += exfat.o
 
diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 6c12f2d79f4d..3abab33e932c 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
  */
diff --git a/drivers/staging/exfat/exfat_blkdev.c b/drivers/staging/exfat/exfat_blkdev.c
index f086c75e7076..81d20e6241c6 100644
--- a/drivers/staging/exfat/exfat_blkdev.c
+++ b/drivers/staging/exfat/exfat_blkdev.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
  */
diff --git a/drivers/staging/exfat/exfat_cache.c b/drivers/staging/exfat/exfat_cache.c
index 1565ce65d39f..e1b001718709 100644
--- a/drivers/staging/exfat/exfat_cache.c
+++ b/drivers/staging/exfat/exfat_cache.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
  */
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index b3e9cf725cf5..79174e5c4145 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
  */
diff --git a/drivers/staging/exfat/exfat_nls.c b/drivers/staging/exfat/exfat_nls.c
index 03cb8290b5d2..a5c4b68925fb 100644
--- a/drivers/staging/exfat/exfat_nls.c
+++ b/drivers/staging/exfat/exfat_nls.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
  */
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5f6caee819a6..229ecabe7a93 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
  */
diff --git a/drivers/staging/exfat/exfat_upcase.c b/drivers/staging/exfat/exfat_upcase.c
index 366082fb3dab..b91a1faa0e50 100644
--- a/drivers/staging/exfat/exfat_upcase.c
+++ b/drivers/staging/exfat/exfat_upcase.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
  */

