Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1B1437CF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhJVTCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233568AbhJVTCH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4/T8Io6jeWnvNKIt07Mm8mabiVSgkjPoie4O9EQTu8=;
        b=gH4ZtBQIzKFQI1L9dcJ1z9BjvXLesnlY+dJ9rIrcOSo47x/BNe9g+OWvDVex/vHXmmISVo
        VWsbet4dqbYJWTTaq2jqf9emVRvPB79pJuQxPn64a8rpNeH/QrJHrg/QEEEsF/ksEyJG/S
        UxYNAKYUXViorBRTWPoOVZeIQ+jPtXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-Kc5968NdOam7MLlrHa62lA-1; Fri, 22 Oct 2021 14:59:45 -0400
X-MC-Unique: Kc5968NdOam7MLlrHa62lA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA98918D6A25;
        Fri, 22 Oct 2021 18:59:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 700D85DD68;
        Fri, 22 Oct 2021 18:59:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 04/53] cachefiles_old: Rename CONFIG_CACHEFILES* to
 CONFIG_CACHEFILES_OLD*
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
Date:   Fri, 22 Oct 2021 19:59:34 +0100
Message-ID: <163492917458.1038219.13229909230658169654.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename the CONFIG_CACHEFILES* config symbols to CONFIG_CACHEFILES_OLD*.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/Makefile                  |    2 +-
 fs/cachefiles_old/Kconfig    |    8 ++++----
 fs/cachefiles_old/Makefile   |    2 +-
 fs/cachefiles_old/internal.h |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/Makefile b/fs/Makefile
index 6e6dbcd04cae..e5cb91ecb29f 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -125,7 +125,7 @@ obj-$(CONFIG_AFS_FS)		+= afs/
 obj-$(CONFIG_NILFS2_FS)		+= nilfs2/
 obj-$(CONFIG_BEFS_FS)		+= befs/
 obj-$(CONFIG_HOSTFS)		+= hostfs/
-obj-$(CONFIG_CACHEFILES)	+= cachefiles_old/
+obj-$(CONFIG_CACHEFILES_OLD)	+= cachefiles_old/
 obj-$(CONFIG_DEBUG_FS)		+= debugfs/
 obj-$(CONFIG_TRACING)		+= tracefs/
 obj-$(CONFIG_OCFS2_FS)		+= ocfs2/
diff --git a/fs/cachefiles_old/Kconfig b/fs/cachefiles_old/Kconfig
index 7f3e1881fb21..48977018c64e 100644
--- a/fs/cachefiles_old/Kconfig
+++ b/fs/cachefiles_old/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-config CACHEFILES
-	tristate "Filesystem caching on files"
+config CACHEFILES_OLD
+	tristate "Filesystem caching on files (old driver)"
 	depends on FSCACHE_OLD && BLOCK
 	help
 	  This permits use of a mounted filesystem as a cache for other
@@ -11,9 +11,9 @@ config CACHEFILES
 	  See Documentation/filesystems/caching/cachefiles.rst for more
 	  information.
 
-config CACHEFILES_DEBUG
+config CACHEFILES_OLD_DEBUG
 	bool "Debug CacheFiles"
-	depends on CACHEFILES
+	depends on CACHEFILES_OLD
 	help
 	  This permits debugging to be dynamically enabled in the filesystem
 	  caching on files module.  If this is set, the debugging output may be
diff --git a/fs/cachefiles_old/Makefile b/fs/cachefiles_old/Makefile
index 714e84b3ca24..e0c2e69ddf50 100644
--- a/fs/cachefiles_old/Makefile
+++ b/fs/cachefiles_old/Makefile
@@ -14,4 +14,4 @@ cachefiles-y := \
 	security.o \
 	xattr.o
 
-obj-$(CONFIG_CACHEFILES) := cachefiles.o
+obj-$(CONFIG_CACHEFILES_OLD) := cachefiles.o
diff --git a/fs/cachefiles_old/internal.h b/fs/cachefiles_old/internal.h
index 28351d62d8d2..9e3a8d6894db 100644
--- a/fs/cachefiles_old/internal.h
+++ b/fs/cachefiles_old/internal.h
@@ -235,7 +235,7 @@ do {									\
 #define _leave(FMT, ...) kleave(FMT, ##__VA_ARGS__)
 #define _debug(FMT, ...) kdebug(FMT, ##__VA_ARGS__)
 
-#elif defined(CONFIG_CACHEFILES_DEBUG)
+#elif defined(CONFIG_CACHEFILES_OLD_DEBUG)
 #define _enter(FMT, ...)				\
 do {							\
 	if (cachefiles_debug & CACHEFILES_DEBUG_KENTER)	\


