Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77957730774
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 20:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjFNSlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 14:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjFNSkt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:40:49 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E5B1BF9;
        Wed, 14 Jun 2023 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1686768038;
        bh=4CJx16EcnxgGxbCniEZqiBh3CmXAUAC3svoc61S+bmQ=;
        h=From:To:Cc:Subject:Date;
        b=RR6eWYlZAbKfJ1rlTG8DUddW6d3+4amJJ6vtJgYOYXxFNZrJlDIV90a7dp4ZrbB8v
         BfKvRduvUi+gUI6D8UMKOGtuwVB1Opf7xRV0Vm0Gjl5Q0+4o5f4dvnkSkLDx8xpsHF
         J2N0W2FY7+/0Ys6PpJDqbJAcpIdkLcbanBTLLxNU=
Received: from localhost.localdomain ([240e:331:cd5:3100:8cae:648b:2ef1:ffd3])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id A2183CA7; Thu, 15 Jun 2023 02:40:33 +0800
X-QQ-mid: xmsmtpt1686768033tx0ydgox7
Message-ID: <tencent_2B6A999A23E86E522D5D9859D54FFCF9AA05@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBncuUbxXFrp32bPaETF/K0fcznOJ2QI/eoK+AaYXcnfqSnMWtWW1
         S7obPgBCsv9e6TeQYAUNEkTC5juZVuGIPrQRluwgUlUC+y1n75crlYC4SDf3i8q1KMJXjnswDB8F
         2OuT3Ra3bHih3uiyvTw+darhYvL4v9wLBaABNfB1JjDgcvX0IbnMZAUwaWlCqOUREBdmB0Zt5/5z
         ai+nonC1dc0EDRaN8cRiaNgX85MjBrcr2aDdXY00p6Hvau27kaCe1Us7CgZyQV+WoTDqvZUFBaNz
         yiDeLaPMJGfz3QyzXNXKvEc3clNmhuBJ4IaHOCRZ8fBMmnHdJy87ivOmyyH8TVT7cOppeI7ErUwc
         bSZQ/RBwXT0ADdix8Oik61O2JOgDKUpmhHTCkyWAlxMMDI+wqWWeH1HAy2aEQNFanSvHhyXFBNs3
         M+BjFog9OHG2UrwHyzHW5RC2crxWEfQeHYOqStU74jnEeR17KX4MHRTIB5GNv+mczMjhanoDOWA3
         FZcJNTS+on3k6Wh4BYAMkiZpg6u+ymaPTZDR3MSs7ILm0VMdBfpGGU16CqEVGL5hTvon3UnVn4hr
         VJpjRlHIWpeck+ev+1SnZP4jEBJzeqyqc5H8qukIAiX/z+67RE08Dcy6CEGTUGHjvVPmCzWjbiom
         2YdBP8/2ZIknKMDWTj1tClIKroS0tp/gXOfjEuMeDFYQrcR2OHBHc8d6yAIyMNTZCgxxgRx1SmCs
         2jwDdiEkrMzs2eEE+g75Bjk1+0TRAamcQOe1AXvjsornWtXRSDw7IslQTPe/7H5xYPvgx1riAXJ9
         NCUDmcjV90DdjM2sIVn951lAxmBA/R08Kxl8mbeMxkqQF39IQMGrGVso3BbLIXdpRvin0yt0Skk/
         epYa42Dq1HStx3fOMXrbe4iIBEXMeRlxdLRgYq3+dP6RIwMj2Yhpbsf3R+9d2YEBsCo4/mxa/j+e
         pFmqpt8qohGjxYDogvfZRH78U3eQ5HiTPg5M/94iMAp86lbzxwZx3i4pWRCZqDnzwDT3tbSpbOU+
         Fe8BkLzKLwEcGWIHOZmZyC4p3OxYU=
X-QQ-XMAILREADINFO: Nho4V/E0OEdrqQ11svVYjpA=
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
Subject: [PATCH v3] eventfd: add a uapi header for eventfd userspace APIs
Date:   Thu, 15 Jun 2023 02:40:28 +0800
X-OQ-MSGID: <20230614184028.207757-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wen Yang <wenyang.linux@foxmail.com>

Create a uapi header include/uapi/linux/eventfd.h, move the associated
flags to the uapi header, and include it from linux/eventfd.h.

Suggested-by: Christian Brauner <brauner@kernel.org>
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
v3: remove types.h that is not needed now
v2: improve the code based on Christian's suggestions

 include/linux/eventfd.h      |  6 +-----
 include/uapi/linux/eventfd.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)
 create mode 100644 include/uapi/linux/eventfd.h

diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index 98d31cdaca40..b9d83652c097 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -9,12 +9,12 @@
 #ifndef _LINUX_EVENTFD_H
 #define _LINUX_EVENTFD_H
 
-#include <linux/fcntl.h>
 #include <linux/wait.h>
 #include <linux/err.h>
 #include <linux/percpu-defs.h>
 #include <linux/percpu.h>
 #include <linux/sched.h>
+#include <uapi/linux/eventfd.h>
 
 /*
  * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
@@ -23,10 +23,6 @@
  * from eventfd, in order to leave a free define-space for
  * shared O_* flags.
  */
-#define EFD_SEMAPHORE (1 << 0)
-#define EFD_CLOEXEC O_CLOEXEC
-#define EFD_NONBLOCK O_NONBLOCK
-
 #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
 #define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
 
diff --git a/include/uapi/linux/eventfd.h b/include/uapi/linux/eventfd.h
new file mode 100644
index 000000000000..2eb9ab6c32f3
--- /dev/null
+++ b/include/uapi/linux/eventfd.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_EVENTFD_H
+#define _UAPI_LINUX_EVENTFD_H
+
+#include <linux/fcntl.h>
+
+#define EFD_SEMAPHORE (1 << 0)
+#define EFD_CLOEXEC O_CLOEXEC
+#define EFD_NONBLOCK O_NONBLOCK
+
+#endif /* _UAPI_LINUX_EVENTFD_H */
-- 
2.25.1

