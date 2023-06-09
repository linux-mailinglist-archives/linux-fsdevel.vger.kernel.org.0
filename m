Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4078D72995B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 14:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239567AbjFIMQ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 08:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbjFIMQy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:16:54 -0400
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353921A2;
        Fri,  9 Jun 2023 05:16:51 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id DF7664250A;
        Fri,  9 Jun 2023 08:09:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1686312545;
        bh=eEtat5a3MMNeh43h2xdMlC3WmW17Blxcz/l7KSWKamY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=fSCf4EZ53FZMFehcTV3p9rcqoLggd8vuJta+Q3cNL/2kVGFlRvxveTvhADWW8Za5B
         khmbGzyUDwbRhgJ19szYUDv7Wt85jm8yitxUZ59WZFkBRtfE9jnj6kV6yga5I/Wwe+
         O5lef1lJMu/JZCltitPO8HuS9ZQQOfypNulznt0uu+ccCwpzXaKg+XzFnu1LJFDezk
         1tKxfVC8wOjnebfdDDT0HKQamifpHLmPFuf5XK3aeuyYEQyk32TjDsI2X1DdDRoCRR
         mSaxiwMH5fbHrZE+SpiMt70Y5t4VTHM1XuCxt5RPygjJmp9lJzTQ0QEkhlqq9MJhHr
         TWaCJ8Qpj63vw==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 9 Jun 2023 14:09:03 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <hch@infradead.org>, <corbet@lwn.net>,
        <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <willy@infradead.org>, <dlemoal@kernel.org>, <wsa@kernel.org>,
        <heikki.krogerus@linux.intel.com>, <ming.lei@redhat.com>,
        <gregkh@linuxfoundation.org>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <sergei.shtepa@veeam.com>
Subject: [PATCH v4 11/11] blksnap: Kconfig and Makefile
Date:   Fri, 9 Jun 2023 13:58:58 +0200
Message-ID: <20230609115858.4737-11-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230609115858.4737-1-sergei.shtepa@veeam.com>
References: <20230609115858.4737-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031554627C6B
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allows to build a module and add the blksnap to the kernel tree.

Co-developed-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/Kconfig          |  2 ++
 drivers/block/Makefile         |  2 ++
 drivers/block/blksnap/Kconfig  | 12 ++++++++++++
 drivers/block/blksnap/Makefile | 15 +++++++++++++++
 4 files changed, 31 insertions(+)
 create mode 100644 drivers/block/blksnap/Kconfig
 create mode 100644 drivers/block/blksnap/Makefile

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 5b9d4aaebb81..74d2d55526a3 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -404,4 +404,6 @@ config BLKDEV_UBLK_LEGACY_OPCODES

 source "drivers/block/rnbd/Kconfig"

+source "drivers/block/blksnap/Kconfig"
+
 endif # BLK_DEV
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 101612cba303..9a2a9a56a247 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -40,3 +40,5 @@ obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
 obj-$(CONFIG_BLK_DEV_UBLK)			+= ublk_drv.o

 swim_mod-y	:= swim.o swim_asm.o
+
+obj-$(CONFIG_BLKSNAP) += blksnap/
diff --git a/drivers/block/blksnap/Kconfig b/drivers/block/blksnap/Kconfig
new file mode 100644
index 000000000000..14081359847b
--- /dev/null
+++ b/drivers/block/blksnap/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Block device snapshot module configuration
+#
+
+config BLKSNAP
+	tristate "Block Devices Snapshots Module (blksnap)"
+	help
+	  Allow to create snapshots and track block changes for block devices.
+	  Designed for creating backups for simple block devices. Snapshots are
+	  temporary and are released then backup is completed. Change block
+	  tracking allows to create incremental or differential backups.
diff --git a/drivers/block/blksnap/Makefile b/drivers/block/blksnap/Makefile
new file mode 100644
index 000000000000..8d528b95579a
--- /dev/null
+++ b/drivers/block/blksnap/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+
+blksnap-y := 		\
+	cbt_map.o	\
+	chunk.o		\
+	diff_area.o	\
+	diff_buffer.o	\
+	diff_storage.o	\
+	event_queue.o	\
+	main.o		\
+	snapimage.o	\
+	snapshot.o	\
+	tracker.o
+
+obj-$(CONFIG_BLKSNAP)	 += blksnap.o
--
2.20.1

