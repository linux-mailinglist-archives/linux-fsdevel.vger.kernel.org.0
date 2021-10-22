Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837DE437CEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 20:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhJVTCH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231627AbhJVTBj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4OcAD/E1FGoKI+vM6y5NNdUST1kBaGZ99sWmiGDdn6E=;
        b=f/KCNMLIsOjPxF8bvkaYBwh1OnRdJShmzRlU8QofbUi7Bb1LS1dyIMjJ6vpaDAjJOAI6XH
        7t1vlc8AW25A1OuG41qB+1ztSNke286/gMzsT1il8SI4HqXfYnhKpyEQEvGtzIbfawucTv
        g0PR5ZU1ZKaNxigXiaCq2Jhv0A3UF8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-ZCmLQDUOPZuReETue5VksA-1; Fri, 22 Oct 2021 14:59:18 -0400
X-MC-Unique: ZCmLQDUOPZuReETue5VksA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42C4E1005E4D;
        Fri, 22 Oct 2021 18:59:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99CF519D9B;
        Fri, 22 Oct 2021 18:59:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 02/53] fscache_old: Rename CONFIG_FSCACHE* to
 CONFIG_FSCACHE_OLD*
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Oct 2021 19:59:07 +0100
Message-ID: <163492914774.1038219.6296963451396706478.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename the CONFIG_FSCACHE* config symbols to CONFIG_FSCACHE_OLD*.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/9p/Kconfig             |    2 +-
 fs/Makefile               |    2 +-
 fs/afs/Kconfig            |    2 +-
 fs/cachefiles/Kconfig     |    2 +-
 fs/ceph/Kconfig           |    2 +-
 fs/cifs/Kconfig           |    2 +-
 fs/fscache_old/Kconfig    |   12 ++++++------
 fs/fscache_old/Makefile   |    4 ++--
 fs/fscache_old/internal.h |    4 ++--
 fs/fscache_old/object.c   |    2 +-
 fs/fscache_old/proc.c     |   12 ++++++------
 fs/nfs/Kconfig            |    2 +-
 12 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/9p/Kconfig b/fs/9p/Kconfig
index d7bc93447c85..b11c15c30bac 100644
--- a/fs/9p/Kconfig
+++ b/fs/9p/Kconfig
@@ -14,7 +14,7 @@ config 9P_FS
 if 9P_FS
 config 9P_FSCACHE
 	bool "Enable 9P client caching support"
-	depends on 9P_FS=m && FSCACHE || 9P_FS=y && FSCACHE=y
+	depends on 9P_FS=m && FSCACHE_OLD || 9P_FS=y && FSCACHE_OLD=y
 	help
 	  Choose Y here to enable persistent, read-only local
 	  caching support for 9p clients using FS-Cache
diff --git a/fs/Makefile b/fs/Makefile
index 8b87c9406ecc..21cf51dbf8b2 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -67,7 +67,7 @@ obj-$(CONFIG_DLM)		+= dlm/
  
 # Do not add any filesystems before this line
 obj-$(CONFIG_NETFS_SUPPORT)	+= netfs/
-obj-$(CONFIG_FSCACHE)		+= fscache_old/
+obj-$(CONFIG_FSCACHE_OLD)	+= fscache_old/
 obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
 obj-$(CONFIG_EXT4_FS)		+= ext4/
 # We place ext4 before ext2 so that clean ext3 root fs's do NOT mount using the
diff --git a/fs/afs/Kconfig b/fs/afs/Kconfig
index fc8ba9142f2f..dbb1ee5fb261 100644
--- a/fs/afs/Kconfig
+++ b/fs/afs/Kconfig
@@ -25,7 +25,7 @@ config AFS_DEBUG
 
 config AFS_FSCACHE
 	bool "Provide AFS client caching support"
-	depends on AFS_FS=m && FSCACHE || AFS_FS=y && FSCACHE=y
+	depends on AFS_FS=m && FSCACHE_OLD || AFS_FS=y && FSCACHE_OLD=y
 	help
 	  Say Y here if you want AFS data to be cached locally on disk through
 	  the generic filesystem cache manager
