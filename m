Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D550F21D7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfEQShW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:22 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57572 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728253AbfEQShC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:02 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj2-0000oH-Qd; Fri, 17 May 2019 14:37:00 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/22] uapi linux/coda_psdev.h: Move CODA_REQ_ from uapi to kernel side headers
Date:   Fri, 17 May 2019 14:36:46 -0400
Message-Id: <baeafc30dad70d8b422ee679420099c2d8aa7da0.1558117389.git.jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558117389.git.jaharkes@cs.cmu.edu>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These constants only used internally and not exposed to userspace.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 include/linux/coda_psdev.h      | 5 +++++
 include/uapi/linux/coda_psdev.h | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/coda_psdev.h b/include/linux/coda_psdev.h
index d1672fd5e638..9487f792770c 100644
--- a/include/linux/coda_psdev.h
+++ b/include/linux/coda_psdev.h
@@ -31,6 +31,11 @@ struct upc_req {
 	wait_queue_head_t	uc_sleep;   /* process' wait queue */
 };
 
+#define CODA_REQ_ASYNC  0x1
+#define CODA_REQ_READ   0x2
+#define CODA_REQ_WRITE  0x4
+#define CODA_REQ_ABORT  0x8
+
 static inline struct venus_comm *coda_vcp(struct super_block *sb)
 {
 	return (struct venus_comm *)((sb)->s_fs_info);
diff --git a/include/uapi/linux/coda_psdev.h b/include/uapi/linux/coda_psdev.h
index d50d51a57fe4..3dacb7fad66a 100644
--- a/include/uapi/linux/coda_psdev.h
+++ b/include/uapi/linux/coda_psdev.h
@@ -7,9 +7,4 @@
 #define CODA_PSDEV_MAJOR 67
 #define MAX_CODADEVS  5	   /* how many do we allow */
 
-#define CODA_REQ_ASYNC  0x1
-#define CODA_REQ_READ   0x2
-#define CODA_REQ_WRITE  0x4
-#define CODA_REQ_ABORT  0x8
-
 #endif /* _UAPI__CODA_PSDEV_H */
-- 
2.20.1

