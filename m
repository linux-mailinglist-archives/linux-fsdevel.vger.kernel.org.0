Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E03672E8FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 19:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjFMREm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 13:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjFMREk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:04:40 -0400
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067B2187;
        Tue, 13 Jun 2023 10:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1686675570;
        bh=wNAYrdR1DOgfCkW7Ui555prk70VUh+otMs+riDcq/LU=;
        h=From:To:Cc:Subject:Date;
        b=yF81Q2UOw0dmjZttica/woTHNAuLSKx7Xjtok6WRTocsDUtqtsyqv9mSXsRQtlx75
         8FDeai+LFGnTdnMqM4wTdK6OUm+99EH6Rq/xxWXXtNb22hYEmcbbNqpSgYrU1aQfHB
         QYcLwvQNpfTvyd3bYMDVjaUxzBvHpu2Yem2ysdlI=
Received: from localhost.localdomain ([240e:331:cc9:d200:8f2b:c42a:801a:dea9])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id EDA2A833; Wed, 14 Jun 2023 00:59:26 +0800
X-QQ-mid: xmsmtpt1686675566tszwp6qrv
Message-ID: <tencent_4AF3548D506B04914F12A49F3093F9C53C0A@qq.com>
X-QQ-XMAILINFO: Nd/Exl7W9DK5dyIyCG8HGgrHUgCDwyaXFvs6r7d1850d0/iaW+4knEO9rE5k3h
         PV29YvKrTadCkphn+eG8Vj9juavj58gdVMhajt7ea9raxEWN3iYABR45kEUeICEaqg6KqpwOrk+3
         loy9BhbhfKTRTZ/1l95aoZ3g1C2Z45BrExV/Shbzuxi6ifLGEP+OGYGuZeUZzLq2VmbSFt3C5fJ9
         KkHYzEVrwmwoSrva+GAKoqvJ5aJnqEa+NnWzqTKYqIOW4kt1aEuMV2dBQ78daEi0UhWYkgtb5Dfe
         jQbdWyN/XptTFYKY/lPFYRk1famBVcgVS2P0Qu0xiCEecftIyp0APs8c6pWehedw148W078AFgzE
         7g/iuauBuEcFDMfpmeQXEagV5Ze5SL9dhCwpWO5/bzdDLB/2OKG6VgK+rK8+jlbHFoK7xuIsE8q3
         pWNmkC3e2N60hujbUUxGXpB/0l7GNVESQEG7Qf3pJIdOZZnJRyz20UA75b8QUoAoTBpwDWRLuveX
         4aeDegkiemsGkSaAM03dWXsMDmpwTVGhCAAmMSF0rSTrPGK1Kyu2Pp3SdI+vT6TS8S7cQEhNThAB
         9OzUZquMgv109OpyQdxsQznyOIpzDmhF9EWapRNrzUtCIu/ejS0A84IJ2SSc07UDxVg98z7Q4JZO
         mBDTW7MKggnjB9N+EmfBC05NJrf+2QfTijoyx/5N3qhepaa1sBU7vscV3nakIhrooVzMVGfEJj2Q
         uK+cOc2zRa82WsKl1aJC2rDmdVUQAG1yye9cPVuyd5jC2xh8wAAQGDc89PSPSbKkp56qPZd8z68M
         kQyVueBKattdjzeOWMcsfnuis0p+EG2BmK+HtwSvtoY0bCzxD8kMHQiwM8VZIoBKlQXdsgf0MySg
         XtOeMM6MOPvpOvF3hdJ2t8HISqkdl1v+wYn8708hWDJnnP3rq5cN2EZX6h/EE8oYSxl6x0V0q9OL
         7zBCKiaH+WyrPvo1MZOfQtEphfARCCivbHg1qoxHNiYX7zSvfqV3uN2FtDa9mVlAPt9RG/cK6mpS
         qolIHWNo/l/oQDbwbM8O5+wMIBSXQ=
X-QQ-XMAILREADINFO: N4rxuMuubwLvS7ommv0RDVk=
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
Subject: [PATCH v2] eventfd: add a uapi header for eventfd userspace APIs
Date:   Wed, 14 Jun 2023 00:59:11 +0800
X-OQ-MSGID: <20230613165911.6703-1-wenyang.linux@foxmail.com>
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
 include/linux/eventfd.h      |  6 +-----
 include/uapi/linux/eventfd.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)
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
index 000000000000..9b3eb6fb20c6
--- /dev/null
+++ b/include/uapi/linux/eventfd.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_EVENTFD_H
+#define _UAPI_LINUX_EVENTFD_H
+
+#include <linux/types.h>
+
+/* For O_CLOEXEC and O_NONBLOCK */
+#include <linux/fcntl.h>
+
+#define EFD_SEMAPHORE (1 << 0)
+#define EFD_CLOEXEC O_CLOEXEC
+#define EFD_NONBLOCK O_NONBLOCK
+
+#endif /* _UAPI_LINUX_EVENTFD_H */
-- 
2.25.1

