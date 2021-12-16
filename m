Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE66F4778E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 17:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbhLPQZz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 11:25:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233922AbhLPQZy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:25:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639671953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPlgQlwxi0Twp5Yox+XtTPal8JtVOWAamYaPi8RMgCQ=;
        b=GPY1eOjBtGj9AA75FYxKa/X4qVg43qEeu5YS4YGdvjA28F1wUuiGk5r77af9MryBsP6z3M
        5T7sNrI0Dktt+W4oJLjJ5QrDZXYA2yf70kxeY0MfgzoUhaWdW1hbWZfPJgrjPBYBBnK2Mv
        vHaW7CFBs9kd84uyoVCOMCfIAXqGtLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-jvFwrVR3NqC-E7ONQFMywg-1; Thu, 16 Dec 2021 11:25:47 -0500
X-MC-Unique: jvFwrVR3NqC-E7ONQFMywg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73010100C66B;
        Thu, 16 Dec 2021 16:25:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A7B35E481;
        Thu, 16 Dec 2021 16:25:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 68/68] fscache: Rewrite documentation
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Dec 2021 16:25:38 +0000
Message-ID: <163967193834.1823006.15991526817786159772.stgit@warthog.procyon.org.uk>
In-Reply-To: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
References: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rewrite the fscache documentation.

Changes
=======
ver #3:
 - The volume coherency data is now an arbitrarily-sized blob, not a u64.

ver #2:
 - Put quoting around some bits of C being referred to in the docs[1].
 - Stripped the markup off the ref to the netfs lib doc[2].

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/20211130175119.63d0e7aa@canb.auug.org.au/ [1]
Link: https://lore.kernel.org/r/20211130162311.105fcfa5@canb.auug.org.au/ [2]
Link: https://lore.kernel.org/r/163819672252.215744.15454333549935901588.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163906986754.143852.17703291789683936950.stgit@warthog.procyon.org.uk/ # v2
---

 Documentation/filesystems/caching/backend-api.rst |  850 ++++++----------
 Documentation/filesystems/caching/cachefiles.rst  |    6 
 Documentation/filesystems/caching/fscache.rst     |  525 +++-------
 Documentation/filesystems/caching/index.rst       |    4 
 Documentation/filesystems/caching/netfs-api.rst   | 1136 ++++++---------------
 Documentation/filesystems/caching/object.rst      |  313 ------
 Documentation/filesystems/caching/operations.rst  |  210 ----
 Documentation/filesystems/netfs_library.rst       |   16 
 8 files changed, 815 insertions(+), 2245 deletions(-)
 delete mode 100644 Documentation/filesystems/caching/object.rst
 delete mode 100644 Documentation/filesystems/caching/operations.rst

diff --git a/Documentation/filesystems/caching/backend-api.rst b/Documentation/filesystems/caching/backend-api.rst
index 19fbf6b9aa36..be793c49a772 100644
--- a/Documentation/filesystems/caching/backend-api.rst
+++ b/Documentation/filesystems/caching/backend-api.rst
@@ -1,727 +1,479 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-==========================
-FS-Cache Cache backend API
-==========================
+=================
+Cache Backend API
+=================
 
 The FS-Cache system provides an API by which actual caches can be supplied to
 FS-Cache for it to then serve out to network filesystems and other interested
-parties.
+parties.  This API is used by::
 
-This API is declared in <linux/fscache-cache.h>.
+	#include <linux/fscache-cache.h>.
 
 
-Initialising and Registering a Cache
-====================================
-
-To start off, a cache definition must be initialised and registered for each
-cache the backend wants to make available.  For instance, CacheFS does this in
-the fill_super() operation on mounting.
-
-The cache definition (struct fscache_cache) should be initialised by calling::
-
-	void fscache_init_cache(struct fscache_cache *cache,
-				struct fscache_cache_ops *ops,
-				const char *idfmt,
-				...);
-
-Where:
-
-   * "cache" is a pointer to the cache definition;
-
-   * "ops" is a pointer to the table of operations that the backend supports on
-     this cache; and
-
-   * "idfmt" is a format and printf-style arguments for constructing a label
-     for the cache.
-
-
-The cache should then be registered with FS-Cache by passing a pointer to the
-previously initialised cache definition to::
-
-	int fscache_add_cache(struct fscache_cache *cache,
-			      struct fscache_object *fsdef,
-			      const char *tagname);
-
-Two extra arguments should also be supplied:
-
-   * "fsdef" which should point to the object representation for the FS-Cache
-     master index in this cache.  Netfs primary index entries will be created
-     here.  FS-Cache keeps the caller's reference to the index object if
-     successful and will release it upon withdrawal of the cache.
-
-   * "tagname" which, if given, should be a text string naming this cache.  If
-     this is NULL, the identifier will be used instead.  For CacheFS, the
-     identifier is set to name the underlying block device and the tag can be
-     supplied by mount.
-
-This function may return -ENOMEM if it ran out of memory or -EEXIST if the tag
-is already in use.  0 will be returned on success.
-
-
-Unregistering a Cache
-=====================
-
-A cache can be withdrawn from the system by calling this function with a
-pointer to the cache definition::
-
-	void fscache_withdraw_cache(struct fscache_cache *cache);
-
-In CacheFS's case, this is called by put_super().
-
-
-Security
+Overview
 ========
 
-The cache methods are executed one of two contexts:
-
- (1) that of the userspace process that issued the netfs operation that caused
-     the cache method to be invoked, or
-
- (2) that of one of the processes in the FS-Cache thread pool.
-
-In either case, this may not be an appropriate context in which to access the
-cache.
-
-The calling process's fsuid, fsgid and SELinux security identities may need to
-be masqueraded for the duration of the cache driver's access to the cache.
-This is left to the cache to handle; FS-Cache makes no effort in this regard.
-
+Interaction with the API is handled on three levels: cache, volume and data
+storage, and each level has its own type of cookie object:
 
-Control and Statistics Presentation
-===================================
+	=======================	=======================
+	COOKIE			C TYPE
+	=======================	=======================
+	Cache cookie		struct fscache_cache
+	Volume cookie		struct fscache_volume
+	Data storage cookie	struct fscache_cookie
+	=======================	=======================
 
-The cache may present data to the outside world through FS-Cache's interfaces
-in sysfs and procfs - the former for control and the latter for statistics.
+Cookies are used to provide some filesystem data to the cache, manage state and
+pin the cache during access in addition to acting as reference points for the
+API functions.  Each cookie has a debugging ID that is included in trace points
+to make it easier to correlate traces.  Note, though, that debugging IDs are
+simply allocated from incrementing counters and will eventually wrap.
 
-A sysfs directory called /sys/fs/fscache/<cachetag>/ is created if CONFIG_SYSFS
-is enabled.  This is accessible through the kobject struct fscache_cache::kobj
-and is for use by the cache as it sees fit.
+The cache backend and the network filesystem can both ask for cache cookies -
+and if they ask for one of the same name, they'll get the same cookie.  Volume
+and data cookies, however, are created at the behest of the filesystem only.
 
 
-Relevant Data Structures
-========================
+Cache Cookies
+=============
 
-   * Index/Data file FS-Cache representation cookie::
+Caches are represented in the API by cache cookies.  These are objects of
+type::
 
