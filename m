Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740B072B381
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 21:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjFKTID (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 15:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFKTIC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 15:08:02 -0400
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 11 Jun 2023 12:08:00 PDT
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A139F;
        Sun, 11 Jun 2023 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1686510478;
        bh=WTlI9lDwIb26jxouPAzEjCQdYursinj8cqf+Aqs40+4=;
        h=From:To:Cc:Subject:Date;
        b=kVX8U0GdPhqaNU0HkiirFx/P+O6zQ++nYf2RqIUi10Q5ipbA/Mr7KB1+E4i3Ocisi
         svCim1ww1RrPtnfEdDxFuZhppmuuy7lJ255+DaJfwSox+0zZMo0TSHRVkFcVAVTJyO
         ZefVPdG/ounYyG7VApn2zcWCKIKlV1WDosCv6Bac=
Received: from wen-VirtualBox.. ([240e:331:cb9:1200:2421:564d:c6df:cf15])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id EDB1DE32; Mon, 12 Jun 2023 02:59:27 +0800
X-QQ-mid: xmsmtpt1686509967t6yjb17a3
Message-ID: <tencent_F7EEF9B42A817A28086FF22DBD84B9CF2F05@qq.com>
X-QQ-XMAILINFO: N1wtWDyxLDbScaoYXG6UwxVPUyZrgHDJLCghEmkj2xgrdfqNoy240ueNe5zuMl
         ZfuJOg4cPrmUyKGO3XBaWP8aWMNJEq3ZM7EDoKt55xYrnMRs4cBxgYnQp+89N7vbF1jaEMaNwbC3
         vJRcLzgVSYKGdLG7u6FlTVQkmAQ950Cb0qDSkU5ZyfAdn+KxGhoxk7sPnXj7vq7tozbl9bFwKObu
         0IK2q9XkVGZ+OdARK91l5ViytwO82HRtGaasjMHVapU0kbqXdrUpM1T5pPJ//QVmQpM1Ovad8OT7
         XqnoHbrI+mwWg50XSVAVY6VCFpqMykrpx3omBBpolyiuPkDeQoeKd5Cz63sPkNP2ohGrdFn9BHA+
         TFSD+6AwT+sHTzVY8PfcRh4XiN2bPx41lIfIzjvX9vOIimEz55Wk+xQOe+tr1naOvjo5tJhia9fE
         HTnnrrs4fL451C43wMX2uhn5uS3YGnwfxixT0BE3krgSquH6Vtgw3ajvDhxYxlCkieSGuUTGDO3P
         R5o0TNTKkBXJChnsJza9AMgiqWx4WpgHdf/1huIigJDcI7WL2WAYISsJRk3JeddNVAers+FMyJJo
         UUHFaj1nTIDl7t87Ihu5ghGIZEDdkXZIwj+B12v2sDwywghskVgN2cSOcWctX+f3p9yDqmBDWREu
         kge2Jibzezg92Dd5rMFAGx2h1A0NGFpYOskJ9shXaoGoW+LS0y3jRphA0JAandJo5FentYiTPaRN
         JIW0RlWVaP7Ss0ZkjAQMS4VVCOa2ETg1xOtF7iscjCnZrtk6lILjDmtQoMnl+I6BeOhjhxz7Tsf2
         yDQPiobfIOCDtrACCLiY19IHNi9MrkOIyDbe2b1ZfaT1JqVQw6qTVXniD0FHN2+mzk0mn7Yad8cH
         3noX9WIDl7FY82InrsqDj/r4pGCdU8F1FA2nJEJ63i76YbCXd8BQXNKdUwJ1GOYIofeLjH9jDKL5
         M6ozYZZv12OUut8/qxr6+n1PrpGySSLYgOO61VBMM3m2+EvG8The5aTonX2KiIRrVgrs3LTfJJav
         UQ8KsqjUGIdbYViNlt
From:   wenyang.linux@foxmail.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Wen Yang <wenyang.linux@foxmail.com>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] eventfd: add a uapi header for eventfd userspace APIs
Date:   Mon, 12 Jun 2023 02:59:20 +0800
X-OQ-MSGID: <20230611185920.2191-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wen Yang <wenyang.linux@foxmail.com>

Create a uapi header include/uapi/linux/eventfd.h, move the associated
flags to the uapi header, and include it from linux/eventfd.h.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dylan Yudaken <dylany@fb.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Eric Biggers <ebiggers@google.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/eventfd.h      | 16 +---------------
 include/uapi/linux/eventfd.h | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 15 deletions(-)
 create mode 100644 include/uapi/linux/eventfd.h

diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index 98d31cdaca40..c8be8fa6795d 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -9,26 +9,12 @@
 #ifndef _LINUX_EVENTFD_H
 #define _LINUX_EVENTFD_H
 
-#include <linux/fcntl.h>
 #include <linux/wait.h>
 #include <linux/err.h>
 #include <linux/percpu-defs.h>
 #include <linux/percpu.h>
 #include <linux/sched.h>
-
-/*
- * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
- * new flags, since they might collide with O_* ones. We want
- * to re-use O_* flags that couldn't possibly have a meaning
- * from eventfd, in order to leave a free define-space for
- * shared O_* flags.
- */
-#define EFD_SEMAPHORE (1 << 0)
-#define EFD_CLOEXEC O_CLOEXEC
-#define EFD_NONBLOCK O_NONBLOCK
-
-#define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
-#define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
+#include <uapi/linux/eventfd.h>
 
 struct eventfd_ctx;
 struct file;
diff --git a/include/uapi/linux/eventfd.h b/include/uapi/linux/eventfd.h
new file mode 100644
index 000000000000..02e9dcdb8d29
--- /dev/null
+++ b/include/uapi/linux/eventfd.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_EVENTFD_H
+#define _UAPI_LINUX_EVENTFD_H
+
+#include <linux/types.h>
+
+/* For O_CLOEXEC and O_NONBLOCK */
+#include <linux/fcntl.h>
+
+/* For _IO helpers */
+#include <linux/ioctl.h>
+
+/*
+ * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
+ * new flags, since they might collide with O_* ones. We want
+ * to re-use O_* flags that couldn't possibly have a meaning
+ * from eventfd, in order to leave a free define-space for
+ * shared O_* flags.
+ */
+#define EFD_SEMAPHORE (1 << 0)
+#define EFD_CLOEXEC O_CLOEXEC
+#define EFD_NONBLOCK O_NONBLOCK
+
+#define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
+#define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
+
+#endif /* _UAPI_LINUX_EVENTFD_H */
-- 
2.34.1

