Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D7E425E0B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 22:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbhJGUud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 16:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242359AbhJGUuW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 16:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633639707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=70InvbqsqypuEnS2UDOophgIH35nKb/r9Q+HJmOMNFY=;
        b=UsDMENn9X9l6CR1Wpyu4NzJPswcjqNZNF4Vbb/waLDA+iG8ARrKxtgGAITIKOmBl7cJMHL
        Ja9DsoG/AgmWkOFtOCQH2UVW5+8CwL+3pa21ihtSTPNbwdkOoSYorGUGV2cP/mNCMMfhDR
        H0zpBJaEthkBBDoDF7/BHWL+FTBrMCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-trh4nSt2NXSJloYLyTZTCw-1; Thu, 07 Oct 2021 16:48:24 -0400
X-MC-Unique: trh4nSt2NXSJloYLyTZTCw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 628D514E7D3;
        Thu,  7 Oct 2021 20:44:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D75EE10013C1;
        Thu,  7 Oct 2021 20:44:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 10/10] fscache: Update the documentation to reflect I/O API
 changes
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-cachefs@redhat.com, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Oct 2021 21:44:36 +0100
Message-ID: <163363947604.1980952.1211932372068640168.stgit@warthog.procyon.org.uk>
In-Reply-To: <163363935000.1980952.15279841414072653108.stgit@warthog.procyon.org.uk>
References: <163363935000.1980952.15279841414072653108.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update the fscache documentation to remove the old I/O API bits and to note
the new fallback API.

Changes
=======
ver #2:
  - Changed "deprecated" to "fallback" in the new function names[1].

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/CAHk-=wiVK+1CyEjW8u71zVPK8msea=qPpznX35gnX+s8sXnJTg@mail.gmail.com/ [1]
Link: https://lore.kernel.org/r/163162778200.438332.1918683687532006409.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/163189115518.2509237.6454712882112339524.stgit@warthog.procyon.org.uk/ # rfc v2
---

 Documentation/filesystems/caching/backend-api.rst |  138 --------
 Documentation/filesystems/caching/netfs-api.rst   |  385 ++-------------------
 2 files changed, 47 insertions(+), 476 deletions(-)

diff --git a/Documentation/filesystems/caching/backend-api.rst b/Documentation/filesystems/caching/backend-api.rst
index 19fbf6b9aa36..08fdd92d502a 100644
--- a/Documentation/filesystems/caching/backend-api.rst
+++ b/Documentation/filesystems/caching/backend-api.rst
@@ -355,14 +355,6 @@ performed on the denizens of the cache.  These are held in a structure of type:
      device.
 
 
-   * Dissociate a cache [mandatory]::
-
-	void (*dissociate_pages)(struct fscache_cache *cache)
-
-     This is called to ask a cache to perform any page dissociations as part of
-     cache withdrawal.
-
-
    * Notification that the attributes on a netfs file changed [mandatory]::
 
 	int (*attr_changed)(struct fscache_object *object);
@@ -402,123 +394,14 @@ performed on the denizens of the cache.  These are held in a structure of type:
      size if larger than that already.
 
 
-   * Request page be read from cache [mandatory]::
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
-   * Request pages be read from cache [mandatory]::
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
-     ``*nr_pages`` decremented per page.
-
-     If there was an error such as -ENOMEM, then that should be returned; else
-     if one or more pages couldn't be read or allocated, then -ENOBUFS should
-     be returned; else if one or more pages couldn't be read, then -ENODATA
-     should be returned.  If all the pages are dispatched then 0 should be
-     returned.
-
-
-   * Request page be allocated in the cache [mandatory]::
+   * Begin an operation [mandatory]::
 
-	int (*allocate_page)(struct fscache_retrieval *op,
-			     struct page *page,
-			     gfp_t gfp)
+	int (*begin_operation)(struct netfs_cache_resources *cres,
+			       struct fscache_operation *op);
 
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
-   * Request pages be allocated in the cache [mandatory]::
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
-   * Request page be written to cache [mandatory]::
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
-   * Discard retained per-page metadata [mandatory]::
-
-	void (*uncache_page)(struct fscache_object *object, struct page *page)
-
-     This is called when a netfs page is being evicted from the pagecache.  The
-     cache backend should tear down any internal representation or tracking it
-     maintains for this page.
+     This is called to start an operation on behalf of the network filesystem
+     or the netfs helper library.  The cache resources attached to *cres
+     should be filled in by the cache so that the operation can be performed.
 
 
 FS-Cache Utilities
@@ -578,15 +461,6 @@ FS-Cache provides some utilities that a cache backend may make use of:
      rejected by fscache_read_alloc_page() and co with -ENOBUFS.
 
 
-   * Mark pages as being cached::
-
-	void fscache_mark_pages_cached(struct fscache_retrieval *op,
-				       struct pagevec *pagevec);
-
-     This marks a set of pages as being cached.  After this has been called,
-     the netfs must call fscache_uncache_page() to unmark the pages.
-
-
    * Perform coherency check on an object::
 
 	enum fscache_checkaux fscache_check_aux(struct fscache_object *object,
diff --git a/Documentation/filesystems/caching/netfs-api.rst b/Documentation/filesystems/caching/netfs-api.rst
index d9f14b8610ba..a469cb9dbdcd 100644
--- a/Documentation/filesystems/caching/netfs-api.rst
+++ b/Documentation/filesystems/caching/netfs-api.rst
@@ -32,15 +32,13 @@ This API is declared in <linux/fscache.h>.
 	 (7) Data file registration
 	 (8) Miscellaneous object registration
  	 (9) Setting the data file size
-	(10) Page alloc/read/write
-	(11) Page uncaching
-	(12) Index and data file consistency
-	(13) Cookie enablement
-	(14) Miscellaneous cookie operations
-	(15) Cookie unregistration
-	(16) Index invalidation
-	(17) Data file invalidation
-	(18) FS-Cache specific page flags.
+	(10) Page read/write
+	(11) Index and data file consistency
+	(12) Cookie enablement
+	(13) Miscellaneous cookie operations
+	(14) Cookie unregistration
+	(15) Index invalidation
+	(16) Data file invalidation
 
 
 Network Filesystem Definition
@@ -132,14 +130,6 @@ To define an object, a structure of the following type should be filled out::
 						   const void *data,
 						   uint16_t datalen,
 						   loff_t object_size);