-	struct fscache_cookie {
-		struct fscache_object_def	*def;
-		struct fscache_netfs		*netfs;
-		void				*netfs_data;
-		...
-	};
-
-     The fields that might be of use to the backend describe the object
-     definition, the netfs definition and the netfs's data for this cookie.
-     The object definition contain functions supplied by the netfs for loading
-     and matching index entries; these are required to provide some of the
-     cache operations.
-
-
-   * In-cache object representation::
-
-	struct fscache_object {
-		int				debug_id;
-		enum {
-			FSCACHE_OBJECT_RECYCLING,
-			...
-		}				state;
-		spinlock_t			lock
-		struct fscache_cache		*cache;
-		struct fscache_cookie		*cookie;
+	struct fscache_cache {
+		void		*cache_priv;
+		unsigned int	debug_id;
+		char		*name;
 		...
 	};
 
-     Structures of this type should be allocated by the cache backend and
-     passed to FS-Cache when requested by the appropriate cache operation.  In
-     the case of CacheFS, they're embedded in CacheFS's internal object
-     structures.
+There are a few fields that the cache backend might be interested in.  The
+``debug_id`` can be used in tracing to match lines referring to the same cache
+and ``name`` is the name the cache was registered with.  The ``cache_priv``
+member is private data provided by the cache when it is brought online.  The
+other fields are for internal use.
 
-     The debug_id is a simple integer that can be used in debugging messages
-     that refer to a particular object.  In such a case it should be printed
-     using "OBJ%x" to be consistent with FS-Cache.
 
-     Each object contains a pointer to the cookie that represents the object it
-     is backing.  An object should retired when put_object() is called if it is
-     in state FSCACHE_OBJECT_RECYCLING.  The fscache_object struct should be
-     initialised by calling fscache_object_init(object).
+Registering a Cache
+===================
 
+When a cache backend wants to bring a cache online, it should first register
+the cache name and that will get it a cache cookie.  This is done with::
 
-   * FS-Cache operation record::
+	struct fscache_cache *fscache_acquire_cache(const char *name);
 
-	struct fscache_operation {
-		atomic_t		usage;
-		struct fscache_object	*object;
-		unsigned long		flags;
-	#define FSCACHE_OP_EXCLUSIVE
-		void (*processor)(struct fscache_operation *op);
-		void (*release)(struct fscache_operation *op);
-		...
-	};
+This will look up and potentially create a cache cookie.  The cache cookie may
+have already been created by a network filesystem looking for it, in which case
+that cache cookie will be used.  If the cache cookie is not in use by another
+cache, it will be moved into the preparing state, otherwise it will return
+busy.
 
-     FS-Cache has a pool of threads that it uses to give CPU time to the
-     various asynchronous operations that need to be done as part of driving
-     the cache.  These are represented by the above structure.  The processor
-     method is called to give the op CPU time, and the release method to get
-     rid of it when its usage count reaches 0.
+If successful, the cache backend can then start setting up the cache.  In the
+event that the initialisation fails, the cache backend should call::
 
-     An operation can be made exclusive upon an object by setting the
-     appropriate flag before enqueuing it with fscache_enqueue_operation().  If
-     an operation needs more processing time, it should be enqueued again.
+	void fscache_relinquish_cookie(struct fscache_cache *cache);
 
+to reset and discard the cookie.
 
-   * FS-Cache retrieval operation record::
 
-	struct fscache_retrieval {
-		struct fscache_operation op;
-		struct address_space	*mapping;
-		struct list_head	*to_do;
-		...
-	};
+Bringing a Cache Online
+=======================
 
-     A structure of this type is allocated by FS-Cache to record retrieval and
-     allocation requests made by the netfs.  This struct is then passed to the
-     backend to do the operation.  The backend may get extra refs to it by
-     calling fscache_get_retrieval() and refs may be discarded by calling
-     fscache_put_retrieval().
+Once the cache is set up, it can be brought online by calling::
 
-     A retrieval operation can be used by the backend to do retrieval work.  To
-     do this, the retrieval->op.processor method pointer should be set
-     appropriately by the backend and fscache_enqueue_retrieval() called to
-     submit it to the thread pool.  CacheFiles, for example, uses this to queue
-     page examination when it detects PG_lock being cleared.
+	int fscache_add_cache(struct fscache_cache *cache,
+			      const struct fscache_cache_ops *ops,
+			      void *cache_priv);
 
-     The to_do field is an empty list available for the cache backend to use as
-     it sees fit.
+This stores the cache operations table pointer and cache private data into the
+cache cookie and moves the cache to the active state, thereby allowing accesses
+to take place.
 
 
-   * FS-Cache storage operation record::
+Withdrawing a Cache From Service
+================================
 
-	struct fscache_storage {
-		struct fscache_operation op;
-		pgoff_t			store_limit;
-		...
-	};
+The cache backend can withdraw a cache from service by calling this function::
 
-     A structure of this type is allocated by FS-Cache to record outstanding
-     writes to be made.  FS-Cache itself enqueues this operation and invokes
-     the write_page() method on the object at appropriate times to effect
-     storage.
+	void fscache_withdraw_cache(struct fscache_cache *cache);
 
+This moves the cache to the withdrawn state to prevent new cache- and
+volume-level accesses from starting and then waits for outstanding cache-level
+accesses to complete.
 
-Cache Operations
-================
+The cache must then go through the data storage objects it has and tell fscache
+to withdraw them, calling::
 
-The cache backend provides FS-Cache with a table of operations that can be
-performed on the denizens of the cache.  These are held in a structure of type:
+	void fscache_withdraw_cookie(struct fscache_cookie *cookie);
 
-	::
+on the cookie that each object belongs to.  This schedules the specified cookie
+for withdrawal.  This gets offloaded to a workqueue.  The cache backend can
+test for completion by calling::
 
-	    struct fscache_cache_ops
+	bool fscache_are_objects_withdrawn(struct fscache_cookie *cache);
 
-   * Name of cache provider [mandatory]::
+Once all the cookies are withdrawn, a cache backend can withdraw all the
+volumes, calling::
 
-	const char *name
+	void fscache_withdraw_volume(struct fscache_volume *volume);
 
-     This isn't strictly an operation, but should be pointed at a string naming
-     the backend.
+to tell fscache that a volume has been withdrawn.  This waits for all
+outstanding accesses on the volume to complete before returning.
 
+When the the cache is completely withdrawn, fscache should be notified by
+calling::
 
-   * Allocate a new object [mandatory]::
+	void fscache_cache_relinquish(struct fscache_cache *cache);
 
-	struct fscache_object *(*alloc_object)(struct fscache_cache *cache,
-					       struct fscache_cookie *cookie)
+to clear fields in the cookie and discard the caller's ref on it.
 
-     This method is used to allocate a cache object representation to back a
-     cookie in a particular cache.  fscache_object_init() should be called on
-     the object to initialise it prior to returning.
 
-     This function may also be used to parse the index key to be used for
-     multiple lookup calls to turn it into a more convenient form.  FS-Cache
-     will call the lookup_complete() method to allow the cache to release the
-     form once lookup is complete or aborted.
+Volume Cookies
+==============
 
+Within a cache, the data storage objects are organised into logical volumes.
+These are represented in the API as objects of type::
 
-   * Look up and create object [mandatory]::
+	struct fscache_volume {
+		struct fscache_cache		*cache;
+		void				*cache_priv;
+		unsigned int			debug_id;
+		char				*key;
+		unsigned int			key_hash;
+		...
+		u8				coherency_len;
+		u8				coherency[];
+	};
 
-	void (*lookup_object)(struct fscache_object *object)
+There are a number of fields here that are of interest to the caching backend:
 
-     This method is used to look up an object, given that the object is already
-     allocated and attached to the cookie.  This should instantiate that object
-     in the cache if it can.
+   * ``cache`` - The parent cache cookie.
 
-     The method should call fscache_object_lookup_negative() as soon as
-     possible if it determines the object doesn't exist in the cache.  If the
-     object is found to exist and the netfs indicates that it is valid then
-     fscache_obtained_object() should be called once the object is in a
-     position to have data stored in it.  Similarly, fscache_obtained_object()
-     should also be called once a non-present object has been created.
+   * ``cache_priv`` - A place for the cache to stash private data.
 
-     If a lookup error occurs, fscache_object_lookup_error() should be called
-     to abort the lookup of that object.
+   * ``debug_id`` - A debugging ID for logging in tracepoints.
 
+   * ``key`` - A printable string with no '/' characters in it that represents
+     the index key for the volume.  The key is NUL-terminated and padded out to
+     a multiple of 4 bytes.
 
-   * Release lookup data [mandatory]::
+   * ``key_hash`` - A hash of the index key.  This should work out the same, no
+     matter the cpu arch and endianness.
 
-	void (*lookup_complete)(struct fscache_object *object)
+   * ``coherency`` - A piece of coherency data that should be checked when the
+     volume is bound to in the cache.
 
-     This method is called to ask the cache to release any resources it was
-     using to perform a lookup.
+   * ``coherency_len`` - The amount of data in the coherency buffer.
 
 
-   * Increment object refcount [mandatory]::
+Data Storage Cookies
+====================
 
-	struct fscache_object *(*grab_object)(struct fscache_object *object)
+A volume is a logical group of data storage objects, each of which is
+represented to the network filesystem by a cookie.  Cookies are represented in
+the API as objects of type::
 
-     This method is called to increment the reference count on an object.  It
-     may fail (for instance if the cache is being withdrawn) by returning NULL.
-     It should return the object pointer if successful.
+	struct fscache_cookie {
+		struct fscache_volume		*volume;
+		void				*cache_priv;
+		unsigned long			flags;
+		unsigned int			debug_id;
+		unsigned int			inval_counter;
+		loff_t				object_size;
+		u8				advice;
+		u32				key_hash;
+		u8				key_len;
+		u8				aux_len;
+		...
+	};
 
+The fields in the cookie that are of interest to the cache backend are:
 
-   * Lock/Unlock object [mandatory]::
+   * ``volume`` - The parent volume cookie.
 
-	void (*lock_object)(struct fscache_object *object)
-	void (*unlock_object)(struct fscache_object *object)
+   * ``cache_priv`` - A place for the cache to stash private data.
 
-     These methods are used to exclusively lock an object.  It must be possible
-     to schedule with the lock held, so a spinlock isn't sufficient.
+   * ``flags`` - A collection of bit flags, including:
 
+      * FSCACHE_COOKIE_NO_DATA_TO_READ - There is no data available in the
+	cache to be read as the cookie has been created or invalidated.
 
-   * Pin/Unpin object [optional]::
+      * FSCACHE_COOKIE_NEEDS_UPDATE - The coherency data and/or object size has
+	been changed and needs committing.
 
-	int (*pin_object)(struct fscache_object *object)
-	void (*unpin_object)(struct fscache_object *object)
+      * FSCACHE_COOKIE_LOCAL_WRITE - The netfs's data has been modified
+	locally, so the cache object may be in an incoherent state with respect
+	to the server.
 
-     These methods are used to pin an object into the cache.  Once pinned an
-     object cannot be reclaimed to make space.  Return -ENOSPC if there's not
-     enough space in the cache to permit this.
+      * FSCACHE_COOKIE_HAVE_DATA - The backend should set this if it
+	successfully stores data into the cache.
 
+      * FSCACHE_COOKIE_RETIRED - The cookie was invalidated when it was
+	relinquished and the cached data should be discarded.
 
-   * Check coherency state of an object [mandatory]::
+   * ``debug_id`` - A debugging ID for logging in tracepoints.
 
-	int (*check_consistency)(struct fscache_object *object)
+   * ``inval_counter`` - The number of invalidations done on the cookie.
 
-     This method is called to have the cache check the saved auxiliary data of
-     the object against the netfs's idea of the state.  0 should be returned
-     if they're consistent and -ESTALE otherwise.  -ENOMEM and -ERESTARTSYS
-     may also be returned.
+   * ``advice`` - Information about how the cookie is to be used.
 
-   * Update object [mandatory]::
+   * ``key_hash`` - A hash of the index key.  This should work out the same, no
+     matter the cpu arch and endianness.
 
-	int (*update_object)(struct fscache_object *object)
+   * ``key_len`` - The length of the index key.
 
-     This is called to update the index entry for the specified object.  The
-     new information should be in object->cookie->netfs_data.  This can be
-     obtained by calling object->cookie->def->get_aux()/get_attr().
+   * ``aux_len`` - The length of the coherency data buffer.
 
+Each cookie has an index key, which may be stored inline to the cookie or
+elsewhere.  A pointer to this can be obtained by calling::
 
-   * Invalidate data object [mandatory]::
+	void *fscache_get_key(struct fscache_cookie *cookie);
 
-	int (*invalidate_object)(struct fscache_operation *op)
+The index key is a binary blob, the storage for which is padded out to a
+multiple of 4 bytes.
 
-     This is called to invalidate a data object (as pointed to by op->object).
-     All the data stored for this object should be discarded and an
-     attr_changed operation should be performed.  The caller will follow up
-     with an object update operation.
+Each cookie also has a buffer for coherency data.  This may also be inline or
+detached from the cookie and a pointer is obtained by calling::
 
-     fscache_op_complete() must be called on op before returning.
+	void *fscache_get_aux(struct fscache_cookie *cookie);
 
 
-   * Discard object [mandatory]::
 
-	void (*drop_object)(struct fscache_object *object)
+Cookie Accounting
+=================
 
-     This method is called to indicate that an object has been unbound from its
-     cookie, and that the cache should release the object's resources and
-     retire it if it's in state FSCACHE_OBJECT_RECYCLING.
+Data storage cookies are counted and this is used to block cache withdrawal
+completion until all objects have been destroyed.  The following functions are
+provided to the cache to deal with that::
 
-     This method should not attempt to release any references held by the
-     caller.  The caller will invoke the put_object() method as appropriate.
+	void fscache_count_object(struct fscache_cache *cache);
+	void fscache_uncount_object(struct fscache_cache *cache);
+	void fscache_wait_for_objects(struct fscache_cache *cache);
 
+The count function records the allocation of an object in a cache and the
+uncount function records its destruction.  Warning: by the time the uncount
+function returns, the cache may have been destroyed.
 
-   * Release object reference [mandatory]::
+The wait function can be used during the withdrawal procedure to wait for
+fscache to finish withdrawing all the objects in the cache.  When it completes,
+there will be no remaining objects referring to the cache object or any volume
+objects.
 
-	void (*put_object)(struct fscache_object *object)
 
-     This method is used to discard a reference to an object.  The object may
-     be freed when all the references to it are released.
+Cache Management API
+====================
 
+The cache backend implements the cache management API by providing a table of
+operations that fscache can use to manage various aspects of the cache.  These
+are held in a structure of type::
 
-   * Synchronise a cache [mandatory]::
+	struct fscache_cache_ops {
+		const char *name;
+		...
+	};
 
-	void (*sync)(struct fscache_cache *cache)
+This contains a printable name for the cache backend driver plus a number of
+pointers to methods to allow fscache to request management of the cache:
 
-     This is called to ask the backend to synchronise a cache with its backing
-     device.
+   * Set up a volume cookie [optional]::
 
+	void (*acquire_volume)(struct fscache_volume *volume);
 
-   * Dissociate a cache [mandatory]::
+     This method is called when a volume cookie is being created.  The caller
+     holds a cache-level access pin to prevent the cache from going away for
+     the duration.  This method should set up the resources to access a volume
+     in the cache and should not return until it has done so.
 
-	void (*dissociate_pages)(struct fscache_cache *cache)
+     If successful, it can set ``cache_priv`` to its own data.
 
-     This is called to ask a cache to perform any page dissociations as part of
-     cache withdrawal.
 
+   * Clean up volume cookie [optional]::
 
-   * Notification that the attributes on a netfs file changed [mandatory]::
+       void (*free_volume)(struct fscache_volume *volume);
 
-	int (*attr_changed)(struct fscache_object *object);
+     This method is called when a volume cookie is being released if
+     ``cache_priv`` is set.
 
-     This is called to indicate to the cache that certain attributes on a netfs
-     file have changed (for example the maximum size a file may reach).  The
-     cache can read these from the netfs by calling the cookie's get_attr()
-     method.
 
-     The cache may use the file size information to reserve space on the cache.
-     It should also call fscache_set_store_limit() to indicate to FS-Cache the
-     highest byte it's willing to store for an object.
+   * Look up a cookie in the cache [mandatory]::
 
-     This method may return -ve if an error occurred or the cache object cannot
-     be expanded.  In such a case, the object will be withdrawn from service.
+	bool (*lookup_cookie)(struct fscache_cookie *cookie);
 
-     This operation is run asynchronously from FS-Cache's thread pool, and
-     storage and retrieval operations from the netfs are excluded during the
-     execution of this operation.
+     This method is called to look up/create the resources needed to access the
+     data storage for a cookie.  It is called from a worker thread with a
+     volume-level access pin in the cache to prevent it from being withdrawn.
 
+     True should be returned if successful and false otherwise.  If false is
+     returned, the withdraw_cookie op (see below) will be called.
 
-   * Reserve cache space for an object's data [optional]::
+     If lookup fails, but the object could still be created (e.g. it hasn't
+     been cached before), then::
 
-	int (*reserve_space)(struct fscache_object *object, loff_t size);
+		void fscache_cookie_lookup_negative(
+			struct fscache_cookie *cookie);
 
-     This is called to request that cache space be reserved to hold the data
-     for an object and the metadata used to track it.  Zero size should be
-     taken as request to cancel a reservation.
+     can be called to let the network filesystem proceed and start downloading
+     stuff whilst the cache backend gets on with the job of creating things.
 
-     This should return 0 if successful, -ENOSPC if there isn't enough space
-     available, or -ENOMEM or -EIO on other errors.
+     If successful, ``cookie->cache_priv`` can be set.
 
-     The reservation may exceed the current size of the object, thus permitting
-     future expansion.  If the amount of space consumed by an object would
-     exceed the reservation, it's permitted to refuse requests to allocate
-     pages, but not required.  An object may be pruned down to its reservation
-     size if larger than that already.
 
+   * Withdraw an object without any cookie access counts held [mandatory]::
 
-   * Request page be read from cache [mandatory]::
+	void (*withdraw_cookie)(struct fscache_cookie *cookie);
 
-	int (*read_or_alloc_page)(struct fscache_retrieval *op,
-				  struct page *page,
-				  gfp_t gfp)
+     This method is called to withdraw a cookie from service.  It will be
+     called when the cookie is relinquished by the netfs, withdrawn or culled
+     by the cache backend or closed after a period of non-use by fscache.
 
-     This is called to attempt to read a netfs page from the cache, or to
-     reserve a backing block if not.  FS-Cache will have done as much checking
-     as it can before calling, but most of the work belongs to the backend.
+     The caller doesn't hold any access pins, but it is called from a
+     non-reentrant work item to manage races between the various ways
+     withdrawal can occur.
 
-     If there's no page in the cache, then -ENODATA should be returned if the
-     backend managed to reserve a backing block; -ENOBUFS or -ENOMEM if it
-     didn't.
+     The cookie will have the ``FSCACHE_COOKIE_RETIRED`` flag set on it if the
+     associated data is to be removed from the cache.
 
-     If there is suitable data in the cache, then a read operation should be
-     queued and 0 returned.  When the read finishes, fscache_end_io() should be
-     called.
 
-     The fscache_mark_pages_cached() should be called for the page if any cache
-     metadata is retained.  This will indicate to the netfs that the page needs
-     explicit uncaching.  This operation takes a pagevec, thus allowing several
-     pages to be marked at once.
+   * Change the size of a data storage object [mandatory]::
 
-     The retrieval record pointed to by op should be retained for each page
-     queued and released when I/O on the page has been formally ended.
-     fscache_get/put_retrieval() are available for this purpose.
+	void (*resize_cookie)(struct netfs_cache_resources *cres,
+			      loff_t new_size);
 
-     The retrieval record may be used to get CPU time via the FS-Cache thread
-     pool.  If this is desired, the op->op.processor should be set to point to
-     the appropriate processing routine, and fscache_enqueue_retrieval() should
-     be called at an appropriate point to request CPU time.  For instance, the
-     retrieval routine could be enqueued upon the completion of a disk read.
-     The to_do field in the retrieval record is provided to aid in this.
+     This method is called to inform the cache backend of a change in size of
+     the netfs file due to local truncation.  The cache backend should make all
+     of the changes it needs to make before returning as this is done under the
+     netfs inode mutex.
 
-     If an I/O error occurs, fscache_io_error() should be called and -ENOBUFS
-     returned if possible or fscache_end_io() called with a suitable error
-     code.
+     The caller holds a cookie-level access pin to prevent a race with
+     withdrawal and the netfs must have the cookie marked in-use to prevent
+     garbage collection or culling from removing any resources.
 
-     fscache_put_retrieval() should be called after a page or pages are dealt
-     with.  This will complete the operation when all pages are dealt with.
 
+   * Invalidate a data storage object [mandatory]::
 
-   * Request pages be read from cache [mandatory]::
+	bool (*invalidate_cookie)(struct fscache_cookie *cookie);
 
-	int (*read_or_alloc_pages)(struct fscache_retrieval *op,
-				   struct list_head *pages,
-				   unsigned *nr_pages,
-				   gfp_t gfp)
+     This is called when the network filesystem detects a third-party
+     modification or when an O_DIRECT write is made locally.  This requests
+     that the cache backend should throw away all the data in the cache for
+     this object and start afresh.  It should return true if successful and
+     false otherwise.
 
-     This is like the read_or_alloc_page() method, except it is handed a list
-     of pages instead of one page.  Any pages on which a read operation is
-     started must be added to the page cache for the specified mapping and also
-     to the LRU.  Such pages must also be removed from the pages list and
-     ``*nr_pages`` decremented per page.
+     On entry, new I O/operations are blocked.  Once the cache is in a position
+     to accept I/O again, the backend should release the block by calling::
 
-     If there was an error such as -ENOMEM, then that should be returned; else
-     if one or more pages couldn't be read or allocated, then -ENOBUFS should
-     be returned; else if one or more pages couldn't be read, then -ENODATA
-     should be returned.  If all the pages are dispatched then 0 should be
-     returned.
+	void fscache_resume_after_invalidation(struct fscache_cookie *cookie);
 
+     If the method returns false, caching will be withdrawn for this cookie.
 
-   * Request page be allocated in the cache [mandatory]::
 
-	int (*allocate_page)(struct fscache_retrieval *op,
-			     struct page *page,
-			     gfp_t gfp)
+   * Prepare to make local modifications to the cache [mandatory]::
 
-     This is like the read_or_alloc_page() method, except that it shouldn't
-     read from the cache, even if there's data there that could be retrieved.
-     It should, however, set up any internal metadata required such that
-     the write_page() method can write to the cache.
+	void (*prepare_to_write)(struct fscache_cookie *cookie);
 
-     If there's no backing block available, then -ENOBUFS should be returned
-     (or -ENOMEM if there were other problems).  If a block is successfully
-     allocated, then the netfs page should be marked and 0 returned.
+     This method is called when the network filesystem finds that it is going
+     to need to modify the contents of the cache due to local writes or
+     truncations.  This gives the cache a chance to note that a cache object
+     may be incoherent with respect to the server and may need writing back
+     later.  This may also cause the cached data to be scrapped on later
+     rebinding if not properly committed.
 
 
-   * Request pages be allocated in the cache [mandatory]::
+   * Begin an operation for the netfs lib [mandatory]::
 
-	int (*allocate_pages)(struct fscache_retrieval *op,
-			      struct list_head *pages,
-			      unsigned *nr_pages,
-			      gfp_t gfp)
+	bool (*begin_operation)(struct netfs_cache_resources *cres,
+				enum fscache_want_state want_state);
 
-     This is an multiple page version of the allocate_page() method.  pages and
-     nr_pages should be treated as for the read_or_alloc_pages() method.
+     This method is called when an I/O operation is being set up (read, write
+     or resize).  The caller holds an access pin on the cookie and must have
+     marked the cookie as in-use.
 
+     If it can, the backend should attach any resources it needs to keep around
+     to the netfs_cache_resources object and return true.
 
-   * Request page be written to cache [mandatory]::
+     If it can't complete the setup, it should return false.
 
-	int (*write_page)(struct fscache_storage *op,
-			  struct page *page);
+     The want_state parameter indicates the state the caller needs the cache
+     object to be in and what it wants to do during the operation:
 
-     This is called to write from a page on which there was a previously
-     successful read_or_alloc_page() call or similar.  FS-Cache filters out
-     pages that don't have mappings.
+	* ``FSCACHE_WANT_PARAMS`` - The caller just wants to access cache
+	  object parameters; it doesn't need to do data I/O yet.
 
-     This method is called asynchronously from the FS-Cache thread pool.  It is
-     not required to actually store anything, provided -ENODATA is then
-     returned to the next read of this page.
+	* ``FSCACHE_WANT_READ`` - The caller wants to read data.
 
-     If an error occurred, then a negative error code should be returned,
-     otherwise zero should be returned.  FS-Cache will take appropriate action
-     in response to an error, such as withdrawing this object.
+	* ``FSCACHE_WANT_WRITE`` - The caller wants to write to or resize the
+          cache object.
 
-     If this method returns success then FS-Cache will inform the netfs
-     appropriately.
+     Note that there won't necessarily be anything attached to the cookie's
+     cache_priv yet if the cookie is still being created.
 
 
-   * Discard retained per-page metadata [mandatory]::
+Data I/O API
+============
 
-	void (*uncache_page)(struct fscache_object *object, struct page *page)
+A cache backend provides a data I/O API by through the netfs library's ``struct
+netfs_cache_ops`` attached to a ``struct netfs_cache_resources`` by the
+``begin_operation`` method described above.
 
-     This is called when a netfs page is being evicted from the pagecache.  The
-     cache backend should tear down any internal representation or tracking it
-     maintains for this page.
+See the Documentation/filesystems/netfs_library.rst for a description.
 
 
-FS-Cache Utilities
-==================
+Miscellaneous Functions
+=======================
 
 FS-Cache provides some utilities that a cache backend may make use of:
 
    * Note occurrence of an I/O error in a cache::
 
-	void fscache_io_error(struct fscache_cache *cache)
+	void fscache_io_error(struct fscache_cache *cache);
 
-     This tells FS-Cache that an I/O error occurred in the cache.  After this
-     has been called, only resource dissociation operations (object and page
-     release) will be passed from the netfs to the cache backend for the
-     specified cache.
+     This tells FS-Cache that an I/O error occurred in the cache.  This
+     prevents any new I/O from being started on the cache.
 
      This does not actually withdraw the cache.  That must be done separately.
 
+   * Note cessation of caching on a cookie due to failure::
 
-   * Invoke the retrieval I/O completion function::
-
-	void fscache_end_io(struct fscache_retrieval *op, struct page *page,
-			    int error);
-
-     This is called to note the end of an attempt to retrieve a page.  The
-     error value should be 0 if successful and an error otherwise.
-
-
-   * Record that one or more pages being retrieved or allocated have been dealt
-     with::
-
-	void fscache_retrieval_complete(struct fscache_retrieval *op,
-					int n_pages);
-
-     This is called to record the fact that one or more pages have been dealt
-     with and are no longer the concern of this operation.  When the number of
-     pages remaining in the operation reaches 0, the operation will be
-     completed.
-
-
-   * Record operation completion::
-
-	void fscache_op_complete(struct fscache_operation *op);
-
-     This is called to record the completion of an operation.  This deducts
-     this operation from the parent object's run state, potentially permitting
-     one or more pending operations to start running.
-
-
-   * Set highest store limit::
-
-	void fscache_set_store_limit(struct fscache_object *object,
-				     loff_t i_size);
-
-     This sets the limit FS-Cache imposes on the highest byte it's willing to
-     try and store for a netfs.  Any page over this limit is automatically
-     rejected by fscache_read_alloc_page() and co with -ENOBUFS.
-
-
-   * Mark pages as being cached::
-
-	void fscache_mark_pages_cached(struct fscache_retrieval *op,
-				       struct pagevec *pagevec);
-
-     This marks a set of pages as being cached.  After this has been called,
-     the netfs must call fscache_uncache_page() to unmark the pages.
-
-
-   * Perform coherency check on an object::
-
-	enum fscache_checkaux fscache_check_aux(struct fscache_object *object,
-						const void *data,
-						uint16_t datalen);
-
-     This asks the netfs to perform a coherency check on an object that has
-     just been looked up.  The cookie attached to the object will determine the
-     netfs to use.  data and datalen should specify where the auxiliary data
-     retrieved from the cache can be found.
-
-     One of three values will be returned:
-
-	FSCACHE_CHECKAUX_OKAY
-	    The coherency data indicates the object is valid as is.
-
-	FSCACHE_CHECKAUX_NEEDS_UPDATE
-	    The coherency data needs updating, but otherwise the object is
-	    valid.
-
-	FSCACHE_CHECKAUX_OBSOLETE
-	    The coherency data indicates that the object is obsolete and should
-	    be discarded.
-
-
-   * Initialise a freshly allocated object::
-
-	void fscache_object_init(struct fscache_object *object);
-
-     This initialises all the fields in an object representation.
-
-
-   * Indicate the destruction of an object::
-
-	void fscache_object_destroyed(struct fscache_cache *cache);
-
-     This must be called to inform FS-Cache that an object that belonged to a
-     cache has been destroyed and deallocated.  This will allow continuation
-     of the cache withdrawal process when it is stopped pending destruction of
-     all the objects.
-
-
-   * Indicate negative lookup on an object::
-
-	void fscache_object_lookup_negative(struct fscache_object *object);
-
-     This is called to indicate to FS-Cache that a lookup process for an object
-     found a negative result.
-
-     This changes the state of an object to permit reads pending on lookup
-     completion to go off and start fetching data from the netfs server as it's
-     known at this point that there can't be any data in the cache.
-
-     This may be called multiple times on an object.  Only the first call is
-     significant - all subsequent calls are ignored.
-
-
-   * Indicate an object has been obtained::
-
-	void fscache_obtained_object(struct fscache_object *object);
-
-     This is called to indicate to FS-Cache that a lookup process for an object
-     produced a positive result, or that an object was created.  This should
-     only be called once for any particular object.
-
-     This changes the state of an object to indicate:
-
-	(1) if no call to fscache_object_lookup_negative() has been made on
-	    this object, that there may be data available, and that reads can
-	    now go and look for it; and
-
-        (2) that writes may now proceed against this object.
-
-
-   * Indicate that object lookup failed::
-
-	void fscache_object_lookup_error(struct fscache_object *object);
-
-     This marks an object as having encountered a fatal error (usually EIO)
-     and causes it to move into a state whereby it will be withdrawn as soon
-     as possible.
-
-
-   * Indicate that a stale object was found and discarded::
-
-	void fscache_object_retrying_stale(struct fscache_object *object);
-
-     This is called to indicate that the lookup procedure found an object in
-     the cache that the netfs decided was stale.  The object has been
-     discarded from the cache and the lookup will be performed again.
-
-
-   * Indicate that the caching backend killed an object::
-
-	void fscache_object_mark_killed(struct fscache_object *object,
-					enum fscache_why_object_killed why);
-
-     This is called to indicate that the cache backend preemptively killed an
-     object.  The why parameter should be set to indicate the reason:
+	void fscache_caching_failed(struct fscache_cookie *cookie);
 
-	FSCACHE_OBJECT_IS_STALE
-	    - the object was stale and needs discarding.
+     This notes that a the caching that was being done on a cookie failed in
+     some way, for instance the backing storage failed to be created or
+     invalidation failed and that no further I/O operations should take place
+     on it until the cache is reset.
 
-	FSCACHE_OBJECT_NO_SPACE
-	    - there was insufficient cache space
+   * Count I/O requests::
 
-	FSCACHE_OBJECT_WAS_RETIRED
-	    - the object was retired when relinquished.
+	void fscache_count_read(void);
+	void fscache_count_write(void);
 
-	FSCACHE_OBJECT_WAS_CULLED
-	    - the object was culled to make space.
+     These record reads and writes from/to the cache.  The numbers are
+     displayed in /proc/fs/fscache/stats.
 
+   * Count out-of-space errors::
 
-   * Get and release references on a retrieval record::
+	void fscache_count_no_write_space(void);
+	void fscache_count_no_create_space(void);
 
-	void fscache_get_retrieval(struct fscache_retrieval *op);
-	void fscache_put_retrieval(struct fscache_retrieval *op);
+     These record ENOSPC errors in the cache, divided into failures of data
+     writes and failures of filesystem object creations (e.g. mkdir).
 
-     These two functions are used to retain a retrieval record while doing
-     asynchronous data retrieval and block allocation.
+   * Count objects culled::
 
+	void fscache_count_culled(void);
 
-   * Enqueue a retrieval record for processing::
+     This records the culling of an object.
 
-	void fscache_enqueue_retrieval(struct fscache_retrieval *op);
+   * Get the cookie from a set of cache resources::
 
-     This enqueues a retrieval record for processing by the FS-Cache thread
-     pool.  One of the threads in the pool will invoke the retrieval record's
-     op->op.processor callback function.  This function may be called from
-     within the callback function.
+	struct fscache_cookie *fscache_cres_cookie(struct netfs_cache_resources *cres)
 
+     Pull a pointer to the cookie from the cache resources.  This may return a
+     NULL cookie if no cookie was set.
 
-   * List of object state names::
 
-	const char *fscache_object_states[];
+API Function Reference
+======================
 
-     For debugging purposes, this may be used to turn the state that an object
-     is in into a text string for display purposes.
+.. kernel-doc:: include/linux/fscache-cache.h
diff --git a/Documentation/filesystems/caching/cachefiles.rst b/Documentation/filesystems/caching/cachefiles.rst
index e58bc1fd312a..8bf396b76359 100644
--- a/Documentation/filesystems/caching/cachefiles.rst
+++ b/Documentation/filesystems/caching/cachefiles.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-===============================================
-CacheFiles: CACHE ON ALREADY MOUNTED FILESYSTEM
-===============================================
+===================================
+Cache on Already Mounted Filesystem
+===================================
 
 .. Contents:
 
diff --git a/Documentation/filesystems/caching/fscache.rst b/Documentation/filesystems/caching/fscache.rst
index 70de86922b6a..a74d7b052dc1 100644
--- a/Documentation/filesystems/caching/fscache.rst
+++ b/Documentation/filesystems/caching/fscache.rst
@@ -10,25 +10,25 @@ Overview
 This facility is a general purpose cache for network filesystems, though it
 could be used for caching other things such as ISO9660 filesystems too.
 
-FS-Cache mediates between cache backends (such as CacheFS) and network
+FS-Cache mediates between cache backends (such as CacheFiles) and network
 filesystems::
 
 	+---------+
-	|         |                        +--------------+
-	|   NFS   |--+                     |              |
-	|         |  |                 +-->|   CacheFS    |
-	+---------+  |   +----------+  |   |  /dev/hda5   |
-	             |   |          |  |   +--------------+
-	+---------+  +-->|          |  |
-	|         |      |          |--+
-	|   AFS   |----->| FS-Cache |
-	|         |      |          |--+
-	+---------+  +-->|          |  |
-	             |   |          |  |   +--------------+
-	+---------+  |   +----------+  |   |              |
-	|         |  |                 +-->|  CacheFiles  |
-	|  ISOFS  |--+                     |  /var/cache  |
-	|         |                        +--------------+
+	|         |                                    +--------------+
+	|   NFS   |--+                                 |              |
+	|         |  |                             +-->|   CacheFS    |
+	+---------+  |               +----------+  |   |  /dev/hda5   |
+	             |               |          |  |   +--------------+
+	+---------+  +-------------->|          |  |
+	|         |      +-------+   |          |--+
+	|   AFS   |----->|       |   | FS-Cache |
+	|         |      | netfs |-->|          |--+
+	+---------+  +-->|  lib  |   |          |  |
+	             |   |       |   |          |  |   +--------------+
+	+---------+  |   +-------+   +----------+  |   |              |
+	|         |  |                             +-->|  CacheFiles  |
+	|   9P    |--+                                 |  /var/cache  |
+	|         |                                    +--------------+
 	+---------+
 
 Or to look at it another way, FS-Cache is a module that provides a caching
@@ -84,101 +84,62 @@ then serving the pages out of that cache rather than the netfs inode because:
      one-off access of a small portion of it (such as might be done with the
      "file" program).
 
-It instead serves the cache out in PAGE_SIZE chunks as and when requested by
-the netfs('s) using it.
+It instead serves the cache out in chunks as and when requested by the netfs
+using it.
 
 
 FS-Cache provides the following facilities:
 
- (1) More than one cache can be used at once.  Caches can be selected
+   * More than one cache can be used at once.  Caches can be selected
      explicitly by use of tags.
 
- (2) Caches can be added / removed at any time.
+   * Caches can be added / removed at any time, even whilst being accessed.
 
- (3) The netfs is provided with an interface that allows either party to
+   * The netfs is provided with an interface that allows either party to
      withdraw caching facilities from a file (required for (2)).
 
- (4) The interface to the netfs returns as few errors as possible, preferring
+   * The interface to the netfs returns as few errors as possible, preferring
      rather to let the netfs remain oblivious.
 
- (5) Cookies are used to represent indices, files and other objects to the
-     netfs.  The simplest cookie is just a NULL pointer - indicating nothing
-     cached there.
-
- (6) The netfs is allowed to propose - dynamically - any index hierarchy it
-     desires, though it must be aware that the index search function is
-     recursive, stack space is limited, and indices can only be children of
-     indices.
-
- (7) Data I/O is done direct to and from the netfs's pages.  The netfs
-     indicates that page A is at index B of the data-file represented by cookie
-     C, and that it should be read or written.  The cache backend may or may
-     not start I/O on that page, but if it does, a netfs callback will be
-     invoked to indicate completion.  The I/O may be either synchronous or
-     asynchronous.
-
- (8) Cookies can be "retired" upon release.  At this point FS-Cache will mark
-     them as obsolete and the index hierarchy rooted at that point will get
-     recycled.
-
- (9) The netfs provides a "match" function for index searches.  In addition to
-     saying whether a match was made or not, this can also specify that an
-     entry should be updated or deleted.
-
-(10) As much as possible is done asynchronously.
-
-
-FS-Cache maintains a virtual indexing tree in which all indices, files, objects
-and pages are kept.  Bits of this tree may actually reside in one or more
-caches::
-
-                                            FSDEF
-                                              |
-                         +------------------------------------+
-                         |                                    |
-                        NFS                                  AFS
-                         |                                    |
-            +--------------------------+                +-----------+
-            |                          |                |           |
-         homedir                     mirror          afs.org   redhat.com
-            |                          |                            |
-      +------------+           +---------------+              +----------+
-      |            |           |               |              |          |
-    00001        00002       00007           00125        vol00001   vol00002
-      |            |           |               |                         |
-  +---+---+     +-----+      +---+      +------+------+            +-----+----+
-  |   |   |     |     |      |   |      |      |      |            |     |    |
- PG0 PG1 PG2   PG0  XATTR   PG0 PG1   DIRENT DIRENT DIRENT        R/W   R/O  Bak
-                      |                                            |
-                     PG0                                       +-------+
-                                                               |       |
-                                                             00001   00003
-                                                               |
-                                                           +---+---+
-                                                           |   |   |
-                                                          PG0 PG1 PG2
-
-In the example above, you can see two netfs's being backed: NFS and AFS.  These
-have different index hierarchies:
-
-   * The NFS primary index contains per-server indices.  Each server index is
-     indexed by NFS file handles to get data file objects.  Each data file
-     objects can have an array of pages, but may also have further child
-     objects, such as extended attributes and directory entries.  Extended
-     attribute objects themselves have page-array contents.
-
-   * The AFS primary index contains per-cell indices.  Each cell index contains
-     per-logical-volume indices.  Each of volume index contains up to three
-     indices for the read-write, read-only and backup mirrors of those volumes.
-     Each of these contains vnode data file objects, each of which contains an
-     array of pages.
-
-The very top index is the FS-Cache master index in which individual netfs's
-have entries.
-
-Any index object may reside in more than one cache, provided it only has index
-children.  Any index with non-index object children will be assumed to only
-reside in one cache.
+   * There are three types of cookie: cache, volume and data file cookies.
+     Cache cookies represent the cache as a whole and are not normally visible
+     to the netfs; the netfs gets a volume cookie to represent a collection of
+     files (typically something that a netfs would get for a superblock); and
+     data file cookies are used to cache data (something that would be got for
+     an inode).
+
+   * Volumes are matched using a key.  This is a printable string that is used
+     to encode all the information that might be needed to distinguish one
+     superblock, say, from another.  This would be a compound of things like
+     cell name or server address, volume name or share path.  It must be a
+     valid pathname.
+
+   * Cookies are matched using a key.  This is a binary blob and is used to
+     represent the object within a volume (so the volume key need not form
+     part of the blob).  This might include things like an inode number and
+     uniquifier or a file handle.
+
+   * Cookie resources are set up and pinned by marking the cookie in-use.
+     This prevents the backing resources from being culled.  Timed garbage
+     collection is employed to eliminate cookies that haven't been used for a
+     short while, thereby reducing resource overload.  This is intended to be
+     used when a file is opened or closed.
+
+     A cookie can be marked in-use multiple times simultaneously; each mark
+     must be unused.
+
+   * Begin/end access functions are provided to delay cache withdrawal for the
+     duration of an operation and prevent structs from being freed whilst
+     we're looking at them.
+
+   * Data I/O is done by asynchronous DIO to/from a buffer described by the
+     netfs using an iov_iter.
+
+   * An invalidation facility is available to discard data from the cache and
+     to deal with I/O that's in progress that is accessing old data.
+
+   * Cookies can be "retired" upon release, thereby causing the object to be
+     removed from the cache.
 
 
 The netfs API to FS-Cache can be found in:
@@ -189,11 +150,6 @@ The cache backend API to FS-Cache can be found in:
 
 	Documentation/filesystems/caching/backend-api.rst
 
-A description of the internal representations and object state machine can be
-found in:
-
-	Documentation/filesystems/caching/object.rst
-
 
 Statistical Information
 =======================
@@ -201,333 +157,162 @@ Statistical Information
 If FS-Cache is compiled with the following options enabled::
 
 	CONFIG_FSCACHE_STATS=y
-	CONFIG_FSCACHE_HISTOGRAM=y
 
-then it will gather certain statistics and display them through a number of
-proc files.
+then it will gather certain statistics and display them through:
 
-/proc/fs/fscache/stats
-----------------------
+	/proc/fs/fscache/stats
 
-     This shows counts of a number of events that can happen in FS-Cache:
+This shows counts of a number of events that can happen in FS-Cache:
 
 +--------------+-------+-------------------------------------------------------+
 |CLASS         |EVENT  |MEANING                                                |
 +==============+=======+=======================================================+
-|Cookies       |idx=N  |Number of index cookies allocated                      |
-+              +-------+-------------------------------------------------------+
-|              |dat=N  |Number of data storage cookies allocated               |
+|Cookies       |n=N    |Number of data storage cookies allocated               |
 +              +-------+-------------------------------------------------------+
-|              |spc=N  |Number of special cookies allocated                    |
-+--------------+-------+-------------------------------------------------------+
-|Objects       |alc=N  |Number of objects allocated                            |
-+              +-------+-------------------------------------------------------+
-|              |nal=N  |Number of object allocation failures                   |
+|              |v=N    |Number of volume index cookies allocated               |
 +              +-------+-------------------------------------------------------+
-|              |avl=N  |Number of objects that reached the available state     |
-+              +-------+-------------------------------------------------------+
-|              |ded=N  |Number of objects that reached the dead state          |
-+--------------+-------+-------------------------------------------------------+
-|ChkAux        |non=N  |Number of objects that didn't have a coherency check   |
+|              |vcol=N |Number of volume index key collisions                  |
 +              +-------+-------------------------------------------------------+
-|              |ok=N   |Number of objects that passed a coherency check        |
-+              +-------+-------------------------------------------------------+
-|              |upd=N  |Number of objects that needed a coherency data update  |
-+              +-------+-------------------------------------------------------+
-|              |obs=N  |Number of objects that were declared obsolete          |
-+--------------+-------+-------------------------------------------------------+
-|Pages         |mrk=N  |Number of pages marked as being cached                 |
-|              |unc=N  |Number of uncache page requests seen                   |
+|              |voom=N |Number of OOM events when allocating volume cookies    |
 +--------------+-------+-------------------------------------------------------+
 |Acquire       |n=N    |Number of acquire cookie requests seen                 |
 +              +-------+-------------------------------------------------------+
-|              |nul=N  |Number of acq reqs given a NULL parent                 |
-+              +-------+-------------------------------------------------------+
-|              |noc=N  |Number of acq reqs rejected due to no cache available  |
-+              +-------+-------------------------------------------------------+
 |              |ok=N   |Number of acq reqs succeeded                           |
 +              +-------+-------------------------------------------------------+
-|              |nbf=N  |Number of acq reqs rejected due to error               |
-+              +-------+-------------------------------------------------------+
 |              |oom=N  |Number of acq reqs failed on ENOMEM                    |
 +--------------+-------+-------------------------------------------------------+
-|Lookups       |n=N    |Number of lookup calls made on cache backends          |
+|LRU           |n=N    |Number of cookies currently on the LRU                 |
 +              +-------+-------------------------------------------------------+
-|              |neg=N  |Number of negative lookups made                        |
+|              |exp=N  |Number of cookies expired off of the LRU               |
 +              +-------+-------------------------------------------------------+
-|              |pos=N  |Number of positive lookups made                        |
+|              |rmv=N  |Number of cookies removed from the LRU                 |
 +              +-------+-------------------------------------------------------+
-|              |crt=N  |Number of objects created by lookup                    |
+|              |drp=N  |Number of LRU'd cookies relinquished/withdrawn         |
 +              +-------+-------------------------------------------------------+
-|              |tmo=N  |Number of lookups timed out and requeued               |
+|              |at=N   |Time till next LRU cull (jiffies)                      |
++--------------+-------+-------------------------------------------------------+
+|Invals        |n=N    |Number of invalidations                                |
 +--------------+-------+-------------------------------------------------------+
 |Updates       |n=N    |Number of update cookie requests seen                  |
 +              +-------+-------------------------------------------------------+
-|              |nul=N  |Number of upd reqs given a NULL parent                 |
+|              |rsz=N  |Number of resize requests                              |
 +              +-------+-------------------------------------------------------+
-|              |run=N  |Number of upd reqs granted CPU time                    |
+|              |rsn=N  |Number of skipped resize requests                      |
 +--------------+-------+-------------------------------------------------------+
 |Relinqs       |n=N    |Number of relinquish cookie requests seen              |
 +              +-------+-------------------------------------------------------+
-|              |nul=N  |Number of rlq reqs given a NULL parent                 |
+|              |rtr=N  |Number of rlq reqs with retire=true                    |
 +              +-------+-------------------------------------------------------+
-|              |wcr=N  |Number of rlq reqs waited on completion of creation    |
+|              |drop=N |Number of cookies no longer blocking re-acquisition    |
 +--------------+-------+-------------------------------------------------------+
-|AttrChg       |n=N    |Number of attribute changed requests seen              |
-+              +-------+-------------------------------------------------------+
-|              |ok=N   |Number of attr changed requests queued                 |
-+              +-------+-------------------------------------------------------+
-|              |nbf=N  |Number of attr changed rejected -ENOBUFS               |
+|NoSpace       |nwr=N  |Number of write requests refused due to lack of space  |
 +              +-------+-------------------------------------------------------+
-|              |oom=N  |Number of attr changed failed -ENOMEM                  |
+|              |ncr=N  |Number of create requests refused due to lack of space |
 +              +-------+-------------------------------------------------------+
-|              |run=N  |Number of attr changed ops given CPU time              |
+|              |cull=N |Number of objects culled to make space                 |
 +--------------+-------+-------------------------------------------------------+
-|Allocs        |n=N    |Number of allocation requests seen                     |
+|IO            |rd=N   |Number of read operations in the cache                 |
 +              +-------+-------------------------------------------------------+
-|              |ok=N   |Number of successful alloc reqs                        |
-+              +-------+-------------------------------------------------------+
-|              |wt=N   |Number of alloc reqs that waited on lookup completion  |
-+              +-------+-------------------------------------------------------+
-|              |nbf=N  |Number of alloc reqs rejected -ENOBUFS                 |
-+              +-------+-------------------------------------------------------+
-|              |int=N  |Number of alloc reqs aborted -ERESTARTSYS              |
-+              +-------+-------------------------------------------------------+
-|              |ops=N  |Number of alloc reqs submitted                         |
-+              +-------+-------------------------------------------------------+
-|              |owt=N  |Number of alloc reqs waited for CPU time               |
-+              +-------+-------------------------------------------------------+
-|              |abt=N  |Number of alloc reqs aborted due to object death       |
-+--------------+-------+-------------------------------------------------------+
-|Retrvls       |n=N    |Number of retrieval (read) requests seen               |
-+              +-------+-------------------------------------------------------+
-|              |ok=N   |Number of successful retr reqs                         |
-+              +-------+-------------------------------------------------------+
-|              |wt=N   |Number of retr reqs that waited on lookup completion   |
-+              +-------+-------------------------------------------------------+
-|              |nod=N  |Number of retr reqs returned -ENODATA                  |
-+              +-------+-------------------------------------------------------+
-|              |nbf=N  |Number of retr reqs rejected -ENOBUFS                  |
-+              +-------+-------------------------------------------------------+
-|              |int=N  |Number of retr reqs aborted -ERESTARTSYS               |
-+              +-------+-------------------------------------------------------+
-|              |oom=N  |Number of retr reqs failed -ENOMEM                     |
-+              +-------+-------------------------------------------------------+
-|              |ops=N  |Number of retr reqs submitted                          |
-+              +-------+-------------------------------------------------------+
-|              |owt=N  |Number of retr reqs waited for CPU time                |
-+              +-------+-------------------------------------------------------+
-|              |abt=N  |Number of retr reqs aborted due to object death        |
-+--------------+-------+-------------------------------------------------------+
-|Stores        |n=N    |Number of storage (write) requests seen                |
-+              +-------+-------------------------------------------------------+
-|              |ok=N   |Number of successful store reqs                        |
-+              +-------+-------------------------------------------------------+
-|              |agn=N  |Number of store reqs on a page already pending storage |
-+              +-------+-------------------------------------------------------+
-|              |nbf=N  |Number of store reqs rejected -ENOBUFS                 |
-+              +-------+-------------------------------------------------------+
-|              |oom=N  |Number of store reqs failed -ENOMEM                    |
-+              +-------+-------------------------------------------------------+
-|              |ops=N  |Number of store reqs submitted                         |
-+              +-------+-------------------------------------------------------+
-|              |run=N  |Number of store reqs granted CPU time                  |
-+              +-------+-------------------------------------------------------+
-|              |pgs=N  |Number of pages given store req processing time        |
-+              +-------+-------------------------------------------------------+
-|              |rxd=N  |Number of store reqs deleted from tracking tree        |
-+              +-------+-------------------------------------------------------+
-|              |olm=N  |Number of store reqs over store limit                  |
-+--------------+-------+-------------------------------------------------------+
-|VmScan        |nos=N  |Number of release reqs against pages with no           |
-|              |       |pending store                                          |
-+              +-------+-------------------------------------------------------+
-|              |gon=N  |Number of release reqs against pages stored by         |
-|              |       |time lock granted                                      |
-+              +-------+-------------------------------------------------------+
-|              |bsy=N  |Number of release reqs ignored due to in-progress store|
-+              +-------+-------------------------------------------------------+
-|              |can=N  |Number of page stores cancelled due to release req     |
-+--------------+-------+-------------------------------------------------------+
-|Ops           |pend=N |Number of times async ops added to pending queues      |
-+              +-------+-------------------------------------------------------+
-|              |run=N  |Number of times async ops given CPU time               |
-+              +-------+-------------------------------------------------------+
-|              |enq=N  |Number of times async ops queued for processing        |
-+              +-------+-------------------------------------------------------+
-|              |can=N  |Number of async ops cancelled                          |
-+              +-------+-------------------------------------------------------+
-|              |rej=N  |Number of async ops rejected due to object             |
-|              |       |lookup/create failure                                  |
-+              +-------+-------------------------------------------------------+
-|              |ini=N  |Number of async ops initialised                        |
-+              +-------+-------------------------------------------------------+
-|              |dfr=N  |Number of async ops queued for deferred release        |
-+              +-------+-------------------------------------------------------+
-|              |rel=N  |Number of async ops released                           |
-|              |       |(should equal ini=N when idle)                         |
-+              +-------+-------------------------------------------------------+
-|              |gc=N   |Number of deferred-release async ops garbage collected |
-+--------------+-------+-------------------------------------------------------+
-|CacheOp       |alo=N  |Number of in-progress alloc_object() cache ops         |
-+              +-------+-------------------------------------------------------+
-|              |luo=N  |Number of in-progress lookup_object() cache ops        |
-+              +-------+-------------------------------------------------------+
-|              |luc=N  |Number of in-progress lookup_complete() cache ops      |
-+              +-------+-------------------------------------------------------+
-|              |gro=N  |Number of in-progress grab_object() cache ops          |
-+              +-------+-------------------------------------------------------+
-|              |upo=N  |Number of in-progress update_object() cache ops        |
-+              +-------+-------------------------------------------------------+
-|              |dro=N  |Number of in-progress drop_object() cache ops          |
-+              +-------+-------------------------------------------------------+
-|              |pto=N  |Number of in-progress put_object() cache ops           |
-+              +-------+-------------------------------------------------------+
-|              |syn=N  |Number of in-progress sync_cache() cache ops           |
-+              +-------+-------------------------------------------------------+
-|              |atc=N  |Number of in-progress attr_changed() cache ops         |
-+              +-------+-------------------------------------------------------+
-|              |rap=N  |Number of in-progress read_or_alloc_page() cache ops   |
-+              +-------+-------------------------------------------------------+
-|              |ras=N  |Number of in-progress read_or_alloc_pages() cache ops  |
-+              +-------+-------------------------------------------------------+
-|              |alp=N  |Number of in-progress allocate_page() cache ops        |
-+              +-------+-------------------------------------------------------+
-|              |als=N  |Number of in-progress allocate_pages() cache ops       |
-+              +-------+-------------------------------------------------------+
-|              |wrp=N  |Number of in-progress write_page() cache ops           |
-+              +-------+-------------------------------------------------------+
-|              |ucp=N  |Number of in-progress uncache_page() cache ops         |
-+              +-------+-------------------------------------------------------+
-|              |dsp=N  |Number of in-progress dissociate_pages() cache ops     |
-+--------------+-------+-------------------------------------------------------+
-|CacheEv       |nsp=N  |Number of object lookups/creations rejected due to     |
-|              |       |lack of space                                          |
-+              +-------+-------------------------------------------------------+
-|              |stl=N  |Number of stale objects deleted                        |
-+              +-------+-------------------------------------------------------+
-|              |rtr=N  |Number of objects retired when relinquished            |
-+              +-------+-------------------------------------------------------+
-|              |cul=N  |Number of objects culled                               |
+|              |wr=N   |Number of write operations in the cache                |
 +--------------+-------+-------------------------------------------------------+
 
+Netfslib will also add some stats counters of its own.
 
 
-/proc/fs/fscache/histogram
---------------------------
+Cache List
+==========
 
-     ::
+FS-Cache provides a list of cache cookies:
 
-	cat /proc/fs/fscache/histogram
-	JIFS  SECS  OBJ INST  OP RUNS   OBJ RUNS  RETRV DLY RETRIEVLS
-	===== ===== ========= ========= ========= ========= =========
+	/proc/fs/fscache/cookies
 
-     This shows the breakdown of the number of times each amount of time
-     between 0 jiffies and HZ-1 jiffies a variety of tasks took to run.  The
-     columns are as follows:
+This will look something like::
 
-	=========	=======================================================
-	COLUMN		TIME MEASUREMENT
-	=========	=======================================================
-	OBJ INST	Length of time to instantiate an object
-	OP RUNS		Length of time a call to process an operation took
-	OBJ RUNS	Length of time a call to process an object event took
-	RETRV DLY	Time between an requesting a read and lookup completing
-	RETRIEVLS	Time between beginning and end of a retrieval
-	=========	=======================================================
+	# cat /proc/fs/fscache/caches
+	CACHE    REF   VOLS  OBJS  ACCES S NAME
+	======== ===== ===== ===== ===== = ===============
+	00000001     2     1  2123     1 A default
 
-     Each row shows the number of events that took a particular range of times.
-     Each step is 1 jiffy in size.  The JIFS column indicates the particular
-     jiffy range covered, and the SECS field the equivalent number of seconds.
+where the columns are:
 
+	=======	===============================================================
+	COLUMN	DESCRIPTION
+	=======	===============================================================
+	CACHE	Cache cookie debug ID (also appears in traces)
+	REF	Number of references on the cache cookie
+	VOLS	Number of volumes cookies in this cache
+	OBJS	Number of cache objects in use
+	ACCES	Number of accesses pinning the cache
+	S	State
+	NAME	Name of the cache.
+	=======	===============================================================
+
+The state can be (-) Inactive, (P)reparing, (A)ctive, (E)rror or (W)ithdrawing.
 
 
-Object List
+Volume List
 ===========
 
-If CONFIG_FSCACHE_OBJECT_LIST is enabled, the FS-Cache facility will maintain a
-list of all the objects currently allocated and allow them to be viewed
-through::
+FS-Cache provides a list of volume cookies:
 
-	/proc/fs/fscache/objects
+	/proc/fs/fscache/volumes
 
 This will look something like::
 
-	[root@andromeda ~]# head /proc/fs/fscache/objects
-	OBJECT   PARENT   STAT CHLDN OPS OOP IPR EX READS EM EV F S | NETFS_COOKIE_DEF TY FL NETFS_DATA       OBJECT_KEY, AUX_DATA
-	======== ======== ==== ===== === === === == ===== == == = = | ================ == == ================ ================
-	   17e4b        2 ACTV     0   0   0   0  0     0 7b  4 0 0 | NFS.fh           DT  0 ffff88001dd82820 010006017edcf8bbc93b43298fdfbe71e50b57b13a172c0117f38472, e567634700000000000000000000000063f2404a000000000000000000000000c9030000000000000000000063f2404a
-	   1693a        2 ACTV     0   0   0   0  0     0 7b  4 0 0 | NFS.fh           DT  0 ffff88002db23380 010006017edcf8bbc93b43298fdfbe71e50b57b1e0162c01a2df0ea6, 420ebc4a000000000000000000000000420ebc4a0000000000000000000000000e1801000000000000000000420ebc4a
+	VOLUME   REF   nCOOK ACC FL CACHE           KEY
+	======== ===== ===== === == =============== ================
+	00000001    55    54   1 00 default         afs,example.com,100058
 
-where the first set of columns before the '|' describe the object:
+where the columns are:
 
 	=======	===============================================================
 	COLUMN	DESCRIPTION
 	=======	===============================================================
-	OBJECT	Object debugging ID (appears as OBJ%x in some debug messages)
-	PARENT	Debugging ID of parent object
-	STAT	Object state
-	CHLDN	Number of child objects of this object
-	OPS	Number of outstanding operations on this object
-	OOP	Number of outstanding child object management operations
-	IPR
-	EX	Number of outstanding exclusive operations
-	READS	Number of outstanding read operations
-	EM	Object's event mask
-	EV	Events raised on this object
-	F	Object flags
-	S	Object work item busy state mask (1:pending 2:running)
+	VOLUME	The volume cookie debug ID (also appears in traces)
+	REF	Number of references on the volume cookie
+	nCOOK	Number of cookies in the volume
+	ACC	Number of accesses pinning the cache
+	FL	Flags on the volume cookie
+	CACHE	Name of the cache or "-"
+	KEY	The indexing key for the volume
 	=======	===============================================================
 
-and the second set of columns describe the object's cookie, if present:
-
-	================ ======================================================
-	COLUMN		 DESCRIPTION
-	================ ======================================================
-	NETFS_COOKIE_DEF Name of netfs cookie definition
-	TY		 Cookie type (IX - index, DT - data, hex - special)
-	FL		 Cookie flags
-	NETFS_DATA	 Netfs private data stored in the cookie
-	OBJECT_KEY	 Object key } 1 column, with separating comma
-	AUX_DATA	 Object aux data } presence may be configured
-	================ ======================================================
-
-The data shown may be filtered by attaching the a key to an appropriate keyring
-before viewing the file.  Something like::
-
-		keyctl add user fscache:objlist <restrictions> @s
-
-where <restrictions> are a selection of the following letters:
 
