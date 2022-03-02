Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00834CA727
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 15:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbiCBOFx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 09:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242695AbiCBOFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:05:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 372947F6FD
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 06:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646229890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7pL5TQ/ceL7hK+H3XwW4t6WlPdMSfda6AyLIPYOJCxQ=;
        b=cAgoZNfJ4EZCqg47oTl0Op0ertYV8C4qGU3FJnSGfsopr9XX077EXf9xjDKjSikt9VWCmK
        bMBA2leyYdHwAPLhEmt/YrDpPCL/Hfo8IYPP6jpNIAw97wQc8/eUbTWCy01GFoIph1DhJv
        eGy0qq8Qr/hbUWv6UJ4tRnYGovITHYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-xOAqDH04N6-HGLT1NFOhQg-1; Wed, 02 Mar 2022 09:04:47 -0500
X-MC-Unique: xOAqDH04N6-HGLT1NFOhQg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF866A0C07;
        Wed,  2 Mar 2022 14:04:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D05F1053B0F;
        Wed,  2 Mar 2022 14:04:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/19] netfs: Rename netfs_read_*request to netfs_io_*request
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Mar 2022 14:04:40 +0000
Message-ID: <164622988070.3564931.7089670190434315183.stgit@warthog.procyon.org.uk>
In-Reply-To: <164622970143.3564931.3656393397237724303.stgit@warthog.procyon.org.uk>
References: <164622970143.3564931.3656393397237724303.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename netfs_read_*request to netfs_io_*request so that the same structures
can be used for the write helpers too.

perl -p -i -e 's/netfs_read_(request|subrequest)/netfs_io_$1/g' \
   `git grep -l 'netfs_read_\(sub\|\)request'`
perl -p -i -e 's/netfs_read_(origin|source)/netfs_io_$1/g' \
   `git grep -l 'netfs_read_\(origin\|source\)'`
perl -p -i -e 's/nr_rd_ops/nr_outstanding/g' \
   `git grep -l nr_rd_ops`
perl -p -i -e 's/nr_wr_ops/nr_copy_ops/g' \
   `git grep -l nr_wr_ops`

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 Documentation/filesystems/netfs_library.rst |   38 +++---
 fs/9p/vfs_addr.c                            |    8 +
 fs/afs/file.c                               |    8 +
 fs/afs/internal.h                           |    2 
 fs/cachefiles/io.c                          |    6 -
 fs/ceph/addr.c                              |   14 +-
 fs/ceph/cache.h                             |    4 -
 fs/netfs/read_helper.c                      |  182 ++++++++++++++-------------
 include/linux/netfs.h                       |   32 ++---
 include/trace/events/cachefiles.h           |    6 -
 include/trace/events/netfs.h                |   14 +-
 11 files changed, 157 insertions(+), 157 deletions(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 4f373a8ec47b..5e1b25349c41 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -71,11 +71,11 @@ Read Helper Functions
 Three read helpers are provided::
 
 	void netfs_readahead(struct readahead_control *ractl,
-			     const struct netfs_read_request_ops *ops,
+			     const struct netfs_io_request_ops *ops,
 			     void *netfs_priv);
 	int netfs_readpage(struct file *file,
 			   struct folio *folio,
-			   const struct netfs_read_request_ops *ops,
+			   const struct netfs_io_request_ops *ops,
 			   void *netfs_priv);
 	int netfs_write_begin(struct file *file,
 			      struct address_space *mapping,
@@ -84,7 +84,7 @@ Three read helpers are provided::
 			      unsigned int flags,
 			      struct folio **_folio,
 			      void **_fsdata,
-			      const struct netfs_read_request_ops *ops,
+			      const struct netfs_io_request_ops *ops,
 			      void *netfs_priv);
 
 Each corresponds to a VM operation, with the addition of a couple of parameters
@@ -116,7 +116,7 @@ occurs, the request will get partially completed if sufficient data is read.
 
 Additionally, there is::
 
-  * void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
+  * void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
 				 ssize_t transferred_or_error,
 				 bool was_async);
 
@@ -132,7 +132,7 @@ Read Helper Structures
 The read helpers make use of a couple of structures to maintain the state of
 the read.  The first is a structure that manages a read request as a whole::
 
