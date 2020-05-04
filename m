Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653AA1C4230
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgEDRQq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:16:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27445 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730469AbgEDRQp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5tMnk9BcSjmx0akz2diPyjusrCozNs7hYlmYsTAzDXE=;
        b=WXPFdqwexjxaU0hjB19Ibz0F1k6Kqq3wpxqCA4XKggmZhor8bhKnkrACuZy3fYcj2d2yIj
        xAzwedVRVZleuVjp+WMBGuuijAnwnCB8iCWJItSwDqXFWYLaFcfmoJT/DgPQdzDgEI2Lmt
        TwLvxYmfilRpSt2IOi3VPTXdkJ6jggM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-OjuoWTsVO4-XAd_9J_vzZw-1; Mon, 04 May 2020 13:16:36 -0400
X-MC-Unique: OjuoWTsVO4-XAd_9J_vzZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A241D835B46;
        Mon,  4 May 2020 17:16:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C4C860BEC;
        Mon,  4 May 2020 17:16:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 59/61] fscache: Remove the obsolete API bits from the
 documentation
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:16:30 +0100
Message-ID: <158861259038.340223.11841617389255663030.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the obsolete API bits from the documentation preparatory to writing
up the new API.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/filesystems/caching/backend-api.txt |  424 ----------------
 Documentation/filesystems/caching/netfs-api.txt   |  554 +--------------------
 Documentation/filesystems/caching/object.txt      |  240 ---------
 Documentation/filesystems/caching/operations.txt  |  213 --------
 4 files changed, 21 insertions(+), 1410 deletions(-)
 delete mode 100644 Documentation/filesystems/caching/operations.txt

diff --git a/Documentation/filesystems/caching/backend-api.txt b/Documentation/filesystems/caching/backend-api.txt
index c418280c915f..710d10408fcb 100644
--- a/Documentation/filesystems/caching/backend-api.txt
+++ b/Documentation/filesystems/caching/backend-api.txt
@@ -108,27 +108,14 @@ RELEVANT DATA STRUCTURES
  (*) Index/Data file FS-Cache representation cookie:
 
 	struct fscache_cookie {
-		struct fscache_object_def	*def;
-		struct fscache_netfs		*netfs;
-		void				*netfs_data;
 		...
 	};
 
