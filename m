Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4576D72C67B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 15:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjFLNxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 09:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbjFLNxJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:53:09 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B4A10EB;
        Mon, 12 Jun 2023 06:53:05 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 7C25741AF0;
        Mon, 12 Jun 2023 09:53:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1686577983;
        bh=ugxVl7Zf6JxnwJk4+LT20nHkkRjvyXw6j21wQSIhSbA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=YikgQXjRpuA6+lHoKNJy5YHmrzLSHqwxdydV+Z/BXq6oJdGTH9D7IHLM+LvNyuXEg
         hRluNcX6HtVf3NMjDE5r8PQMs2eGHbvx9fzFRtvu+CGgSIiPdjRYwnKq4A+Z7uaFQp
         gzzA46yOutc9BHjwoV2OuEeGKPT2sPc3UibFzrTECcvFFt5FpEuZ2rFm7iOj6lgzCl
         Espnh3TXHM1/47zR5RTPUYyw/y6Mgkv08blzDjGWd0CEyWvL7aIUCQeyFYBcdTy4eG
         M1muYKcqJ8mCIVE1OP69l+4gw6IWkaWv9nMI85SBY12kEBHkxNM69SmW5fxjEb6LJN
         OIPksPlrx3lnQ==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 12 Jun 2023 15:53:01 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <hch@infradead.org>, <corbet@lwn.net>,
        <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <dchinner@redhat.com>, <willy@infradead.org>, <dlemoal@kernel.org>,
        <linux@weissschuh.net>, <jack@suse.cz>, <ming.lei@redhat.com>,
        <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sergei.shtepa@veeam.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v5 01/11] documentation: Block Device Filtering Mechanism
Date:   Mon, 12 Jun 2023 15:52:18 +0200
Message-ID: <20230612135228.10702-2-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230612135228.10702-1-sergei.shtepa@veeam.com>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29240315546D776B
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The document contains:
* Describes the purpose of the mechanism
* A little historical background on the capabilities of handling I/O
  units of the Linux kernel
* Brief description of the design
* Reference to interface description

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 Documentation/block/blkfilter.rst | 64 +++++++++++++++++++++++++++++++
 Documentation/block/index.rst     |  1 +
 MAINTAINERS                       |  6 +++
 3 files changed, 71 insertions(+)
 create mode 100644 Documentation/block/blkfilter.rst

diff --git a/Documentation/block/blkfilter.rst b/Documentation/block/blkfilter.rst
new file mode 100644
index 000000000000..555625789244
--- /dev/null
+++ b/Documentation/block/blkfilter.rst
@@ -0,0 +1,64 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================
+Block Device Filtering Mechanism
+================================
+
+The block device filtering mechanism is an API that allows to attach block
+device filters. Block device filters allow perform additional processing
+for I/O units.
+
+Introduction
+============
+
+The idea of handling I/O units on block devices is not new. Back in the
+2.6 kernel, there was an undocumented possibility of handling I/O units
+by substituting the make_request_fn() function, which belonged to the
+request_queue structure. But none of the in-tree kernel modules used this
+feature, and it was eliminated in the 5.10 kernel.
+
+The block device filtering mechanism returns the ability to handle I/O units.
+It is possible to safely attach filter to a block device "on the fly" without
+changing the structure of block devices stack.
+
+It supports attaching one filter to one block device, because there is only
+one filter implementation in the kernel yet.
+See Documentation/block/blksnap.rst.
+
+Design
+======
+
+The block device filtering mechanism provides registration and unregistration
+for filter operations. The struct blkfilter_operations contains a pointer to
+the callback functions for the filter. After registering the filter operations,
+filter can be managed using block device ioctl BLKFILTER_ATTACH,
+BLKFILTER_DETACH and BLKFILTER_CTL.
+
+When the filter is attached, the callback function is called for each I/O unit
+for a block device, providing I/O unit filtering. Depending on the result of
+filtering the I/O unit, it can either be passed for subsequent processing by
+the block layer, or skipped.
+
+The filter can be implemented as a loadable module. In this case, the filter
+module cannot be unloaded while the filter is attached to at least one of the
+block devices.
+
+Interface description
+=====================
+
+The ioctl BLKFILTER_ATTACH and BLKFILTER_DETACH use structure blkfilter_name.
+It allows to attach a filter to a block device or detach it.
+
+The ioctl BLKFILTER_CTL use structure blkfilter_ctl. It allows to send a
+filter-specific command.
+
+.. kernel-doc:: include/uapi/linux/blk-filter.h
+
+To register in the system, the filter creates its own account, which contains
+callback functions, unique filter name and module owner. This filter account is
+used by the registration functions.
+
+.. kernel-doc:: include/linux/blk-filter.h
+
+.. kernel-doc:: block/blk-filter.c
+   :export:
diff --git a/Documentation/block/index.rst b/Documentation/block/index.rst
index 9fea696f9daa..e9712f72cd6d 100644
--- a/Documentation/block/index.rst
+++ b/Documentation/block/index.rst
@@ -10,6 +10,7 @@ Block
    bfq-iosched
    biovecs
    blk-mq
+   blkfilter
    cmdline-partition
    data-integrity
    deadline-iosched
diff --git a/MAINTAINERS b/MAINTAINERS
index e0ad886d3163..d801b8985b43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3580,6 +3580,12 @@ M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
 S:	Maintained
 F:	drivers/leds/leds-blinkm.c
 
+BLOCK DEVICE FILTERING MECHANISM
+M:	Sergei Shtepa <sergei.shtepa@veeam.com>
+L:	linux-block@vger.kernel.org
+S:	Supported
+F:	Documentation/block/blkfilter.rst
+
 BLOCK LAYER
 M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-block@vger.kernel.org
-- 
2.20.1