diff --git a/fs/cachefiles/Kconfig b/fs/cachefiles/Kconfig
index 6827b40f7ddc..7f3e1881fb21 100644
--- a/fs/cachefiles/Kconfig
+++ b/fs/cachefiles/Kconfig
@@ -2,7 +2,7 @@
 
 config CACHEFILES
 	tristate "Filesystem caching on files"
-	depends on FSCACHE && BLOCK
+	depends on FSCACHE_OLD && BLOCK
 	help
 	  This permits use of a mounted filesystem as a cache for other
 	  filesystems - primarily networking filesystems - thus allowing fast
diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
index 94df854147d3..77ad452337ee 100644
--- a/fs/ceph/Kconfig
+++ b/fs/ceph/Kconfig
@@ -21,7 +21,7 @@ config CEPH_FS
 if CEPH_FS
 config CEPH_FSCACHE
 	bool "Enable Ceph client caching support"
-	depends on CEPH_FS=m && FSCACHE || CEPH_FS=y && FSCACHE=y
+	depends on CEPH_FS=m && FSCACHE_OLD || CEPH_FS=y && FSCACHE_OLD=y
 	help
 	  Choose Y here to enable persistent, read-only local
 	  caching support for Ceph clients using FS-Cache
diff --git a/fs/cifs/Kconfig b/fs/cifs/Kconfig
index 3b7e3b9e4fd2..c5477abbcff0 100644
--- a/fs/cifs/Kconfig
+++ b/fs/cifs/Kconfig
@@ -188,7 +188,7 @@ config CIFS_SMB_DIRECT
 
 config CIFS_FSCACHE
 	bool "Provide CIFS client caching support"
-	depends on CIFS=m && FSCACHE || CIFS=y && FSCACHE=y
+	depends on CIFS=m && FSCACHE_OLD || CIFS=y && FSCACHE_OLD=y
 	help
 	  Makes CIFS FS-Cache capable. Say Y here if you want your CIFS data
 	  to be cached locally on disk through the general filesystem cache
diff --git a/fs/fscache_old/Kconfig b/fs/fscache_old/Kconfig
index b313a978ae0a..a5a657246df8 100644
--- a/fs/fscache_old/Kconfig
+++ b/fs/fscache_old/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-config FSCACHE
-	tristate "General filesystem local caching manager"
+config FSCACHE_OLD
+	tristate "General filesystem local caching manager (old driver)"
 	select NETFS_SUPPORT
 	help
 	  This option enables a generic filesystem caching manager that can be
@@ -11,9 +11,9 @@ config FSCACHE
 
 	  See Documentation/filesystems/caching/fscache.rst for more information.
 
-config FSCACHE_STATS
+config FSCACHE_OLD_STATS
 	bool "Gather statistical information on local caching"
-	depends on FSCACHE && PROC_FS
+	depends on FSCACHE_OLD && PROC_FS
 	select NETFS_STATS
 	help
 	  This option causes statistical information to be gathered on local
@@ -29,9 +29,9 @@ config FSCACHE_STATS
 
 	  See Documentation/filesystems/caching/fscache.rst for more information.
 
-config FSCACHE_DEBUG
+config FSCACHE_OLD_DEBUG
 	bool "Debug FS-Cache"
-	depends on FSCACHE
+	depends on FSCACHE_OLD
 	help
 	  This permits debugging to be dynamically enabled in the local caching
 	  management module.  If this is set, the debugging output may be
diff --git a/fs/fscache_old/Makefile b/fs/fscache_old/Makefile
index 03a871d689bb..55d5ef397e8c 100644
--- a/fs/fscache_old/Makefile
+++ b/fs/fscache_old/Makefile
@@ -15,6 +15,6 @@ fscache-y := \
 	page.o
 
 fscache-$(CONFIG_PROC_FS) += proc.o
-fscache-$(CONFIG_FSCACHE_STATS) += stats.o
+fscache-$(CONFIG_FSCACHE_OLD_STATS) += stats.o
 
-obj-$(CONFIG_FSCACHE) := fscache.o
+obj-$(CONFIG_FSCACHE_OLD) := fscache.o
diff --git a/fs/fscache_old/internal.h b/fs/fscache_old/internal.h
index 7288622cf2c3..07cc997d6832 100644
--- a/fs/fscache_old/internal.h
+++ b/fs/fscache_old/internal.h
@@ -131,7 +131,7 @@ extern void fscache_proc_cleanup(void);
 /*
  * stats.c
  */