-	struct netfs_read_request {
+	struct netfs_io_request {
 		struct inode		*inode;
 		struct address_space	*mapping;
 		struct netfs_cache_resources cache_resources;
@@ -140,7 +140,7 @@ the read.  The first is a structure that manages a read request as a whole::
 		loff_t			start;
 		size_t			len;
 		loff_t			i_size;
-		const struct netfs_read_request_ops *netfs_ops;
+		const struct netfs_io_request_ops *netfs_ops;
 		unsigned int		debug_id;
 		...
 	};
@@ -187,8 +187,8 @@ The above fields are the ones the netfs can use.  They are:
 The second structure is used to manage individual slices of the overall read
 request::
 
-	struct netfs_read_subrequest {
-		struct netfs_read_request *rreq;
+	struct netfs_io_subrequest {
+		struct netfs_io_request *rreq;
 		loff_t			start;
 		size_t			len;
 		size_t			transferred;
@@ -244,17 +244,17 @@ Read Helper Operations
 The network filesystem must provide the read helpers with a table of operations
 through which it can issue requests and negotiate::
 
-	struct netfs_read_request_ops {
-		void (*init_rreq)(struct netfs_read_request *rreq, struct file *file);
+	struct netfs_io_request_ops {
+		void (*init_rreq)(struct netfs_io_request *rreq, struct file *file);
 		bool (*is_cache_enabled)(struct inode *inode);
-		int (*begin_cache_operation)(struct netfs_read_request *rreq);
-		void (*expand_readahead)(struct netfs_read_request *rreq);
-		bool (*clamp_length)(struct netfs_read_subrequest *subreq);
-		void (*issue_op)(struct netfs_read_subrequest *subreq);
-		bool (*is_still_valid)(struct netfs_read_request *rreq);
+		int (*begin_cache_operation)(struct netfs_io_request *rreq);
+		void (*expand_readahead)(struct netfs_io_request *rreq);
+		bool (*clamp_length)(struct netfs_io_subrequest *subreq);
+		void (*issue_op)(struct netfs_io_subrequest *subreq);
+		bool (*is_still_valid)(struct netfs_io_request *rreq);
 		int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
 					 struct folio *folio, void **_fsdata);
-		void (*done)(struct netfs_read_request *rreq);
+		void (*done)(struct netfs_io_request *rreq);
 		void (*cleanup)(struct address_space *mapping, void *netfs_priv);
 	};
 
@@ -420,12 +420,12 @@ The network filesystem's ->begin_cache_operation() method is called to set up a
 cache and this must call into the cache to do the work.  If using fscache, for
 example, the cache would call::
 
-	int fscache_begin_read_operation(struct netfs_read_request *rreq,
+	int fscache_begin_read_operation(struct netfs_io_request *rreq,
 					 struct fscache_cookie *cookie);
 
 passing in the request pointer and the cookie corresponding to the file.
 
-The netfs_read_request object contains a place for the cache to hang its
+The netfs_io_request object contains a place for the cache to hang its
 state::
 
 	struct netfs_cache_resources {
@@ -443,7 +443,7 @@ operation table looks like the following::
 		void (*expand_readahead)(struct netfs_cache_resources *cres,
 					 loff_t *_start, size_t *_len, loff_t i_size);
 
-		enum netfs_read_source (*prepare_read)(struct netfs_read_subrequest *subreq,
+		enum netfs_io_source (*prepare_read)(struct netfs_io_subrequest *subreq,
 						       loff_t i_size);
 
 		int (*read)(struct netfs_cache_resources *cres,
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 495767616cf4..088d37944963 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -31,9 +31,9 @@
  * v9fs_req_issue_op - Issue a read from 9P
  * @subreq: The read to make
  */
-static void v9fs_req_issue_op(struct netfs_read_subrequest *subreq)
+static void v9fs_req_issue_op(struct netfs_io_subrequest *subreq)
 {
-	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_io_request *rreq = subreq->rreq;
 	struct p9_fid *fid = rreq->netfs_priv;
 	struct iov_iter to;
 	loff_t pos = subreq->start + subreq->transferred;
@@ -56,7 +56,7 @@ static void v9fs_req_issue_op(struct netfs_read_subrequest *subreq)
  * @rreq: The read request
  * @file: The file being read from
  */
-static void v9fs_init_rreq(struct netfs_read_request *rreq, struct file *file)
+static void v9fs_init_rreq(struct netfs_io_request *rreq, struct file *file)
 {
 	struct p9_fid *fid = file->private_data;
 
@@ -80,7 +80,7 @@ static void v9fs_req_cleanup(struct address_space *mapping, void *priv)
  * v9fs_begin_cache_operation - Begin a cache operation for a read
  * @rreq: The read request
  */
-static int v9fs_begin_cache_operation(struct netfs_read_request *rreq)
+static int v9fs_begin_cache_operation(struct netfs_io_request *rreq)
 {
 #ifdef CONFIG_9P_FSCACHE
 	struct fscache_cookie *cookie = v9fs_inode_cookie(V9FS_I(rreq->inode));
diff --git a/fs/afs/file.c b/fs/afs/file.c
index ee5fd2102a42..0e247fd0abef 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -238,7 +238,7 @@ void afs_put_read(struct afs_read *req)
 static void afs_fetch_data_notify(struct afs_operation *op)
 {
 	struct afs_read *req = op->fetch.req;
-	struct netfs_read_subrequest *subreq = req->subreq;
+	struct netfs_io_subrequest *subreq = req->subreq;
 	int error = op->error;
 
 	if (error == -ECONNABORTED)
@@ -308,7 +308,7 @@ int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 	return afs_do_sync_operation(op);
 }
 
-static void afs_req_issue_op(struct netfs_read_subrequest *subreq)
+static void afs_req_issue_op(struct netfs_io_subrequest *subreq)
 {
 	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
 	struct afs_read *fsreq;
@@ -357,12 +357,12 @@ static int afs_symlink_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
-static void afs_init_rreq(struct netfs_read_request *rreq, struct file *file)
+static void afs_init_rreq(struct netfs_io_request *rreq, struct file *file)
 {
 	rreq->netfs_priv = key_get(afs_file_key(file));
 }
 
-static int afs_begin_cache_operation(struct netfs_read_request *rreq)
+static int afs_begin_cache_operation(struct netfs_io_request *rreq)
 {
 #ifdef CONFIG_AFS_FSCACHE
 	struct afs_vnode *vnode = AFS_FS_I(rreq->inode);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 9fec5fd70abc..75ca3026457e 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -207,7 +207,7 @@ struct afs_read {
 	loff_t			file_size;	/* File size returned by server */
 	struct key		*key;		/* The key to use to reissue the read */
 	struct afs_vnode	*vnode;		/* The file being read into. */
-	struct netfs_read_subrequest *subreq;	/* Fscache helper read request this belongs to */
+	struct netfs_io_subrequest *subreq;	/* Fscache helper read request this belongs to */
 	afs_dataversion_t	data_version;	/* Version number returned by server */
 	refcount_t		usage;
 	unsigned int		call_debug_id;
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 753986ea1583..6ac6fdbc70d3 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -382,18 +382,18 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
  * Prepare a read operation, shortening it to a cached/uncached
  * boundary as appropriate.
  */
-static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subrequest *subreq,
+static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *subreq,
 						      loff_t i_size)
 {
 	enum cachefiles_prepare_read_trace why;
-	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_io_request *rreq = subreq->rreq;
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	struct fscache_cookie *cookie = fscache_cres_cookie(cres);
 	const struct cred *saved_cred;
 	struct file *file = cachefiles_cres_file(cres);
-	enum netfs_read_source ret = NETFS_DOWNLOAD_FROM_SERVER;
+	enum netfs_io_source ret = NETFS_DOWNLOAD_FROM_SERVER;
 	loff_t off, to;
 	ino_t ino = file ? file_inode(file)->i_ino : 0;
 
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index cb43c1397da5..a6452ca3482e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -183,7 +183,7 @@ static int ceph_releasepage(struct page *page, gfp_t gfp)
 	return 1;
 }
 
-static void ceph_netfs_expand_readahead(struct netfs_read_request *rreq)
+static void ceph_netfs_expand_readahead(struct netfs_io_request *rreq)
 {
 	struct inode *inode = rreq->inode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
@@ -200,7 +200,7 @@ static void ceph_netfs_expand_readahead(struct netfs_read_request *rreq)
 	rreq->len = roundup(rreq->len, lo->stripe_unit);
 }
 
-static bool ceph_netfs_clamp_length(struct netfs_read_subrequest *subreq)
+static bool ceph_netfs_clamp_length(struct netfs_io_subrequest *subreq)
 {
 	struct inode *inode = subreq->rreq->inode;
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
@@ -219,7 +219,7 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 {
 	struct ceph_fs_client *fsc = ceph_inode_to_client(req->r_inode);
 	struct ceph_osd_data *osd_data = osd_req_op_extent_osd_data(req, 0);
-	struct netfs_read_subrequest *subreq = req->r_priv;
+	struct netfs_io_subrequest *subreq = req->r_priv;
 	int num_pages;
 	int err = req->r_result;
 
@@ -245,9 +245,9 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	iput(req->r_inode);
 }
 
-static bool ceph_netfs_issue_op_inline(struct netfs_read_subrequest *subreq)
+static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 {
-	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_io_request *rreq = subreq->rreq;
 	struct inode *inode = rreq->inode;
 	struct ceph_mds_reply_info_parsed *rinfo;
 	struct ceph_mds_reply_info_in *iinfo;
@@ -298,9 +298,9 @@ static bool ceph_netfs_issue_op_inline(struct netfs_read_subrequest *subreq)
 	return true;
 }
 
-static void ceph_netfs_issue_op(struct netfs_read_subrequest *subreq)
+static void ceph_netfs_issue_op(struct netfs_io_subrequest *subreq)
 {
-	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_io_request *rreq = subreq->rreq;
 	struct inode *inode = rreq->inode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index 69646587aa75..c20e43cade94 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -57,7 +57,7 @@ static inline int ceph_fscache_set_page_dirty(struct page *page)
 	return fscache_set_page_dirty(page, ceph_fscache_cookie(ci));
 }
 
-static inline int ceph_begin_cache_operation(struct netfs_read_request *rreq)
+static inline int ceph_begin_cache_operation(struct netfs_io_request *rreq)
 {
 	struct fscache_cookie *cookie = ceph_fscache_cookie(ceph_inode(rreq->inode));
 
@@ -134,7 +134,7 @@ static inline bool ceph_is_cache_enabled(struct inode *inode)
 	return false;
 }
 
-static inline int ceph_begin_cache_operation(struct netfs_read_request *rreq)
+static inline int ceph_begin_cache_operation(struct netfs_io_request *rreq)
 {
 	return -ENOBUFS;
 }
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index b0b237669561..a90b3fbcb93f 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -27,24 +27,24 @@ module_param_named(debug, netfs_debug, uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
 
 static void netfs_rreq_work(struct work_struct *);
-static void __netfs_put_subrequest(struct netfs_read_subrequest *, bool);
+static void __netfs_put_subrequest(struct netfs_io_subrequest *, bool);
 
-static void netfs_put_subrequest(struct netfs_read_subrequest *subreq,
+static void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 				 bool was_async)
 {
 	if (refcount_dec_and_test(&subreq->usage))
 		__netfs_put_subrequest(subreq, was_async);
 }
 
-static struct netfs_read_request *netfs_alloc_read_request(struct address_space *mapping,
+static struct netfs_io_request *netfs_alloc_read_request(struct address_space *mapping,
 							   struct file *file)
 {
 	static atomic_t debug_ids;
 	struct inode *inode = file ? file_inode(file) : mapping->host;
 	struct netfs_i_context *ctx = netfs_i_context(inode);
-	struct netfs_read_request *rreq;
+	struct netfs_io_request *rreq;
 
-	rreq = kzalloc(sizeof(struct netfs_read_request), GFP_KERNEL);
+	rreq = kzalloc(sizeof(struct netfs_io_request), GFP_KERNEL);
 	if (rreq) {
 		rreq->mapping	= mapping;
 		rreq->inode	= inode;
@@ -63,19 +63,19 @@ static struct netfs_read_request *netfs_alloc_read_request(struct address_space
 	return rreq;
 }
 
-static void netfs_get_read_request(struct netfs_read_request *rreq)
+static void netfs_get_read_request(struct netfs_io_request *rreq)
 {
 	refcount_inc(&rreq->usage);
 }
 
-static void netfs_rreq_clear_subreqs(struct netfs_read_request *rreq,
+static void netfs_rreq_clear_subreqs(struct netfs_io_request *rreq,
 				     bool was_async)
 {
-	struct netfs_read_subrequest *subreq;
+	struct netfs_io_subrequest *subreq;
 
 	while (!list_empty(&rreq->subrequests)) {
 		subreq = list_first_entry(&rreq->subrequests,
-					  struct netfs_read_subrequest, rreq_link);
+					  struct netfs_io_subrequest, rreq_link);
 		list_del(&subreq->rreq_link);
 		netfs_put_subrequest(subreq, was_async);
 	}
@@ -83,8 +83,8 @@ static void netfs_rreq_clear_subreqs(struct netfs_read_request *rreq,
 
 static void netfs_free_read_request(struct work_struct *work)
 {
-	struct netfs_read_request *rreq =
-		container_of(work, struct netfs_read_request, work);
+	struct netfs_io_request *rreq =
+		container_of(work, struct netfs_io_request, work);
 	netfs_rreq_clear_subreqs(rreq, false);
 	if (rreq->netfs_priv)
 		rreq->netfs_ops->cleanup(rreq->mapping, rreq->netfs_priv);
@@ -95,7 +95,7 @@ static void netfs_free_read_request(struct work_struct *work)
 	netfs_stat_d(&netfs_n_rh_rreq);
 }
 
-static void netfs_put_read_request(struct netfs_read_request *rreq, bool was_async)
+static void netfs_put_read_request(struct netfs_io_request *rreq, bool was_async)
 {
 	if (refcount_dec_and_test(&rreq->usage)) {
 		if (was_async) {
@@ -111,12 +111,12 @@ static void netfs_put_read_request(struct netfs_read_request *rreq, bool was_asy
 /*
  * Allocate and partially initialise an I/O request structure.
  */
-static struct netfs_read_subrequest *netfs_alloc_subrequest(
-	struct netfs_read_request *rreq)
+static struct netfs_io_subrequest *netfs_alloc_subrequest(
+	struct netfs_io_request *rreq)
 {
-	struct netfs_read_subrequest *subreq;
+	struct netfs_io_subrequest *subreq;
 
-	subreq = kzalloc(sizeof(struct netfs_read_subrequest), GFP_KERNEL);
+	subreq = kzalloc(sizeof(struct netfs_io_subrequest), GFP_KERNEL);
 	if (subreq) {
 		INIT_LIST_HEAD(&subreq->rreq_link);
 		refcount_set(&subreq->usage, 2);
@@ -128,15 +128,15 @@ static struct netfs_read_subrequest *netfs_alloc_subrequest(
 	return subreq;
 }
 
-static void netfs_get_read_subrequest(struct netfs_read_subrequest *subreq)
+static void netfs_get_read_subrequest(struct netfs_io_subrequest *subreq)
 {
 	refcount_inc(&subreq->usage);
 }
 
-static void __netfs_put_subrequest(struct netfs_read_subrequest *subreq,
+static void __netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 				   bool was_async)
 {
-	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_io_request *rreq = subreq->rreq;
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_free);
 	kfree(subreq);
@@ -147,7 +147,7 @@ static void __netfs_put_subrequest(struct netfs_read_subrequest *subreq,
 /*
  * Clear the unread part of an I/O request.
  */
-static void netfs_clear_unread(struct netfs_read_subrequest *subreq)
+static void netfs_clear_unread(struct netfs_io_subrequest *subreq)
 {
 	struct iov_iter iter;
 
@@ -160,7 +160,7 @@ static void netfs_clear_unread(struct netfs_read_subrequest *subreq)
 static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error,
 					bool was_async)
 {
-	struct netfs_read_subrequest *subreq = priv;
+	struct netfs_io_subrequest *subreq = priv;
 
 	netfs_subreq_terminated(subreq, transferred_or_error, was_async);
 }
@@ -169,8 +169,8 @@ static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error
  * Issue a read against the cache.
  * - Eats the caller's ref on subreq.
  */
-static void netfs_read_from_cache(struct netfs_read_request *rreq,
-				  struct netfs_read_subrequest *subreq,
+static void netfs_read_from_cache(struct netfs_io_request *rreq,
+				  struct netfs_io_subrequest *subreq,
 				  enum netfs_read_from_hole read_hole)
 {
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
@@ -188,8 +188,8 @@ static void netfs_read_from_cache(struct netfs_read_request *rreq,
 /*
  * Fill a subrequest region with zeroes.
  */
-static void netfs_fill_with_zeroes(struct netfs_read_request *rreq,
-				   struct netfs_read_subrequest *subreq)
+static void netfs_fill_with_zeroes(struct netfs_io_request *rreq,
+				   struct netfs_io_subrequest *subreq)
 {
 	netfs_stat(&netfs_n_rh_zero);
 	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
@@ -212,8 +212,8 @@ static void netfs_fill_with_zeroes(struct netfs_read_request *rreq,
  * - NETFS_SREQ_CLEAR_TAIL: A short read - the rest of the buffer will be
  *   cleared.
  */
-static void netfs_read_from_server(struct netfs_read_request *rreq,
-				   struct netfs_read_subrequest *subreq)
+static void netfs_read_from_server(struct netfs_io_request *rreq,
+				   struct netfs_io_subrequest *subreq)
 {
 	netfs_stat(&netfs_n_rh_download);
 	rreq->netfs_ops->issue_op(subreq);
@@ -222,7 +222,7 @@ static void netfs_read_from_server(struct netfs_read_request *rreq,
 /*
  * Release those waiting.
  */
-static void netfs_rreq_completed(struct netfs_read_request *rreq, bool was_async)
+static void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async)
 {
 	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
 	netfs_rreq_clear_subreqs(rreq, was_async);
@@ -235,10 +235,10 @@ static void netfs_rreq_completed(struct netfs_read_request *rreq, bool was_async
  *
  * May be called in softirq mode and we inherit a ref from the caller.
  */
-static void netfs_rreq_unmark_after_write(struct netfs_read_request *rreq,
+static void netfs_rreq_unmark_after_write(struct netfs_io_request *rreq,
 					  bool was_async)
 {
-	struct netfs_read_subrequest *subreq;
+	struct netfs_io_subrequest *subreq;
 	struct folio *folio;
 	pgoff_t unlocked = 0;
 	bool have_unlocked = false;
@@ -267,8 +267,8 @@ static void netfs_rreq_unmark_after_write(struct netfs_read_request *rreq,
 static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error,
 				       bool was_async)
 {
-	struct netfs_read_subrequest *subreq = priv;
-	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_io_subrequest *subreq = priv;
+	struct netfs_io_request *rreq = subreq->rreq;
 
 	if (IS_ERR_VALUE(transferred_or_error)) {
 		netfs_stat(&netfs_n_rh_write_failed);
@@ -280,8 +280,8 @@ static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error,
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_write_term);
 
-	/* If we decrement nr_wr_ops to 0, the ref belongs to us. */
-	if (atomic_dec_and_test(&rreq->nr_wr_ops))
+	/* If we decrement nr_copy_ops to 0, the ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_copy_ops))
 		netfs_rreq_unmark_after_write(rreq, was_async);
 
 	netfs_put_subrequest(subreq, was_async);
@@ -291,10 +291,10 @@ static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error,
  * Perform any outstanding writes to the cache.  We inherit a ref from the
  * caller.
  */
-static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
+static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
 {
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
-	struct netfs_read_subrequest *subreq, *next, *p;
+	struct netfs_io_subrequest *subreq, *next, *p;
 	struct iov_iter iter;
 	int ret;
 
@@ -303,7 +303,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
 	/* We don't want terminating writes trying to wake us up whilst we're
 	 * still going through the list.
 	 */
-	atomic_inc(&rreq->nr_wr_ops);
+	atomic_inc(&rreq->nr_copy_ops);
 
 	list_for_each_entry_safe(subreq, p, &rreq->subrequests, rreq_link) {
 		if (!test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags)) {
@@ -334,7 +334,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
 		iov_iter_xarray(&iter, WRITE, &rreq->mapping->i_pages,
 				subreq->start, subreq->len);
 
-		atomic_inc(&rreq->nr_wr_ops);
+		atomic_inc(&rreq->nr_copy_ops);
 		netfs_stat(&netfs_n_rh_write);
 		netfs_get_read_subrequest(subreq);
 		trace_netfs_sreq(subreq, netfs_sreq_trace_write);
@@ -342,20 +342,20 @@ static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
 				 netfs_rreq_copy_terminated, subreq);
 	}
 
-	/* If we decrement nr_wr_ops to 0, the usage ref belongs to us. */
-	if (atomic_dec_and_test(&rreq->nr_wr_ops))
+	/* If we decrement nr_copy_ops to 0, the usage ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_copy_ops))
 		netfs_rreq_unmark_after_write(rreq, false);
 }
 
 static void netfs_rreq_write_to_cache_work(struct work_struct *work)
 {
-	struct netfs_read_request *rreq =
-		container_of(work, struct netfs_read_request, work);
+	struct netfs_io_request *rreq =
+		container_of(work, struct netfs_io_request, work);
 
 	netfs_rreq_do_write_to_cache(rreq);
 }
 
-static void netfs_rreq_write_to_cache(struct netfs_read_request *rreq)
+static void netfs_rreq_write_to_cache(struct netfs_io_request *rreq)
 {
 	rreq->work.func = netfs_rreq_write_to_cache_work;
 	if (!queue_work(system_unbound_wq, &rreq->work))
@@ -366,9 +366,9 @@ static void netfs_rreq_write_to_cache(struct netfs_read_request *rreq)
  * Unlock the folios in a read operation.  We need to set PG_fscache on any
  * folios we're going to write back before we unlock them.
  */
-static void netfs_rreq_unlock(struct netfs_read_request *rreq)
+static void netfs_rreq_unlock(struct netfs_io_request *rreq)
 {
-	struct netfs_read_subrequest *subreq;
+	struct netfs_io_subrequest *subreq;
 	struct folio *folio;
 	unsigned int iopos, account = 0;
 	pgoff_t start_page = rreq->start / PAGE_SIZE;
@@ -391,7 +391,7 @@ static void netfs_rreq_unlock(struct netfs_read_request *rreq)
 	 * mixture inside.
 	 */
 	subreq = list_first_entry(&rreq->subrequests,
-				  struct netfs_read_subrequest, rreq_link);
+				  struct netfs_io_subrequest, rreq_link);
 	iopos = 0;
 	subreq_failed = (subreq->error < 0);
 
@@ -450,8 +450,8 @@ static void netfs_rreq_unlock(struct netfs_read_request *rreq)
 /*
  * Handle a short read.
  */
-static void netfs_rreq_short_read(struct netfs_read_request *rreq,
-				  struct netfs_read_subrequest *subreq)
+static void netfs_rreq_short_read(struct netfs_io_request *rreq,
+				  struct netfs_io_subrequest *subreq)
 {
 	__clear_bit(NETFS_SREQ_SHORT_READ, &subreq->flags);
 	__set_bit(NETFS_SREQ_SEEK_DATA_READ, &subreq->flags);
@@ -460,7 +460,7 @@ static void netfs_rreq_short_read(struct netfs_read_request *rreq,
 	trace_netfs_sreq(subreq, netfs_sreq_trace_resubmit_short);
 
 	netfs_get_read_subrequest(subreq);
-	atomic_inc(&rreq->nr_rd_ops);
+	atomic_inc(&rreq->nr_outstanding);
 	if (subreq->source == NETFS_READ_FROM_CACHE)
 		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_CLEAR);
 	else
@@ -471,9 +471,9 @@ static void netfs_rreq_short_read(struct netfs_read_request *rreq,
  * Resubmit any short or failed operations.  Returns true if we got the rreq
  * ref back.
  */
-static bool netfs_rreq_perform_resubmissions(struct netfs_read_request *rreq)
+static bool netfs_rreq_perform_resubmissions(struct netfs_io_request *rreq)
 {
-	struct netfs_read_subrequest *subreq;
+	struct netfs_io_subrequest *subreq;
 
 	WARN_ON(in_interrupt());
 
@@ -482,7 +482,7 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_read_request *rreq)
 	/* We don't want terminating submissions trying to wake us up whilst
 	 * we're still going through the list.
 	 */
-	atomic_inc(&rreq->nr_rd_ops);
+	atomic_inc(&rreq->nr_outstanding);
 
 	__clear_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
 	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
@@ -494,27 +494,27 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_read_request *rreq)
 			netfs_stat(&netfs_n_rh_download_instead);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_download_instead);
 			netfs_get_read_subrequest(subreq);
-			atomic_inc(&rreq->nr_rd_ops);
+			atomic_inc(&rreq->nr_outstanding);
 			netfs_read_from_server(rreq, subreq);
 		} else if (test_bit(NETFS_SREQ_SHORT_READ, &subreq->flags)) {
 			netfs_rreq_short_read(rreq, subreq);
 		}
 	}
 
-	/* If we decrement nr_rd_ops to 0, the usage ref belongs to us. */
-	if (atomic_dec_and_test(&rreq->nr_rd_ops))
+	/* If we decrement nr_outstanding to 0, the usage ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_outstanding))
 		return true;
 
-	wake_up_var(&rreq->nr_rd_ops);
+	wake_up_var(&rreq->nr_outstanding);
 	return false;
 }
 
 /*
  * Check to see if the data read is still valid.
  */
-static void netfs_rreq_is_still_valid(struct netfs_read_request *rreq)
+static void netfs_rreq_is_still_valid(struct netfs_io_request *rreq)
 {
-	struct netfs_read_subrequest *subreq;
+	struct netfs_io_subrequest *subreq;
 
 	if (!rreq->netfs_ops->is_still_valid ||
 	    rreq->netfs_ops->is_still_valid(rreq))
@@ -534,7 +534,7 @@ static void netfs_rreq_is_still_valid(struct netfs_read_request *rreq)
  * Note that we could be in an ordinary kernel thread, on a workqueue or in
  * softirq context at this point.  We inherit a ref from the caller.
  */
-static void netfs_rreq_assess(struct netfs_read_request *rreq, bool was_async)
+static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
 {
 	trace_netfs_rreq(rreq, netfs_rreq_trace_assess);
 
@@ -561,8 +561,8 @@ static void netfs_rreq_assess(struct netfs_read_request *rreq, bool was_async)
 
 static void netfs_rreq_work(struct work_struct *work)
 {
-	struct netfs_read_request *rreq =
-		container_of(work, struct netfs_read_request, work);
+	struct netfs_io_request *rreq =
+		container_of(work, struct netfs_io_request, work);
 	netfs_rreq_assess(rreq, false);
 }
 
@@ -570,7 +570,7 @@ static void netfs_rreq_work(struct work_struct *work)
  * Handle the completion of all outstanding I/O operations on a read request.
  * We inherit a ref from the caller.
  */
-static void netfs_rreq_terminated(struct netfs_read_request *rreq,
+static void netfs_rreq_terminated(struct netfs_io_request *rreq,
 				  bool was_async)
 {
 	if (test_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags) &&
@@ -600,11 +600,11 @@ static void netfs_rreq_terminated(struct netfs_read_request *rreq,
  * If @was_async is true, the caller might be running in softirq or interrupt
  * context and we can't sleep.
  */
-void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
+void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
 			     ssize_t transferred_or_error,
 			     bool was_async)
 {
-	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_io_request *rreq = subreq->rreq;
 	int u;
 
 	_enter("[%u]{%llx,%lx},%zd",
@@ -648,12 +648,12 @@ void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
 out:
 	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
 
-	/* If we decrement nr_rd_ops to 0, the ref belongs to us. */
-	u = atomic_dec_return(&rreq->nr_rd_ops);
+	/* If we decrement nr_outstanding to 0, the ref belongs to us. */
+	u = atomic_dec_return(&rreq->nr_outstanding);
 	if (u == 0)
 		netfs_rreq_terminated(rreq, was_async);
 	else if (u == 1)
-		wake_up_var(&rreq->nr_rd_ops);
+		wake_up_var(&rreq->nr_outstanding);
 
 	netfs_put_subrequest(subreq, was_async);
 	return;
@@ -691,10 +691,10 @@ void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
 }
 EXPORT_SYMBOL(netfs_subreq_terminated);
 
-static enum netfs_read_source netfs_cache_prepare_read(struct netfs_read_subrequest *subreq,
+static enum netfs_io_source netfs_cache_prepare_read(struct netfs_io_subrequest *subreq,
 						       loff_t i_size)
 {
-	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_io_request *rreq = subreq->rreq;
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
 
 	if (cres->ops)
@@ -707,11 +707,11 @@ static enum netfs_read_source netfs_cache_prepare_read(struct netfs_read_subrequ
 /*
  * Work out what sort of subrequest the next one will be.
  */
-static enum netfs_read_source
-netfs_rreq_prepare_read(struct netfs_read_request *rreq,
-			struct netfs_read_subrequest *subreq)
+static enum netfs_io_source
+netfs_rreq_prepare_read(struct netfs_io_request *rreq,
+			struct netfs_io_subrequest *subreq)
 {
-	enum netfs_read_source source;
+	enum netfs_io_source source;
 
 	_enter("%llx-%llx,%llx", subreq->start, subreq->start + subreq->len, rreq->i_size);
 
@@ -748,11 +748,11 @@ netfs_rreq_prepare_read(struct netfs_read_request *rreq,
 /*
  * Slice off a piece of a read request and submit an I/O request for it.
  */
-static bool netfs_rreq_submit_slice(struct netfs_read_request *rreq,
+static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
 				    unsigned int *_debug_index)
 {
-	struct netfs_read_subrequest *subreq;
-	enum netfs_read_source source;
+	struct netfs_io_subrequest *subreq;
+	enum netfs_io_source source;
 
 	subreq = netfs_alloc_subrequest(rreq);
 	if (!subreq)
@@ -777,7 +777,7 @@ static bool netfs_rreq_submit_slice(struct netfs_read_request *rreq,
 	if (source == NETFS_INVALID_READ)
 		goto subreq_failed;
 
-	atomic_inc(&rreq->nr_rd_ops);
+	atomic_inc(&rreq->nr_outstanding);
 
 	rreq->submitted += subreq->len;
 
@@ -804,7 +804,7 @@ static bool netfs_rreq_submit_slice(struct netfs_read_request *rreq,
 	return false;
 }
 
-static void netfs_cache_expand_readahead(struct netfs_read_request *rreq,
+static void netfs_cache_expand_readahead(struct netfs_io_request *rreq,
 					 loff_t *_start, size_t *_len, loff_t i_size)
 {
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
@@ -813,7 +813,7 @@ static void netfs_cache_expand_readahead(struct netfs_read_request *rreq,
 		cres->ops->expand_readahead(cres, _start, _len, i_size);
 }
 
-static void netfs_rreq_expand(struct netfs_read_request *rreq,
+static void netfs_rreq_expand(struct netfs_io_request *rreq,
 			      struct readahead_control *ractl)
 {
 	/* Give the cache a chance to change the request parameters.  The
@@ -864,7 +864,7 @@ static void netfs_rreq_expand(struct netfs_read_request *rreq,
  */
 void netfs_readahead(struct readahead_control *ractl)
 {
-	struct netfs_read_request *rreq;
+	struct netfs_io_request *rreq;
 	struct netfs_i_context *ctx = netfs_i_context(ractl->mapping->host);
 	unsigned int debug_index = 0;
 	int ret;
@@ -892,7 +892,7 @@ void netfs_readahead(struct readahead_control *ractl)
 
 	netfs_rreq_expand(rreq, ractl);
 
-	atomic_set(&rreq->nr_rd_ops, 1);
+	atomic_set(&rreq->nr_outstanding, 1);
 	do {
 		if (!netfs_rreq_submit_slice(rreq, &debug_index))
 			break;
@@ -905,8 +905,8 @@ void netfs_readahead(struct readahead_control *ractl)
 	while (readahead_folio(ractl))
 		;
 
-	/* If we decrement nr_rd_ops to 0, the ref belongs to us. */
-	if (atomic_dec_and_test(&rreq->nr_rd_ops))
+	/* If we decrement nr_outstanding to 0, the ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_outstanding))
 		netfs_rreq_assess(rreq, false);
 	return;
 
@@ -934,7 +934,7 @@ int netfs_readpage(struct file *file, struct page *subpage)
 {
 	struct folio *folio = page_folio(subpage);
 	struct address_space *mapping = folio_file_mapping(folio);
-	struct netfs_read_request *rreq;
+	struct netfs_io_request *rreq;
 	struct netfs_i_context *ctx = netfs_i_context(mapping->host);
 	unsigned int debug_index = 0;
 	int ret;
@@ -960,19 +960,19 @@ int netfs_readpage(struct file *file, struct page *subpage)
 
 	netfs_get_read_request(rreq);
 
-	atomic_set(&rreq->nr_rd_ops, 1);
+	atomic_set(&rreq->nr_outstanding, 1);
 	do {
 		if (!netfs_rreq_submit_slice(rreq, &debug_index))
 			break;
 
 	} while (rreq->submitted < rreq->len);
 
-	/* Keep nr_rd_ops incremented so that the ref always belongs to us, and
+	/* Keep nr_outstanding incremented so that the ref always belongs to us, and
 	 * the service code isn't punted off to a random thread pool to
 	 * process.
 	 */
 	do {
-		wait_var_event(&rreq->nr_rd_ops, atomic_read(&rreq->nr_rd_ops) == 1);
+		wait_var_event(&rreq->nr_outstanding, atomic_read(&rreq->nr_outstanding) == 1);
 		netfs_rreq_assess(rreq, false);
 	} while (test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags));
 
@@ -1075,7 +1075,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 		      loff_t pos, unsigned int len, unsigned int aop_flags,
 		      struct folio **_folio, void **_fsdata)
 {
-	struct netfs_read_request *rreq;
+	struct netfs_io_request *rreq;
 	struct netfs_i_context *ctx = netfs_i_context(file_inode(file ));
 	struct folio *folio;
 	unsigned int debug_index = 0, fgp_flags;
@@ -1147,19 +1147,19 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	while (readahead_folio(&ractl))
 		;
 
-	atomic_set(&rreq->nr_rd_ops, 1);
+	atomic_set(&rreq->nr_outstanding, 1);
 	do {
 		if (!netfs_rreq_submit_slice(rreq, &debug_index))
 			break;
 
 	} while (rreq->submitted < rreq->len);
 
-	/* Keep nr_rd_ops incremented so that the ref always belongs to us, and
+	/* Keep nr_outstanding incremented so that the ref always belongs to us, and
 	 * the service code isn't punted off to a random thread pool to
 	 * process.
 	 */
 	for (;;) {
-		wait_var_event(&rreq->nr_rd_ops, atomic_read(&rreq->nr_rd_ops) == 1);
+		wait_var_event(&rreq->nr_outstanding, atomic_read(&rreq->nr_outstanding) == 1);
 		netfs_rreq_assess(rreq, false);
 		if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags))
 			break;
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index fdb449dbb9fa..630b0400e9fa 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -106,7 +106,7 @@ static inline int wait_on_page_fscache_killable(struct page *page)
 	return folio_wait_private_2_killable(page_folio(page));
 }
 
-enum netfs_read_source {
+enum netfs_io_source {
 	NETFS_FILL_WITH_ZEROES,
 	NETFS_DOWNLOAD_FROM_SERVER,
 	NETFS_READ_FROM_CACHE,
@@ -140,8 +140,8 @@ struct netfs_cache_resources {
 /*
  * Descriptor for a single component subrequest.
  */
-struct netfs_read_subrequest {
-	struct netfs_read_request *rreq;	/* Supervising read request */
+struct netfs_io_subrequest {
+	struct netfs_io_request *rreq;	/* Supervising read request */
 	struct list_head	rreq_link;	/* Link in rreq->subrequests */
 	loff_t			start;		/* Where to start the I/O */
 	size_t			len;		/* Size of the I/O */
@@ -149,7 +149,7 @@ struct netfs_read_subrequest {
 	refcount_t		usage;
 	short			error;		/* 0 or error that occurred */
 	unsigned short		debug_index;	/* Index in list (for debugging output) */
-	enum netfs_read_source	source;		/* Where to read from */
+	enum netfs_io_source	source;		/* Where to read from */
 	unsigned long		flags;
 #define NETFS_SREQ_WRITE_TO_CACHE	0	/* Set if should write to cache */
 #define NETFS_SREQ_CLEAR_TAIL		1	/* Set if the rest of the read should be cleared */
@@ -162,7 +162,7 @@ struct netfs_read_subrequest {
  * Descriptor for a read helper request.  This is used to make multiple I/O
  * requests on a variety of sources and then stitch the result together.
  */
-struct netfs_read_request {
+struct netfs_io_request {
 	struct work_struct	work;
 	struct inode		*inode;		/* The file being accessed */
 	struct address_space	*mapping;	/* The mapping being accessed */
@@ -170,8 +170,8 @@ struct netfs_read_request {
 	struct list_head	subrequests;	/* Requests to fetch I/O from disk or net */
 	void			*netfs_priv;	/* Private data for the netfs */
 	unsigned int		debug_id;
-	atomic_t		nr_rd_ops;	/* Number of read ops in progress */
-	atomic_t		nr_wr_ops;	/* Number of write ops in progress */
+	atomic_t		nr_outstanding;	/* Number of read ops in progress */
+	atomic_t		nr_copy_ops;	/* Number of write ops in progress */
 	size_t			submitted;	/* Amount submitted for I/O so far */
 	size_t			len;		/* Length of the request */
 	short			error;		/* 0 or error that occurred */
@@ -193,15 +193,15 @@ struct netfs_read_request {
  * Operations the network filesystem can/must provide to the helpers.
  */
 struct netfs_request_ops {
-	void (*init_rreq)(struct netfs_read_request *rreq, struct file *file);
-	int (*begin_cache_operation)(struct netfs_read_request *rreq);
-	void (*expand_readahead)(struct netfs_read_request *rreq);
-	bool (*clamp_length)(struct netfs_read_subrequest *subreq);
-	void (*issue_op)(struct netfs_read_subrequest *subreq);
-	bool (*is_still_valid)(struct netfs_read_request *rreq);
+	void (*init_rreq)(struct netfs_io_request *rreq, struct file *file);
+	int (*begin_cache_operation)(struct netfs_io_request *rreq);
+	void (*expand_readahead)(struct netfs_io_request *rreq);
+	bool (*clamp_length)(struct netfs_io_subrequest *subreq);
+	void (*issue_op)(struct netfs_io_subrequest *subreq);
+	bool (*is_still_valid)(struct netfs_io_request *rreq);
 	int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
 				 struct folio *folio, void **_fsdata);
-	void (*done)(struct netfs_read_request *rreq);
+	void (*done)(struct netfs_io_request *rreq);
 	void (*cleanup)(struct address_space *mapping, void *netfs_priv);
 };
 
@@ -244,7 +244,7 @@ struct netfs_cache_ops {
 	/* Prepare a read operation, shortening it to a cached/uncached
 	 * boundary as appropriate.
 	 */
-	enum netfs_read_source (*prepare_read)(struct netfs_read_subrequest *subreq,
+	enum netfs_io_source (*prepare_read)(struct netfs_io_subrequest *subreq,
 					       loff_t i_size);
 
 	/* Prepare a write operation, working out what part of the write we can
@@ -269,7 +269,7 @@ extern int netfs_write_begin(struct file *, struct address_space *,
 			     loff_t, unsigned int, unsigned int, struct folio **,
 			     void **);
 
-extern void netfs_subreq_terminated(struct netfs_read_subrequest *, ssize_t, bool);
+extern void netfs_subreq_terminated(struct netfs_io_subrequest *, ssize_t, bool);
 extern void netfs_stats_show(struct seq_file *);
 
 /**
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index c6f5aa74db89..002d0ae4f9bc 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -424,8 +424,8 @@ TRACE_EVENT(cachefiles_vol_coherency,
 	    );
 
 TRACE_EVENT(cachefiles_prep_read,
-	    TP_PROTO(struct netfs_read_subrequest *sreq,
-		     enum netfs_read_source source,
+	    TP_PROTO(struct netfs_io_subrequest *sreq,
+		     enum netfs_io_source source,
 		     enum cachefiles_prepare_read_trace why,
 		     ino_t cache_inode),
 
@@ -435,7 +435,7 @@ TRACE_EVENT(cachefiles_prep_read,
 		    __field(unsigned int,		rreq		)
 		    __field(unsigned short,		index		)
 		    __field(unsigned short,		flags		)
-		    __field(enum netfs_read_source,	source		)
+		    __field(enum netfs_io_source,	source		)
 		    __field(enum cachefiles_prepare_read_trace,	why	)
 		    __field(size_t,			len		)
 		    __field(loff_t,			start		)
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 88d9a74dd346..2d0665b416bf 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -94,7 +94,7 @@ netfs_failures;
 #define E_(a, b)	{ a, b }
 
 TRACE_EVENT(netfs_read,
-	    TP_PROTO(struct netfs_read_request *rreq,
+	    TP_PROTO(struct netfs_io_request *rreq,
 		     loff_t start, size_t len,
 		     enum netfs_read_trace what),
 
@@ -127,7 +127,7 @@ TRACE_EVENT(netfs_read,
 	    );
 
 TRACE_EVENT(netfs_rreq,
-	    TP_PROTO(struct netfs_read_request *rreq,
+	    TP_PROTO(struct netfs_io_request *rreq,
 		     enum netfs_rreq_trace what),
 
 	    TP_ARGS(rreq, what),
@@ -151,7 +151,7 @@ TRACE_EVENT(netfs_rreq,
 	    );
 
 TRACE_EVENT(netfs_sreq,
-	    TP_PROTO(struct netfs_read_subrequest *sreq,
+	    TP_PROTO(struct netfs_io_subrequest *sreq,
 		     enum netfs_sreq_trace what),
 
 	    TP_ARGS(sreq, what),
@@ -161,7 +161,7 @@ TRACE_EVENT(netfs_sreq,
 		    __field(unsigned short,		index		)
 		    __field(short,			error		)
 		    __field(unsigned short,		flags		)
-		    __field(enum netfs_read_source,	source		)
+		    __field(enum netfs_io_source,	source		)
 		    __field(enum netfs_sreq_trace,	what		)
 		    __field(size_t,			len		)
 		    __field(size_t,			transferred	)
@@ -190,8 +190,8 @@ TRACE_EVENT(netfs_sreq,
 	    );
 
 TRACE_EVENT(netfs_failure,
-	    TP_PROTO(struct netfs_read_request *rreq,
-		     struct netfs_read_subrequest *sreq,
+	    TP_PROTO(struct netfs_io_request *rreq,
+		     struct netfs_io_subrequest *sreq,
 		     int error, enum netfs_failure what),
 
 	    TP_ARGS(rreq, sreq, error, what),
@@ -201,7 +201,7 @@ TRACE_EVENT(netfs_failure,
 		    __field(unsigned short,		index		)
 		    __field(short,			error		)
 		    __field(unsigned short,		flags		)
-		    __field(enum netfs_read_source,	source		)
+		    __field(enum netfs_io_source,	source		)
 		    __field(enum netfs_failure,		what		)
 		    __field(size_t,			len		)
 		    __field(size_t,			transferred	)


