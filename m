Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC6616171D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgBQQMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47416 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbgBQQMi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2b6OfwcwnNBviMQxJO7IlPr8Nb/dYA3UzzyXiGkkftc=; b=ErYTRfZ1osf9DR8Q7TcAZcwhXp
        85BSjbxlud/e7ApIdeiO2GCK2834LxpgF4VGZzxQNpbxDDF4MCKqcrRbgyQxGtASDjLumH6XnZn21
        rvSRVPydulDK1Z0UlCl6ohNHSr22ed/hidixN23OmfYEtS0FtHKCF/cCN6OzNXAjGJATm5FzR7H+R
        OYZyKWzyIMZttHEO5tOUuV6XbZGTyZl9fxZeuZ1B+hZxI7ghvreHZEsIiiOEhGn5/tG1YUdCTQtKH
        cFnxIenpcpCOFlpph0WmYQybDU8S+X+mQhTdvbbJ8JRAXwWXIBGNHcta5DDV3VHHerfokpUj9eXbC
        T63KKpqg==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006ur-QP; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0a-000fbG-Sw; Mon, 17 Feb 2020 17:12:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH 29/44] docs: filesystems: convert ocfs2.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:15 +0100
Message-Id: <e29a8120bf1d847f23fb68e915f10a7d43bed9e3.1581955849.git.mchehab+huawei@kernel.org>
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
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |  1 +
 .../filesystems/{ocfs2.txt => ocfs2.rst}      | 31 +++++++++++++------
 2 files changed, 22 insertions(+), 10 deletions(-)
 rename Documentation/filesystems/{ocfs2.txt => ocfs2.rst} (88%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index f3a26fdbd04f..3b2b07491c98 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -76,6 +76,7 @@ Documentation for filesystem implementations.
    nilfs2
    nfs/index
    ntfs
+   ocfs2
    ocfs2-online-filecheck
    overlayfs
    virtiofs
diff --git a/Documentation/filesystems/ocfs2.txt b/Documentation/filesystems/ocfs2.rst
similarity index 88%
rename from Documentation/filesystems/ocfs2.txt
rename to Documentation/filesystems/ocfs2.rst
index 4c49e5410595..412386bc6506 100644
--- a/Documentation/filesystems/ocfs2.txt
+++ b/Documentation/filesystems/ocfs2.rst
@@ -1,5 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
 OCFS2 filesystem
-==================
+================
+
 OCFS2 is a general purpose extent based shared disk cluster file
 system with many similarities to ext3. It supports 64 bit inode
 numbers, and has automatically extending metadata groups which may
@@ -14,22 +18,26 @@ OCFS2 mailing lists: http://oss.oracle.com/projects/ocfs2/mailman/
 
 All code copyright 2005 Oracle except when otherwise noted.
 
-CREDITS:
+Credits
+=======
+
 Lots of code taken from ext3 and other projects.
 
 Authors in alphabetical order:
-Joel Becker   <joel.becker@oracle.com>
-Zach Brown    <zach.brown@oracle.com>
-Mark Fasheh   <mfasheh@suse.com>
-Kurt Hackel   <kurt.hackel@oracle.com>
-Tao Ma        <tao.ma@oracle.com>
-Sunil Mushran <sunil.mushran@oracle.com>
-Manish Singh  <manish.singh@oracle.com>
-Tiger Yang    <tiger.yang@oracle.com>
+
+- Joel Becker   <joel.becker@oracle.com>
+- Zach Brown    <zach.brown@oracle.com>
+- Mark Fasheh   <mfasheh@suse.com>
+- Kurt Hackel   <kurt.hackel@oracle.com>
+- Tao Ma        <tao.ma@oracle.com>
+- Sunil Mushran <sunil.mushran@oracle.com>
+- Manish Singh  <manish.singh@oracle.com>
+- Tiger Yang    <tiger.yang@oracle.com>
 
 Caveats
 =======
 Features which OCFS2 does not support yet:
+
 	- Directory change notification (F_NOTIFY)
 	- Distributed Caching (F_SETLEASE/F_GETLEASE/break_lease)
 
@@ -37,8 +45,10 @@ Mount options
 =============
 
 OCFS2 supports the following mount options:
+
 (*) == default
 
+======================= ========================================================
 barrier=1		This enables/disables barriers. barrier=0 disables it,
 			barrier=1 enables it.
 errors=remount-ro(*)	Remount the filesystem read-only on an error.
@@ -104,3 +114,4 @@ journal_async_commit	Commit block can be written to disk without waiting
 			for descriptor blocks. If enabled older kernels cannot
 			mount the device. This will enable 'journal_checksum'
 			internally.
+======================= ========================================================
-- 
2.24.1