-     The fields that might be of use to the backend describe the object
-     definition, the netfs definition and the netfs's data for this cookie.
-     The object definition contain functions supplied by the netfs for loading
-     and matching index entries; these are required to provide some of the
-     cache operations.
-
 
  (*) In-cache object representation:
 
 	struct fscache_object {
 		int				debug_id;
-		enum {
-			FSCACHE_OBJECT_RECYCLING,
-			...
-		}				state;
 		spinlock_t			lock
 		struct fscache_cache		*cache;
 		struct fscache_cookie		*cookie;
@@ -145,71 +132,8 @@ RELEVANT DATA STRUCTURES
      using "OBJ%x" to be consistent with FS-Cache.
 
      Each object contains a pointer to the cookie that represents the object it
-     is backing.  An object should retired when put_object() is called if it is
-     in state FSCACHE_OBJECT_RECYCLING.  The fscache_object struct should be
-     initialised by calling fscache_object_init(object).
-
-
- (*) FS-Cache operation record:
-
-	struct fscache_operation {
-		atomic_t		usage;
-		struct fscache_object	*object;
-		unsigned long		flags;
-	#define FSCACHE_OP_EXCLUSIVE
-		void (*processor)(struct fscache_operation *op);
-		void (*release)(struct fscache_operation *op);
-		...
-	};
-
-     FS-Cache has a pool of threads that it uses to give CPU time to the
-     various asynchronous operations that need to be done as part of driving
-     the cache.  These are represented by the above structure.  The processor
-     method is called to give the op CPU time, and the release method to get
-     rid of it when its usage count reaches 0.
-
-     An operation can be made exclusive upon an object by setting the
-     appropriate flag before enqueuing it with fscache_enqueue_operation().  If
-     an operation needs more processing time, it should be enqueued again.
-
-
- (*) FS-Cache retrieval operation record:
-
-	struct fscache_retrieval {
-		struct fscache_operation op;
-		struct address_space	*mapping;
-		struct list_head	*to_do;
-		...
-	};
-
-     A structure of this type is allocated by FS-Cache to record retrieval and
-     allocation requests made by the netfs.  This struct is then passed to the
-     backend to do the operation.  The backend may get extra refs to it by
-     calling fscache_get_retrieval() and refs may be discarded by calling
-     fscache_put_retrieval().
-
-     A retrieval operation can be used by the backend to do retrieval work.  To
-     do this, the retrieval->op.processor method pointer should be set
-     appropriately by the backend and fscache_enqueue_retrieval() called to
-     submit it to the thread pool.  CacheFiles, for example, uses this to queue
-     page examination when it detects PG_lock being cleared.
-
-     The to_do field is an empty list available for the cache backend to use as
-     it sees fit.
-
-
- (*) FS-Cache storage operation record:
-
-	struct fscache_storage {
-		struct fscache_operation op;
-		pgoff_t			store_limit;
-		...
-	};
-
-     A structure of this type is allocated by FS-Cache to record outstanding
-     writes to be made.  FS-Cache itself enqueues this operation and invokes
-     the write_page() method on the object at appropriate times to effect
-     storage.
+     is backing.  The fscache_object struct should be initialised by calling
+     fscache_object_init(object).
 
 
 ================
@@ -238,11 +162,6 @@ performed on the denizens of the cache.  These are held in a structure of type:
      cookie in a particular cache.  fscache_object_init() should be called on
      the object to initialise it prior to returning.
 
-     This function may also be used to parse the index key to be used for
-     multiple lookup calls to turn it into a more convenient form.  FS-Cache
-     will call the lookup_complete() method to allow the cache to release the
-     form once lookup is complete or aborted.
-
 
  (*) Look up and create object [mandatory]:
 
@@ -252,16 +171,6 @@ performed on the denizens of the cache.  These are held in a structure of type:
      allocated and attached to the cookie.  This should instantiate that object
      in the cache if it can.
 
-     The method should call fscache_object_lookup_negative() as soon as
-     possible if it determines the object doesn't exist in the cache.  If the
-     object is found to exist and the netfs indicates that it is valid then
-     fscache_obtained_object() should be called once the object is in a
-     position to have data stored in it.  Similarly, fscache_obtained_object()
-     should also be called once a non-present object has been created.
-
-     If a lookup error occurs, fscache_object_lookup_error() should be called
-     to abort the lookup of that object.
-
 
  (*) Release lookup data [mandatory]:
 
@@ -276,17 +185,7 @@ performed on the denizens of the cache.  These are held in a structure of type:
 	struct fscache_object *(*grab_object)(struct fscache_object *object)
 
      This method is called to increment the reference count on an object.  It
-     may fail (for instance if the cache is being withdrawn) by returning NULL.
-     It should return the object pointer if successful.
-
-
- (*) Lock/Unlock object [mandatory]:
-
-	void (*lock_object)(struct fscache_object *object)
-	void (*unlock_object)(struct fscache_object *object)
-
-     These methods are used to exclusively lock an object.  It must be possible
-     to schedule with the lock held, so a spinlock isn't sufficient.
+     should return the object pointer.
 
 
  (*) Pin/Unpin object [optional]:
@@ -299,34 +198,19 @@ performed on the denizens of the cache.  These are held in a structure of type:
      enough space in the cache to permit this.
 
 
- (*) Check coherency state of an object [mandatory]:
-
-	int (*check_consistency)(struct fscache_object *object)
-
-     This method is called to have the cache check the saved auxiliary data of
-     the object against the netfs's idea of the state.  0 should be returned
-     if they're consistent and -ESTALE otherwise.  -ENOMEM and -ERESTARTSYS
-     may also be returned.
-
  (*) Update object [mandatory]:
 
 	int (*update_object)(struct fscache_object *object)
 
      This is called to update the index entry for the specified object.  The
-     new information should be in object->cookie->netfs_data.  This can be
-     obtained by calling object->cookie->def->get_aux()/get_attr().
+     new information should be in object->cookie->aux and ->object_size.
 
 
  (*) Invalidate data object [mandatory]:
 
 	int (*invalidate_object)(struct fscache_operation *op)
 
-     This is called to invalidate a data object (as pointed to by op->object).
-     All the data stored for this object should be discarded and an
-     attr_changed operation should be performed.  The caller will follow up
-     with an object update operation.
-
-     fscache_op_complete() must be called on op before returning.
+     This is called to invalidate a data object.
 
 
  (*) Discard object [mandatory]:
@@ -334,8 +218,7 @@ performed on the denizens of the cache.  These are held in a structure of type:
 	void (*drop_object)(struct fscache_object *object)
 
      This method is called to indicate that an object has been unbound from its
-     cookie, and that the cache should release the object's resources and
-     retire it if it's in state FSCACHE_OBJECT_RECYCLING.
+     cookie.
 
      This method should not attempt to release any references held by the
      caller.  The caller will invoke the put_object() method as appropriate.
@@ -351,41 +234,12 @@ performed on the denizens of the cache.  These are held in a structure of type:
 
  (*) Synchronise a cache [mandatory]:
 
-	void (*sync)(struct fscache_cache *cache)
+	void (*sync_cache)(struct fscache_cache *cache)
 
      This is called to ask the backend to synchronise a cache with its backing
      device.
 
 
- (*) Dissociate a cache [mandatory]:
-
-	void (*dissociate_pages)(struct fscache_cache *cache)
-
-     This is called to ask a cache to perform any page dissociations as part of
-     cache withdrawal.
-
-
- (*) Notification that the attributes on a netfs file changed [mandatory]:
-
-	int (*attr_changed)(struct fscache_object *object);
-
-     This is called to indicate to the cache that certain attributes on a netfs
-     file have changed (for example the maximum size a file may reach).  The
-     cache can read these from the netfs by calling the cookie's get_attr()
-     method.
-
-     The cache may use the file size information to reserve space on the cache.
-     It should also call fscache_set_store_limit() to indicate to FS-Cache the
-     highest byte it's willing to store for an object.
-
-     This method may return -ve if an error occurred or the cache object cannot
-     be expanded.  In such a case, the object will be withdrawn from service.
-
-     This operation is run asynchronously from FS-Cache's thread pool, and
-     storage and retrieval operations from the netfs are excluded during the
-     execution of this operation.
-
-
  (*) Reserve cache space for an object's data [optional]:
 
 	int (*reserve_space)(struct fscache_object *object, loff_t size);
@@ -404,125 +258,6 @@ performed on the denizens of the cache.  These are held in a structure of type:
      size if larger than that already.
 
 
- (*) Request page be read from cache [mandatory]:
-
-	int (*read_or_alloc_page)(struct fscache_retrieval *op,
-				  struct page *page,
-				  gfp_t gfp)
-
-     This is called to attempt to read a netfs page from the cache, or to
-     reserve a backing block if not.  FS-Cache will have done as much checking
-     as it can before calling, but most of the work belongs to the backend.
-
-     If there's no page in the cache, then -ENODATA should be returned if the
-     backend managed to reserve a backing block; -ENOBUFS or -ENOMEM if it
-     didn't.
-
-     If there is suitable data in the cache, then a read operation should be
-     queued and 0 returned.  When the read finishes, fscache_end_io() should be
-     called.
-
-     The fscache_mark_pages_cached() should be called for the page if any cache
-     metadata is retained.  This will indicate to the netfs that the page needs
-     explicit uncaching.  This operation takes a pagevec, thus allowing several
-     pages to be marked at once.
-
-     The retrieval record pointed to by op should be retained for each page
-     queued and released when I/O on the page has been formally ended.
-     fscache_get/put_retrieval() are available for this purpose.
-
-     The retrieval record may be used to get CPU time via the FS-Cache thread
-     pool.  If this is desired, the op->op.processor should be set to point to
-     the appropriate processing routine, and fscache_enqueue_retrieval() should
-     be called at an appropriate point to request CPU time.  For instance, the
-     retrieval routine could be enqueued upon the completion of a disk read.
-     The to_do field in the retrieval record is provided to aid in this.
-
-     If an I/O error occurs, fscache_io_error() should be called and -ENOBUFS
-     returned if possible or fscache_end_io() called with a suitable error
-     code.
-
-     fscache_put_retrieval() should be called after a page or pages are dealt
-     with.  This will complete the operation when all pages are dealt with.
-
-
- (*) Request pages be read from cache [mandatory]:
-
-	int (*read_or_alloc_pages)(struct fscache_retrieval *op,
-				   struct list_head *pages,
-				   unsigned *nr_pages,
-				   gfp_t gfp)
-
-     This is like the read_or_alloc_page() method, except it is handed a list
-     of pages instead of one page.  Any pages on which a read operation is
-     started must be added to the page cache for the specified mapping and also
-     to the LRU.  Such pages must also be removed from the pages list and
-     *nr_pages decremented per page.
-
-     If there was an error such as -ENOMEM, then that should be returned; else
-     if one or more pages couldn't be read or allocated, then -ENOBUFS should
-     be returned; else if one or more pages couldn't be read, then -ENODATA
-     should be returned.  If all the pages are dispatched then 0 should be
-     returned.
-
-
- (*) Request page be allocated in the cache [mandatory]:
-
-	int (*allocate_page)(struct fscache_retrieval *op,
-			     struct page *page,
-			     gfp_t gfp)
-
-     This is like the read_or_alloc_page() method, except that it shouldn't
-     read from the cache, even if there's data there that could be retrieved.
-     It should, however, set up any internal metadata required such that
-     the write_page() method can write to the cache.
-
-     If there's no backing block available, then -ENOBUFS should be returned
-     (or -ENOMEM if there were other problems).  If a block is successfully
-     allocated, then the netfs page should be marked and 0 returned.
-
-
- (*) Request pages be allocated in the cache [mandatory]:
-
-	int (*allocate_pages)(struct fscache_retrieval *op,
-			      struct list_head *pages,
-			      unsigned *nr_pages,
-			      gfp_t gfp)
-
-     This is an multiple page version of the allocate_page() method.  pages and
-     nr_pages should be treated as for the read_or_alloc_pages() method.
-
-
- (*) Request page be written to cache [mandatory]:
-
-	int (*write_page)(struct fscache_storage *op,
-			  struct page *page);
-
-     This is called to write from a page on which there was a previously
-     successful read_or_alloc_page() call or similar.  FS-Cache filters out
-     pages that don't have mappings.
-
-     This method is called asynchronously from the FS-Cache thread pool.  It is
-     not required to actually store anything, provided -ENODATA is then
-     returned to the next read of this page.
-
-     If an error occurred, then a negative error code should be returned,
-     otherwise zero should be returned.  FS-Cache will take appropriate action
-     in response to an error, such as withdrawing this object.
-
-     If this method returns success then FS-Cache will inform the netfs
-     appropriately.
-
-
- (*) Discard retained per-page metadata [mandatory]:
-
-	void (*uncache_page)(struct fscache_object *object, struct page *page)
-
-     This is called when a netfs page is being evicted from the pagecache.  The
-     cache backend should tear down any internal representation or tracking it
-     maintains for this page.
-
-
 ==================
 FS-CACHE UTILITIES
 ==================
@@ -541,83 +276,6 @@ FS-Cache provides some utilities that a cache backend may make use of:
      This does not actually withdraw the cache.  That must be done separately.
 
 
- (*) Invoke the retrieval I/O completion function:
-
-	void fscache_end_io(struct fscache_retrieval *op, struct page *page,
-			    int error);
-
-     This is called to note the end of an attempt to retrieve a page.  The
-     error value should be 0 if successful and an error otherwise.
-
-
- (*) Record that one or more pages being retrieved or allocated have been dealt
-     with:
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
- (*) Record operation completion:
-
-	void fscache_op_complete(struct fscache_operation *op);
-
-     This is called to record the completion of an operation.  This deducts
-     this operation from the parent object's run state, potentially permitting
-     one or more pending operations to start running.
-
-
- (*) Set highest store limit:
-
-	void fscache_set_store_limit(struct fscache_object *object,
-				     loff_t i_size);
-
-     This sets the limit FS-Cache imposes on the highest byte it's willing to
-     try and store for a netfs.  Any page over this limit is automatically
-     rejected by fscache_read_alloc_page() and co with -ENOBUFS.
-
-
- (*) Mark pages as being cached:
-
-	void fscache_mark_pages_cached(struct fscache_retrieval *op,
-				       struct pagevec *pagevec);
-
-     This marks a set of pages as being cached.  After this has been called,
-     the netfs must call fscache_uncache_page() to unmark the pages.
-
-
- (*) Perform coherency check on an object:
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
-	(*) FSCACHE_CHECKAUX_OKAY
-
-	    The coherency data indicates the object is valid as is.
-
-	(*) FSCACHE_CHECKAUX_NEEDS_UPDATE
-
-	    The coherency data needs updating, but otherwise the object is
-	    valid.
-
-	(*) FSCACHE_CHECKAUX_OBSOLETE
-
-	    The coherency data indicates that the object is obsolete and should
-	    be discarded.
-
-
  (*) Initialise a freshly allocated object:
 
 	void fscache_object_init(struct fscache_object *object);
@@ -635,47 +293,6 @@ FS-Cache provides some utilities that a cache backend may make use of:
      all the objects.
 
 
- (*) Indicate negative lookup on an object:
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
- (*) Indicate an object has been obtained:
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
- (*) Indicate that object lookup failed:
-
-	void fscache_object_lookup_error(struct fscache_object *object);
-
-     This marks an object as having encountered a fatal error (usually EIO)
-     and causes it to move into a state whereby it will be withdrawn as soon
-     as possible.
-
-
  (*) Indicate that a stale object was found and discarded:
 
 	void fscache_object_retrying_stale(struct fscache_object *object);
@@ -697,30 +314,3 @@ FS-Cache provides some utilities that a cache backend may make use of:
 	FSCACHE_OBJECT_NO_SPACE - there was insufficient cache space
 	FSCACHE_OBJECT_WAS_RETIRED - the object was retired when relinquished.
 	FSCACHE_OBJECT_WAS_CULLED - the object was culled to make space.
-
-
- (*) Get and release references on a retrieval record:
-
-	void fscache_get_retrieval(struct fscache_retrieval *op);
-	void fscache_put_retrieval(struct fscache_retrieval *op);
-
-     These two functions are used to retain a retrieval record while doing
-     asynchronous data retrieval and block allocation.
-
-
- (*) Enqueue a retrieval record for processing.
-
-	void fscache_enqueue_retrieval(struct fscache_retrieval *op);
-
-     This enqueues a retrieval record for processing by the FS-Cache thread
-     pool.  One of the threads in the pool will invoke the retrieval record's
-     op->op.processor callback function.  This function may be called from
-     within the callback function.
-
-
- (*) List of object state names:
-
-	const char *fscache_object_states[];
-
-     For debugging purposes, this may be used to turn the state that an object
-     is in into a text string for display purposes.
diff --git a/Documentation/filesystems/caching/netfs-api.txt b/Documentation/filesystems/caching/netfs-api.txt
index ba968e8f5704..a39de0a4f336 100644
--- a/Documentation/filesystems/caching/netfs-api.txt
+++ b/Documentation/filesystems/caching/netfs-api.txt
@@ -21,24 +21,19 @@ This API is declared in <linux/fscache.h>.
 
 This document contains the following sections:
 
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
+	- Network filesystem definition
+	- Index definition
+	- Network filesystem (un)registration
+	- Cache tag lookup
+	- Index registration
+	- Data file registration
+	- Miscellaneous object registration
+	- Index and data file consistency
+	- Miscellaneous cookie operations
+	- Cookie unregistration
+	- Index invalidation
+	- Data file invalidation
+	- FS-Cache specific page flag
 
 
 =============================
@@ -114,128 +109,6 @@ There are some limits on indices:
      function is recursive.  Too many layers will run the kernel out of stack.
 
 
-=================
-OBJECT DEFINITION
-=================
-
-To define an object, a structure of the following type should be filled out:
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
-	(*) FSCACHE_COOKIE_TYPE_INDEX
-
-	    This defines an index, which is a special FS-Cache type.
-
-	(*) FSCACHE_COOKIE_TYPE_DATAFILE
-
-	    This defines an ordinary data file.
-
-	(*) Any other value between 2 and 255
-
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
-	(*) FSCACHE_CHECKAUX_OKAY		- the entry is okay as is
-	(*) FSCACHE_CHECKAUX_NEEDS_UPDATE	- the entry requires update
-	(*) FSCACHE_CHECKAUX_OBSOLETE		- the entry should be deleted
-
-     This function can also be used to extract data from the auxiliary data in
-     the cache and copy it into the netfs's structures.
-
- (5) A pair of functions to manage contexts for the completion callback
-     [optional].
-
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
 ===================================
 NETWORK FILESYSTEM (UN)REGISTRATION
 ===================================
@@ -319,10 +192,6 @@ The netfs may pass an arbitrary value in netfs_data and this will be presented
 to it in the event of any calling back.  This may also be used in tracing or
 logging of messages.
 
-The cache tracks the size of the data attached to an object and this set to be
-object_size.  For indices, this should be 0.  This value will be passed to the
-->check_aux() callback.
-
 Note that this function never returns an error - all errors are handled
 internally.  It may, however, return NULL to indicate no cookie.  It is quite
 acceptable to pass this token back to this function as the parent to another
@@ -334,10 +203,6 @@ object needs to be created somewhere down the hierarchy.  Furthermore, an index
 may be created in several different caches independently at different times.
 This is all handled transparently, and the netfs doesn't see any of it.
 
-A cookie will be created in the disabled state if enabled is false.  A cookie
-must be enabled to do anything with it.  A disabled cookie can be enabled by
-calling fscache_enable_cookie() (see below).
-
 For example, with AFS, a cell would be added to the primary index.  This index
 entry would have a dependent inode containing volume mappings within this cell:
 
@@ -396,317 +261,10 @@ Miscellaneous objects might be used to store extended attributes or directory
 entries for example.
 
 
-==========================
-SETTING THE DATA FILE SIZE
-==========================
-
-The fifth step is to set the physical attributes of the file, such as its size.
-This doesn't automatically reserve any space in the cache, but permits the
-cache to adjust its metadata for data tracking appropriately:
-
-	int fscache_attr_changed(struct fscache_cookie *cookie);
-
-The cache will return -ENOBUFS if there is no backing cache or if there is no
-space to allocate any extra metadata required in the cache.
-
-Note that attempts to read or write data pages in the cache over this size may
-be rebuffed with -ENOBUFS.
-
-This operation schedules an attribute adjustment to happen asynchronously at
-some point in the future, and as such, it may happen after the function returns
-to the caller.  The attribute adjustment excludes read and write operations.
-
-
-=====================
-PAGE ALLOC/READ/WRITE
-=====================
-
-And the sixth step is to store and retrieve pages in the cache.  There are
-three functions that are used to do this.
-
-Note:
-
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
-allocate space to store the contents if not:
-
-	typedef
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
-
- (2) The function will submit a request to read the data from the cache's
-     backing device directly into the page specified.
-
- (3) The function will return 0.
-
- (4) When the read is complete, end_io_func() will be invoked with:
-
-     (*) The netfs data supplied when the cookie was created.
-
-     (*) The page descriptor.
-
-     (*) The context argument passed to the above function.  This will be
-         maintained with the get_context/put_context functions mentioned above.
-
-     (*) An argument that's 0 on success or negative for an error code.
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
-PAGE ALLOCATE
--------------
-
-Alternatively, if there's not expected to be any data in the cache for a page
-because the file has been extended, a block can simply be allocated instead:
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
-PAGE WRITE
-----------
-
-Secondly, if the netfs changes the contents of the page (either due to an
-initial download or if a user performs a write), then the page should be
-written back to the cache:
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
-MULTIPLE PAGE READ
-------------------
-
-A facility is provided to read several pages at once, as requested by the
-readpages() address space operation:
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
-     list will be empty and *nr_pages will be 0.
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
-CANCELLATION OF UNREAD PAGES
-----------------------------
-
-If one or more pages are passed to fscache_read_or_alloc_pages() but not then
-read from the cache and also not read from the underlying filesystem then
-those pages will need to have any marks and reservations removed.  This can be
-done by calling:
-
-	void fscache_readpages_cancel(struct fscache_cookie *cookie,
-				      struct list_head *pages);
-
-prior to returning to the caller.  The cookie argument should be as passed to
-fscache_read_or_alloc_pages().  Every page in the pages list will be examined
-and any that have PG_fscache set will be uncached.
-
-
-==============
-PAGE UNCACHING
-==============
-
-To uncache a page, this function should be called:
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
-invalidation functions must use:
-
-	bool fscache_check_page_write(struct fscache_cookie *cookie,
-				      struct page *page);
-
-to see if a page is being written to the cache, and:
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
-need to allocate memory):
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
-BULK INODE PAGE UNCACHE
------------------------
-
-A convenience routine is provided to perform an uncache on all the pages
-attached to an inode.  This assumes that the pages on the inode correspond on a
-1:1 basis with the pages in the cache.
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
 ===============================
 INDEX AND DATA FILE CONSISTENCY
 ===============================
 
