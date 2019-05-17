Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C473421D6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbfEQShE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:04 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57608 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729368AbfEQShC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:02 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj3-0000pg-A1; Fri, 17 May 2019 14:37:01 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/22] coda: remove uapi/linux/coda_psdev.h
Date:   Fri, 17 May 2019 14:36:54 -0400
Message-Id: <bb11378cef94739f2cf89425dd6d302a52c64480.1558117389.git.jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558117389.git.jaharkes@cs.cmu.edu>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Nothing is left in this header that is used by userspace.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/coda_psdev.h            |  5 ++++-
 include/uapi/linux/coda_psdev.h | 10 ----------
 2 files changed, 4 insertions(+), 11 deletions(-)
 delete mode 100644 include/uapi/linux/coda_psdev.h

diff --git a/fs/coda/coda_psdev.h b/fs/coda/coda_psdev.h
index 012e16f741a6..801423cbbdfc 100644
--- a/fs/coda/coda_psdev.h
+++ b/fs/coda/coda_psdev.h
@@ -3,8 +3,11 @@
 #define __CODA_PSDEV_H
 
 #include <linux/backing-dev.h>
+#include <linux/magic.h>
 #include <linux/mutex.h>
-#include <linux/coda_psdev.h>
+
+#define CODA_PSDEV_MAJOR 67
+#define MAX_CODADEVS  5	   /* how many do we allow */
 
 struct kstatfs;
 
diff --git a/include/uapi/linux/coda_psdev.h b/include/uapi/linux/coda_psdev.h
deleted file mode 100644
index 3dacb7fad66a..000000000000
--- a/include/uapi/linux/coda_psdev.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI__CODA_PSDEV_H
-#define _UAPI__CODA_PSDEV_H
-
-#include <linux/magic.h>
-
-#define CODA_PSDEV_MAJOR 67
-#define MAX_CODADEVS  5	   /* how many do we allow */
-
-#endif /* _UAPI__CODA_PSDEV_H */
-- 
2.20.1

