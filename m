Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A341BB011
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 23:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgD0VR0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 17:17:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgD0VR0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:17:26 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C1A021D79;
        Mon, 27 Apr 2020 21:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588022244;
        bh=yz+D7iVuh5MZRcPLv2I33NXwj3NBarP44LcAmlrDVsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MAtUelUlowEBDiiYM9Tbi4nmOvT3taOzq63y3ASn44HiLFkF7zFJsKk1jL/vWAOtb
         N4oD4bLqQ1MPW+lAIdLZI8O3dXbYB3ibpQflpK/3QbaiECAR3AkVvvWvD5bzzlTXeo
         n395gqnZJKVekm5aKksIJd/6KNGlXC2T7O3EEh4k=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jTB7y-000HkT-K7; Mon, 27 Apr 2020 23:17:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 11/29] docs: filesystems: convert dnotify.txt to ReST
Date:   Mon, 27 Apr 2020 23:17:03 +0200
Message-Id: <b39d6430d1c28438e833f01cb4597eff78703c75.1588021877.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588021877.git.mchehab+huawei@kernel.org>
References: <cover.1588021877.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

- Add a SPDX header;
- Add a document title;
- Some whitespace fixes and new line breaks;
- Add table markups;
- Add it to filesystems/index.rst

Acked-by: Jan Kara <jack@suse.cz>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{dnotify.txt => dnotify.rst}          | 11 ++++++++---
 Documentation/filesystems/index.rst                   |  1 +
 MAINTAINERS                                           |  2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)
 rename Documentation/filesystems/{dnotify.txt => dnotify.rst} (90%)

diff --git a/Documentation/filesystems/dnotify.txt b/Documentation/filesystems/dnotify.rst
similarity index 90%
rename from Documentation/filesystems/dnotify.txt
rename to Documentation/filesystems/dnotify.rst
index 08d575ece45d..a28a1f9ef79c 100644
--- a/Documentation/filesystems/dnotify.txt
+++ b/Documentation/filesystems/dnotify.rst
@@ -1,5 +1,8 @@
-		Linux Directory Notification
-		============================
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+Linux Directory Notification
+============================
 
 	   Stephen Rothwell <sfr@canb.auug.org.au>
 
@@ -12,6 +15,7 @@ being delivered using signals.
 The application decides which "events" it wants to be notified about.
 The currently defined events are:
 
+	=========	=====================================================
 	DN_ACCESS	A file in the directory was accessed (read)
 	DN_MODIFY	A file in the directory was modified (write,truncate)
 	DN_CREATE	A file was created in the directory
@@ -19,6 +23,7 @@ The currently defined events are:
 	DN_RENAME	A file in the directory was renamed
 	DN_ATTRIB	A file in the directory had its attributes
 			changed (chmod,chown)
+	=========	=====================================================
 
 Usually, the application must reregister after each notification, but
 if DN_MULTISHOT is or'ed with the event mask, then the registration will
@@ -36,7 +41,7 @@ especially important if DN_MULTISHOT is specified.  Note that SIGRTMIN
 is often blocked, so it is better to use (at least) SIGRTMIN + 1.
 
 Implementation expectations (features and bugs :-))
----------------------------
+---------------------------------------------------
 
 The notification should work for any local access to files even if the
 actual file system is on a remote server.  This implies that remote
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 10207f158a3e..8f26f1b91e04 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -25,6 +25,7 @@ algorithms work.
    locking
    directory-locking
    devpts
+   dnotify
 
    automount-support
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 7d26487c55cf..36d1fd48b6b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5007,7 +5007,7 @@ M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
-F:	Documentation/filesystems/dnotify.txt
+F:	Documentation/filesystems/dnotify.rst
 F:	fs/notify/dnotify/
 F:	include/linux/dnotify.h
 
-- 
2.25.4

