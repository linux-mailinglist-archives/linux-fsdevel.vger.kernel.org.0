Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199E2469984
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 15:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344691AbhLFOz7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 09:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344662AbhLFOzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:55:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D859C061746;
        Mon,  6 Dec 2021 06:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HVyPhoN0G0V8pPJN7QDvhgJ8VtoOcDZqLE/8FLH58Wg=; b=bzbuHVnLiBiirVEcYDdGSmHeHX
        WIrODQpx0Coyjl3oql6uVoCHPyI3XesuHAG7wTU5HdYXGHC6Ir3oLtSjC6XUEx9GG+fLjTajyhaJr
        1II9GxiXv+blSdZusiMaq5oLCx2Z311UlTQEROIXbYZai6BQQUa7vNN67bbsg9FViiIaQBqwhG2QX
        60/5nlP5oYDsms1LNlzXoBIpH7F9q7fvryPHD738VZ0oSU7zaadb299hEL3fHaSJbD7Cstu/84b1M
        hkaaI6e4ScCa/1dB1fgmVd8un/I4bcDSMIKIC7+XhOK0dNnAyxQG8S7kxhmZ+1n3SJBT0wvTMDeFm
        +tnoNWOw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muFLp-004vkH-J5; Mon, 06 Dec 2021 14:52:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-doc@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] iov_iter: Add skeleton documentation
Date:   Mon,  6 Dec 2021 14:52:18 +0000
Message-Id: <20211206145220.1175209-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211206145220.1175209-1-willy@infradead.org>
References: <20211206145220.1175209-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is just somewhere to include the kernel-doc from for now.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/core-api/index.rst    |  1 +
 Documentation/core-api/iov_iter.rst | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 Documentation/core-api/iov_iter.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 5de2c7a4b1b3..082143baa983 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -43,6 +43,7 @@ Library functionality that is used throughout the kernel.
    this_cpu_ops
    timekeeping
    errseq
+   iov_iter
 
 Concurrency primitives
 ======================
diff --git a/Documentation/core-api/iov_iter.rst b/Documentation/core-api/iov_iter.rst
new file mode 100644
index 000000000000..541c16caf958
--- /dev/null
+++ b/Documentation/core-api/iov_iter.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+========
+iov_iter
+========
+
+:Author: Matthew Wilcox
+
+Overview
+========
+
+The iov_iter is used to represent the source or destination for a read or
+write.  It can point to many different kinds of memory, including user
+memory, kernel memory, pipes and biovecs.
+
+Functions and structures
+========================
+
+.. kernel-doc:: include/linux/uio.h
+.. kernel-doc:: lib/iov_iter.c
+   :export:
-- 
2.33.0