-#ifdef CONFIG_FSCACHE_STATS
+#ifdef CONFIG_FSCACHE_OLD_STATS
 extern atomic_t fscache_n_ops_processed[FSCACHE_MAX_THREADS];
 extern atomic_t fscache_n_objs_processed[FSCACHE_MAX_THREADS];
 
@@ -303,7 +303,7 @@ void fscache_update_aux(struct fscache_cookie *cookie, const void *aux_data)
 #define _leave(FMT, ...) kleave(FMT, ##__VA_ARGS__)
 #define _debug(FMT, ...) kdebug(FMT, ##__VA_ARGS__)
 
-#elif defined(CONFIG_FSCACHE_DEBUG)
+#elif defined(CONFIG_FSCACHE_OLD_DEBUG)
 #define _enter(FMT, ...)			\
 do {						\
 	if (__do_kdebug(ENTER))			\
diff --git a/fs/fscache_old/object.c b/fs/fscache_old/object.c
index 86ad941726f7..365ba306397a 100644
--- a/fs/fscache_old/object.c
+++ b/fs/fscache_old/object.c
@@ -321,7 +321,7 @@ void fscache_object_init(struct fscache_object *object,
 	object->cookie = cookie;
 	fscache_cookie_get(cookie, fscache_cookie_get_attach_object);
 	object->parent = NULL;
-#ifdef CONFIG_FSCACHE_OBJECT_LIST
+#ifdef CONFIG_FSCACHE_OLD_OBJECT_LIST
 	RB_CLEAR_NODE(&object->objlist_link);
 #endif
 
diff --git a/fs/fscache_old/proc.c b/fs/fscache_old/proc.c
index 061df8f61ffc..a96f67b57e0c 100644
--- a/fs/fscache_old/proc.c
+++ b/fs/fscache_old/proc.c
@@ -25,13 +25,13 @@ int __init fscache_proc_init(void)
 			     &fscache_cookies_seq_ops))
 		goto error_cookies;
 
-#ifdef CONFIG_FSCACHE_STATS
+#ifdef CONFIG_FSCACHE_OLD_STATS
 	if (!proc_create_single("fs/fscache/stats", S_IFREG | 0444, NULL,
 			fscache_stats_show))
 		goto error_stats;
 #endif
 
-#ifdef CONFIG_FSCACHE_OBJECT_LIST
+#ifdef CONFIG_FSCACHE_OLD_OBJECT_LIST
 	if (!proc_create("fs/fscache/objects", S_IFREG | 0444, NULL,
 			 &fscache_objlist_proc_ops))
 		goto error_objects;
@@ -40,10 +40,10 @@ int __init fscache_proc_init(void)
 	_leave(" = 0");
 	return 0;
 
-#ifdef CONFIG_FSCACHE_OBJECT_LIST
+#ifdef CONFIG_FSCACHE_OLD_OBJECT_LIST
 error_objects:
 #endif
-#ifdef CONFIG_FSCACHE_STATS
+#ifdef CONFIG_FSCACHE_OLD_STATS
 	remove_proc_entry("fs/fscache/stats", NULL);
 error_stats:
 #endif
@@ -60,10 +60,10 @@ int __init fscache_proc_init(void)
  */
 void fscache_proc_cleanup(void)
 {
-#ifdef CONFIG_FSCACHE_OBJECT_LIST
+#ifdef CONFIG_FSCACHE_OLD_OBJECT_LIST
 	remove_proc_entry("fs/fscache/objects", NULL);
 #endif
-#ifdef CONFIG_FSCACHE_STATS
+#ifdef CONFIG_FSCACHE_OLD_STATS
 	remove_proc_entry("fs/fscache/stats", NULL);
 #endif
 	remove_proc_entry("fs/fscache/cookies", NULL);
diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 14a72224b657..a8b73c90aa00 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -170,7 +170,7 @@ config ROOT_NFS
 
 config NFS_FSCACHE
 	bool "Provide NFS client caching support"
-	depends on NFS_FS=m && FSCACHE || NFS_FS=y && FSCACHE=y
+	depends on NFS_FS=m && FSCACHE_OLD || NFS_FS=y && FSCACHE_OLD=y
 	help
 	  Say Y here if you want NFS data to be cached locally on disc through
 	  the general filesystem cache manager


