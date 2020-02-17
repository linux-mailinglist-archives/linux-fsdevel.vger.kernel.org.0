Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69408161754
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgBQQNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:13:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47200 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbgBQQMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/DBUrKI6DpY7GgC4iBLFf7Vw+SvYY8ymToSdulq9HlA=; b=h0AIjeIhPNtrutRLB2PJqARD/f
        czOOJc/Cpamg4l26Wz8OUIhXlcoDyodXu485K3mdgaOsegyJh1me+3dMd2fjAC6CCMws5d2wG4lCL
        LGCddNpaj0Y3GiLtRBAgP5yjddmlLRT0gs4nrJB1FB7S3hnIm9CIoffaB+i4EdMVfAmtT6kupG2L4
        umO6mRysn4U3QtzwpuiCJ2N+K4apZhecu4swEdXa4eNB+Be7Q4/esgymI/su+HloOpPiYmrvLhdGW
        KmuUZNctgqutI3nz1X2foPBWqjskG0RVFpPiTOW+KDLIX+H9XCS0GlcgLvMIF/PYBGVp+lSGoXilT
        Z6K0baiw==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006uq-QM; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0a-000fbB-RF; Mon, 17 Feb 2020 17:12:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 28/44] docs: filesystems: convert ocfs2-online-filecheck.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:14 +0100
Message-Id: <6007166acc3252697755836354bd29b5a5fb82aa.1581955849.git.mchehab+huawei@kernel.org>
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
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |  1 +
 ...lecheck.txt => ocfs2-online-filecheck.rst} | 45 ++++++++++---------
 2 files changed, 26 insertions(+), 20 deletions(-)
 rename Documentation/filesystems/{ocfs2-online-filecheck.txt => ocfs2-online-filecheck.rst} (77%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 62be53c4755d..f3a26fdbd04f 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -76,6 +76,7 @@ Documentation for filesystem implementations.
    nilfs2
    nfs/index
    ntfs
+   ocfs2-online-filecheck
    overlayfs
    virtiofs
    vfat
diff --git a/Documentation/filesystems/ocfs2-online-filecheck.txt b/Documentation/filesystems/ocfs2-online-filecheck.rst
similarity index 77%
rename from Documentation/filesystems/ocfs2-online-filecheck.txt
rename to Documentation/filesystems/ocfs2-online-filecheck.rst
index 139fab175c8a..2257bb53edc1 100644
--- a/Documentation/filesystems/ocfs2-online-filecheck.txt
+++ b/Documentation/filesystems/ocfs2-online-filecheck.rst
@@ -1,5 +1,8 @@
-		    OCFS2 online file check
-		    -----------------------
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+OCFS2 file system - online file check
+=====================================
 
 This document will describe OCFS2 online file check feature.
 
@@ -40,7 +43,7 @@ When there are errors in the OCFS2 filesystem, they are usually accompanied
 by the inode number which caused the error. This inode number would be the
 input to check/fix the file.
 
-There is a sysfs directory for each OCFS2 file system mounting:
+There is a sysfs directory for each OCFS2 file system mounting::
 
   /sys/fs/ocfs2/<devname>/filecheck
 
@@ -50,34 +53,36 @@ communicate with kernel space, tell which file(inode number) will be checked or
 fixed. Currently, three operations are supported, which includes checking
 inode, fixing inode and setting the size of result record history.
 
-1. If you want to know what error exactly happened to <inode> before fixing, do
+1. If you want to know what error exactly happened to <inode> before fixing, do::
 
-  # echo "<inode>" > /sys/fs/ocfs2/<devname>/filecheck/check
-  # cat /sys/fs/ocfs2/<devname>/filecheck/check
+    # echo "<inode>" > /sys/fs/ocfs2/<devname>/filecheck/check
+    # cat /sys/fs/ocfs2/<devname>/filecheck/check
 
-The output is like this:
-  INO		DONE	ERROR
-39502		1	GENERATION
+The output is like this::
 
-<INO> lists the inode numbers.
-<DONE> indicates whether the operation has been finished.
-<ERROR> says what kind of errors was found. For the detailed error numbers,
-please refer to the file linux/fs/ocfs2/filecheck.h.
+    INO		DONE	ERROR
+    39502		1	GENERATION
 
-2. If you determine to fix this inode, do
+    <INO> lists the inode numbers.
+    <DONE> indicates whether the operation has been finished.
+    <ERROR> says what kind of errors was found. For the detailed error numbers,
+    please refer to the file linux/fs/ocfs2/filecheck.h.
 
-  # echo "<inode>" > /sys/fs/ocfs2/<devname>/filecheck/fix
-  # cat /sys/fs/ocfs2/<devname>/filecheck/fix
+2. If you determine to fix this inode, do::
 
-The output is like this:
-  INO		DONE	ERROR
-39502		1	SUCCESS
+    # echo "<inode>" > /sys/fs/ocfs2/<devname>/filecheck/fix
+    # cat /sys/fs/ocfs2/<devname>/filecheck/fix
+
+The output is like this:::
+
+    INO		DONE	ERROR
+    39502		1	SUCCESS
 
 This time, the <ERROR> column indicates whether this fix is successful or not.
 
 3. The record cache is used to store the history of check/fix results. It's
 default size is 10, and can be adjust between the range of 10 ~ 100. You can
-adjust the size like this:
+adjust the size like this::
 
   # echo "<size>" > /sys/fs/ocfs2/<devname>/filecheck/set
 
-- 
2.24.1