-
-		void (*get_context)(void *cookie_netfs_data, void *context);
-
-		void (*put_context)(void *cookie_netfs_data, void *context);
-
-		void (*mark_pages_cached)(void *cookie_netfs_data,
-					  struct address_space *mapping,
-					  struct pagevec *cached_pvec);
 	};
 
 This has the following fields:
@@ -200,42 +190,6 @@ This has the following fields:
      This function can also be used to extract data from the auxiliary data in
      the cache and copy it into the netfs's structures.
 
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
 
 Network Filesystem (Un)registration
 ===================================
@@ -412,277 +366,56 @@ some point in the future, and as such, it may happen after the function returns
 to the caller.  The attribute adjustment excludes read and write operations.
 
 
-Page alloc/read/write
+Page Read/Write
 =====================
 
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
-allocate space to store the contents if not::
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
-       * The netfs data supplied when the cookie was created.
-
-       * The page descriptor.
-
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
+And the sixth step is to store and retrieve pages in the cache.  The functions
+provided may do direct I/O calls on the backing filesystem and it is up to the
+network filesystem to prevent clashes.  Typically, a page would be locked for
+the duration of a read and a page would be marked with PageFsCache whilst it is
+being written out.
 
-Secondly, if the netfs changes the contents of the page (either due to an
-initial download or if a user performs a write), then the page should be
-written back to the cache::
+By preference, reading would be performed through the netfs library's helper
+functions, but there is a fallback API, though this should be considered
+deprecated as it may lead to data corruption, depending on the characteristics
+of the backing filesystem.  If the fallback API is to be used, the filesystem
+must do::
 
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
+	#define FSCACHE_USE_FALLBACK_IO_API
+	#include <linux/fscache.h>
 
- (2) The function will submit a request to write the data to cache's backing
-     device directly from the page specified.
 
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
+Fallback Page Read
 ------------------
 
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
+A page may be synchronously read from the backing filesystem::
 
-prior to returning to the caller.  The cookie argument should be as passed to
-fscache_read_or_alloc_pages().  Every page in the pages list will be examined
-and any that have PG_fscache set will be uncached.
+	int fscache_fallback_read_page(struct fscache_cookie *cookie,
+				       struct page *page);
 
+The cookie argument must specify a cookie for an object that isn't an index and
+the page specified will have the data loaded into it (and is also used to
+specify the page number).  The function will return 0 if the page was
+read, -ENODATA if there was no data and -ENOBUFS if there was no cache
+attached.  It may also return errors such as -ENOMEM or -EINTR.  It might also
+return some other error from the backing filesystem, but this should be treated
+as -ENOBUS.
 
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
 
-	bool fscache_check_page_write(struct fscache_cookie *cookie,
-				      struct page *page);
+Fallback Page Write
+-------------------
 
-to see if a page is being written to the cache, and::
+A page may be synchronously written to the backing filesystem::
 
-	void fscache_wait_on_page_write(struct fscache_cookie *cookie,
+	int fscache_fallback_write_page(struct fscache_cookie *cookie,
 					struct page *page);
 
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
+The cookie argument must specify a cookie for an object that isn't an index and
+the page specified will have the data written from it (and is also used to
+specify the page number).  The function will return 0 if the page was read
+and -ENOBUFS if there was no cache attached or no space available in the cache.
+It may also return errors such as -ENOMEM or -EINTR.  It might also return some
+other error from the backing filesystem, but this should be treated as -ENOBUS.
 
 
 Index and Data File consistency
@@ -858,39 +591,3 @@ to have reached a point at which it can start submitting ordinary operations
 once again::
 
 	void fscache_wait_on_invalidate(struct fscache_cookie *cookie);
-
-
-FS-cache Specific Page Flag
-===========================
-
-FS-Cache makes use of a page flag, PG_private_2, for its own purpose.  This is
-given the alternative name PG_fscache.
-
-PG_fscache is used to indicate that the page is known by the cache, and that
-the cache must be informed if the page is going to go away.  It's an indication
-to the netfs that the cache has an interest in this page, where an interest may
-be a pointer to it, resources allocated or reserved for it, or I/O in progress
-upon it.
-
-The netfs can use this information in methods such as releasepage() to
-determine whether it needs to uncache a page or update it.
-
-Furthermore, if this bit is set, releasepage() and invalidatepage() operations
-will be called on a page to get rid of it, even if PG_private is not set.  This
-allows caching to attempted on a page before read_cache_pages() to be called
-after fscache_read_or_alloc_pages() as the former will try and release pages it
-was given under certain circumstances.
-
-This bit does not overlap with such as PG_private.  This means that FS-Cache
-can be used with a filesystem that uses the block buffering code.
-
-There are a number of operations defined on this flag::
-
-	int PageFsCache(struct page *page);
-	void SetPageFsCache(struct page *page)
-	void ClearPageFsCache(struct page *page)
-	int TestSetPageFsCache(struct page *page)
-	int TestClearPageFsCache(struct page *page)
-
-These functions are bit test, bit set, bit clear, bit test and set and bit
-test and clear operations on PG_fscache.


