Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45EEF16171E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbgBQQMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47412 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729723AbgBQQMi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8ve1EdRGT1AOdRBBer85+9QRZqy+lJPvusfJVzOT22E=; b=NK5G7rjy/2utgRFINiJJInCGhW
        RuRc3TtcskV73Vl+cJD+ZToPaAl9y73ZpUp8WKmV+okPqje3UNvpHQQfNrnY3mtZ4lLTXeQYuW2Yt
        fn6n60qGx+HNzMR0sRu2kY251Pw+UeD2CuW4Cgy8A7tRpKvp7ldXWnNviTzPGBQrFGTPOxF9VuoyL
        S6d7b3H9btpQfAaLgvaDhqrwGyvuDtmsKto/AYIWWuAKJF/BcBjbWg2RBWzc/PDdPs3U5KvZaH0N6
        447mi5czOtSC/zj1xvSr+cgaF0XOmSiBRyD61bvTYXlSmbX7iJ6SPXOfLBzneuHBky5xE1H90qNNx
        4nCY/xGg==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006uX-3Z; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0Z-000fZr-Vl; Mon, 17 Feb 2020 17:12:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH 12/44] docs: filesystems: convert dlmfs.txt to ReST
Date:   Mon, 17 Feb 2020 17:11:58 +0100
Message-Id: <efc9e59925723e17d1a4741b11049616c221463e.1581955849.git.mchehab+huawei@kernel.org>
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
- Use copyright symbol;
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add table markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{dlmfs.txt => dlmfs.rst}      | 28 +++++++++++++------
 Documentation/filesystems/index.rst           |  1 +
 2 files changed, 20 insertions(+), 9 deletions(-)
 rename Documentation/filesystems/{dlmfs.txt => dlmfs.rst} (86%)

diff --git a/Documentation/filesystems/dlmfs.txt b/Documentation/filesystems/dlmfs.rst
similarity index 86%
rename from Documentation/filesystems/dlmfs.txt
rename to Documentation/filesystems/dlmfs.rst
index fcf4d509d118..68daaa7facf9 100644
--- a/Documentation/filesystems/dlmfs.txt
+++ b/Documentation/filesystems/dlmfs.rst
@@ -1,20 +1,25 @@
-dlmfs
-==================
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+=====
+DLMFS
+=====
+
 A minimal DLM userspace interface implemented via a virtual file
 system.
 
 dlmfs is built with OCFS2 as it requires most of its infrastructure.
 
-Project web page:    http://ocfs2.wiki.kernel.org
-Tools web page:      https://github.com/markfasheh/ocfs2-tools
-OCFS2 mailing lists: http://oss.oracle.com/projects/ocfs2/mailman/
+:Project web page:    http://ocfs2.wiki.kernel.org
+:Tools web page:      https://github.com/markfasheh/ocfs2-tools
+:OCFS2 mailing lists: http://oss.oracle.com/projects/ocfs2/mailman/
 
 All code copyright 2005 Oracle except when otherwise noted.
 
-CREDITS
+Credits
 =======
 
-Some code taken from ramfs which is Copyright (C) 2000 Linus Torvalds
+Some code taken from ramfs which is Copyright |copy| 2000 Linus Torvalds
 and Transmeta Corp.
 
 Mark Fasheh <mark.fasheh@oracle.com>
@@ -96,14 +101,19 @@ operation. If the lock succeeds, you'll get an fd.
 open(2) with O_CREAT to ensure the resource inode is created - dlmfs does
 not automatically create inodes for existing lock resources.
 
+============  ===========================
 Open Flag     Lock Request Type
----------     -----------------
+============  ===========================
 O_RDONLY      Shared Read
 O_RDWR        Exclusive
+============  ===========================
 
+
+============  ===========================
 Open Flag     Resulting Locking Behavior
----------     --------------------------
+============  ===========================
 O_NONBLOCK    Trylock operation
+============  ===========================
 
 You must provide exactly one of O_RDONLY or O_RDWR.
 
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index ab3b656bbe60..c6885c7ef781 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -58,6 +58,7 @@ Documentation for filesystem implementations.
    ceph
    cramfs
    debugfs
+   dlmfs
    fuse
    overlayfs
    virtiofs
-- 
2.24.1