-	==	=========================================================
-	K	Show hexdump of object key (don't show if not given)
-	A	Show hexdump of object aux data (don't show if not given)
-	==	=========================================================
+Cookie List
+===========
 
-and the following paired letters:
+FS-Cache provides a list of cookies:
 
-	==	=========================================================
-	C	Show objects that have a cookie
-	c	Show objects that don't have a cookie
-	B	Show objects that are busy
-	b	Show objects that aren't busy
-	W	Show objects that have pending writes
-	w	Show objects that don't have pending writes
-	R	Show objects that have outstanding reads
-	r	Show objects that don't have outstanding reads
-	S	Show objects that have work queued
-	s	Show objects that don't have work queued
-	==	=========================================================
+	/proc/fs/fscache/cookies
 
-If neither side of a letter pair is given, then both are implied.  For example:
+This will look something like::
 
-	keyctl add user fscache:objlist KB @s
+	# head /proc/fs/fscache/cookies
+	COOKIE   VOLUME   REF ACT ACC S FL DEF
+	======== ======== === === === = == ================
+	00000435 00000001   1   0  -1 - 08 0000000201d080070000000000000000, 0000000000000000
+	00000436 00000001   1   0  -1 - 00 0000005601d080080000000000000000, 0000000000000051
+	00000437 00000001   1   0  -1 - 08 00023b3001d0823f0000000000000000, 0000000000000000
+	00000438 00000001   1   0  -1 - 08 0000005801d0807b0000000000000000, 0000000000000000
+	00000439 00000001   1   0  -1 - 08 00023b3201d080a10000000000000000, 0000000000000000
+	0000043a 00000001   1   0  -1 - 08 00023b3401d080a30000000000000000, 0000000000000000
+	0000043b 00000001   1   0  -1 - 08 00023b3601d080b30000000000000000, 0000000000000000
+	0000043c 00000001   1   0  -1 - 08 00023b3801d080b40000000000000000, 0000000000000000
 
-shows objects that are busy, and lists their object keys, but does not dump
-their auxiliary data.  It also implies "CcWwRrSs", but as 'B' is given, 'b' is
-not implied.
+where the columns are:
 
-By default all objects and all fields will be shown.
+	=======	===============================================================
+	COLUMN	DESCRIPTION
+	=======	===============================================================
+	COOKIE	The cookie debug ID (also appears in traces)
+	VOLUME	The parent volume cookie debug ID
+	REF	Number of references on the volume cookie
+	ACT	Number of times the cookie is marked for in use
+	ACC	Number of access pins in the cookie
+	S	State of the cookie
+	FL	Flags on the cookie
+	DEF	Key, auxiliary data
+	=======	===============================================================
 
 
 Debugging
@@ -549,10 +334,8 @@ This is a bitmask of debugging streams to enable:
 	3	8	Cookie management		Function entry trace
 	4	16					Function exit trace
 	5	32					General
-	6	64	Page handling			Function entry trace
-	7	128					Function exit trace
-	8	256					General
-	9	512	Operation management		Function entry trace
+	6-8						(Not used)
+	9	512	I/O operation management	Function entry trace
 	10	1024					Function exit trace
 	11	2048					General
 	=======	=======	===============================	=======================
@@ -560,6 +343,6 @@ This is a bitmask of debugging streams to enable:
 The appropriate set of values should be OR'd together and the result written to
 the control file.  For example::
 
-	echo $((1|8|64)) >/sys/module/fscache/parameters/debug
+	echo $((1|8|512)) >/sys/module/fscache/parameters/debug
 
 will turn on all function entry debugging.
diff --git a/Documentation/filesystems/caching/index.rst b/Documentation/filesystems/caching/index.rst
index 033da7ac7c6e..df4307124b00 100644
--- a/Documentation/filesystems/caching/index.rst
+++ b/Documentation/filesystems/caching/index.rst
@@ -7,8 +7,6 @@ Filesystem Caching
    :maxdepth: 2
 
    fscache
-   object
+   netfs-api
    backend-api
    cachefiles
-   netfs-api
-   operations
diff --git a/Documentation/filesystems/caching/netfs-api.rst b/Documentation/filesystems/caching/netfs-api.rst
index d9f14b8610ba..f84e9ffdf0b4 100644
--- a/Documentation/filesystems/caching/netfs-api.rst
+++ b/Documentation/filesystems/caching/netfs-api.rst
@@ -1,896 +1,452 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-===============================
-FS-Cache Network Filesystem API
-===============================
+==============================
+Network Filesystem Caching API
+==============================
 
-There's an API by which a network filesystem can make use of the FS-Cache
-facilities.  This is based around a number of principles:
+Fscache provides an API by which a network filesystem can make use of local
+caching facilities.  The API is arranged around a number of principles:
 
- (1) Caches can store a number of different object types.  There are two main
-     object types: indices and files.  The first is a special type used by
-     FS-Cache to make finding objects faster and to make retiring of groups of
-     objects easier.
+ (1) A cache is logically organised into volumes and data storage objects
+     within those volumes.
 
- (2) Every index, file or other object is represented by a cookie.  This cookie
-     may or may not have anything associated with it, but the netfs doesn't
-     need to care.
+ (2) Volumes and data storage objects are represented by various types of
+     cookie.
 
- (3) Barring the top-level index (one entry per cached netfs), the index
-     hierarchy for each netfs is structured according the whim of the netfs.
+ (3) Cookies have keys that distinguish them from their peers.
 
-This API is declared in <linux/fscache.h>.
+ (4) Cookies have coherency data that allows a cache to determine if the
+     cached data is still valid.
 
-.. This document contains the following sections:
-
-	 (1) Network filesystem definition
-	 (2) Index definition
-	 (3) Object definition
-	 (4) Network filesystem (un)registration
-	 (5) Cache tag lookup
-	 (6) Index registration
-	 (7) Data file registration
-	 (8) Miscellaneous object registration
- 	 (9) Setting the data file size
-	(10) Page alloc/read/write
-	(11) Page uncaching
-	(12) Index and data file consistency
-	(13) Cookie enablement
-	(14) Miscellaneous cookie operations
-	(15) Cookie unregistration
-	(16) Index invalidation
-	(17) Data file invalidation
-	(18) FS-Cache specific page flags.
-
-
-Network Filesystem Definition
-=============================
-
-FS-Cache needs a description of the network filesystem.  This is specified
-using a record of the following structure::
-
-	struct fscache_netfs {
-		uint32_t			version;
-		const char			*name;
-		struct fscache_cookie		*primary_index;
-		...
-	};
-
-This first two fields should be filled in before registration, and the third
-will be filled in by the registration function; any other fields should just be
-ignored and are for internal use only.
-
-The fields are:
-
- (1) The name of the netfs (used as the key in the toplevel index).
-
- (2) The version of the netfs (if the name matches but the version doesn't, the
-     entire in-cache hierarchy for this netfs will be scrapped and begun
-     afresh).
-
- (3) The cookie representing the primary index will be allocated according to
-     another parameter passed into the registration function.
-
-For example, kAFS (linux/fs/afs/) uses the following definitions to describe
-itself::
-
-	struct fscache_netfs afs_cache_netfs = {
-		.version	= 0,
-		.name		= "afs",
-	};
-
-
-Index Definition
-================
-
-Indices are used for two purposes:
-
- (1) To aid the finding of a file based on a series of keys (such as AFS's
-     "cell", "volume ID", "vnode ID").
-
- (2) To make it easier to discard a subset of all the files cached based around
-     a particular key - for instance to mirror the removal of an AFS volume.
-
-However, since it's unlikely that any two netfs's are going to want to define
-their index hierarchies in quite the same way, FS-Cache tries to impose as few
-restraints as possible on how an index is structured and where it is placed in
-the tree.  The netfs can even mix indices and data files at the same level, but
-it's not recommended.
-
-Each index entry consists of a key of indeterminate length plus some auxiliary
-data, also of indeterminate length.
-
-There are some limits on indices:
-
- (1) Any index containing non-index objects should be restricted to a single
-     cache.  Any such objects created within an index will be created in the
-     first cache only.  The cache in which an index is created can be
-     controlled by cache tags (see below).
-
- (2) The entry data must be atomically journallable, so it is limited to about
-     400 bytes at present.  At least 400 bytes will be available.
-
- (3) The depth of the index tree should be judged with care as the search
-     function is recursive.  Too many layers will run the kernel out of stack.
-
-
-Object Definition
-=================
-
-To define an object, a structure of the following type should be filled out::
-
-	struct fscache_cookie_def
-	{
-		uint8_t name[16];
-		uint8_t type;
-
-		struct fscache_cache_tag *(*select_cache)(
-			const void *parent_netfs_data,
-			const void *cookie_netfs_data);
-
-		enum fscache_checkaux (*check_aux)(void *cookie_netfs_data,
-						   const void *data,
-						   uint16_t datalen,
-						   loff_t object_size);
-
-		void (*get_context)(void *cookie_netfs_data, void *context);
-
-		void (*put_context)(void *cookie_netfs_data, void *context);
-
-		void (*mark_pages_cached)(void *cookie_netfs_data,
-					  struct address_space *mapping,
-					  struct pagevec *cached_pvec);
-	};
-
-This has the following fields:
-
- (1) The type of the object [mandatory].
-
-     This is one of the following values:
-
-	FSCACHE_COOKIE_TYPE_INDEX
-	    This defines an index, which is a special FS-Cache type.
-
-	FSCACHE_COOKIE_TYPE_DATAFILE
-	    This defines an ordinary data file.
-
-	Any other value between 2 and 255
-	    This defines an extraordinary object such as an XATTR.
-
- (2) The name of the object type (NUL terminated unless all 16 chars are used)
-     [optional].
-
- (3) A function to select the cache in which to store an index [optional].
-
-     This function is invoked when an index needs to be instantiated in a cache
-     during the instantiation of a non-index object.  Only the immediate index
-     parent for the non-index object will be queried.  Any indices above that
-     in the hierarchy may be stored in multiple caches.  This function does not
-     need to be supplied for any non-index object or any index that will only
-     have index children.
-
-     If this function is not supplied or if it returns NULL then the first
-     cache in the parent's list will be chosen, or failing that, the first
-     cache in the master list.
-
- (4) A function to check the auxiliary data [optional].
-
-     This function will be called to check that a match found in the cache for
-     this object is valid.  For instance with AFS it could check the auxiliary
-     data against the data version number returned by the server to determine
-     whether the index entry in a cache is still valid.
-
-     If this function is absent, it will be assumed that matching objects in a
-     cache are always valid.
-
-     The function is also passed the cache's idea of the object size and may
-     use this to manage coherency also.
-
-     If present, the function should return one of the following values:
-
-	FSCACHE_CHECKAUX_OKAY
-	    - the entry is okay as is
-
-	FSCACHE_CHECKAUX_NEEDS_UPDATE
-	    - the entry requires update
-
-	FSCACHE_CHECKAUX_OBSOLETE
-	    - the entry should be deleted
+ (5) I/O is done asynchronously where possible.
 
-     This function can also be used to extract data from the auxiliary data in
-     the cache and copy it into the netfs's structures.
+This API is used by::
 
- (5) A pair of functions to manage contexts for the completion callback
-     [optional].
+	#include <linux/fscache.h>.
 
-     The cache read/write functions are passed a context which is then passed
-     to the I/O completion callback function.  To ensure this context remains
-     valid until after the I/O completion is called, two functions may be
-     provided: one to get an extra reference on the context, and one to drop a
-     reference to it.
-
-     If the context is not used or is a type of object that won't go out of
-     scope, then these functions are not required.  These functions are not
-     required for indices as indices may not contain data.  These functions may
-     be called in interrupt context and so may not sleep.
-
- (6) A function to mark a page as retaining cache metadata [optional].
-
-     This is called by the cache to indicate that it is retaining in-memory
-     information for this page and that the netfs should uncache the page when
-     it has finished.  This does not indicate whether there's data on the disk
-     or not.  Note that several pages at once may be presented for marking.
-
-     The PG_fscache bit is set on the pages before this function would be
-     called, so the function need not be provided if this is sufficient.
-
-     This function is not required for indices as they're not permitted data.
-
- (7) A function to unmark all the pages retaining cache metadata [mandatory].
-
-     This is called by FS-Cache to indicate that a backing store is being
-     unbound from a cookie and that all the marks on the pages should be
-     cleared to prevent confusion.  Note that the cache will have torn down all
-     its tracking information so that the pages don't need to be explicitly
-     uncached.
-
-     This function is not required for indices as they're not permitted data.
-
-
-Network Filesystem (Un)registration
-===================================
-
-The first step is to declare the network filesystem to the cache.  This also
-involves specifying the layout of the primary index (for AFS, this would be the
-"cell" level).
-
-The registration function is::
-
-	int fscache_register_netfs(struct fscache_netfs *netfs);
-
-It just takes a pointer to the netfs definition.  It returns 0 or an error as
-appropriate.
-
-For kAFS, registration is done as follows::
-
-	ret = fscache_register_netfs(&afs_cache_netfs);
-
-The last step is, of course, unregistration::
-
-	void fscache_unregister_netfs(struct fscache_netfs *netfs);
-
-
-Cache Tag Lookup
-================
-
-FS-Cache permits the use of more than one cache.  To permit particular index
-subtrees to be bound to particular caches, the second step is to look up cache
-representation tags.  This step is optional; it can be left entirely up to
-FS-Cache as to which cache should be used.  The problem with doing that is that
-FS-Cache will always pick the first cache that was registered.
-
-To get the representation for a named tag::
-
-	struct fscache_cache_tag *fscache_lookup_cache_tag(const char *name);
-
-This takes a text string as the name and returns a representation of a tag.  It
-will never return an error.  It may return a dummy tag, however, if it runs out
-of memory; this will inhibit caching with this tag.
-
-Any representation so obtained must be released by passing it to this function::
-
-	void fscache_release_cache_tag(struct fscache_cache_tag *tag);
+.. This document contains the following sections:
 
-The tag will be retrieved by FS-Cache when it calls the object definition
-operation select_cache().
+	 (1) Overview
+	 (2) Volume registration
+	 (3) Data file registration
+	 (4) Declaring a cookie to be in use
+	 (5) Resizing a data file (truncation)
+	 (6) Data I/O API
+	 (7) Data file coherency
+	 (8) Data file invalidation
+	 (9) Write back resource management
+	(10) Caching of local modifications
+	(11) Page release and invalidation
+
+
+Overview
+========
+
+The fscache hierarchy is organised on two levels from a network filesystem's
+point of view.  The upper level represents "volumes" and the lower level
+represents "data storage objects".  These are represented by two types of
+cookie, hereafter referred to as "volume cookies" and "cookies".
+
+A network filesystem acquires a volume cookie for a volume using a volume key,
+which represents all the information that defines that volume (e.g. cell name
+or server address, volume ID or share name).  This must be rendered as a
+printable string that can be used as a directory name (ie. no '/' characters
+and shouldn't begin with a '.').  The maximum name length is one less than the
+maximum size of a filename component (allowing the cache backend one char for
+its own purposes).
+
+A filesystem would typically have a volume cookie for each superblock.
+
+The filesystem then acquires a cookie for each file within that volume using an
+object key.  Object keys are binary blobs and only need to be unique within
+their parent volume.  The cache backend is reponsible for rendering the binary
+blob into something it can use and may employ hash tables, trees or whatever to
+improve its ability to find an object.  This is transparent to the network
+filesystem.
+
+A filesystem would typically have a cookie for each inode, and would acquire it
+in iget and relinquish it when evicting the cookie.
+
+Once it has a cookie, the filesystem needs to mark the cookie as being in use.
+This causes fscache to send the cache backend off to look up/create resources
+for the cookie in the background, to check its coherency and, if necessary, to
+mark the object as being under modification.
+
+A filesystem would typically "use" the cookie in its file open routine and
+unuse it in file release and it needs to use the cookie around calls to
+truncate the cookie locally.  It *also* needs to use the cookie when the
+pagecache becomes dirty and unuse it when writeback is complete.  This is
+slightly tricky, and provision is made for it.
+
+When performing a read, write or resize on a cookie, the filesystem must first
+begin an operation.  This copies the resources into a holding struct and puts
+extra pins into the cache to stop cache withdrawal from tearing down the
+structures being used.  The actual operation can then be issued and conflicting
+invalidations can be detected upon completion.
+
+The filesystem is expected to use netfslib to access the cache, but that's not
+actually required and it can use the fscache I/O API directly.
+
+
+Volume Registration
+===================
+
+The first step for a network filsystem is to acquire a volume cookie for the
+volume it wants to access::
+
+	struct fscache_volume *
+	fscache_acquire_volume(const char *volume_key,
+			       const char *cache_name,
+			       const void *coherency_data,
+			       size_t coherency_len);
+
+This function creates a volume cookie with the specified volume key as its name
+and notes the coherency data.
+
+The volume key must be a printable string with no '/' characters in it.  It
+should begin with the name of the filesystem and should be no longer than 254
+characters.  It should uniquely represent the volume and will be matched with
+what's stored in the cache.
+
+The caller may also specify the name of the cache to use.  If specified,
+fscache will look up or create a cache cookie of that name and will use a cache
+of that name if it is online or comes online.  If no cache name is specified,
+it will use the first cache that comes to hand and set the name to that.
+
+The specified coherency data is stored in the cookie and will be matched
+against coherency data stored on disk.  The data pointer may be NULL if no data
+is provided.  If the coherency data doesn't match, the entire cache volume will
+be invalidated.
+
+This function can return errors such as EBUSY if the volume key is already in
+use by an acquired volume or ENOMEM if an allocation failure occured.  It may
+also return a NULL volume cookie if fscache is not enabled.  It is safe to
+pass a NULL cookie to any function that takes a volume cookie.  This will
+cause that function to do nothing.
+
+
+When the network filesystem has finished with a volume, it should relinquish it
+by calling::
+
+	void fscache_relinquish_volume(struct fscache_volume *volume,
+				       const void *coherency_data,
+				       bool invalidate);
+
+This will cause the volume to be committed or removed, and if sealed the
+coherency data will be set to the value supplied.  The amount of coherency data
+must match the length specified when the volume was acquired.  Note that all
+data cookies obtained in this volume must be relinquished before the volume is
+relinquished.
 
 
-Index Registration
-==================
+Data File Registration
+======================
 
-The third step is to inform FS-Cache about part of an index hierarchy that can
-be used to locate files.  This is done by requesting a cookie for each index in
-the path to the file::
+Once it has a volume cookie, a network filesystem can use it to acquire a
+cookie for data storage::
 
 	struct fscache_cookie *
-	fscache_acquire_cookie(struct fscache_cookie *parent,
-			       const struct fscache_object_def *def,
+	fscache_acquire_cookie(struct fscache_volume *volume,
+			       u8 advice,
 			       const void *index_key,
 			       size_t index_key_len,
 			       const void *aux_data,
 			       size_t aux_data_len,
-			       void *netfs_data,
-			       loff_t object_size,
-			       bool enable);
+			       loff_t object_size)
 
-This function creates an index entry in the index represented by parent,
-filling in the index entry by calling the operations pointed to by def.
+This creates the cookie in the volume using the specified index key.  The index
+key is a binary blob of the given length and must be unique for the volume.
+This is saved into the cookie.  There are no restrictions on the content, but
+its length shouldn't exceed about three quarters of the maximum filename length
+to allow for encoding.
 
-A unique key that represents the object within the parent must be pointed to by
-index_key and is of length index_key_len.
+The caller should also pass in a piece of coherency data in aux_data.  A buffer
+of size aux_data_len will be allocated and the coherency data copied in.  It is
+assumed that the size is invariant over time.  The coherency data is used to
+check the validity of data in the cache.  Functions are provided by which the
+coherency data can be updated.
 
-An optional blob of auxiliary data that is to be stored within the cache can be
-pointed to with aux_data and should be of length aux_data_len.  This would
-typically be used for storing coherency data.
+The file size of the object being cached should also be provided.  This may be
+used to trim the data and will be stored with the coherency data.
 
-The netfs may pass an arbitrary value in netfs_data and this will be presented
-to it in the event of any calling back.  This may also be used in tracing or
-logging of messages.
+This function never returns an error, though it may return a NULL cookie on
+allocation failure or if fscache is not enabled.  It is safe to pass in a NULL
+volume cookie and pass the NULL cookie returned to any function that takes it.
+This will cause that function to do nothing.
 
-The cache tracks the size of the data attached to an object and this set to be
-object_size.  For indices, this should be 0.  This value will be passed to the
-->check_aux() callback.
 
-Note that this function never returns an error - all errors are handled
-internally.  It may, however, return NULL to indicate no cookie.  It is quite
-acceptable to pass this token back to this function as the parent to another
-acquisition (or even to the relinquish cookie, read page and write page
-functions - see below).
+When the network filesystem has finished with a cookie, it should relinquish it
+by calling::
 
-Note also that no indices are actually created in a cache until a non-index
-object needs to be created somewhere down the hierarchy.  Furthermore, an index
-may be created in several different caches independently at different times.
-This is all handled transparently, and the netfs doesn't see any of it.
+	void fscache_relinquish_cookie(struct fscache_cookie *cookie,
+				       bool retire);
 
-A cookie will be created in the disabled state if enabled is false.  A cookie
-must be enabled to do anything with it.  A disabled cookie can be enabled by
-calling fscache_enable_cookie() (see below).
+This will cause fscache to either commit the storage backing the cookie or
+delete it.
 
-For example, with AFS, a cell would be added to the primary index.  This index
-entry would have a dependent inode containing volume mappings within this cell::
 
-	cell->cache =
-		fscache_acquire_cookie(afs_cache_netfs.primary_index,
-				       &afs_cell_cache_index_def,
-				       cell->name, strlen(cell->name),
-				       NULL, 0,
-				       cell, 0, true);
+Marking A Cookie In-Use
+=======================
 
-And then a particular volume could be added to that index by ID, creating
-another index for vnodes (AFS inode equivalents)::
+Once a cookie has been acquired by a network filesystem, the filesystem should
+tell fscache when it intends to use the cookie (typically done on file open)
+and should say when it has finished with it (typically on file close)::
 
-	volume->cache =
-		fscache_acquire_cookie(volume->cell->cache,
-				       &afs_volume_cache_index_def,
-				       &volume->vid, sizeof(volume->vid),
-				       NULL, 0,
-				       volume, 0, true);
+	void fscache_use_cookie(struct fscache_cookie *cookie,
+				bool will_modify);
+	void fscache_unuse_cookie(struct fscache_cookie *cookie,
+				  const void *aux_data,
+				  const loff_t *object_size);
 
+The *use* function tells fscache that it will use the cookie and, additionally,
+indicate if the user is intending to modify the contents locally.  If not yet
+done, this will trigger the cache backend to go and gather the resources it
+needs to access/store data in the cache.  This is done in the background, and
+so may not be complete by the time the function returns.
 
-Data File Registration
-======================
+The *unuse* function indicates that a filesystem has finished using a cookie.
+It optionally updates the stored coherency data and object size and then
+decreases the in-use counter.  When the last user unuses the cookie, it is
+scheduled for garbage collection.  If not reused within a short time, the
+resources will be released to reduce system resource consumption.
 
-The fourth step is to request a data file be created in the cache.  This is
-identical to index cookie acquisition.  The only difference is that the type in
-the object definition should be something other than index type::
+A cookie must be marked in-use before it can be accessed for read, write or
+resize - and an in-use mark must be kept whilst there is dirty data in the
+pagecache in order to avoid an oops due to trying to open a file during process
+exit.
 
-	vnode->cache =
-		fscache_acquire_cookie(volume->cache,
-				       &afs_vnode_cache_object_def,
-				       &key, sizeof(key),
-				       &aux, sizeof(aux),
-				       vnode, vnode->status.size, true);
+Note that in-use marks are cumulative.  For each time a cookie is marked
+in-use, it must be unused.
 
 
-Miscellaneous Object Registration
+Resizing A Data File (Truncation)
 =================================
 
-An optional step is to request an object of miscellaneous type be created in
-the cache.  This is almost identical to index cookie acquisition.  The only
-difference is that the type in the object definition should be something other
-than index type.  While the parent object could be an index, it's more likely
-it would be some other type of object such as a data file::
-
-	xattr->cache =
-		fscache_acquire_cookie(vnode->cache,
-				       &afs_xattr_cache_object_def,
-				       &xattr->name, strlen(xattr->name),
-				       NULL, 0,
-				       xattr, strlen(xattr->val), true);
-
-Miscellaneous objects might be used to store extended attributes or directory
-entries for example.
-
-
-Setting the Data File Size
-==========================
+If a network filesystem file is resized locally by truncation, the following
+should be called to notify the cache::
 
-The fifth step is to set the physical attributes of the file, such as its size.
-This doesn't automatically reserve any space in the cache, but permits the
-cache to adjust its metadata for data tracking appropriately::
+	void fscache_resize_cookie(struct fscache_cookie *cookie,
+				   loff_t new_size);
 
-	int fscache_attr_changed(struct fscache_cookie *cookie);
+The caller must have first marked the cookie in-use.  The cookie and the new
+size are passed in and the cache is synchronously resized.  This is expected to
+be called from ``->setattr()`` inode operation under the inode lock.
 
-The cache will return -ENOBUFS if there is no backing cache or if there is no
-space to allocate any extra metadata required in the cache.
 
-Note that attempts to read or write data pages in the cache over this size may
-be rebuffed with -ENOBUFS.
+Data I/O API
+============
 
-This operation schedules an attribute adjustment to happen asynchronously at
-some point in the future, and as such, it may happen after the function returns
-to the caller.  The attribute adjustment excludes read and write operations.
+To do data I/O operations directly through a cookie, the following functions
+are available::
 
+	int fscache_begin_read_operation(struct netfs_cache_resources *cres,
+					 struct fscache_cookie *cookie);
+	int fscache_read(struct netfs_cache_resources *cres,
+			 loff_t start_pos,
+			 struct iov_iter *iter,
+			 enum netfs_read_from_hole read_hole,
+			 netfs_io_terminated_t term_func,
+			 void *term_func_priv);
+	int fscache_write(struct netfs_cache_resources *cres,
+			  loff_t start_pos,
+			  struct iov_iter *iter,
+			  netfs_io_terminated_t term_func,
+			  void *term_func_priv);
 
-Page alloc/read/write
-=====================
+The *begin* function sets up an operation, attaching the resources required to
+the cache resources block from the cookie.  Assuming it doesn't return an error
+(for instance, it will return -ENOBUFS if given a NULL cookie, but otherwise do
+nothing), then one of the other two functions can be issued.
 
-And the sixth step is to store and retrieve pages in the cache.  There are
-three functions that are used to do this.
+The *read* and *write* functions initiate a direct-IO operation.  Both take the
+previously set up cache resources block, an indication of the start file
+position, and an I/O iterator that describes buffer and indicates the amount of
+data.
 
-Note:
+The read function also takes a parameter to indicate how it should handle a
+partially populated region (a hole) in the disk content.  This may be to ignore
+it, skip over an initial hole and place zeros in the buffer or give an error.
 
- (1) A page should not be re-read or re-allocated without uncaching it first.
-
- (2) A read or allocated page must be uncached when the netfs page is released
-     from the pagecache.
-
- (3) A page should only be written to the cache if previous read or allocated.
-
-This permits the cache to maintain its page tracking in proper order.
-
-
-PAGE READ
----------
-
-Firstly, the netfs should ask FS-Cache to examine the caches and read the
-contents cached for a particular page of a particular file if present, or else
-allocate space to store the contents if not::
+The read and write functions can be given an optional termination function that
+will be run on completion::
 
 	typedef
-	void (*fscache_rw_complete_t)(struct page *page,
-				      void *context,
-				      int error);
-
-	int fscache_read_or_alloc_page(struct fscache_cookie *cookie,
-				       struct page *page,
-				       fscache_rw_complete_t end_io_func,
-				       void *context,
-				       gfp_t gfp);
-
-The cookie argument must specify a cookie for an object that isn't an index,
-the page specified will have the data loaded into it (and is also used to
-specify the page number), and the gfp argument is used to control how any
-memory allocations made are satisfied.
-
-If the cookie indicates the inode is not cached:
-
- (1) The function will return -ENOBUFS.
-
-Else if there's a copy of the page resident in the cache:
-
- (1) The mark_pages_cached() cookie operation will be called on that page.
+	void (*netfs_io_terminated_t)(void *priv, ssize_t transferred_or_error,
+				      bool was_async);
 
- (2) The function will submit a request to read the data from the cache's
-     backing device directly into the page specified.
+If a termination function is given, the operation will be run asynchronously
+and the termination function will be called upon completion.  If not given, the
+operation will be run synchronously.  Note that in the asynchronous case, it is
+possible for the operation to complete before the function returns.
 
- (3) The function will return 0.
+Both the read and write functions end the operation when they complete,
+detaching any pinned resources.
 
- (4) When the read is complete, end_io_func() will be invoked with:
+The read operation will fail with ESTALE if invalidation occurred whilst the
+operation was ongoing.
 
-       * The netfs data supplied when the cookie was created.
 
-       * The page descriptor.
+Data File Coherency
+===================
 
-       * The context argument passed to the above function.  This will be
-         maintained with the get_context/put_context functions mentioned above.
-
-       * An argument that's 0 on success or negative for an error code.
-
-     If an error occurs, it should be assumed that the page contains no usable
-     data.  fscache_readpages_cancel() may need to be called.
-
-     end_io_func() will be called in process context if the read is results in
-     an error, but it might be called in interrupt context if the read is
-     successful.
-
-Otherwise, if there's not a copy available in cache, but the cache may be able
-to store the page:
-
- (1) The mark_pages_cached() cookie operation will be called on that page.
-
- (2) A block may be reserved in the cache and attached to the object at the
-     appropriate place.
-
- (3) The function will return -ENODATA.
-
-This function may also return -ENOMEM or -EINTR, in which case it won't have
-read any data from the cache.
-
-
-Page Allocate
--------------
-
-Alternatively, if there's not expected to be any data in the cache for a page
-because the file has been extended, a block can simply be allocated instead::
-
-	int fscache_alloc_page(struct fscache_cookie *cookie,
-			       struct page *page,
-			       gfp_t gfp);
-
-This is similar to the fscache_read_or_alloc_page() function, except that it
-never reads from the cache.  It will return 0 if a block has been allocated,
-rather than -ENODATA as the other would.  One or the other must be performed
-before writing to the cache.
-
-The mark_pages_cached() cookie operation will be called on the page if
-successful.
-
-
-Page Write
-----------
-
-Secondly, if the netfs changes the contents of the page (either due to an
-initial download or if a user performs a write), then the page should be
-written back to the cache::
-
-	int fscache_write_page(struct fscache_cookie *cookie,
-			       struct page *page,
-			       loff_t object_size,
-			       gfp_t gfp);
-
-The cookie argument must specify a data file cookie, the page specified should
-contain the data to be written (and is also used to specify the page number),
-object_size is the revised size of the object and the gfp argument is used to
-control how any memory allocations made are satisfied.
-
-The page must have first been read or allocated successfully and must not have
-been uncached before writing is performed.
-
-If the cookie indicates the inode is not cached then:
-
- (1) The function will return -ENOBUFS.
-
-Else if space can be allocated in the cache to hold this page:
-
- (1) PG_fscache_write will be set on the page.
-
- (2) The function will submit a request to write the data to cache's backing
-     device directly from the page specified.
-
- (3) The function will return 0.
-
- (4) When the write is complete PG_fscache_write is cleared on the page and
-     anyone waiting for that bit will be woken up.
-
-Else if there's no space available in the cache, -ENOBUFS will be returned.  It
-is also possible for the PG_fscache_write bit to be cleared when no write took
-place if unforeseen circumstances arose (such as a disk error).
-
-Writing takes place asynchronously.
-
-
-Multiple Page Read
-------------------
-
-A facility is provided to read several pages at once, as requested by the
-readpages() address space operation::
-
-	int fscache_read_or_alloc_pages(struct fscache_cookie *cookie,
-					struct address_space *mapping,
-					struct list_head *pages,
-					int *nr_pages,
-					fscache_rw_complete_t end_io_func,
-					void *context,
-					gfp_t gfp);
-
-This works in a similar way to fscache_read_or_alloc_page(), except:
-
- (1) Any page it can retrieve data for is removed from pages and nr_pages and
-     dispatched for reading to the disk.  Reads of adjacent pages on disk may
-     be merged for greater efficiency.
-
- (2) The mark_pages_cached() cookie operation will be called on several pages
-     at once if they're being read or allocated.
-
- (3) If there was an general error, then that error will be returned.
-
-     Else if some pages couldn't be allocated or read, then -ENOBUFS will be
-     returned.
-
-     Else if some pages couldn't be read but were allocated, then -ENODATA will
-     be returned.
-
-     Otherwise, if all pages had reads dispatched, then 0 will be returned, the
-     list will be empty and ``*nr_pages`` will be 0.
-
- (4) end_io_func will be called once for each page being read as the reads
-     complete.  It will be called in process context if error != 0, but it may
-     be called in interrupt context if there is no error.
-
-Note that a return of -ENODATA, -ENOBUFS or any other error does not preclude
-some of the pages being read and some being allocated.  Those pages will have
-been marked appropriately and will need uncaching.
-
-
-Cancellation of Unread Pages
-----------------------------
-
-If one or more pages are passed to fscache_read_or_alloc_pages() but not then
-read from the cache and also not read from the underlying filesystem then
-those pages will need to have any marks and reservations removed.  This can be
-done by calling::
-
-	void fscache_readpages_cancel(struct fscache_cookie *cookie,
-				      struct list_head *pages);
-
-prior to returning to the caller.  The cookie argument should be as passed to
-fscache_read_or_alloc_pages().  Every page in the pages list will be examined
-and any that have PG_fscache set will be uncached.
-
-
-Page Uncaching
-==============
-
-To uncache a page, this function should be called::
-
-	void fscache_uncache_page(struct fscache_cookie *cookie,
-				  struct page *page);
-
-This function permits the cache to release any in-memory representation it
-might be holding for this netfs page.  This function must be called once for
-each page on which the read or write page functions above have been called to
-make sure the cache's in-memory tracking information gets torn down.
-
-Note that pages can't be explicitly deleted from the a data file.  The whole
-data file must be retired (see the relinquish cookie function below).
-
-Furthermore, note that this does not cancel the asynchronous read or write
-operation started by the read/alloc and write functions, so the page
-invalidation functions must use::
-
-	bool fscache_check_page_write(struct fscache_cookie *cookie,
-				      struct page *page);
-
-to see if a page is being written to the cache, and::
-
-	void fscache_wait_on_page_write(struct fscache_cookie *cookie,
-					struct page *page);
-
-to wait for it to finish if it is.
-
-
-When releasepage() is being implemented, a special FS-Cache function exists to
-manage the heuristics of coping with vmscan trying to eject pages, which may
-conflict with the cache trying to write pages to the cache (which may itself
-need to allocate memory)::
-
-	bool fscache_maybe_release_page(struct fscache_cookie *cookie,
-					struct page *page,
-					gfp_t gfp);
-
-This takes the netfs cookie, and the page and gfp arguments as supplied to
-releasepage().  It will return false if the page cannot be released yet for
-some reason and if it returns true, the page has been uncached and can now be
-released.
-
-To make a page available for release, this function may wait for an outstanding
-storage request to complete, or it may attempt to cancel the storage request -
-in which case the page will not be stored in the cache this time.
-
-
-Bulk Image Page Uncache
------------------------
-
-A convenience routine is provided to perform an uncache on all the pages
-attached to an inode.  This assumes that the pages on the inode correspond on a
-1:1 basis with the pages in the cache::
-
-	void fscache_uncache_all_inode_pages(struct fscache_cookie *cookie,
-					     struct inode *inode);
-
-This takes the netfs cookie that the pages were cached with and the inode that
-the pages are attached to.  This function will wait for pages to finish being
-written to the cache and for the cache to finish with the page generally.  No
-error is returned.
-
-
-Index and Data File consistency
-===============================
-
-To find out whether auxiliary data for an object is up to data within the
-cache, the following function can be called::
-
-	int fscache_check_consistency(struct fscache_cookie *cookie,
-				      const void *aux_data);
-
-This will call back to the netfs to check whether the auxiliary data associated
-with a cookie is correct; if aux_data is non-NULL, it will update the auxiliary
-data buffer first.  It returns 0 if it is and -ESTALE if it isn't; it may also
-return -ENOMEM and -ERESTARTSYS.
-
-To request an update of the index data for an index or other object, the
-following function should be called::
+To request an update of the coherency data and file size on a cookie, the
+following should be called::
 
 	void fscache_update_cookie(struct fscache_cookie *cookie,
-				   const void *aux_data);
-
-This function will update the cookie's auxiliary data buffer from aux_data if
-that is non-NULL and then schedule this to be stored on disk.  The update
-method in the parent index definition will be called to transfer the data.
-
-Note that partial updates may happen automatically at other times, such as when
-data blocks are added to a data file object.
-
-
-Cookie Enablement
-=================
-
-Cookies exist in one of two states: enabled and disabled.  If a cookie is
-disabled, it ignores all attempts to acquire child cookies; check, update or
-invalidate its state; allocate, read or write backing pages - though it is
-still possible to uncache pages and relinquish the cookie.
-
-The initial enablement state is set by fscache_acquire_cookie(), but the cookie
-can be enabled or disabled later.  To disable a cookie, call::
-
-	void fscache_disable_cookie(struct fscache_cookie *cookie,
-				    const void *aux_data,
-    				    bool invalidate);
-
-If the cookie is not already disabled, this locks the cookie against other
-enable and disable ops, marks the cookie as being disabled, discards or
-invalidates any backing objects and waits for cessation of activity on any
-associated object before unlocking the cookie.
-
-All possible failures are handled internally.  The caller should consider
-calling fscache_uncache_all_inode_pages() afterwards to make sure all page
-markings are cleared up.
-
-Cookies can be enabled or reenabled with::
-
-    	void fscache_enable_cookie(struct fscache_cookie *cookie,
 				   const void *aux_data,
-				   loff_t object_size,
-    				   bool (*can_enable)(void *data),
-    				   void *data)
-
-If the cookie is not already enabled, this locks the cookie against other
-enable and disable ops, invokes can_enable() and, if the cookie is not an index
-cookie, will begin the procedure of acquiring backing objects.
-
-The optional can_enable() function is passed the data argument and returns a
-ruling as to whether or not enablement should actually be permitted to begin.
+				   const loff_t *object_size);
 
-All possible failures are handled internally.  The cookie will only be marked
-as enabled if provisional backing objects are allocated.
+This will update the cookie's coherency data and/or file size.
 
-The object's data size is updated from object_size and is passed to the
-->check_aux() function.
 
-In both cases, the cookie's auxiliary data buffer is updated from aux_data if
-that is non-NULL inside the enablement lock before proceeding.
-
-
-Miscellaneous Cookie operations
-===============================
+Data File Invalidation
+======================
 
-There are a number of operations that can be used to control cookies:
+Sometimes it will be necessary to invalidate an object that contains data.
+Typically this will be necessary when the server informs the network filesystem
+of a remote third-party change - at which point the filesystem has to throw
+away the state and cached data that it had for an file and reload from the
+server.
 
-     * Cookie pinning::
+To indicate that a cache object should be invalidated, the following should be
+called::
 
-	int fscache_pin_cookie(struct fscache_cookie *cookie);
-	void fscache_unpin_cookie(struct fscache_cookie *cookie);
+	void fscache_invalidate(struct fscache_cookie *cookie,
+				const void *aux_data,
+				loff_t size,
+				unsigned int flags);
 
-     These operations permit data cookies to be pinned into the cache and to
-     have the pinning removed.  They are not permitted on index cookies.
+This increases the invalidation counter in the cookie to cause outstanding
+reads to fail with -ESTALE, sets the coherency data and file size from the
+information supplied, blocks new I/O on the cookie and dispatches the cache to
+go and get rid of the old data.
 
-     The pinning function will return 0 if successful, -ENOBUFS in the cookie
-     isn't backed by a cache, -EOPNOTSUPP if the cache doesn't support pinning,
-     -ENOSPC if there isn't enough space to honour the operation, -ENOMEM or
-     -EIO if there's any other problem.
+Invalidation runs asynchronously in a worker thread so that it doesn't block
+too much.
 
-   * Data space reservation::
 
-	int fscache_reserve_space(struct fscache_cookie *cookie, loff_t size);
+Write-Back Resource Management
+==============================
 
-     This permits a netfs to request cache space be reserved to store up to the
-     given amount of a file.  It is permitted to ask for more than the current
-     size of the file to allow for future file expansion.
+To write data to the cache from network filesystem writeback, the cache
+resources required need to be pinned at the point the modification is made (for
+instance when the page is marked dirty) as it's not possible to open a file in
+a thread that's exiting.
 
-     If size is given as zero then the reservation will be cancelled.
+The following facilities are provided to manage this:
 
-     The function will return 0 if successful, -ENOBUFS in the cookie isn't
-     backed by a cache, -EOPNOTSUPP if the cache doesn't support reservations,
-     -ENOSPC if there isn't enough space to honour the operation, -ENOMEM or
-     -EIO if there's any other problem.
+ * An inode flag, ``I_PINNING_FSCACHE_WB``, is provided to indicate that an
+   in-use is held on the cookie for this inode.  It can only be changed if the
+   the inode lock is held.
 
-     Note that this doesn't pin an object in a cache; it can still be culled to
-     make space if it's not in use.
+ * A flag, ``unpinned_fscache_wb`` is placed in the ``writeback_control``
+   struct that gets set if ``__writeback_single_inode()`` clears
+   ``I_PINNING_FSCACHE_WB`` because all the dirty pages were cleared.
 
+To support this, the following functions are provided::
 
-Cookie Unregistration
-=====================
+	int fscache_set_page_dirty(struct page *page,
+				   struct fscache_cookie *cookie);
+	void fscache_unpin_writeback(struct writeback_control *wbc,
+				     struct fscache_cookie *cookie);
+	void fscache_clear_inode_writeback(struct fscache_cookie *cookie,
+					   struct inode *inode,
+					   const void *aux);
 
-To get rid of a cookie, this function should be called::
+The *set* function is intended to be called from the filesystem's
+``set_page_dirty`` address space operation.  If ``I_PINNING_FSCACHE_WB`` is not
+set, it sets that flag and increments the use count on the cookie (the caller
+must already have called ``fscache_use_cookie()``).
 
-	void fscache_relinquish_cookie(struct fscache_cookie *cookie,
-				       const void *aux_data,
-				       bool retire);
+The *unpin* function is intended to be called from the filesystem's
+``write_inode`` superblock operation.  It cleans up after writing by unusing
+the cookie if unpinned_fscache_wb is set in the writeback_control struct.
 
-If retire is non-zero, then the object will be marked for recycling, and all
-copies of it will be removed from all active caches in which it is present.
-Not only that but all child objects will also be retired.
+The *clear* function is intended to be called from the netfs's ``evict_inode``
+superblock operation.  It must be called *after*
+``truncate_inode_pages_final()``, but *before* ``clear_inode()``.  This cleans
+up any hanging ``I_PINNING_FSCACHE_WB``.  It also allows the coherency data to
+be updated.
 
-If retire is zero, then the object may be available again when next the
-acquisition function is called.  Retirement here will overrule the pinning on a
-cookie.
 
-The cookie's auxiliary data will be updated from aux_data if that is non-NULL
-so that the cache can lazily update it on disk.
+Caching of Local Modifications
+==============================
 
-One very important note - relinquish must NOT be called for a cookie unless all
-the cookies for "child" indices, objects and pages have been relinquished
-first.
+If a network filesystem has locally modified data that it wants to write to the
+cache, it needs to mark the pages to indicate that a write is in progress, and
+if the mark is already present, it needs to wait for it to be removed first
+(presumably due to an already in-progress operation).  This prevents multiple
+competing DIO writes to the same storage in the cache.
 
+Firstly, the netfs should determine if caching is available by doing something
+like::
 
-Index Invalidation
-==================
+	bool caching = fscache_cookie_enabled(cookie);
 
-There is no direct way to invalidate an index subtree.  To do this, the caller
-should relinquish and retire the cookie they have, and then acquire a new one.
+If caching is to be attempted, pages should be waited for and then marked using
+the following functions provided by the netfs helper library::
 
+	void set_page_fscache(struct page *page);
+	void wait_on_page_fscache(struct page *page);
+	int wait_on_page_fscache_killable(struct page *page);
 
-Data File Invalidation
-======================
+Once all the pages in the span are marked, the netfs can ask fscache to
+schedule a write of that region::
 
-Sometimes it will be necessary to invalidate an object that contains data.
-Typically this will be necessary when the server tells the netfs of a foreign
-change - at which point the netfs has to throw away all the state it had for an
-inode and reload from the server.
+	void fscache_write_to_cache(struct fscache_cookie *cookie,
+				    struct address_space *mapping,
+				    loff_t start, size_t len, loff_t i_size,
+				    netfs_io_terminated_t term_func,
+				    void *term_func_priv,
+				    bool caching)
 
-To indicate that a cache object should be invalidated, the following function
-can be called::
+And if an error occurs before that point is reached, the marks can be removed
+by calling::
 
-	void fscache_invalidate(struct fscache_cookie *cookie);
+	void fscache_clear_page_bits(struct fscache_cookie *cookie,
+				     struct address_space *mapping,
+				     loff_t start, size_t len,
+				     bool caching)
 
-This can be called with spinlocks held as it defers the work to a thread pool.
-All extant storage, retrieval and attribute change ops at this point are
-cancelled and discarded.  Some future operations will be rejected until the
-cache has had a chance to insert a barrier in the operations queue.  After
-that, operations will be queued again behind the invalidation operation.
+In both of these functions, the cookie representing the cache object to be
+written to and a pointer to the mapping to which the source pages are attached
+are passed in; start and len indicate the size of the region that's going to be
+written (it doesn't have to align to page boundaries necessarily, but it does
+have to align to DIO boundaries on the backing filesystem).  The caching
+parameter indicates if caching should be skipped, and if false, the functions
+do nothing.
 
-The invalidation operation will perform an attribute change operation and an
-auxiliary data update operation as it is very likely these will have changed.
+The write function takes some additional parameters: i_size indicates the size
+of the netfs file and term_func indicates an optional completion function, to
+which term_func_priv will be passed, along with the error or amount written.
 
-Using the following function, the netfs can wait for the invalidation operation
-to have reached a point at which it can start submitting ordinary operations
-once again::
+Note that the write function will always run asynchronously and will unmark all
+the pages upon completion before calling term_func.
 
-	void fscache_wait_on_invalidate(struct fscache_cookie *cookie);
 
+Page Release and Invalidation
+=============================
 
-FS-cache Specific Page Flag
-===========================
+Fscache keeps track of whether we have any data in the cache yet for a cache
+object we've just created.  It knows it doesn't have to do any reading until it
+has done a write and then the page it wrote from has been released by the VM,
+after which it *has* to look in the cache.
 
-FS-Cache makes use of a page flag, PG_private_2, for its own purpose.  This is
-given the alternative name PG_fscache.
+To inform fscache that a page might now be in the cache, the following function
+should be called from the ``releasepage`` address space op::
 
-PG_fscache is used to indicate that the page is known by the cache, and that
-the cache must be informed if the page is going to go away.  It's an indication
-to the netfs that the cache has an interest in this page, where an interest may
-be a pointer to it, resources allocated or reserved for it, or I/O in progress
-upon it.
+	void fscache_note_page_release(struct fscache_cookie *cookie);
 
-The netfs can use this information in methods such as releasepage() to
-determine whether it needs to uncache a page or update it.
+if the page has been released (ie. releasepage returned true).
 
-Furthermore, if this bit is set, releasepage() and invalidatepage() operations
-will be called on a page to get rid of it, even if PG_private is not set.  This
-allows caching to attempted on a page before read_cache_pages() to be called
-after fscache_read_or_alloc_pages() as the former will try and release pages it
-was given under certain circumstances.
+Page release and page invalidation should also wait for any mark left on the
+page to say that a DIO write is underway from that page::
 
-This bit does not overlap with such as PG_private.  This means that FS-Cache
-can be used with a filesystem that uses the block buffering code.
+	void wait_on_page_fscache(struct page *page);
+	int wait_on_page_fscache_killable(struct page *page);
 
-There are a number of operations defined on this flag::
 
-	int PageFsCache(struct page *page);
-	void SetPageFsCache(struct page *page)
-	void ClearPageFsCache(struct page *page)
-	int TestSetPageFsCache(struct page *page)
-	int TestClearPageFsCache(struct page *page)
+API Function Reference
+======================
 
-These functions are bit test, bit set, bit clear, bit test and set and bit
-test and clear operations on PG_fscache.
+.. kernel-doc:: include/linux/fscache.h
diff --git a/Documentation/filesystems/caching/object.rst b/Documentation/filesystems/caching/object.rst
deleted file mode 100644
index ce0e043ccd33..000000000000
--- a/Documentation/filesystems/caching/object.rst
+++ /dev/null
@@ -1,313 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-====================================================
-In-Kernel Cache Object Representation and Management
-====================================================
-
-By: David Howells <dhowells@redhat.com>
-
-.. Contents:
-
- (*) Representation
-
- (*) Object management state machine.
-
-     - Provision of cpu time.
-     - Locking simplification.
-
- (*) The set of states.
-
- (*) The set of events.
-
-
-Representation
-==============
-
-FS-Cache maintains an in-kernel representation of each object that a netfs is
-currently interested in.  Such objects are represented by the fscache_cookie
-struct and are referred to as cookies.
-
-FS-Cache also maintains a separate in-kernel representation of the objects that
-a cache backend is currently actively caching.  Such objects are represented by
-the fscache_object struct.  The cache backends allocate these upon request, and
-are expected to embed them in their own representations.  These are referred to
-as objects.
-
-There is a 1:N relationship between cookies and objects.  A cookie may be
-represented by multiple objects - an index may exist in more than one cache -
-or even by no objects (it may not be cached).
-
-Furthermore, both cookies and objects are hierarchical.  The two hierarchies
-correspond, but the cookies tree is a superset of the union of the object trees
-of multiple caches::
-
-	    NETFS INDEX TREE               :      CACHE 1     :      CACHE 2
-	                                   :                  :
-	                                   :   +-----------+  :
-	                          +----------->|  IObject  |  :
-	      +-----------+       |        :   +-----------+  :
-	      |  ICookie  |-------+        :         |        :
-	      +-----------+       |        :         |        :   +-----------+
-	            |             +------------------------------>|  IObject  |
-	            |                      :         |        :   +-----------+
-	            |                      :         V        :         |
-	            |                      :   +-----------+  :         |
-	            V             +----------->|  IObject  |  :         |
-	      +-----------+       |        :   +-----------+  :         |
-	      |  ICookie  |-------+        :         |        :         V
-	      +-----------+       |        :         |        :   +-----------+
-	            |             +------------------------------>|  IObject  |
-	      +-----+-----+                :         |        :   +-----------+
-	      |           |                :         |        :         |
-	      V           |                :         V        :         |
-	+-----------+     |                :   +-----------+  :         |
-	|  ICookie  |------------------------->|  IObject  |  :         |
-	+-----------+     |                :   +-----------+  :         |
-	      |           V                :         |        :         V
-	      |     +-----------+          :         |        :   +-----------+
-	      |     |  ICookie  |-------------------------------->|  IObject  |
-	      |     +-----------+          :         |        :   +-----------+
-	      V           |                :         V        :         |
-	+-----------+     |                :   +-----------+  :         |
-	|  DCookie  |------------------------->|  DObject  |  :         |
-	+-----------+     |                :   +-----------+  :         |
-	                  |                :                  :         |
-	          +-------+-------+        :                  :         |
-	          |               |        :                  :         |
-	          V               V        :                  :         V
-	    +-----------+   +-----------+  :                  :   +-----------+
-	    |  DCookie  |   |  DCookie  |------------------------>|  DObject  |
-	    +-----------+   +-----------+  :                  :   +-----------+
-	                                   :                  :
-
-In the above illustration, ICookie and IObject represent indices and DCookie
-and DObject represent data storage objects.  Indices may have representation in
-multiple caches, but currently, non-index objects may not.  Objects of any type
-may also be entirely unrepresented.
-
-As far as the netfs API goes, the netfs is only actually permitted to see
-pointers to the cookies.  The cookies themselves and any objects attached to
-those cookies are hidden from it.
-
-
-Object Management State Machine
-===============================
-
-Within FS-Cache, each active object is managed by its own individual state
-machine.  The state for an object is kept in the fscache_object struct, in
-object->state.  A cookie may point to a set of objects that are in different
-states.
-
-Each state has an action associated with it that is invoked when the machine
-wakes up in that state.  There are four logical sets of states:
-
- (1) Preparation: states that wait for the parent objects to become ready.  The
-     representations are hierarchical, and it is expected that an object must
-     be created or accessed with respect to its parent object.
-
- (2) Initialisation: states that perform lookups in the cache and validate
-     what's found and that create on disk any missing metadata.
-
- (3) Normal running: states that allow netfs operations on objects to proceed
-     and that update the state of objects.
-
- (4) Termination: states that detach objects from their netfs cookies, that
-     delete objects from disk, that handle disk and system errors and that free
-     up in-memory resources.
-
-
-In most cases, transitioning between states is in response to signalled events.
-When a state has finished processing, it will usually set the mask of events in
-which it is interested (object->event_mask) and relinquish the worker thread.
-Then when an event is raised (by calling fscache_raise_event()), if the event
-is not masked, the object will be queued for processing (by calling
-fscache_enqueue_object()).
-
-
-Provision of CPU Time
----------------------
-
-The work to be done by the various states was given CPU time by the threads of
-the slow work facility.  This was used in preference to the workqueue facility
-because:
-
- (1) Threads may be completely occupied for very long periods of time by a
-     particular work item.  These state actions may be doing sequences of
-     synchronous, journalled disk accesses (lookup, mkdir, create, setxattr,
-     getxattr, truncate, unlink, rmdir, rename).
-
- (2) Threads may do little actual work, but may rather spend a lot of time
-     sleeping on I/O.  This means that single-threaded and 1-per-CPU-threaded
-     workqueues don't necessarily have the right numbers of threads.
-
-
-Locking Simplification
-----------------------
-
-Because only one worker thread may be operating on any particular object's
-state machine at once, this simplifies the locking, particularly with respect
-to disconnecting the netfs's representation of a cache object (fscache_cookie)
-from the cache backend's representation (fscache_object) - which may be
-requested from either end.
-
-
-The Set of States
-=================
-
-The object state machine has a set of states that it can be in.  There are
-preparation states in which the object sets itself up and waits for its parent
-object to transit to a state that allows access to its children:
-
- (1) State FSCACHE_OBJECT_INIT.
-
-     Initialise the object and wait for the parent object to become active.  In
-     the cache, it is expected that it will not be possible to look an object
-     up from the parent object, until that parent object itself has been looked
-     up.
-
-There are initialisation states in which the object sets itself up and accesses
-disk for the object metadata:
-
- (2) State FSCACHE_OBJECT_LOOKING_UP.
-
-     Look up the object on disk, using the parent as a starting point.
-     FS-Cache expects the cache backend to probe the cache to see whether this
-     object is represented there, and if it is, to see if it's valid (coherency
-     management).
-
-     The cache should call fscache_object_lookup_negative() to indicate lookup
-     failure for whatever reason, and should call fscache_obtained_object() to
-     indicate success.
-
-     At the completion of lookup, FS-Cache will let the netfs go ahead with
-     read operations, no matter whether the file is yet cached.  If not yet
-     cached, read operations will be immediately rejected with ENODATA until
-     the first known page is uncached - as to that point there can be no data
-     to be read out of the cache for that file that isn't currently also held
-     in the pagecache.
-
- (3) State FSCACHE_OBJECT_CREATING.
-
-     Create an object on disk, using the parent as a starting point.  This
-     happens if the lookup failed to find the object, or if the object's
-     coherency data indicated what's on disk is out of date.  In this state,
-     FS-Cache expects the cache to create
-
-     The cache should call fscache_obtained_object() if creation completes
-     successfully, fscache_object_lookup_negative() otherwise.
-
-     At the completion of creation, FS-Cache will start processing write
-     operations the netfs has queued for an object.  If creation failed, the
-     write ops will be transparently discarded, and nothing recorded in the
-     cache.
-
-There are some normal running states in which the object spends its time
-servicing netfs requests:
-
- (4) State FSCACHE_OBJECT_AVAILABLE.
-
-     A transient state in which pending operations are started, child objects
-     are permitted to advance from FSCACHE_OBJECT_INIT state, and temporary
-     lookup data is freed.
-
- (5) State FSCACHE_OBJECT_ACTIVE.
-
-     The normal running state.  In this state, requests the netfs makes will be
-     passed on to the cache.
-
- (6) State FSCACHE_OBJECT_INVALIDATING.
-
-     The object is undergoing invalidation.  When the state comes here, it
-     discards all pending read, write and attribute change operations as it is
-     going to clear out the cache entirely and reinitialise it.  It will then
-     continue to the FSCACHE_OBJECT_UPDATING state.
-
- (7) State FSCACHE_OBJECT_UPDATING.
-
-     The state machine comes here to update the object in the cache from the
-     netfs's records.  This involves updating the auxiliary data that is used
-     to maintain coherency.
-
-And there are terminal states in which an object cleans itself up, deallocates
-memory and potentially deletes stuff from disk:
-
- (8) State FSCACHE_OBJECT_LC_DYING.
-
-     The object comes here if it is dying because of a lookup or creation
-     error.  This would be due to a disk error or system error of some sort.
-     Temporary data is cleaned up, and the parent is released.
-
- (9) State FSCACHE_OBJECT_DYING.
-
-     The object comes here if it is dying due to an error, because its parent
-     cookie has been relinquished by the netfs or because the cache is being
-     withdrawn.
-
-     Any child objects waiting on this one are given CPU time so that they too
-     can destroy themselves.  This object waits for all its children to go away
-     before advancing to the next state.
-
-(10) State FSCACHE_OBJECT_ABORT_INIT.
-
-     The object comes to this state if it was waiting on its parent in
-     FSCACHE_OBJECT_INIT, but its parent died.  The object will destroy itself
-     so that the parent may proceed from the FSCACHE_OBJECT_DYING state.
-
-(11) State FSCACHE_OBJECT_RELEASING.
-(12) State FSCACHE_OBJECT_RECYCLING.
-
-     The object comes to one of these two states when dying once it is rid of
-     all its children, if it is dying because the netfs relinquished its
-     cookie.  In the first state, the cached data is expected to persist, and
-     in the second it will be deleted.
-
-(13) State FSCACHE_OBJECT_WITHDRAWING.
-
-     The object transits to this state if the cache decides it wants to
-     withdraw the object from service, perhaps to make space, but also due to
-     error or just because the whole cache is being withdrawn.
-
-(14) State FSCACHE_OBJECT_DEAD.
-
-     The object transits to this state when the in-memory object record is
-     ready to be deleted.  The object processor shouldn't ever see an object in
-     this state.
-
-
-The Set of Events
------------------
-
-There are a number of events that can be raised to an object state machine:
-
- FSCACHE_OBJECT_EV_UPDATE
-     The netfs requested that an object be updated.  The state machine will ask
-     the cache backend to update the object, and the cache backend will ask the
-     netfs for details of the change through its cookie definition ops.
-
- FSCACHE_OBJECT_EV_CLEARED
-     This is signalled in two circumstances:
-
-     (a) when an object's last child object is dropped and
-
-     (b) when the last operation outstanding on an object is completed.
-
-     This is used to proceed from the dying state.
-
- FSCACHE_OBJECT_EV_ERROR
-     This is signalled when an I/O error occurs during the processing of some
-     object.
-
- FSCACHE_OBJECT_EV_RELEASE, FSCACHE_OBJECT_EV_RETIRE
-     These are signalled when the netfs relinquishes a cookie it was using.
-     The event selected depends on whether the netfs asks for the backing
-     object to be retired (deleted) or retained.
-
- FSCACHE_OBJECT_EV_WITHDRAW
-     This is signalled when the cache backend wants to withdraw an object.
-     This means that the object will have to be detached from the netfs's
-     cookie.
-
-Because the withdrawing releasing/retiring events are all handled by the object
-state machine, it doesn't matter if there's a collision with both ends trying
-to sever the connection at the same time.  The state machine can just pick
-which one it wants to honour, and that effects the other.
diff --git a/Documentation/filesystems/caching/operations.rst b/Documentation/filesystems/caching/operations.rst
deleted file mode 100644
index 9983e1675447..000000000000
--- a/Documentation/filesystems/caching/operations.rst
+++ /dev/null
@@ -1,210 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-================================
-Asynchronous Operations Handling
-================================
-
-By: David Howells <dhowells@redhat.com>
-
-.. Contents:
-
- (*) Overview.
-
- (*) Operation record initialisation.
-
- (*) Parameters.
-
- (*) Procedure.
-
- (*) Asynchronous callback.
-
-
-Overview
-========
-
-FS-Cache has an asynchronous operations handling facility that it uses for its
-data storage and retrieval routines.  Its operations are represented by
-fscache_operation structs, though these are usually embedded into some other
-structure.
-
-This facility is available to and expected to be used by the cache backends,
-and FS-Cache will create operations and pass them off to the appropriate cache
-backend for completion.
-
-To make use of this facility, <linux/fscache-cache.h> should be #included.
-
-
-Operation Record Initialisation
-===============================
-
-An operation is recorded in an fscache_operation struct::
-
-	struct fscache_operation {
-		union {
-			struct work_struct fast_work;
-			struct slow_work slow_work;
-		};
-		unsigned long		flags;
-		fscache_operation_processor_t processor;
-		...
-	};
-
-Someone wanting to issue an operation should allocate something with this
-struct embedded in it.  They should initialise it by calling::
-
-	void fscache_operation_init(struct fscache_operation *op,
-				    fscache_operation_release_t release);
-
-with the operation to be initialised and the release function to use.
-
-The op->flags parameter should be set to indicate the CPU time provision and
-the exclusivity (see the Parameters section).
-
-The op->fast_work, op->slow_work and op->processor flags should be set as
-appropriate for the CPU time provision (see the Parameters section).
-
-FSCACHE_OP_WAITING may be set in op->flags prior to each submission of the
-operation and waited for afterwards.
-
-
-Parameters
-==========
-
-There are a number of parameters that can be set in the operation record's flag
-parameter.  There are three options for the provision of CPU time in these
-operations:
-
- (1) The operation may be done synchronously (FSCACHE_OP_MYTHREAD).  A thread
-     may decide it wants to handle an operation itself without deferring it to
-     another thread.
-
-     This is, for example, used in read operations for calling readpages() on
-     the backing filesystem in CacheFiles.  Although readpages() does an
-     asynchronous data fetch, the determination of whether pages exist is done
-     synchronously - and the netfs does not proceed until this has been
-     determined.
-
-     If this option is to be used, FSCACHE_OP_WAITING must be set in op->flags
-     before submitting the operation, and the operating thread must wait for it
-     to be cleared before proceeding::
-
-		wait_on_bit(&op->flags, FSCACHE_OP_WAITING,
-			    TASK_UNINTERRUPTIBLE);
-
-
- (2) The operation may be fast asynchronous (FSCACHE_OP_FAST), in which case it
-     will be given to keventd to process.  Such an operation is not permitted
-     to sleep on I/O.
-
-     This is, for example, used by CacheFiles to copy data from a backing fs
-     page to a netfs page after the backing fs has read the page in.
-
-     If this option is used, op->fast_work and op->processor must be
-     initialised before submitting the operation::
-
-		INIT_WORK(&op->fast_work, do_some_work);
-
-
- (3) The operation may be slow asynchronous (FSCACHE_OP_SLOW), in which case it
-     will be given to the slow work facility to process.  Such an operation is
-     permitted to sleep on I/O.
-
-     This is, for example, used by FS-Cache to handle background writes of
-     pages that have just been fetched from a remote server.
-
-     If this option is used, op->slow_work and op->processor must be
-     initialised before submitting the operation::
-
-		fscache_operation_init_slow(op, processor)
-
-
-Furthermore, operations may be one of two types:
-
- (1) Exclusive (FSCACHE_OP_EXCLUSIVE).  Operations of this type may not run in
-     conjunction with any other operation on the object being operated upon.
-
-     An example of this is the attribute change operation, in which the file
-     being written to may need truncation.
-
- (2) Shareable.  Operations of this type may be running simultaneously.  It's
-     up to the operation implementation to prevent interference between other
-     operations running at the same time.
-
-
-Procedure
-=========
-
-Operations are used through the following procedure:
-
- (1) The submitting thread must allocate the operation and initialise it
-     itself.  Normally this would be part of a more specific structure with the
-     generic op embedded within.
-
- (2) The submitting thread must then submit the operation for processing using
-     one of the following two functions::
-
-	int fscache_submit_op(struct fscache_object *object,
-			      struct fscache_operation *op);
-
-	int fscache_submit_exclusive_op(struct fscache_object *object,
-					struct fscache_operation *op);
-
-     The first function should be used to submit non-exclusive ops and the
-     second to submit exclusive ones.  The caller must still set the
-     FSCACHE_OP_EXCLUSIVE flag.
-
-     If successful, both functions will assign the operation to the specified
-     object and return 0.  -ENOBUFS will be returned if the object specified is
-     permanently unavailable.
-
-     The operation manager will defer operations on an object that is still
-     undergoing lookup or creation.  The operation will also be deferred if an
-     operation of conflicting exclusivity is in progress on the object.
-
-     If the operation is asynchronous, the manager will retain a reference to
-     it, so the caller should put their reference to it by passing it to::
-
-	void fscache_put_operation(struct fscache_operation *op);
-
- (3) If the submitting thread wants to do the work itself, and has marked the
-     operation with FSCACHE_OP_MYTHREAD, then it should monitor
-     FSCACHE_OP_WAITING as described above and check the state of the object if
-     necessary (the object might have died while the thread was waiting).
-
-     When it has finished doing its processing, it should call
-     fscache_op_complete() and fscache_put_operation() on it.
-
- (4) The operation holds an effective lock upon the object, preventing other
-     exclusive ops conflicting until it is released.  The operation can be
-     enqueued for further immediate asynchronous processing by adjusting the
-     CPU time provisioning option if necessary, eg::
-
-	op->flags &= ~FSCACHE_OP_TYPE;
-	op->flags |= ~FSCACHE_OP_FAST;
-
-     and calling::
-
-	void fscache_enqueue_operation(struct fscache_operation *op)
-
-     This can be used to allow other things to have use of the worker thread
-     pools.
-
-
-Asynchronous Callback
-=====================
-
-When used in asynchronous mode, the worker thread pool will invoke the
-processor method with a pointer to the operation.  This should then get at the
-container struct by using container_of()::
-
-	static void fscache_write_op(struct fscache_operation *_op)
-	{
-		struct fscache_storage *op =
-			container_of(_op, struct fscache_storage, op);
-	...
-	}
-
-The caller holds a reference on the operation, and will invoke
-fscache_put_operation() when the processor function returns.  The processor
-function is at liberty to call fscache_enqueue_operation() or to take extra
-references.
diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 375baca7edcd..136f8da3d0e2 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -454,7 +454,8 @@ operation table looks like the following::
 			    void *term_func_priv);
 
 		int (*prepare_write)(struct netfs_cache_resources *cres,
-				     loff_t *_start, size_t *_len, loff_t i_size);
+				     loff_t *_start, size_t *_len, loff_t i_size,
+				     bool no_space_allocated_yet);
 
 		int (*write)(struct netfs_cache_resources *cres,
 			     loff_t start_pos,
@@ -515,11 +516,14 @@ The methods defined in the table are:
 
  * ``prepare_write()``
 
-   [Required] Called to adjust a write to the cache and check that there is
-   sufficient space in the cache.  The start and length values indicate the
-   size of the write that netfslib is proposing, and this can be adjusted by
-   the cache to respect DIO boundaries.  The file size is passed for
-   information.
+   [Required] Called to prepare a write to the cache to take place.  This
+   involves checking to see whether the cache has sufficient space to honour
+   the write.  ``*_start`` and ``*_len`` indicate the region to be written; the
+   region can be shrunk or it can be expanded to a page boundary either way as
+   necessary to align for direct I/O.  i_size holds the size of the object and
+   is provided for reference.  no_space_allocated_yet is set to true if the
+   caller is certain that no data has been written to that region - for example
+   if it tried to do a read from there already.
 
  * ``write()``
 


