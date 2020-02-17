Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96904161769
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbgBQQNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:13:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47174 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbgBQQMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6OBIEyGeC8GGKqnKGwL1+V0v9tkJKSySR1o7CWTaj+Y=; b=O1kOqDcTn4lLO5x8zG6VdNLHV1
        ad8mt3jTMPWEOUZQ2LvGt+rjHTpf78NEf7Rk7XepFltFNoQDBa5p9SYKOlZn7frpHr5VgYWGO0f4M
        Gwcy3FOs3NE3JAT5lT00HIxDUFz8YbvAKn/vrVyXZwACpm8J7/fI7ToKvTqHkSjVYboNwxrNVuiaI
        iuCDP911Lo+uzze1RPoEQFRyGO0xBUl2Yq3g17B5c1BjhPmZaSPrVnM8lMZ4KuXfspgb75ERlR31B
        qsJMO6EZPZXPVqhhF5wioxLGCpaRkdrreeD2eX5BMl7yDFArYavRWmqc1Q3Gnt2zYTF1hVs8UR8WI
        C0Xsy9UA==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006um-I5; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0a-000far-Kn; Mon, 17 Feb 2020 17:12:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 24/44] docs: filesystems: convert inotify.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:10 +0100
Message-Id: <8f846843ecf1914988feb4d001e3a53d27dc1a65.1581955849.git.mchehab+huawei@kernel.org>
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
- Adjust document title;
- Fix list markups;
- Some whitespace fixes and new line breaks;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |  1 +
 .../filesystems/{inotify.txt => inotify.rst}  | 33 ++++++++++++-------
 2 files changed, 23 insertions(+), 11 deletions(-)
 rename Documentation/filesystems/{inotify.txt => inotify.rst} (83%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 3fbe2fa0b5c5..5a737722652c 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -70,6 +70,7 @@ Documentation for filesystem implementations.
    hfs
    hfsplus
    hpfs
+   inotify
    fuse
    overlayfs
    virtiofs
diff --git a/Documentation/filesystems/inotify.txt b/Documentation/filesystems/inotify.rst
similarity index 83%
rename from Documentation/filesystems/inotify.txt
rename to Documentation/filesystems/inotify.rst
index 51f61db787fb..7f7ef8af0e1e 100644
--- a/Documentation/filesystems/inotify.txt
+++ b/Documentation/filesystems/inotify.rst
@@ -1,27 +1,36 @@
-				   inotify
-	    a powerful yet simple file change notification system
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================================================
+Inotify - A Powerful yet Simple File Change Notification System
+===============================================================
 
 
 
 Document started 15 Mar 2005 by Robert Love <rml@novell.com>
+
 Document updated 4 Jan 2015 by Zhang Zhen <zhenzhang.zhang@huawei.com>
-	--Deleted obsoleted interface, just refer to manpages for user interface.
+
+	- Deleted obsoleted interface, just refer to manpages for user interface.
 
 (i) Rationale
 
-Q: What is the design decision behind not tying the watch to the open fd of
+Q:
+   What is the design decision behind not tying the watch to the open fd of
    the watched object?
 
-A: Watches are associated with an open inotify device, not an open file.
+A:
+   Watches are associated with an open inotify device, not an open file.
    This solves the primary problem with dnotify: keeping the file open pins
    the file and thus, worse, pins the mount.  Dnotify is therefore infeasible
    for use on a desktop system with removable media as the media cannot be
    unmounted.  Watching a file should not require that it be open.
 
-Q: What is the design decision behind using an-fd-per-instance as opposed to
+Q:
+   What is the design decision behind using an-fd-per-instance as opposed to
    an fd-per-watch?
 
-A: An fd-per-watch quickly consumes more file descriptors than are allowed,
+A:
+   An fd-per-watch quickly consumes more file descriptors than are allowed,
    more fd's than are feasible to manage, and more fd's than are optimally
    select()-able.  Yes, root can bump the per-process fd limit and yes, users
    can use epoll, but requiring both is a silly and extraneous requirement.
@@ -29,8 +38,8 @@ A: An fd-per-watch quickly consumes more file descriptors than are allowed,
    spaces is thus sensible.  The current design is what user-space developers
    want: Users initialize inotify, once, and add n watches, requiring but one
    fd and no twiddling with fd limits.  Initializing an inotify instance two
-   thousand times is silly.  If we can implement user-space's preferences 
-   cleanly--and we can, the idr layer makes stuff like this trivial--then we 
+   thousand times is silly.  If we can implement user-space's preferences
+   cleanly--and we can, the idr layer makes stuff like this trivial--then we
    should.
 
    There are other good arguments.  With a single fd, there is a single
@@ -65,9 +74,11 @@ A: An fd-per-watch quickly consumes more file descriptors than are allowed,
    need not be a one-fd-per-process mapping; it is one-fd-per-queue and a
    process can easily want more than one queue.
 
-Q: Why the system call approach?
+Q:
+   Why the system call approach?
 
-A: The poor user-space interface is the second biggest problem with dnotify.
+A:
+   The poor user-space interface is the second biggest problem with dnotify.
    Signals are a terrible, terrible interface for file notification.  Or for
    anything, for that matter.  The ideal solution, from all perspectives, is a
    file descriptor-based one that allows basic file I/O and poll/select.
-- 
2.24.1

