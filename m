Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4183A161710
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgBQQMg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47312 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbgBQQMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qbXjqWaMhiEM/3olVTMF2u6QEj84pVI+8DoFQcFxy7Y=; b=aOYuXvgDnMisAm5NyTrGXSBhvH
        1Dg6+YhIyv5gvc3rL+1TO80UF6pY+RcJIdIzwQZoo+RoAkbCDC/ZFEOWRuPk6Vm068Q3m0vnMc0OL
        9/IifVVqWcKs1Fu2WJCcuqrnnC0fTXeFXD7b/ZB2aXOQypyBJWTvmtnLSqKEPYtVMsDcfqjJZyGSX
        3/hHOFDTpUvrYjv8t35PIcadrF73GGdV6uGmrQcimt37KY+O9KQ46uz9nUcL2YTxUD7L8JsYufZoi
        P7gMzM0+e/+oADb0VJAAs7W6GMmC7DH0ul/wuc9TlrGZcjGd6Pf7G0brMUFTnfejYLb9kEOq6TPfE
        3INWn5ug==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0d-0006uT-MF; Mon, 17 Feb 2020 16:12:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0b-000fcE-DM; Mon, 17 Feb 2020 17:12:33 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 41/44] docs: filesystems: convert ubifs-authentication.rst.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:27 +0100
Message-Id: <0c36091b6660cd372f994bd98e1264491d766c22.1581955849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581955849.git.mchehab+huawei@kernel.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

- Add a SPDX header;
- Mark some literals as such;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst                |  1 +
 Documentation/filesystems/ubifs-authentication.rst | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 27d37e7712da..bb14738df358 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -90,5 +90,6 @@ Documentation for filesystem implementations.
    sysfs
    sysv-fs
    tmpfs
+   ubifs-authentication.rst
    virtiofs
    vfat
diff --git a/Documentation/filesystems/ubifs-authentication.rst b/Documentation/filesystems/ubifs-authentication.rst
index 6a9584f6ff46..16efd729bf7c 100644
--- a/Documentation/filesystems/ubifs-authentication.rst
+++ b/Documentation/filesystems/ubifs-authentication.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 :orphan:
 
 .. UBIFS Authentication
@@ -92,11 +94,11 @@ UBIFS Index & Tree Node Cache
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Basic on-flash UBIFS entities are called *nodes*. UBIFS knows different types
-of nodes. Eg. data nodes (`struct ubifs_data_node`) which store chunks of file
-contents or inode nodes (`struct ubifs_ino_node`) which represent VFS inodes.
-Almost all types of nodes share a common header (`ubifs_ch`) containing basic
+of nodes. Eg. data nodes (``struct ubifs_data_node``) which store chunks of file
+contents or inode nodes (``struct ubifs_ino_node``) which represent VFS inodes.
+Almost all types of nodes share a common header (``ubifs_ch``) containing basic
 information like node type, node length, a sequence number, etc. (see
-`fs/ubifs/ubifs-media.h`in kernel source). Exceptions are entries of the LPT
+``fs/ubifs/ubifs-media.h`` in kernel source). Exceptions are entries of the LPT
 and some less important node types like padding nodes which are used to pad
 unusable content at the end of LEBs.
 
-- 
2.24.1

