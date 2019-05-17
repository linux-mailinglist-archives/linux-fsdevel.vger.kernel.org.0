Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8A521D7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfEQShS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:18 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57600 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729363AbfEQShC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:02 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj2-0000nn-Dx; Fri, 17 May 2019 14:37:00 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org,
        Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH 02/22] uapi linux/coda.h: use __kernel_pid_t for userspace
Date:   Fri, 17 May 2019 14:36:40 -0400
Message-Id: <f374a71f4d351bc8c8b3ac18ad7765c88d806d10.1558117389.git.jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558117389.git.jaharkes@cs.cmu.edu>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mikko Rapeli <mikko.rapeli@iki.fi>

Part of a patch by Mikko Rapeli, as Arnd Bergman commented on
the original patch.

   pid_t might differ between libc and the kernel, so the kernel interface
   has to use types that the kernel defines.

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 include/uapi/linux/coda.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/coda.h b/include/uapi/linux/coda.h
index 695fade33c64..ed8cb263e482 100644
--- a/include/uapi/linux/coda.h
+++ b/include/uapi/linux/coda.h
@@ -295,8 +295,8 @@ struct coda_statfs {
 struct coda_in_hdr {
     u_int32_t opcode;
     u_int32_t unique;	    /* Keep multiple outstanding msgs distinct */
-    pid_t pid;
-    pid_t pgid;
+    __kernel_pid_t pid;
+    __kernel_pid_t pgid;
     vuid_t uid;
 };
 
-- 
2.20.1

