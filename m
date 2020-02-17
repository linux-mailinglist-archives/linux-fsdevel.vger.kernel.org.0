Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA54F161714
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgBQQMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47340 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729723AbgBQQMg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qUV6cuRCVoQrvbcAQsjOrlimenxPDdJsyO20uY0Wv2w=; b=qzuxW3JIPk0pfi2cPHBsawJLm0
        Vh4YlXUzufZvf5IUlOLn3sZiIym44t5Uy0Ys8WMJTvt+/0nRDRPVaAdUg+WZJRdbq15U6zbSWEtPi
        i/9hDWA66+8jQ7GzjIkEkYbul3ypZQShVb7HDlvJyE55kneBDnmQNAvruQv6iMCwXjAOzjJj71Y06
        JMkXIVxVmS1oTMyav/bg3UjFInTOeHv161qb4toAgwMcvqH1H25RVMuKCzA+s/7JAaN86UFPh1vlO
        10PueqseI0NY2RpA4N4M/IOWSQWpcYpOrIZFm7GtUa7p63Pzkxdb4MJCIYZNeFpE5RRW6+PtRAVGS
        VsAGSp4g==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0e-0006uO-3X; Mon, 17 Feb 2020 16:12:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0b-000fcO-FT; Mon, 17 Feb 2020 17:12:33 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: [PATCH 43/44] docs: filesystems: convert udf.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:29 +0100
Message-Id: <2887f8a3a813a31170389eab687e9f199327dc7d.1581955849.git.mchehab+huawei@kernel.org>
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
- Add a document title;
- Add table markups;
- Add lists markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |  1 +
 .../filesystems/{udf.txt => udf.rst}          | 21 +++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)
 rename Documentation/filesystems/{udf.txt => udf.rst} (83%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 58d57c9bf922..ec03cb4d7353 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -92,5 +92,6 @@ Documentation for filesystem implementations.
    tmpfs
    ubifs
    ubifs-authentication.rst
+   udf
    virtiofs
    vfat
diff --git a/Documentation/filesystems/udf.txt b/Documentation/filesystems/udf.rst
similarity index 83%
rename from Documentation/filesystems/udf.txt
rename to Documentation/filesystems/udf.rst
index e2f2faf32f18..d9badbf285b2 100644
--- a/Documentation/filesystems/udf.txt
+++ b/Documentation/filesystems/udf.rst
@@ -1,6 +1,8 @@
-*
-* Documentation/filesystems/udf.txt
-*
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+UDF file system
+===============
 
 If you encounter problems with reading UDF discs using this driver,
 please report them according to MAINTAINERS file.
@@ -18,8 +20,10 @@ performance due to very poor read-modify-write support supplied internally
 by drive firmware.
 
 -------------------------------------------------------------------------------
+
 The following mount options are supported:
 
+	===========	======================================
 	gid=		Set the default group.
 	umask=		Set the default umask.
 	mode=		Set the default file permissions.
@@ -34,6 +38,7 @@ The following mount options are supported:
 	longad		Use long ad's (default)
 	nostrict	Unset strict conformance
 	iocharset=	Set the NLS character set
+	===========	======================================
 
 The uid= and gid= options need a bit more explaining.  They will accept a
 decimal numeric value and all inodes on that mount will then appear as
@@ -47,13 +52,17 @@ the interactive user will always see the files on the disk as belonging to him.
 
 The remaining are for debugging and disaster recovery:
 
-	novrs		Skip volume sequence recognition 
+	=====		================================
+	novrs		Skip volume sequence recognition
+	=====		================================
 
 The following expect a offset from 0.
 
+	==========	=================================================
 	session=	Set the CDROM session (default= last session)
 	anchor=		Override standard anchor location. (default= 256)
 	lastblock=	Set the last block of the filesystem/
+	==========	=================================================
 
 -------------------------------------------------------------------------------
 
@@ -62,5 +71,5 @@ For the latest version and toolset see:
 	https://github.com/pali/udftools
 
 Documentation on UDF and ECMA 167 is available FREE from:
-	http://www.osta.org/
-	http://www.ecma-international.org/
+	- http://www.osta.org/
+	- http://www.ecma-international.org/
-- 
2.24.1

