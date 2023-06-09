Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833DC72995D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 14:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240264AbjFIMQ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 08:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjFIMQy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:16:54 -0400
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010FF185;
        Fri,  9 Jun 2023 05:16:51 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id CA86D42522;
        Fri,  9 Jun 2023 07:59:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1686311958;
        bh=xI5U7I017OidC54JE6H4lbxHIRF0RMUuN/RqLqBQZp8=;
        h=From:To:CC:Subject:Date:From;
        b=Abehoq5oDSasqmcnt/zZf3kO3zp7A+lTkaJymLCxpNoHkBNeeshcfI7Gtg11AVlWv
         +YoNNyiEMjKcgQZ3Lsc5BLwllTFQXlmSWF/DhEd+d6GZ8Y9lKfzBEQxRxuTxmejqkP
         xiy/v1jL7YvyH3ppkZ2nSyhwCcXxZKZ4QCzy9rKJjW7E76wwvwL/vlXsyssApFe9Bg
         ehJAq9BcvN5SY9Mf0VB8DZ+s9R53VhrFXRkqflUFYNn1uK6jH8QrmpcDwsjyAKt42X
         9Xjw/xXhELl/eLWJtzTRzAhWKILDRMQZGKmcrrLPwOv534N6/ob8MTXAS2fOpInub6
         1i8YTLCZ7H0VQ==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 9 Jun 2023 13:59:15 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <hch@infradead.org>, <corbet@lwn.net>,
        <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <willy@infradead.org>, <dlemoal@kernel.org>, <wsa@kernel.org>,
        <heikki.krogerus@linux.intel.com>, <ming.lei@redhat.com>,
        <gregkh@linuxfoundation.org>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <sergei.shtepa@veeam.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v4 01/11] documentation: Block Device Filtering Mechanism
Date:   Fri, 9 Jun 2023 13:58:48 +0200
Message-ID: <20230609115858.4737-1-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
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
index 250518fc70ff..f85f21487364 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3583,6 +3583,12 @@ M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
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

