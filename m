Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CE2432080
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbhJRO4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 10:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232099AbhJRO4Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634568853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhjrXcMJ61+jv4encCReJ2B1wbDIxHE4Ygch5kqp1lw=;
        b=i65PInKaPeupRd5lOTpNs0lr+kDYdUMdmlQbIzGrkw+vZEsnqyB099p0nxKHCNJEemSC6H
        upIXv9SLXjlbxurvJQBtGxihNx2PNU8zVATcq5+2be3af7tQ6eKpUFP4JvrGXex95fXIcI
        pSO2G0JmqjsNbXdRE0AXfrwNKiejOJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-0ouMmq1iMYOr3H1rYz3eUQ-1; Mon, 18 Oct 2021 10:54:07 -0400
X-MC-Unique: 0ouMmq1iMYOr3H1rYz3eUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 393191006AA3;
        Mon, 18 Oct 2021 14:54:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38867100EBBF;
        Mon, 18 Oct 2021 14:53:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 11/67] fscache: Remove fscache_attr_changed()
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Oct 2021 15:53:42 +0100
Message-ID: <163456882235.2614702.16403136063544166351.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove fscache_attr_changed() as it's unused.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c     |   13 ++----
 fs/fscache/page.c             |   84 -----------------------------------------
 include/linux/fscache-cache.h |    4 --
 include/linux/fscache.h       |   21 ----------
 4 files changed, 5 insertions(+), 117 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 460dd190dad5..4a813a490ffe 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -10,7 +10,7 @@
 #include <linux/xattr.h>
 #include "internal.h"
 
-static int cachefiles_attr_changed(struct fscache_object *_object);
+static int cachefiles_attr_changed(struct cachefiles_object *object);
 
 /*
  * allocate an object record for a cookie lookup and prepare the lookup data
@@ -110,7 +110,7 @@ static int cachefiles_lookup_object(struct fscache_object *_object)
 	/* polish off by setting the attributes of non-index files */
 	if (ret == 0 &&
 	    object->fscache.cookie->type != FSCACHE_COOKIE_TYPE_INDEX)
-		cachefiles_attr_changed(&object->fscache);
+		cachefiles_attr_changed(object);
 
 	if (ret < 0 && ret != -ETIMEDOUT) {
 		if (ret != -ENOBUFS)
@@ -324,9 +324,8 @@ static void cachefiles_sync_cache(struct fscache_cache *_cache)
  * notification the attributes on an object have changed
  * - called with reads/writes excluded by FS-Cache
  */
-static int cachefiles_attr_changed(struct fscache_object *_object)
+static int cachefiles_attr_changed(struct cachefiles_object *object)
 {
-	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	const struct cred *saved_cred;
 	struct iattr newattrs;
@@ -334,12 +333,11 @@ static int cachefiles_attr_changed(struct fscache_object *_object)
 	loff_t oi_size;
 	int ret;
 
-	ni_size = _object->cookie->object_size;
+	ni_size = object->fscache.cookie->object_size;
 
 	_enter("{OBJ%x},[%llu]",
-	       _object->debug_id, (unsigned long long) ni_size);
+	       object->fscache.debug_id, (unsigned long long) ni_size);
 
-	object = container_of(_object, struct cachefiles_object, fscache);
 	cache = container_of(object->fscache.cache,
 			     struct cachefiles_cache, cache);
 
@@ -442,6 +440,5 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.drop_object		= cachefiles_drop_object,
 	.put_object		= cachefiles_put_object,
 	.sync_cache		= cachefiles_sync_cache,
-	.attr_changed		= cachefiles_attr_changed,
 	.begin_operation	= cachefiles_begin_operation,
 };
diff --git a/fs/fscache/page.c b/fs/fscache/page.c
index 2883d661f972..1d86c8a2a8c4 100644
--- a/fs/fscache/page.c
+++ b/fs/fscache/page.c
@@ -13,90 +13,6 @@
 #include <linux/slab.h>
 #include "internal.h"
 