-To find out whether auxiliary data for an object is up to data within the
-cache, the following function can be called:
-
-	int fscache_check_consistency(struct fscache_cookie *cookie,
-				      const void *aux_data);
-
-This will call back to the netfs to check whether the auxiliary data associated
-with a cookie is correct; if aux_data is non-NULL, it will update the auxiliary
-data buffer first.  It returns 0 if it is and -ESTALE if it isn't; it may also
-return -ENOMEM and -ERESTARTSYS.
-
 To request an update of the index data for an index or other object, the
 following function should be called:
 
@@ -721,56 +279,6 @@ Note that partial updates may happen automatically at other times, such as when
 data blocks are added to a data file object.
 
 
-=================
-COOKIE ENABLEMENT
-=================
-
-Cookies exist in one of two states: enabled and disabled.  If a cookie is
-disabled, it ignores all attempts to acquire child cookies; check, update or
-invalidate its state; allocate, read or write backing pages - though it is
-still possible to uncache pages and relinquish the cookie.
-
-The initial enablement state is set by fscache_acquire_cookie(), but the cookie
-can be enabled or disabled later.  To disable a cookie, call:
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
-Cookies can be enabled or reenabled with:
-
-    	void fscache_enable_cookie(struct fscache_cookie *cookie,
-				   const void *aux_data,
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
-
-All possible failures are handled internally.  The cookie will only be marked
-as enabled if provisional backing objects are allocated.
-
-The object's data size is updated from object_size and is passed to the
-->check_aux() function.
-
-In both cases, the cookie's auxiliary data buffer is updated from aux_data if
-that is non-NULL inside the enablement lock before proceeding.
-
-
 ===============================
 MISCELLANEOUS COOKIE OPERATIONS
 ===============================
@@ -790,24 +298,6 @@ There are a number of operations that can be used to control cookies:
      -ENOSPC if there isn't enough space to honour the operation, -ENOMEM or
      -EIO if there's any other problem.
 
- (*) Data space reservation:
-
-	int fscache_reserve_space(struct fscache_cookie *cookie, loff_t size);
-
-     This permits a netfs to request cache space be reserved to store up to the
-     given amount of a file.  It is permitted to ask for more than the current
-     size of the file to allow for future file expansion.
-
-     If size is given as zero then the reservation will be cancelled.
-
-     The function will return 0 if successful, -ENOBUFS in the cookie isn't
-     backed by a cache, -EOPNOTSUPP if the cache doesn't support reservations,
-     -ENOSPC if there isn't enough space to honour the operation, -ENOMEM or
-     -EIO if there's any other problem.
-
-     Note that this doesn't pin an object in a cache; it can still be culled to
-     make space if it's not in use.
-
 
 =====================
 COOKIE UNREGISTRATION
@@ -857,7 +347,6 @@ can be called:
 
 	void fscache_invalidate(struct fscache_cookie *cookie);
 
-This can be called with spinlocks held as it defers the work to a thread pool.
 All extant storage, retrieval and attribute change ops at this point are
 cancelled and discarded.  Some future operations will be rejected until the
 cache has had a chance to insert a barrier in the operations queue.  After
@@ -866,12 +355,6 @@ that, operations will be queued again behind the invalidation operation.
 The invalidation operation will perform an attribute change operation and an
 auxiliary data update operation as it is very likely these will have changed.
 
-Using the following function, the netfs can wait for the invalidation operation
-to have reached a point at which it can start submitting ordinary operations
-once again:
-
-	void fscache_wait_on_invalidate(struct fscache_cookie *cookie);
-
 
 ===========================
 FS-CACHE SPECIFIC PAGE FLAG
@@ -880,20 +363,11 @@ FS-CACHE SPECIFIC PAGE FLAG
 FS-Cache makes use of a page flag, PG_private_2, for its own purpose.  This is
 given the alternative name PG_fscache.
 
-PG_fscache is used to indicate that the page is known by the cache, and that
-the cache must be informed if the page is going to go away.  It's an indication
-to the netfs that the cache has an interest in this page, where an interest may
-be a pointer to it, resources allocated or reserved for it, or I/O in progress
-upon it.
-
 The netfs can use this information in methods such as releasepage() to
 determine whether it needs to uncache a page or update it.
 
 Furthermore, if this bit is set, releasepage() and invalidatepage() operations
-will be called on a page to get rid of it, even if PG_private is not set.  This
-allows caching to attempted on a page before read_cache_pages() to be called
-after fscache_read_or_alloc_pages() as the former will try and release pages it
-was given under certain circumstances.
+will be called on a page to get rid of it, even if PG_private is not set.
 
 This bit does not overlap with such as PG_private.  This means that FS-Cache
 can be used with a filesystem that uses the block buffering code.
diff --git a/Documentation/filesystems/caching/object.txt b/Documentation/filesystems/caching/object.txt
index 100ff41127e4..65848e3d0a3f 100644
--- a/Documentation/filesystems/caching/object.txt
+++ b/Documentation/filesystems/caching/object.txt
@@ -8,15 +8,6 @@ Contents:
 
  (*) Representation
 
- (*) Object management state machine.
-
-     - Provision of cpu time.
-     - Locking simplification.
-
- (*) The set of states.
-
- (*) The set of events.
-
 
 ==============
 REPRESENTATION
@@ -87,234 +78,3 @@ may also be entirely unrepresented.
 As far as the netfs API goes, the netfs is only actually permitted to see
 pointers to the cookies.  The cookies themselves and any objects attached to
 those cookies are hidden from it.
-
-
-===============================
-OBJECT MANAGEMENT STATE MACHINE
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
-PROVISION OF CPU TIME
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
-LOCKING SIMPLIFICATION
-----------------------
-
-Because only one worker thread may be operating on any particular object's
-state machine at once, this simplifies the locking, particularly with respect
-to disconnecting the netfs's representation of a cache object (fscache_cookie)
-from the cache backend's representation (fscache_object) - which may be
-requested from either end.
-
-
-=================
-THE SET OF STATES
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
-THE SET OF EVENTS
------------------
-
-There are a number of events that can be raised to an object state machine:
-
- (*) FSCACHE_OBJECT_EV_UPDATE
-
-     The netfs requested that an object be updated.  The state machine will ask
-     the cache backend to update the object, and the cache backend will ask the
-     netfs for details of the change through its cookie definition ops.
-
- (*) FSCACHE_OBJECT_EV_CLEARED
-
-     This is signalled in two circumstances:
-
-     (a) when an object's last child object is dropped and
-
-     (b) when the last operation outstanding on an object is completed.
-
-     This is used to proceed from the dying state.
-
- (*) FSCACHE_OBJECT_EV_ERROR
-
-     This is signalled when an I/O error occurs during the processing of some
-     object.
-
- (*) FSCACHE_OBJECT_EV_RELEASE
- (*) FSCACHE_OBJECT_EV_RETIRE
-
-     These are signalled when the netfs relinquishes a cookie it was using.
-     The event selected depends on whether the netfs asks for the backing
-     object to be retired (deleted) or retained.
-
- (*) FSCACHE_OBJECT_EV_WITHDRAW
-
-     This is signalled when the cache backend wants to withdraw an object.
-     This means that the object will have to be detached from the netfs's
-     cookie.
-
-Because the withdrawing releasing/retiring events are all handled by the object
-state machine, it doesn't matter if there's a collision with both ends trying
-to sever the connection at the same time.  The state machine can just pick
-which one it wants to honour, and that effects the other.
diff --git a/Documentation/filesystems/caching/operations.txt b/Documentation/filesystems/caching/operations.txt
deleted file mode 100644
index d8976c434718..000000000000
--- a/Documentation/filesystems/caching/operations.txt
+++ /dev/null
@@ -1,213 +0,0 @@
-		       ================================
-		       ASYNCHRONOUS OPERATIONS HANDLING
-		       ================================
-
-By: David Howells <dhowells@redhat.com>
-
-Contents:
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
-========
-OVERVIEW
-========
-
-FS-Cache has an asynchronous operations handling facility that it uses for its
-data storage and retrieval routines.  Its operations are represented by
-fscache_operation structs, though these are usually embedded into some other
-structure.
-
-This facility is available to and expected to be be used by the cache backends,
-and FS-Cache will create operations and pass them off to the appropriate cache
-backend for completion.
-
-To make use of this facility, <linux/fscache-cache.h> should be #included.
-
-
-===============================
-OPERATION RECORD INITIALISATION
-===============================
-
-An operation is recorded in an fscache_operation struct:
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
-struct embedded in it.  They should initialise it by calling:
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
-==========
-PARAMETERS
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
-     to be cleared before proceeding:
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
-     initialised before submitting the operation:
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
-     initialised before submitting the operation:
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
-=========
-PROCEDURE
-=========
-
-Operations are used through the following procedure:
-
- (1) The submitting thread must allocate the operation and initialise it
-     itself.  Normally this would be part of a more specific structure with the
-     generic op embedded within.
-
- (2) The submitting thread must then submit the operation for processing using
-     one of the following two functions:
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
-     it, so the caller should put their reference to it by passing it to:
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
-     CPU time provisioning option if necessary, eg:
-
-	op->flags &= ~FSCACHE_OP_TYPE;
-	op->flags |= ~FSCACHE_OP_FAST;
-
-     and calling:
-
-	void fscache_enqueue_operation(struct fscache_operation *op)
-
-     This can be used to allow other things to have use of the worker thread
-     pools.
-
-
-=====================
-ASYNCHRONOUS CALLBACK
-=====================
-
-When used in asynchronous mode, the worker thread pool will invoke the
-processor method with a pointer to the operation.  This should then get at the
-container struct by using container_of():
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


