Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 766B216176B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbgBQQNP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:13:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47152 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbgBQQMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Mlp2YudsgKj01KT2PuaX4p7SmB2D+Sxh5I7uxx47ouU=; b=HmBQfdJCJ+NPAgO1L03d9A3wSp
        TZVXNHo1mmtHnNOYUHS5ErADQDwTYoSsnj7hiezvLE9vyUhlMiFdvRK/vwbRuPMfAWu2UG0ACZ1SU
        +fJy2tEu6IYsDYJwG4UUZbelJpFZPWKssIttZqhQWd9Rs0iR2Xv8yLm+KVqbLb5critWcmjR2HetN
        xDhLdd38SC6JzStItGOIiMjx8xTqjzqaCWoG4vSvTfC91oCep1u0IBXwsHOxSl/uVNcEnQtkkYryv
        mx3zcd+c6dl8z97WJS+GKvji/xxJkaeGvyDrwoqBnaS0rVp4JS8cX5+6fiietDRnGkhGgsOP/2/e6
        Qxs4zg7A==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006uk-FT; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0a-000fah-HZ; Mon, 17 Feb 2020 17:12:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 22/44] docs: filesystems: convert hfs.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:08 +0100
Message-Id: <8a625d6652d88809730020048d26c3b9333ddbdf.1581955849.git.mchehab+huawei@kernel.org>
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
- Adjust document and section titles;
- Use notes markups;
- Add lists markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{hfs.txt => hfs.rst}          | 23 +++++++++++--------
 Documentation/filesystems/index.rst           |  1 +
 2 files changed, 15 insertions(+), 9 deletions(-)
 rename Documentation/filesystems/{hfs.txt => hfs.rst} (80%)

diff --git a/Documentation/filesystems/hfs.txt b/Documentation/filesystems/hfs.rst
similarity index 80%
rename from Documentation/filesystems/hfs.txt
rename to Documentation/filesystems/hfs.rst
index d096df6db07a..ab17a005e9b1 100644
--- a/Documentation/filesystems/hfs.txt
+++ b/Documentation/filesystems/hfs.rst
@@ -1,11 +1,16 @@
-Note: This filesystem doesn't have a maintainer.
+.. SPDX-License-Identifier: GPL-2.0
 
+==================================
 Macintosh HFS Filesystem for Linux
 ==================================
 
-HFS stands for ``Hierarchical File System'' and is the filesystem used
+
+.. Note:: This filesystem doesn't have a maintainer.
+
+
+HFS stands for ``Hierarchical File System`` and is the filesystem used
 by the Mac Plus and all later Macintosh models.  Earlier Macintosh
-models used MFS (``Macintosh File System''), which is not supported,
+models used MFS (``Macintosh File System``), which is not supported,
 MacOS 8.1 and newer support a filesystem called HFS+ that's similar to
 HFS but is extended in various areas.  Use the hfsplus filesystem driver
 to access such filesystems from Linux.
@@ -49,25 +54,25 @@ Writing to HFS Filesystems
 HFS is not a UNIX filesystem, thus it does not have the usual features you'd
 expect:
 
- o You can't modify the set-uid, set-gid, sticky or executable bits or the uid
+ * You can't modify the set-uid, set-gid, sticky or executable bits or the uid
    and gid of files.
- o You can't create hard- or symlinks, device files, sockets or FIFOs.
+ * You can't create hard- or symlinks, device files, sockets or FIFOs.
 
 HFS does on the other have the concepts of multiple forks per file.  These
 non-standard forks are represented as hidden additional files in the normal
 filesystems namespace which is kind of a cludge and makes the semantics for
 the a little strange:
 
- o You can't create, delete or rename resource forks of files or the
+ * You can't create, delete or rename resource forks of files or the
    Finder's metadata.
- o They are however created (with default values), deleted and renamed
+ * They are however created (with default values), deleted and renamed
    along with the corresponding data fork or directory.
- o Copying files to a different filesystem will loose those attributes
+ * Copying files to a different filesystem will loose those attributes
    that are essential for MacOS to work.
 
 
 Creating HFS filesystems
-===================================
+========================
 
 The hfsutils package from Robert Leslie contains a program called
 hformat that can be used to create HFS filesystem. See
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index c351bc8a8c85..f776411340cb 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -67,6 +67,7 @@ Documentation for filesystem implementations.
    f2fs
    gfs2
    gfs2-uevents
+   hfs
    hfsplus
    fuse
    overlayfs
-- 
2.24.1