-/*
- * actually apply the changed attributes to a cache object
- */
-static void fscache_attr_changed_op(struct fscache_operation *op)
-{
-	struct fscache_object *object = op->object;
-	int ret;
-
-	_enter("{OBJ%x OP%x}", object->debug_id, op->debug_id);
-
-	fscache_stat(&fscache_n_attr_changed_calls);
-
-	if (fscache_object_is_active(object)) {
-		fscache_stat(&fscache_n_cop_attr_changed);
-		ret = object->cache->ops->attr_changed(object);
-		fscache_stat_d(&fscache_n_cop_attr_changed);
-		if (ret < 0)
-			fscache_abort_object(object);
-		fscache_op_complete(op, ret < 0);
-	} else {
-		fscache_op_complete(op, true);
-	}
-
-	_leave("");
-}
-
-/*
- * notification that the attributes on an object have changed
- */
-int __fscache_attr_changed(struct fscache_cookie *cookie)
-{
-	struct fscache_operation *op;
-	struct fscache_object *object;
-	bool wake_cookie = false;
-
-	_enter("%p", cookie);
-
-	ASSERTCMP(cookie->type, !=, FSCACHE_COOKIE_TYPE_INDEX);
-
-	fscache_stat(&fscache_n_attr_changed);
-
-	op = kzalloc(sizeof(*op), GFP_KERNEL);
-	if (!op) {
-		fscache_stat(&fscache_n_attr_changed_nomem);
-		_leave(" = -ENOMEM");
-		return -ENOMEM;
-	}
-
-	fscache_operation_init(cookie, op, fscache_attr_changed_op, NULL, NULL);
-	trace_fscache_page_op(cookie, NULL, op, fscache_page_op_attr_changed);
-	op->flags = FSCACHE_OP_ASYNC |
-		(1 << FSCACHE_OP_EXCLUSIVE) |
-		(1 << FSCACHE_OP_UNUSE_COOKIE);
-
-	spin_lock(&cookie->lock);
-
-	if (!fscache_cookie_enabled(cookie) ||
-	    hlist_empty(&cookie->backing_objects))
-		goto nobufs;
-	object = hlist_entry(cookie->backing_objects.first,
-			     struct fscache_object, cookie_link);
-
-	__fscache_use_cookie(cookie);
-	if (fscache_submit_exclusive_op(object, op) < 0)
-		goto nobufs_dec;
-	spin_unlock(&cookie->lock);
-	fscache_stat(&fscache_n_attr_changed_ok);
-	fscache_put_operation(op);
-	_leave(" = 0");
-	return 0;
-
-nobufs_dec:
-	wake_cookie = __fscache_unuse_cookie(cookie);
-nobufs:
-	spin_unlock(&cookie->lock);
-	fscache_put_operation(op);
-	if (wake_cookie)
-		__fscache_wake_unused_cookie(cookie);
-	fscache_stat(&fscache_n_attr_changed_nobufs);
-	_leave(" = %d", -ENOBUFS);
-	return -ENOBUFS;
-}
-EXPORT_SYMBOL(__fscache_attr_changed);
-
 /*
  * wait for a deferred lookup to complete
  */
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 15683b7876ff..d0c6c09bb5a1 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -184,10 +184,6 @@ struct fscache_cache_ops {
 	/* sync a cache */
 	void (*sync_cache)(struct fscache_cache *cache);
 
-	/* notification that the attributes of a non-index object (such as
-	 * i_size) have changed */
-	int (*attr_changed)(struct fscache_object *object);
-
 	/* reserve space for an object's data and associated metadata */
 	int (*reserve_space)(struct fscache_object *object, loff_t i_size);
 
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 75ca4fda93d5..1dba014e848f 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -132,7 +132,6 @@ extern struct fscache_cookie *__fscache_acquire_cookie(
 	loff_t, bool);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, const void *, bool);
 extern void __fscache_update_cookie(struct fscache_cookie *, const void *);
-extern int __fscache_attr_changed(struct fscache_cookie *);
 extern void __fscache_invalidate(struct fscache_cookie *);
 extern void __fscache_wait_on_invalidate(struct fscache_cookie *);
 #ifdef FSCACHE_USE_NEW_IO_API
@@ -337,26 +336,6 @@ void fscache_unpin_cookie(struct fscache_cookie *cookie)
 {
 }
 
-/**
- * fscache_attr_changed - Notify cache that an object's attributes changed
- * @cookie: The cookie representing the cache object
- *
- * Send a notification to the cache indicating that an object's attributes have
- * changed.  This includes the data size.  These attributes will be obtained
- * through the get_attr() cookie definition op.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-int fscache_attr_changed(struct fscache_cookie *cookie)
-{
-	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
-		return __fscache_attr_changed(cookie);
-	else
-		return -ENOBUFS;
-}
-
 /**
  * fscache_invalidate - Notify cache that an object needs invalidation
  * @cookie: The cookie representing the cache object


