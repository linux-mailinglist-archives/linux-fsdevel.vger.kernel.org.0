Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D8C4D2548
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 02:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiCIBDe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 20:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiCIBCx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:02:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DB84131977
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 16:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646786419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KsYZRk8UYUUSRoe92DfVY2KRtD79Q/MNYCAgTzXbtlU=;
        b=XXVl1uAUpq7yXxqEj2bNij4oF7o3ulD52sw5HTFVjWE1S84BZI7X2k1ThXouW4wGQRY7gV
        vvbN/G7tVFaRJFMe7JAmkV/0KtoRa+urNpYRwb6fJTBTJ0EwNzJLh25zNNjq5sOZC/6kQv
        ZqdCmYnRJFJnq2C1Vt5FMoYhUMnz08c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-46gsFwudPlaHEgDqUBomnw-1; Tue, 08 Mar 2022 18:29:27 -0500
X-MC-Unique: 46gsFwudPlaHEgDqUBomnw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 817601006AA6;
        Tue,  8 Mar 2022 23:29:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E85DB795AC;
        Tue,  8 Mar 2022 23:29:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 15/19] netfs: Rename read_helper.c to io.c
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
Date:   Tue, 08 Mar 2022 23:29:21 +0000
Message-ID: <164678216109.1200972.16567696909952495832.stgit@warthog.procyon.org.uk>
In-Reply-To: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
References: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename the read_helper.c file to io.c before splitting out the buffered
read functions and some other bits.

Changes
=======
ver #2)
 - Rename read_helper.c before splitting.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/filesystems/netfs_library.rst |    3 
 fs/netfs/Makefile                           |    4 
 fs/netfs/internal.h                         |   14 
 fs/netfs/io.c                               | 1085 +++++++++++++++++++++++++++
 fs/netfs/read_helper.c                      | 1085 ---------------------------
 5 files changed, 1096 insertions(+), 1095 deletions(-)
 create mode 100644 fs/netfs/io.c
 delete mode 100644 fs/netfs/read_helper.c

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index dc716415c7a2..24e7cb7281b4 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -604,4 +604,5 @@ API Function Reference
 ======================
 
 .. kernel-doc:: include/linux/netfs.h
-.. kernel-doc:: fs/netfs/read_helper.c
+.. kernel-doc:: fs/netfs/buffered_read.c
+.. kernel-doc:: fs/netfs/io.c
diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index 939fd00a1fc9..51ece4f7bc77 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 netfs-y := \
-	objects.o \
-	read_helper.o
+	io.o \
+	objects.o
 
 netfs-$(CONFIG_NETFS_STATS) += stats.o
 
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 11c0c9ef9299..1cd2778bfa7d 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -20,6 +20,13 @@
  */
 void netfs_rreq_unlock_folios(struct netfs_io_request *rreq);
 
+/*
+ * io.c
+ */
+extern unsigned int netfs_debug;
+
+int netfs_begin_read(struct netfs_io_request *rreq, bool sync);
+
 /*
  * objects.c
  */
@@ -39,13 +46,6 @@ static inline void netfs_see_request(struct netfs_io_request *rreq,
 	trace_netfs_rreq_ref(rreq->debug_id, refcount_read(&rreq->ref), what);
 }
 
-/*
- * read_helper.c
- */
-extern unsigned int netfs_debug;
-
-int netfs_begin_read(struct netfs_io_request *rreq, bool sync);
-
 /*
  * stats.c
  */
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
new file mode 100644
index 000000000000..058a534ba917
--- /dev/null
+++ b/fs/netfs/io.c
@@ -0,0 +1,1085 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Network filesystem high-level read support.
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/module.h>
+#include <linux/export.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/uio.h>
+#include <linux/sched/mm.h>
+#include <linux/task_io_accounting_ops.h>
+#include "internal.h"
+#define CREATE_TRACE_POINTS
+#include <trace/events/netfs.h>
+
+MODULE_DESCRIPTION("Network fs support");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL");
+
+unsigned netfs_debug;
+module_param_named(debug, netfs_debug, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
+
+/*
+ * Clear the unread part of an I/O request.
+ */
+static void netfs_clear_unread(struct netfs_io_subrequest *subreq)
+{
+	struct iov_iter iter;
+
+	iov_iter_xarray(&iter, READ, &subreq->rreq->mapping->i_pages,
+			subreq->start + subreq->transferred,
+			subreq->len   - subreq->transferred);
+	iov_iter_zero(iov_iter_count(&iter), &iter);
+}
+
+static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error,
+					bool was_async)
+{
+	struct netfs_io_subrequest *subreq = priv;
+
+	netfs_subreq_terminated(subreq, transferred_or_error, was_async);
+}
+
+/*
+ * Issue a read against the cache.
+ * - Eats the caller's ref on subreq.
+ */
+static void netfs_read_from_cache(struct netfs_io_request *rreq,
+				  struct netfs_io_subrequest *subreq,
+				  enum netfs_read_from_hole read_hole)
+{
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
+	struct iov_iter iter;
+
+	netfs_stat(&netfs_n_rh_read);
+	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages,
+			subreq->start + subreq->transferred,
+			subreq->len   - subreq->transferred);
+
+	cres->ops->read(cres, subreq->start, &iter, read_hole,
+			netfs_cache_read_terminated, subreq);
+}
+
+/*
+ * Fill a subrequest region with zeroes.
+ */
+static void netfs_fill_with_zeroes(struct netfs_io_request *rreq,
+				   struct netfs_io_subrequest *subreq)
+{
+	netfs_stat(&netfs_n_rh_zero);
+	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+	netfs_subreq_terminated(subreq, 0, false);
+}
+
+/*
+ * Ask the netfs to issue a read request to the server for us.
+ *
+ * The netfs is expected to read from subreq->pos + subreq->transferred to
+ * subreq->pos + subreq->len - 1.  It may not backtrack and write data into the
+ * buffer prior to the transferred point as it might clobber dirty data
+ * obtained from the cache.
+ *
+ * Alternatively, the netfs is allowed to indicate one of two things:
+ *
+ * - NETFS_SREQ_SHORT_READ: A short read - it will get called again to try and
+ *   make progress.
+ *
+ * - NETFS_SREQ_CLEAR_TAIL: A short read - the rest of the buffer will be
+ *   cleared.
+ */
+static void netfs_read_from_server(struct netfs_io_request *rreq,
+				   struct netfs_io_subrequest *subreq)
+{
+	netfs_stat(&netfs_n_rh_download);
+	rreq->netfs_ops->issue_read(subreq);
+}
+
+/*
+ * Release those waiting.
+ */
+static void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async)
+{
+	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
+	netfs_clear_subrequests(rreq, was_async);
+	netfs_put_request(rreq, was_async, netfs_rreq_trace_put_complete);
+}
+
+/*
+ * Deal with the completion of writing the data to the cache.  We have to clear
+ * the PG_fscache bits on the folios involved and release the caller's ref.
+ *
+ * May be called in softirq mode and we inherit a ref from the caller.
+ */
+static void netfs_rreq_unmark_after_write(struct netfs_io_request *rreq,
+					  bool was_async)
+{
+	struct netfs_io_subrequest *subreq;
+	struct folio *folio;
+	pgoff_t unlocked = 0;
+	bool have_unlocked = false;
+
+	rcu_read_lock();
+
+	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+		XA_STATE(xas, &rreq->mapping->i_pages, subreq->start / PAGE_SIZE);
+
+		xas_for_each(&xas, folio, (subreq->start + subreq->len - 1) / PAGE_SIZE) {
+			/* We might have multiple writes from the same huge
+			 * folio, but we mustn't unlock a folio more than once.
+			 */
+			if (have_unlocked && folio_index(folio) <= unlocked)
+				continue;
+			unlocked = folio_index(folio);
+			folio_end_fscache(folio);
+			have_unlocked = true;
+		}
+	}
+
+	rcu_read_unlock();
+	netfs_rreq_completed(rreq, was_async);
+}
+
+static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error,
+				       bool was_async)
+{
+	struct netfs_io_subrequest *subreq = priv;
+	struct netfs_io_request *rreq = subreq->rreq;
+
+	if (IS_ERR_VALUE(transferred_or_error)) {
+		netfs_stat(&netfs_n_rh_write_failed);
+		trace_netfs_failure(rreq, subreq, transferred_or_error,
+				    netfs_fail_copy_to_cache);
+	} else {
+		netfs_stat(&netfs_n_rh_write_done);
+	}
+
+	trace_netfs_sreq(subreq, netfs_sreq_trace_write_term);
+
+	/* If we decrement nr_copy_ops to 0, the ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_copy_ops))
+		netfs_rreq_unmark_after_write(rreq, was_async);
+
+	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
+}
+
+/*
+ * Perform any outstanding writes to the cache.  We inherit a ref from the
+ * caller.
+ */
+static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
+{
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
+	struct netfs_io_subrequest *subreq, *next, *p;
+	struct iov_iter iter;
+	int ret;
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_copy);
+
+	/* We don't want terminating writes trying to wake us up whilst we're
+	 * still going through the list.
+	 */
+	atomic_inc(&rreq->nr_copy_ops);
+
+	list_for_each_entry_safe(subreq, p, &rreq->subrequests, rreq_link) {
+		if (!test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags)) {
+			list_del_init(&subreq->rreq_link);
+			netfs_put_subrequest(subreq, false,
+					     netfs_sreq_trace_put_no_copy);
+		}
+	}
+
+	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+		/* Amalgamate adjacent writes */
+		while (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
+			next = list_next_entry(subreq, rreq_link);
+			if (next->start != subreq->start + subreq->len)
+				break;
+			subreq->len += next->len;
+			list_del_init(&next->rreq_link);
+			netfs_put_subrequest(next, false,
+					     netfs_sreq_trace_put_merged);
+		}
+
+		ret = cres->ops->prepare_write(cres, &subreq->start, &subreq->len,
+					       rreq->i_size, true);
+		if (ret < 0) {
+			trace_netfs_failure(rreq, subreq, ret, netfs_fail_prepare_write);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_write_skip);
+			continue;
+		}
+
+		iov_iter_xarray(&iter, WRITE, &rreq->mapping->i_pages,
+				subreq->start, subreq->len);
+
+		atomic_inc(&rreq->nr_copy_ops);
+		netfs_stat(&netfs_n_rh_write);
+		netfs_get_subrequest(subreq, netfs_sreq_trace_get_copy_to_cache);
+		trace_netfs_sreq(subreq, netfs_sreq_trace_write);
+		cres->ops->write(cres, subreq->start, &iter,
+				 netfs_rreq_copy_terminated, subreq);
+	}
+
+	/* If we decrement nr_copy_ops to 0, the usage ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_copy_ops))
+		netfs_rreq_unmark_after_write(rreq, false);
+}
+
+static void netfs_rreq_write_to_cache_work(struct work_struct *work)
+{
+	struct netfs_io_request *rreq =
+		container_of(work, struct netfs_io_request, work);
+
+	netfs_rreq_do_write_to_cache(rreq);
+}
+
+static void netfs_rreq_write_to_cache(struct netfs_io_request *rreq)
+{
+	rreq->work.func = netfs_rreq_write_to_cache_work;
+	if (!queue_work(system_unbound_wq, &rreq->work))
+		BUG();
+}
+
+/*
+ * Unlock the folios in a read operation.  We need to set PG_fscache on any
+ * folios we're going to write back before we unlock them.
+ */
+void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
+{
+	struct netfs_io_subrequest *subreq;
+	struct folio *folio;
+	unsigned int iopos, account = 0;
+	pgoff_t start_page = rreq->start / PAGE_SIZE;
+	pgoff_t last_page = ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
+	bool subreq_failed = false;
+
+	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
+
+	if (test_bit(NETFS_RREQ_FAILED, &rreq->flags)) {
+		__clear_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags);
+		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+			__clear_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
+		}
+	}
+
+	/* Walk through the pagecache and the I/O request lists simultaneously.
+	 * We may have a mixture of cached and uncached sections and we only
+	 * really want to write out the uncached sections.  This is slightly
+	 * complicated by the possibility that we might have huge pages with a
+	 * mixture inside.
+	 */
+	subreq = list_first_entry(&rreq->subrequests,
+				  struct netfs_io_subrequest, rreq_link);
+	iopos = 0;
+	subreq_failed = (subreq->error < 0);
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_unlock);
+
+	rcu_read_lock();
+	xas_for_each(&xas, folio, last_page) {
+		unsigned int pgpos = (folio_index(folio) - start_page) * PAGE_SIZE;
+		unsigned int pgend = pgpos + folio_size(folio);
+		bool pg_failed = false;
+
+		for (;;) {
+			if (!subreq) {
+				pg_failed = true;
+				break;
+			}
+			if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
+				folio_start_fscache(folio);
+			pg_failed |= subreq_failed;
+			if (pgend < iopos + subreq->len)
+				break;
+
+			account += subreq->transferred;
+			iopos += subreq->len;
+			if (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
+				subreq = list_next_entry(subreq, rreq_link);
+				subreq_failed = (subreq->error < 0);
+			} else {
+				subreq = NULL;
+				subreq_failed = false;
+			}
+			if (pgend == iopos)
+				break;
+		}
+
+		if (!pg_failed) {
+			flush_dcache_folio(folio);
+			folio_mark_uptodate(folio);
+		}
+
+		if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
+			if (folio_index(folio) == rreq->no_unlock_folio &&
+			    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags))
+				_debug("no unlock");
+			else
+				folio_unlock(folio);
+		}
+	}
+	rcu_read_unlock();
+
+	task_io_account_read(account);
+	if (rreq->netfs_ops->done)
+		rreq->netfs_ops->done(rreq);
+}
+
+/*
+ * Handle a short read.
+ */
+static void netfs_rreq_short_read(struct netfs_io_request *rreq,
+				  struct netfs_io_subrequest *subreq)
+{
+	__clear_bit(NETFS_SREQ_SHORT_IO, &subreq->flags);
+	__set_bit(NETFS_SREQ_SEEK_DATA_READ, &subreq->flags);
+
+	netfs_stat(&netfs_n_rh_short_read);
+	trace_netfs_sreq(subreq, netfs_sreq_trace_resubmit_short);
+
+	netfs_get_subrequest(subreq, netfs_sreq_trace_get_short_read);
+	atomic_inc(&rreq->nr_outstanding);
+	if (subreq->source == NETFS_READ_FROM_CACHE)
+		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_CLEAR);
+	else
+		netfs_read_from_server(rreq, subreq);
+}
+
+/*
+ * Resubmit any short or failed operations.  Returns true if we got the rreq
+ * ref back.
+ */
+static bool netfs_rreq_perform_resubmissions(struct netfs_io_request *rreq)
+{
+	struct netfs_io_subrequest *subreq;
+
+	WARN_ON(in_interrupt());
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_resubmit);
+
+	/* We don't want terminating submissions trying to wake us up whilst
+	 * we're still going through the list.
+	 */
+	atomic_inc(&rreq->nr_outstanding);
+
+	__clear_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
+	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+		if (subreq->error) {
+			if (subreq->source != NETFS_READ_FROM_CACHE)
+				break;
+			subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
+			subreq->error = 0;
+			netfs_stat(&netfs_n_rh_download_instead);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_download_instead);
+			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
+			atomic_inc(&rreq->nr_outstanding);
+			netfs_read_from_server(rreq, subreq);
+		} else if (test_bit(NETFS_SREQ_SHORT_IO, &subreq->flags)) {
+			netfs_rreq_short_read(rreq, subreq);
+		}
+	}
+
+	/* If we decrement nr_outstanding to 0, the usage ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_outstanding))
+		return true;
+
+	wake_up_var(&rreq->nr_outstanding);
+	return false;
+}
+
+/*
+ * Check to see if the data read is still valid.
+ */
+static void netfs_rreq_is_still_valid(struct netfs_io_request *rreq)
+{
+	struct netfs_io_subrequest *subreq;
+
+	if (!rreq->netfs_ops->is_still_valid ||
+	    rreq->netfs_ops->is_still_valid(rreq))
+		return;
+
+	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+		if (subreq->source == NETFS_READ_FROM_CACHE) {
+			subreq->error = -ESTALE;
+			__set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
+		}
+	}
+}
+
+/*
+ * Assess the state of a read request and decide what to do next.
+ *
+ * Note that we could be in an ordinary kernel thread, on a workqueue or in
+ * softirq context at this point.  We inherit a ref from the caller.
+ */
+static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
+{
+	trace_netfs_rreq(rreq, netfs_rreq_trace_assess);
+
+again:
+	netfs_rreq_is_still_valid(rreq);
+
+	if (!test_bit(NETFS_RREQ_FAILED, &rreq->flags) &&
+	    test_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags)) {
+		if (netfs_rreq_perform_resubmissions(rreq))
+			goto again;
+		return;
+	}
+
+	netfs_rreq_unlock_folios(rreq);
+
+	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
+	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
+
+	if (test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags))
+		return netfs_rreq_write_to_cache(rreq);
+
+	netfs_rreq_completed(rreq, was_async);
+}
+
+static void netfs_rreq_work(struct work_struct *work)
+{
+	struct netfs_io_request *rreq =
+		container_of(work, struct netfs_io_request, work);
+	netfs_rreq_assess(rreq, false);
+}
+
+/*
+ * Handle the completion of all outstanding I/O operations on a read request.
+ * We inherit a ref from the caller.
+ */
+static void netfs_rreq_terminated(struct netfs_io_request *rreq,
+				  bool was_async)
+{
+	if (test_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags) &&
+	    was_async) {
+		if (!queue_work(system_unbound_wq, &rreq->work))
+			BUG();
+	} else {
+		netfs_rreq_assess(rreq, was_async);
+	}
+}
+
+/**
+ * netfs_subreq_terminated - Note the termination of an I/O operation.
+ * @subreq: The I/O request that has terminated.
+ * @transferred_or_error: The amount of data transferred or an error code.
+ * @was_async: The termination was asynchronous
+ *
+ * This tells the read helper that a contributory I/O operation has terminated,
+ * one way or another, and that it should integrate the results.
+ *
+ * The caller indicates in @transferred_or_error the outcome of the operation,
+ * supplying a positive value to indicate the number of bytes transferred, 0 to
+ * indicate a failure to transfer anything that should be retried or a negative
+ * error code.  The helper will look after reissuing I/O operations as
+ * appropriate and writing downloaded data to the cache.
+ *
+ * If @was_async is true, the caller might be running in softirq or interrupt
+ * context and we can't sleep.
+ */
+void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
+			     ssize_t transferred_or_error,
+			     bool was_async)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+	int u;
+
+	_enter("[%u]{%llx,%lx},%zd",
+	       subreq->debug_index, subreq->start, subreq->flags,
+	       transferred_or_error);
+
+	switch (subreq->source) {
+	case NETFS_READ_FROM_CACHE:
+		netfs_stat(&netfs_n_rh_read_done);
+		break;
+	case NETFS_DOWNLOAD_FROM_SERVER:
+		netfs_stat(&netfs_n_rh_download_done);
+		break;
+	default:
+		break;
+	}
+
+	if (IS_ERR_VALUE(transferred_or_error)) {
+		subreq->error = transferred_or_error;
+		trace_netfs_failure(rreq, subreq, transferred_or_error,
+				    netfs_fail_read);
+		goto failed;
+	}
+
+	if (WARN(transferred_or_error > subreq->len - subreq->transferred,
+		 "Subreq overread: R%x[%x] %zd > %zu - %zu",
+		 rreq->debug_id, subreq->debug_index,
+		 transferred_or_error, subreq->len, subreq->transferred))
+		transferred_or_error = subreq->len - subreq->transferred;
+
+	subreq->error = 0;
+	subreq->transferred += transferred_or_error;
+	if (subreq->transferred < subreq->len)
+		goto incomplete;
+
+complete:
+	__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
+	if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
+		set_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags);
+
+out:
+	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
+
+	/* If we decrement nr_outstanding to 0, the ref belongs to us. */
+	u = atomic_dec_return(&rreq->nr_outstanding);
+	if (u == 0)
+		netfs_rreq_terminated(rreq, was_async);
+	else if (u == 1)
+		wake_up_var(&rreq->nr_outstanding);
+
+	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
+	return;
+
+incomplete:
+	if (test_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags)) {
+		netfs_clear_unread(subreq);
+		subreq->transferred = subreq->len;
+		goto complete;
+	}
+
+	if (transferred_or_error == 0) {
+		if (__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
+			subreq->error = -ENODATA;
+			goto failed;
+		}
+	} else {
+		__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
+	}
+
+	__set_bit(NETFS_SREQ_SHORT_IO, &subreq->flags);
+	set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
+	goto out;
+
+failed:
+	if (subreq->source == NETFS_READ_FROM_CACHE) {
+		netfs_stat(&netfs_n_rh_read_failed);
+		set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
+	} else {
+		netfs_stat(&netfs_n_rh_download_failed);
+		set_bit(NETFS_RREQ_FAILED, &rreq->flags);
+		rreq->error = subreq->error;
+	}
+	goto out;
+}
+EXPORT_SYMBOL(netfs_subreq_terminated);
+
+static enum netfs_io_source netfs_cache_prepare_read(struct netfs_io_subrequest *subreq,
+						       loff_t i_size)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
+
+	if (cres->ops)
+		return cres->ops->prepare_read(subreq, i_size);
+	if (subreq->start >= rreq->i_size)
+		return NETFS_FILL_WITH_ZEROES;
+	return NETFS_DOWNLOAD_FROM_SERVER;
+}
+
+/*
+ * Work out what sort of subrequest the next one will be.
+ */
+static enum netfs_io_source
+netfs_rreq_prepare_read(struct netfs_io_request *rreq,
+			struct netfs_io_subrequest *subreq)
+{
+	enum netfs_io_source source;
+
+	_enter("%llx-%llx,%llx", subreq->start, subreq->start + subreq->len, rreq->i_size);
+
+	source = netfs_cache_prepare_read(subreq, rreq->i_size);
+	if (source == NETFS_INVALID_READ)
+		goto out;
+
+	if (source == NETFS_DOWNLOAD_FROM_SERVER) {
+		/* Call out to the netfs to let it shrink the request to fit
+		 * its own I/O sizes and boundaries.  If it shinks it here, it
+		 * will be called again to make simultaneous calls; if it wants
+		 * to make serial calls, it can indicate a short read and then
+		 * we will call it again.
+		 */
+		if (subreq->len > rreq->i_size - subreq->start)
+			subreq->len = rreq->i_size - subreq->start;
+
+		if (rreq->netfs_ops->clamp_length &&
+		    !rreq->netfs_ops->clamp_length(subreq)) {
+			source = NETFS_INVALID_READ;
+			goto out;
+		}
+	}
+
+	if (WARN_ON(subreq->len == 0))
+		source = NETFS_INVALID_READ;
+
+out:
+	subreq->source = source;
+	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
+	return source;
+}
+
+/*
+ * Slice off a piece of a read request and submit an I/O request for it.
+ */
+static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
+				    unsigned int *_debug_index)
+{
+	struct netfs_io_subrequest *subreq;
+	enum netfs_io_source source;
+
+	subreq = netfs_alloc_subrequest(rreq);
+	if (!subreq)
+		return false;
+
+	subreq->debug_index	= (*_debug_index)++;
+	subreq->start		= rreq->start + rreq->submitted;
+	subreq->len		= rreq->len   - rreq->submitted;
+
+	_debug("slice %llx,%zx,%zx", subreq->start, subreq->len, rreq->submitted);
+	list_add_tail(&subreq->rreq_link, &rreq->subrequests);
+
+	/* Call out to the cache to find out what it can do with the remaining
+	 * subset.  It tells us in subreq->flags what it decided should be done
+	 * and adjusts subreq->len down if the subset crosses a cache boundary.
+	 *
+	 * Then when we hand the subset, it can choose to take a subset of that
+	 * (the starts must coincide), in which case, we go around the loop
+	 * again and ask it to download the next piece.
+	 */
+	source = netfs_rreq_prepare_read(rreq, subreq);
+	if (source == NETFS_INVALID_READ)
+		goto subreq_failed;
+
+	atomic_inc(&rreq->nr_outstanding);
+
+	rreq->submitted += subreq->len;
+
+	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+	switch (source) {
+	case NETFS_FILL_WITH_ZEROES:
+		netfs_fill_with_zeroes(rreq, subreq);
+		break;
+	case NETFS_DOWNLOAD_FROM_SERVER:
+		netfs_read_from_server(rreq, subreq);
+		break;
+	case NETFS_READ_FROM_CACHE:
+		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_IGNORE);
+		break;
+	default:
+		BUG();
+	}
+
+	return true;
+
+subreq_failed:
+	rreq->error = subreq->error;
+	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_failed);
+	return false;
+}
+
+/*
+ * Begin the process of reading in a chunk of data, where that data may be
+ * stitched together from multiple sources, including multiple servers and the
+ * local cache.
+ */
+int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
+{
+	unsigned int debug_index = 0;
+	int ret;
+
+	_enter("R=%x %llx-%llx",
+	       rreq->debug_id, rreq->start, rreq->start + rreq->len - 1);
+
+	if (rreq->len == 0) {
+		pr_err("Zero-sized read [R=%x]\n", rreq->debug_id);
+		netfs_put_request(rreq, false, netfs_rreq_trace_put_zero_len);
+		return -EIO;
+	}
+
+	rreq->work.func = netfs_rreq_work;
+
+	if (sync)
+		netfs_get_request(rreq, netfs_rreq_trace_get_hold);
+
+	/* Chop the read into slices according to what the cache and the netfs
+	 * want and submit each one.
+	 */
+	atomic_set(&rreq->nr_outstanding, 1);
+	do {
+		if (!netfs_rreq_submit_slice(rreq, &debug_index))
+			break;
+
+	} while (rreq->submitted < rreq->len);
+
+	if (sync) {
+		/* Keep nr_outstanding incremented so that the ref always belongs to
+		 * us, and the service code isn't punted off to a random thread pool to
+		 * process.
+		 */
+		for (;;) {
+			wait_var_event(&rreq->nr_outstanding,
+				       atomic_read(&rreq->nr_outstanding) == 1);
+			netfs_rreq_assess(rreq, false);
+			if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags))
+				break;
+			cond_resched();
+		}
+
+		ret = rreq->error;
+		if (ret == 0 && rreq->submitted < rreq->len) {
+			trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
+			ret = -EIO;
+		}
+		netfs_put_request(rreq, false, netfs_rreq_trace_put_hold);
+	} else {
+		/* If we decrement nr_outstanding to 0, the ref belongs to us. */
+		if (atomic_dec_and_test(&rreq->nr_outstanding))
+			netfs_rreq_assess(rreq, false);
+		ret = 0;
+	}
+	return ret;
+}
+
+static void netfs_cache_expand_readahead(struct netfs_io_request *rreq,
+					 loff_t *_start, size_t *_len, loff_t i_size)
+{
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
+
+	if (cres->ops && cres->ops->expand_readahead)
+		cres->ops->expand_readahead(cres, _start, _len, i_size);
+}
+
+static void netfs_rreq_expand(struct netfs_io_request *rreq,
+			      struct readahead_control *ractl)
+{
+	/* Give the cache a chance to change the request parameters.  The
+	 * resultant request must contain the original region.
+	 */
+	netfs_cache_expand_readahead(rreq, &rreq->start, &rreq->len, rreq->i_size);
+
+	/* Give the netfs a chance to change the request parameters.  The
+	 * resultant request must contain the original region.
+	 */
+	if (rreq->netfs_ops->expand_readahead)
+		rreq->netfs_ops->expand_readahead(rreq);
+
+	/* Expand the request if the cache wants it to start earlier.  Note
+	 * that the expansion may get further extended if the VM wishes to
+	 * insert THPs and the preferred start and/or end wind up in the middle
+	 * of THPs.
+	 *
+	 * If this is the case, however, the THP size should be an integer
+	 * multiple of the cache granule size, so we get a whole number of
+	 * granules to deal with.
+	 */
+	if (rreq->start  != readahead_pos(ractl) ||
+	    rreq->len != readahead_length(ractl)) {
+		readahead_expand(ractl, rreq->start, rreq->len);
+		rreq->start  = readahead_pos(ractl);
+		rreq->len = readahead_length(ractl);
+
+		trace_netfs_read(rreq, readahead_pos(ractl), readahead_length(ractl),
+				 netfs_read_trace_expanded);
+	}
+}
+
+/**
+ * netfs_readahead - Helper to manage a read request
+ * @ractl: The description of the readahead request
+ *
+ * Fulfil a readahead request by drawing data from the cache if possible, or
+ * the netfs if not.  Space beyond the EOF is zero-filled.  Multiple I/O
+ * requests from different sources will get munged together.  If necessary, the
+ * readahead window can be expanded in either direction to a more convenient
+ * alighment for RPC efficiency or to make storage in the cache feasible.
+ *
+ * The calling netfs must initialise a netfs context contiguous to the vfs
+ * inode before calling this.
+ *
+ * This is usable whether or not caching is enabled.
+ */
+void netfs_readahead(struct readahead_control *ractl)
+{
+	struct netfs_io_request *rreq;
+	struct netfs_i_context *ctx = netfs_i_context(ractl->mapping->host);
+	int ret;
+
+	_enter("%lx,%x", readahead_index(ractl), readahead_count(ractl));
+
+	if (readahead_count(ractl) == 0)
+		return;
+
+	rreq = netfs_alloc_request(ractl->mapping, ractl->file,
+				   readahead_pos(ractl),
+				   readahead_length(ractl),
+				   NETFS_READAHEAD);
+	if (IS_ERR(rreq))
+		return;
+
+	if (ctx->ops->begin_cache_operation) {
+		ret = ctx->ops->begin_cache_operation(rreq);
+		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
+			goto cleanup_free;
+	}
+
+	netfs_stat(&netfs_n_rh_readahead);
+	trace_netfs_read(rreq, readahead_pos(ractl), readahead_length(ractl),
+			 netfs_read_trace_readahead);
+
+	netfs_rreq_expand(rreq, ractl);
+
+	/* Drop the refs on the folios here rather than in the cache or
+	 * filesystem.  The locks will be dropped in netfs_rreq_unlock().
+	 */
+	while (readahead_folio(ractl))
+		;
+
+	netfs_begin_read(rreq, false);
+	return;
+
+cleanup_free:
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_failed);
+	return;
+}
+EXPORT_SYMBOL(netfs_readahead);
+
+/**
+ * netfs_readpage - Helper to manage a readpage request
+ * @file: The file to read from
+ * @subpage: A subpage of the folio to read
+ *
+ * Fulfil a readpage request by drawing data from the cache if possible, or the
+ * netfs if not.  Space beyond the EOF is zero-filled.  Multiple I/O requests
+ * from different sources will get munged together.
+ *
+ * The calling netfs must initialise a netfs context contiguous to the vfs
+ * inode before calling this.
+ *
+ * This is usable whether or not caching is enabled.
+ */
+int netfs_readpage(struct file *file, struct page *subpage)
+{
+	struct folio *folio = page_folio(subpage);
+	struct address_space *mapping = folio->mapping;
+	struct netfs_io_request *rreq;
+	struct netfs_i_context *ctx = netfs_i_context(mapping->host);
+	int ret;
+
+	_enter("%lx", folio_index(folio));
+
+	rreq = netfs_alloc_request(mapping, file,
+				   folio_file_pos(folio), folio_size(folio),
+				   NETFS_READPAGE);
+	if (IS_ERR(rreq)) {
+		ret = PTR_ERR(rreq);
+		goto alloc_error;
+	}
+
+	if (ctx->ops->begin_cache_operation) {
+		ret = ctx->ops->begin_cache_operation(rreq);
+		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
+			goto discard;
+	}
+
+	netfs_stat(&netfs_n_rh_readpage);
+	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpage);
+	return netfs_begin_read(rreq, true);
+
+discard:
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_discard);
+alloc_error:
+	folio_unlock(folio);
+	return ret;
+}
+EXPORT_SYMBOL(netfs_readpage);
+
+/*
+ * Prepare a folio for writing without reading first
+ * @folio: The folio being prepared
+ * @pos: starting position for the write
+ * @len: length of write
+ * @always_fill: T if the folio should always be completely filled/cleared
+ *
+ * In some cases, write_begin doesn't need to read at all:
+ * - full folio write
+ * - write that lies in a folio that is completely beyond EOF
+ * - write that covers the folio from start to EOF or beyond it
+ *
+ * If any of these criteria are met, then zero out the unwritten parts
+ * of the folio and return true. Otherwise, return false.
+ */
+static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
+				 bool always_fill)
+{
+	struct inode *inode = folio_inode(folio);
+	loff_t i_size = i_size_read(inode);
+	size_t offset = offset_in_folio(folio, pos);
+	size_t plen = folio_size(folio);
+
+	if (unlikely(always_fill)) {
+		if (pos - offset + len <= i_size)
+			return false; /* Page entirely before EOF */
+		zero_user_segment(&folio->page, 0, plen);
+		folio_mark_uptodate(folio);
+		return true;
+	}
+
+	/* Full folio write */
+	if (offset == 0 && len >= plen)
+		return true;
+
+	/* Page entirely beyond the end of the file */
+	if (pos - offset >= i_size)
+		goto zero_out;
+
+	/* Write that covers from the start of the folio to EOF or beyond */
+	if (offset == 0 && (pos + len) >= i_size)
+		goto zero_out;
+
+	return false;
+zero_out:
+	zero_user_segments(&folio->page, 0, offset, offset + len, len);
+	return true;
+}
+
+/**
+ * netfs_write_begin - Helper to prepare for writing
+ * @file: The file to read from
+ * @mapping: The mapping to read from
+ * @pos: File position at which the write will begin
+ * @len: The length of the write (may extend beyond the end of the folio chosen)
+ * @aop_flags: AOP_* flags
+ * @_folio: Where to put the resultant folio
+ * @_fsdata: Place for the netfs to store a cookie
+ *
+ * Pre-read data for a write-begin request by drawing data from the cache if
+ * possible, or the netfs if not.  Space beyond the EOF is zero-filled.
+ * Multiple I/O requests from different sources will get munged together.  If
+ * necessary, the readahead window can be expanded in either direction to a
+ * more convenient alighment for RPC efficiency or to make storage in the cache
+ * feasible.
+ *
+ * The calling netfs must provide a table of operations, only one of which,
+ * issue_op, is mandatory.
+ *
+ * The check_write_begin() operation can be provided to check for and flush
+ * conflicting writes once the folio is grabbed and locked.  It is passed a
+ * pointer to the fsdata cookie that gets returned to the VM to be passed to
+ * write_end.  It is permitted to sleep.  It should return 0 if the request
+ * should go ahead; unlock the folio and return -EAGAIN to cause the folio to
+ * be regot; or return an error.
+ *
+ * The calling netfs must initialise a netfs context contiguous to the vfs
+ * inode before calling this.
+ *
+ * This is usable whether or not caching is enabled.
+ */
+int netfs_write_begin(struct file *file, struct address_space *mapping,
+		      loff_t pos, unsigned int len, unsigned int aop_flags,
+		      struct folio **_folio, void **_fsdata)
+{
+	struct netfs_io_request *rreq;
+	struct netfs_i_context *ctx = netfs_i_context(file_inode(file ));
+	struct folio *folio;
+	unsigned int fgp_flags;
+	pgoff_t index = pos >> PAGE_SHIFT;
+	int ret;
+
+	DEFINE_READAHEAD(ractl, file, NULL, mapping, index);
+
+retry:
+	fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
+	if (aop_flags & AOP_FLAG_NOFS)
+		fgp_flags |= FGP_NOFS;
+	folio = __filemap_get_folio(mapping, index, fgp_flags,
+				    mapping_gfp_mask(mapping));
+	if (!folio)
+		return -ENOMEM;
+
+	if (ctx->ops->check_write_begin) {
+		/* Allow the netfs (eg. ceph) to flush conflicts. */
+		ret = ctx->ops->check_write_begin(file, pos, len, folio, _fsdata);
+		if (ret < 0) {
+			trace_netfs_failure(NULL, NULL, ret, netfs_fail_check_write_begin);
+			if (ret == -EAGAIN)
+				goto retry;
+			goto error;
+		}
+	}
+
+	if (folio_test_uptodate(folio))
+		goto have_folio;
+
+	/* If the page is beyond the EOF, we want to clear it - unless it's
+	 * within the cache granule containing the EOF, in which case we need
+	 * to preload the granule.
+	 */
+	if (!netfs_is_cache_enabled(ctx) &&
+	    netfs_skip_folio_read(folio, pos, len, false)) {
+		netfs_stat(&netfs_n_rh_write_zskip);
+		goto have_folio_no_wait;
+	}
+
+	rreq = netfs_alloc_request(mapping, file,
+				   folio_file_pos(folio), folio_size(folio),
+				   NETFS_READ_FOR_WRITE);
+	if (IS_ERR(rreq)) {
+		ret = PTR_ERR(rreq);
+		goto error;
+	}
+	rreq->no_unlock_folio	= folio_index(folio);
+	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
+
+	if (ctx->ops->begin_cache_operation) {
+		ret = ctx->ops->begin_cache_operation(rreq);
+		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
+			goto error_put;
+	}
+
+	netfs_stat(&netfs_n_rh_write_begin);
+	trace_netfs_read(rreq, pos, len, netfs_read_trace_write_begin);
+
+	/* Expand the request to meet caching requirements and download
+	 * preferences.
+	 */
+	ractl._nr_pages = folio_nr_pages(folio);
+	netfs_rreq_expand(rreq, &ractl);
+
+	/* We hold the folio locks, so we can drop the references */
+	folio_get(folio);
+	while (readahead_folio(&ractl))
+		;
+
+	ret = netfs_begin_read(rreq, true);
+	if (ret < 0)
+		goto error;
+
+have_folio:
+	ret = folio_wait_fscache_killable(folio);
+	if (ret < 0)
+		goto error;
+have_folio_no_wait:
+	*_folio = folio;
+	_leave(" = 0");
+	return 0;
+
+error_put:
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_failed);
+error:
+	folio_unlock(folio);
+	folio_put(folio);
+	_leave(" = %d", ret);
+	return ret;
+}
+EXPORT_SYMBOL(netfs_write_begin);
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
deleted file mode 100644
index 058a534ba917..000000000000
--- a/fs/netfs/read_helper.c
+++ /dev/null
@@ -1,1085 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* Network filesystem high-level read support.
- *
- * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include <linux/module.h>
-#include <linux/export.h>
-#include <linux/fs.h>
-#include <linux/mm.h>
-#include <linux/pagemap.h>
-#include <linux/slab.h>
-#include <linux/uio.h>
-#include <linux/sched/mm.h>
-#include <linux/task_io_accounting_ops.h>
-#include "internal.h"
-#define CREATE_TRACE_POINTS
-#include <trace/events/netfs.h>
-
-MODULE_DESCRIPTION("Network fs support");
-MODULE_AUTHOR("Red Hat, Inc.");
-MODULE_LICENSE("GPL");
-
-unsigned netfs_debug;
-module_param_named(debug, netfs_debug, uint, S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
-
-/*
- * Clear the unread part of an I/O request.
- */
-static void netfs_clear_unread(struct netfs_io_subrequest *subreq)
-{
-	struct iov_iter iter;
-
-	iov_iter_xarray(&iter, READ, &subreq->rreq->mapping->i_pages,
-			subreq->start + subreq->transferred,
-			subreq->len   - subreq->transferred);
-	iov_iter_zero(iov_iter_count(&iter), &iter);
-}
-
-static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error,
-					bool was_async)
-{
-	struct netfs_io_subrequest *subreq = priv;
-
-	netfs_subreq_terminated(subreq, transferred_or_error, was_async);
-}
-
-/*
- * Issue a read against the cache.
- * - Eats the caller's ref on subreq.
- */
-static void netfs_read_from_cache(struct netfs_io_request *rreq,
-				  struct netfs_io_subrequest *subreq,
-				  enum netfs_read_from_hole read_hole)
-{
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
-	struct iov_iter iter;
-
-	netfs_stat(&netfs_n_rh_read);
-	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages,
-			subreq->start + subreq->transferred,
-			subreq->len   - subreq->transferred);
-
-	cres->ops->read(cres, subreq->start, &iter, read_hole,
-			netfs_cache_read_terminated, subreq);
-}
-
-/*
- * Fill a subrequest region with zeroes.
- */
-static void netfs_fill_with_zeroes(struct netfs_io_request *rreq,
-				   struct netfs_io_subrequest *subreq)
-{
-	netfs_stat(&netfs_n_rh_zero);
-	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
-	netfs_subreq_terminated(subreq, 0, false);
-}
-
-/*
- * Ask the netfs to issue a read request to the server for us.
- *
- * The netfs is expected to read from subreq->pos + subreq->transferred to
- * subreq->pos + subreq->len - 1.  It may not backtrack and write data into the
- * buffer prior to the transferred point as it might clobber dirty data
- * obtained from the cache.
- *
- * Alternatively, the netfs is allowed to indicate one of two things:
- *
- * - NETFS_SREQ_SHORT_READ: A short read - it will get called again to try and
- *   make progress.
- *
- * - NETFS_SREQ_CLEAR_TAIL: A short read - the rest of the buffer will be
- *   cleared.
- */
-static void netfs_read_from_server(struct netfs_io_request *rreq,
-				   struct netfs_io_subrequest *subreq)
-{
-	netfs_stat(&netfs_n_rh_download);
-	rreq->netfs_ops->issue_read(subreq);
-}
-
-/*
- * Release those waiting.
- */
-static void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async)
-{
-	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
-	netfs_clear_subrequests(rreq, was_async);
-	netfs_put_request(rreq, was_async, netfs_rreq_trace_put_complete);
-}
-
-/*
- * Deal with the completion of writing the data to the cache.  We have to clear
- * the PG_fscache bits on the folios involved and release the caller's ref.
- *
- * May be called in softirq mode and we inherit a ref from the caller.
- */
-static void netfs_rreq_unmark_after_write(struct netfs_io_request *rreq,
-					  bool was_async)
-{
-	struct netfs_io_subrequest *subreq;
-	struct folio *folio;
-	pgoff_t unlocked = 0;
-	bool have_unlocked = false;
-
-	rcu_read_lock();
-
-	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
-		XA_STATE(xas, &rreq->mapping->i_pages, subreq->start / PAGE_SIZE);
-
-		xas_for_each(&xas, folio, (subreq->start + subreq->len - 1) / PAGE_SIZE) {
-			/* We might have multiple writes from the same huge
-			 * folio, but we mustn't unlock a folio more than once.
-			 */
-			if (have_unlocked && folio_index(folio) <= unlocked)
-				continue;
-			unlocked = folio_index(folio);
-			folio_end_fscache(folio);
-			have_unlocked = true;
-		}
-	}
-
-	rcu_read_unlock();
-	netfs_rreq_completed(rreq, was_async);
-}
-
-static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error,
-				       bool was_async)
-{
-	struct netfs_io_subrequest *subreq = priv;
-	struct netfs_io_request *rreq = subreq->rreq;
-
-	if (IS_ERR_VALUE(transferred_or_error)) {
-		netfs_stat(&netfs_n_rh_write_failed);
-		trace_netfs_failure(rreq, subreq, transferred_or_error,
-				    netfs_fail_copy_to_cache);
-	} else {
-		netfs_stat(&netfs_n_rh_write_done);
-	}
-
-	trace_netfs_sreq(subreq, netfs_sreq_trace_write_term);
-
-	/* If we decrement nr_copy_ops to 0, the ref belongs to us. */
-	if (atomic_dec_and_test(&rreq->nr_copy_ops))
-		netfs_rreq_unmark_after_write(rreq, was_async);
-
-	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
-}
-
-/*
- * Perform any outstanding writes to the cache.  We inherit a ref from the
- * caller.
- */
-static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
-{
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
-	struct netfs_io_subrequest *subreq, *next, *p;
-	struct iov_iter iter;
-	int ret;
-
-	trace_netfs_rreq(rreq, netfs_rreq_trace_copy);
-
-	/* We don't want terminating writes trying to wake us up whilst we're
-	 * still going through the list.
-	 */
-	atomic_inc(&rreq->nr_copy_ops);
-
-	list_for_each_entry_safe(subreq, p, &rreq->subrequests, rreq_link) {
-		if (!test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags)) {
-			list_del_init(&subreq->rreq_link);
-			netfs_put_subrequest(subreq, false,
-					     netfs_sreq_trace_put_no_copy);
-		}
-	}
-
-	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
-		/* Amalgamate adjacent writes */
-		while (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
-			next = list_next_entry(subreq, rreq_link);
-			if (next->start != subreq->start + subreq->len)
-				break;
-			subreq->len += next->len;
-			list_del_init(&next->rreq_link);
-			netfs_put_subrequest(next, false,
-					     netfs_sreq_trace_put_merged);
-		}
-
-		ret = cres->ops->prepare_write(cres, &subreq->start, &subreq->len,
-					       rreq->i_size, true);
-		if (ret < 0) {
-			trace_netfs_failure(rreq, subreq, ret, netfs_fail_prepare_write);
-			trace_netfs_sreq(subreq, netfs_sreq_trace_write_skip);
-			continue;
-		}
-
-		iov_iter_xarray(&iter, WRITE, &rreq->mapping->i_pages,
-				subreq->start, subreq->len);
-
-		atomic_inc(&rreq->nr_copy_ops);
-		netfs_stat(&netfs_n_rh_write);
-		netfs_get_subrequest(subreq, netfs_sreq_trace_get_copy_to_cache);
-		trace_netfs_sreq(subreq, netfs_sreq_trace_write);
-		cres->ops->write(cres, subreq->start, &iter,
-				 netfs_rreq_copy_terminated, subreq);
-	}
-
-	/* If we decrement nr_copy_ops to 0, the usage ref belongs to us. */
-	if (atomic_dec_and_test(&rreq->nr_copy_ops))
-		netfs_rreq_unmark_after_write(rreq, false);
-}
-
-static void netfs_rreq_write_to_cache_work(struct work_struct *work)
-{
-	struct netfs_io_request *rreq =
-		container_of(work, struct netfs_io_request, work);
-
-	netfs_rreq_do_write_to_cache(rreq);
-}
-
-static void netfs_rreq_write_to_cache(struct netfs_io_request *rreq)
-{
-	rreq->work.func = netfs_rreq_write_to_cache_work;
-	if (!queue_work(system_unbound_wq, &rreq->work))
-		BUG();
-}
-
-/*
- * Unlock the folios in a read operation.  We need to set PG_fscache on any
- * folios we're going to write back before we unlock them.
- */
-void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
-{
-	struct netfs_io_subrequest *subreq;
-	struct folio *folio;
-	unsigned int iopos, account = 0;
-	pgoff_t start_page = rreq->start / PAGE_SIZE;
-	pgoff_t last_page = ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
-	bool subreq_failed = false;
-
-	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
-
-	if (test_bit(NETFS_RREQ_FAILED, &rreq->flags)) {
-		__clear_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags);
-		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
-			__clear_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
-		}
-	}
-
-	/* Walk through the pagecache and the I/O request lists simultaneously.
-	 * We may have a mixture of cached and uncached sections and we only
-	 * really want to write out the uncached sections.  This is slightly
-	 * complicated by the possibility that we might have huge pages with a
-	 * mixture inside.
-	 */
-	subreq = list_first_entry(&rreq->subrequests,
-				  struct netfs_io_subrequest, rreq_link);
-	iopos = 0;
-	subreq_failed = (subreq->error < 0);
-
-	trace_netfs_rreq(rreq, netfs_rreq_trace_unlock);
-
-	rcu_read_lock();
-	xas_for_each(&xas, folio, last_page) {
-		unsigned int pgpos = (folio_index(folio) - start_page) * PAGE_SIZE;
-		unsigned int pgend = pgpos + folio_size(folio);
-		bool pg_failed = false;
-
-		for (;;) {
-			if (!subreq) {
-				pg_failed = true;
-				break;
-			}
-			if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
-				folio_start_fscache(folio);
-			pg_failed |= subreq_failed;
-			if (pgend < iopos + subreq->len)
-				break;
-
-			account += subreq->transferred;
-			iopos += subreq->len;
-			if (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
-				subreq = list_next_entry(subreq, rreq_link);
-				subreq_failed = (subreq->error < 0);
-			} else {
-				subreq = NULL;
-				subreq_failed = false;
-			}
-			if (pgend == iopos)
-				break;
-		}
-
-		if (!pg_failed) {
-			flush_dcache_folio(folio);
-			folio_mark_uptodate(folio);
-		}
-
-		if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
-			if (folio_index(folio) == rreq->no_unlock_folio &&
-			    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags))
-				_debug("no unlock");
-			else
-				folio_unlock(folio);
-		}
-	}
-	rcu_read_unlock();
-
-	task_io_account_read(account);
-	if (rreq->netfs_ops->done)
-		rreq->netfs_ops->done(rreq);
-}
-
-/*
- * Handle a short read.
- */
-static void netfs_rreq_short_read(struct netfs_io_request *rreq,
-				  struct netfs_io_subrequest *subreq)
-{
-	__clear_bit(NETFS_SREQ_SHORT_IO, &subreq->flags);
-	__set_bit(NETFS_SREQ_SEEK_DATA_READ, &subreq->flags);
-
-	netfs_stat(&netfs_n_rh_short_read);
-	trace_netfs_sreq(subreq, netfs_sreq_trace_resubmit_short);
-
-	netfs_get_subrequest(subreq, netfs_sreq_trace_get_short_read);
-	atomic_inc(&rreq->nr_outstanding);
-	if (subreq->source == NETFS_READ_FROM_CACHE)
-		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_CLEAR);
-	else
-		netfs_read_from_server(rreq, subreq);
-}
-
-/*
- * Resubmit any short or failed operations.  Returns true if we got the rreq
- * ref back.
- */
-static bool netfs_rreq_perform_resubmissions(struct netfs_io_request *rreq)
-{
-	struct netfs_io_subrequest *subreq;
-
-	WARN_ON(in_interrupt());
-
-	trace_netfs_rreq(rreq, netfs_rreq_trace_resubmit);
-
-	/* We don't want terminating submissions trying to wake us up whilst
-	 * we're still going through the list.
-	 */
-	atomic_inc(&rreq->nr_outstanding);
-
-	__clear_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
-	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
-		if (subreq->error) {
-			if (subreq->source != NETFS_READ_FROM_CACHE)
-				break;
-			subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
-			subreq->error = 0;
-			netfs_stat(&netfs_n_rh_download_instead);
-			trace_netfs_sreq(subreq, netfs_sreq_trace_download_instead);
-			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-			atomic_inc(&rreq->nr_outstanding);
-			netfs_read_from_server(rreq, subreq);
-		} else if (test_bit(NETFS_SREQ_SHORT_IO, &subreq->flags)) {
-			netfs_rreq_short_read(rreq, subreq);
-		}
-	}
-
-	/* If we decrement nr_outstanding to 0, the usage ref belongs to us. */
-	if (atomic_dec_and_test(&rreq->nr_outstanding))
-		return true;
-
-	wake_up_var(&rreq->nr_outstanding);
-	return false;
-}
-
-/*
- * Check to see if the data read is still valid.
- */
-static void netfs_rreq_is_still_valid(struct netfs_io_request *rreq)
-{
-	struct netfs_io_subrequest *subreq;
-
-	if (!rreq->netfs_ops->is_still_valid ||
-	    rreq->netfs_ops->is_still_valid(rreq))
-		return;
-
-	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
-		if (subreq->source == NETFS_READ_FROM_CACHE) {
-			subreq->error = -ESTALE;
-			__set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
-		}
-	}
-}
-
-/*
- * Assess the state of a read request and decide what to do next.
- *
- * Note that we could be in an ordinary kernel thread, on a workqueue or in
- * softirq context at this point.  We inherit a ref from the caller.
- */
-static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
-{
-	trace_netfs_rreq(rreq, netfs_rreq_trace_assess);
-
-again:
-	netfs_rreq_is_still_valid(rreq);
-
-	if (!test_bit(NETFS_RREQ_FAILED, &rreq->flags) &&
-	    test_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags)) {
-		if (netfs_rreq_perform_resubmissions(rreq))
-			goto again;
-		return;
-	}
-
-	netfs_rreq_unlock_folios(rreq);
-
-	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
-	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
-
-	if (test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags))
-		return netfs_rreq_write_to_cache(rreq);
-
-	netfs_rreq_completed(rreq, was_async);
-}
-
-static void netfs_rreq_work(struct work_struct *work)
-{
-	struct netfs_io_request *rreq =
-		container_of(work, struct netfs_io_request, work);
-	netfs_rreq_assess(rreq, false);
-}
-
-/*
- * Handle the completion of all outstanding I/O operations on a read request.
- * We inherit a ref from the caller.
- */
-static void netfs_rreq_terminated(struct netfs_io_request *rreq,
-				  bool was_async)
-{
-	if (test_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags) &&
-	    was_async) {
-		if (!queue_work(system_unbound_wq, &rreq->work))
-			BUG();
-	} else {
-		netfs_rreq_assess(rreq, was_async);
-	}
-}
-
-/**
- * netfs_subreq_terminated - Note the termination of an I/O operation.
- * @subreq: The I/O request that has terminated.
- * @transferred_or_error: The amount of data transferred or an error code.
- * @was_async: The termination was asynchronous
- *
- * This tells the read helper that a contributory I/O operation has terminated,
- * one way or another, and that it should integrate the results.
- *
- * The caller indicates in @transferred_or_error the outcome of the operation,
- * supplying a positive value to indicate the number of bytes transferred, 0 to
- * indicate a failure to transfer anything that should be retried or a negative
- * error code.  The helper will look after reissuing I/O operations as
- * appropriate and writing downloaded data to the cache.
- *
- * If @was_async is true, the caller might be running in softirq or interrupt
- * context and we can't sleep.
- */
-void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
-			     ssize_t transferred_or_error,
-			     bool was_async)
-{
-	struct netfs_io_request *rreq = subreq->rreq;
-	int u;
-
-	_enter("[%u]{%llx,%lx},%zd",
-	       subreq->debug_index, subreq->start, subreq->flags,
-	       transferred_or_error);
-
-	switch (subreq->source) {
-	case NETFS_READ_FROM_CACHE:
-		netfs_stat(&netfs_n_rh_read_done);
-		break;
-	case NETFS_DOWNLOAD_FROM_SERVER:
-		netfs_stat(&netfs_n_rh_download_done);
-		break;
-	default:
-		break;
-	}
-
-	if (IS_ERR_VALUE(transferred_or_error)) {
-		subreq->error = transferred_or_error;
-		trace_netfs_failure(rreq, subreq, transferred_or_error,
-				    netfs_fail_read);
-		goto failed;
-	}
-
-	if (WARN(transferred_or_error > subreq->len - subreq->transferred,
-		 "Subreq overread: R%x[%x] %zd > %zu - %zu",
-		 rreq->debug_id, subreq->debug_index,
-		 transferred_or_error, subreq->len, subreq->transferred))
-		transferred_or_error = subreq->len - subreq->transferred;
-
-	subreq->error = 0;
-	subreq->transferred += transferred_or_error;
-	if (subreq->transferred < subreq->len)
-		goto incomplete;
-
-complete:
-	__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
-	if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
-		set_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags);
-
-out:
-	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
-
-	/* If we decrement nr_outstanding to 0, the ref belongs to us. */
-	u = atomic_dec_return(&rreq->nr_outstanding);
-	if (u == 0)
-		netfs_rreq_terminated(rreq, was_async);
-	else if (u == 1)
-		wake_up_var(&rreq->nr_outstanding);
-
-	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
-	return;
-
-incomplete:
-	if (test_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags)) {
-		netfs_clear_unread(subreq);
-		subreq->transferred = subreq->len;
-		goto complete;
-	}
-
-	if (transferred_or_error == 0) {
-		if (__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
-			subreq->error = -ENODATA;
-			goto failed;
-		}
-	} else {
-		__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
-	}
-
-	__set_bit(NETFS_SREQ_SHORT_IO, &subreq->flags);
-	set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
-	goto out;
-
-failed:
-	if (subreq->source == NETFS_READ_FROM_CACHE) {
-		netfs_stat(&netfs_n_rh_read_failed);
-		set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
-	} else {
-		netfs_stat(&netfs_n_rh_download_failed);
-		set_bit(NETFS_RREQ_FAILED, &rreq->flags);
-		rreq->error = subreq->error;
-	}
-	goto out;
-}
-EXPORT_SYMBOL(netfs_subreq_terminated);
-
-static enum netfs_io_source netfs_cache_prepare_read(struct netfs_io_subrequest *subreq,
-						       loff_t i_size)
-{
-	struct netfs_io_request *rreq = subreq->rreq;
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
-
-	if (cres->ops)
-		return cres->ops->prepare_read(subreq, i_size);
-	if (subreq->start >= rreq->i_size)
-		return NETFS_FILL_WITH_ZEROES;
-	return NETFS_DOWNLOAD_FROM_SERVER;
-}
-
-/*
- * Work out what sort of subrequest the next one will be.
- */
-static enum netfs_io_source
-netfs_rreq_prepare_read(struct netfs_io_request *rreq,
-			struct netfs_io_subrequest *subreq)
-{
-	enum netfs_io_source source;
-
-	_enter("%llx-%llx,%llx", subreq->start, subreq->start + subreq->len, rreq->i_size);
-
-	source = netfs_cache_prepare_read(subreq, rreq->i_size);
-	if (source == NETFS_INVALID_READ)
-		goto out;
-
-	if (source == NETFS_DOWNLOAD_FROM_SERVER) {
-		/* Call out to the netfs to let it shrink the request to fit
-		 * its own I/O sizes and boundaries.  If it shinks it here, it
-		 * will be called again to make simultaneous calls; if it wants
-		 * to make serial calls, it can indicate a short read and then
-		 * we will call it again.
-		 */
-		if (subreq->len > rreq->i_size - subreq->start)
-			subreq->len = rreq->i_size - subreq->start;
-
-		if (rreq->netfs_ops->clamp_length &&
-		    !rreq->netfs_ops->clamp_length(subreq)) {
-			source = NETFS_INVALID_READ;
-			goto out;
-		}
-	}
-
-	if (WARN_ON(subreq->len == 0))
-		source = NETFS_INVALID_READ;
-
-out:
-	subreq->source = source;
-	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
-	return source;
-}
-
-/*
- * Slice off a piece of a read request and submit an I/O request for it.
- */
-static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
-				    unsigned int *_debug_index)
-{
-	struct netfs_io_subrequest *subreq;
-	enum netfs_io_source source;
-
-	subreq = netfs_alloc_subrequest(rreq);
-	if (!subreq)
-		return false;
-
-	subreq->debug_index	= (*_debug_index)++;
-	subreq->start		= rreq->start + rreq->submitted;
-	subreq->len		= rreq->len   - rreq->submitted;
-
-	_debug("slice %llx,%zx,%zx", subreq->start, subreq->len, rreq->submitted);
-	list_add_tail(&subreq->rreq_link, &rreq->subrequests);
-
-	/* Call out to the cache to find out what it can do with the remaining
-	 * subset.  It tells us in subreq->flags what it decided should be done
-	 * and adjusts subreq->len down if the subset crosses a cache boundary.
-	 *
-	 * Then when we hand the subset, it can choose to take a subset of that
-	 * (the starts must coincide), in which case, we go around the loop
-	 * again and ask it to download the next piece.
-	 */
-	source = netfs_rreq_prepare_read(rreq, subreq);
-	if (source == NETFS_INVALID_READ)
-		goto subreq_failed;
-
-	atomic_inc(&rreq->nr_outstanding);
-
-	rreq->submitted += subreq->len;
-
-	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-	switch (source) {
-	case NETFS_FILL_WITH_ZEROES:
-		netfs_fill_with_zeroes(rreq, subreq);
-		break;
-	case NETFS_DOWNLOAD_FROM_SERVER:
-		netfs_read_from_server(rreq, subreq);
-		break;
-	case NETFS_READ_FROM_CACHE:
-		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_IGNORE);
-		break;
-	default:
-		BUG();
-	}
-
-	return true;
-
-subreq_failed:
-	rreq->error = subreq->error;
-	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_failed);
-	return false;
-}
-
-/*
- * Begin the process of reading in a chunk of data, where that data may be
- * stitched together from multiple sources, including multiple servers and the
- * local cache.
- */
-int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
-{
-	unsigned int debug_index = 0;
-	int ret;
-
-	_enter("R=%x %llx-%llx",
-	       rreq->debug_id, rreq->start, rreq->start + rreq->len - 1);
-
-	if (rreq->len == 0) {
-		pr_err("Zero-sized read [R=%x]\n", rreq->debug_id);
-		netfs_put_request(rreq, false, netfs_rreq_trace_put_zero_len);
-		return -EIO;
-	}
-
-	rreq->work.func = netfs_rreq_work;
-
-	if (sync)
-		netfs_get_request(rreq, netfs_rreq_trace_get_hold);
-
-	/* Chop the read into slices according to what the cache and the netfs
-	 * want and submit each one.
-	 */
-	atomic_set(&rreq->nr_outstanding, 1);
-	do {
-		if (!netfs_rreq_submit_slice(rreq, &debug_index))
-			break;
-
-	} while (rreq->submitted < rreq->len);
-
-	if (sync) {
-		/* Keep nr_outstanding incremented so that the ref always belongs to
-		 * us, and the service code isn't punted off to a random thread pool to
-		 * process.
-		 */
-		for (;;) {
-			wait_var_event(&rreq->nr_outstanding,
-				       atomic_read(&rreq->nr_outstanding) == 1);
-			netfs_rreq_assess(rreq, false);
-			if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags))
-				break;
-			cond_resched();
-		}
-
-		ret = rreq->error;
-		if (ret == 0 && rreq->submitted < rreq->len) {
-			trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
-			ret = -EIO;
-		}
-		netfs_put_request(rreq, false, netfs_rreq_trace_put_hold);
-	} else {
-		/* If we decrement nr_outstanding to 0, the ref belongs to us. */
-		if (atomic_dec_and_test(&rreq->nr_outstanding))
-			netfs_rreq_assess(rreq, false);
-		ret = 0;
-	}
-	return ret;
-}
-
-static void netfs_cache_expand_readahead(struct netfs_io_request *rreq,
-					 loff_t *_start, size_t *_len, loff_t i_size)
-{
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
-
-	if (cres->ops && cres->ops->expand_readahead)
-		cres->ops->expand_readahead(cres, _start, _len, i_size);
-}
-
-static void netfs_rreq_expand(struct netfs_io_request *rreq,
-			      struct readahead_control *ractl)
-{
-	/* Give the cache a chance to change the request parameters.  The
-	 * resultant request must contain the original region.
-	 */
-	netfs_cache_expand_readahead(rreq, &rreq->start, &rreq->len, rreq->i_size);
-
-	/* Give the netfs a chance to change the request parameters.  The
-	 * resultant request must contain the original region.
-	 */
-	if (rreq->netfs_ops->expand_readahead)
-		rreq->netfs_ops->expand_readahead(rreq);
-
-	/* Expand the request if the cache wants it to start earlier.  Note
-	 * that the expansion may get further extended if the VM wishes to
-	 * insert THPs and the preferred start and/or end wind up in the middle
-	 * of THPs.
-	 *
-	 * If this is the case, however, the THP size should be an integer
-	 * multiple of the cache granule size, so we get a whole number of
-	 * granules to deal with.
-	 */
-	if (rreq->start  != readahead_pos(ractl) ||
-	    rreq->len != readahead_length(ractl)) {
-		readahead_expand(ractl, rreq->start, rreq->len);
-		rreq->start  = readahead_pos(ractl);
-		rreq->len = readahead_length(ractl);
-
-		trace_netfs_read(rreq, readahead_pos(ractl), readahead_length(ractl),
-				 netfs_read_trace_expanded);
-	}
-}
-
-/**
- * netfs_readahead - Helper to manage a read request
- * @ractl: The description of the readahead request
- *
- * Fulfil a readahead request by drawing data from the cache if possible, or
- * the netfs if not.  Space beyond the EOF is zero-filled.  Multiple I/O
- * requests from different sources will get munged together.  If necessary, the
- * readahead window can be expanded in either direction to a more convenient
- * alighment for RPC efficiency or to make storage in the cache feasible.
- *
- * The calling netfs must initialise a netfs context contiguous to the vfs
- * inode before calling this.
- *
- * This is usable whether or not caching is enabled.
- */
-void netfs_readahead(struct readahead_control *ractl)
-{
-	struct netfs_io_request *rreq;
-	struct netfs_i_context *ctx = netfs_i_context(ractl->mapping->host);
-	int ret;
-
-	_enter("%lx,%x", readahead_index(ractl), readahead_count(ractl));
-
-	if (readahead_count(ractl) == 0)
-		return;
-
-	rreq = netfs_alloc_request(ractl->mapping, ractl->file,
-				   readahead_pos(ractl),
-				   readahead_length(ractl),
-				   NETFS_READAHEAD);
-	if (IS_ERR(rreq))
-		return;
-
-	if (ctx->ops->begin_cache_operation) {
-		ret = ctx->ops->begin_cache_operation(rreq);
-		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
-			goto cleanup_free;
-	}
-
-	netfs_stat(&netfs_n_rh_readahead);
-	trace_netfs_read(rreq, readahead_pos(ractl), readahead_length(ractl),
-			 netfs_read_trace_readahead);
-
-	netfs_rreq_expand(rreq, ractl);
-
-	/* Drop the refs on the folios here rather than in the cache or
-	 * filesystem.  The locks will be dropped in netfs_rreq_unlock().
-	 */
-	while (readahead_folio(ractl))
-		;
-
-	netfs_begin_read(rreq, false);
-	return;
-
-cleanup_free:
-	netfs_put_request(rreq, false, netfs_rreq_trace_put_failed);
-	return;
-}
-EXPORT_SYMBOL(netfs_readahead);
-
-/**
- * netfs_readpage - Helper to manage a readpage request
- * @file: The file to read from
- * @subpage: A subpage of the folio to read
- *
- * Fulfil a readpage request by drawing data from the cache if possible, or the
- * netfs if not.  Space beyond the EOF is zero-filled.  Multiple I/O requests
- * from different sources will get munged together.
- *
- * The calling netfs must initialise a netfs context contiguous to the vfs
- * inode before calling this.
- *
- * This is usable whether or not caching is enabled.
- */
-int netfs_readpage(struct file *file, struct page *subpage)
-{
-	struct folio *folio = page_folio(subpage);
-	struct address_space *mapping = folio->mapping;
-	struct netfs_io_request *rreq;
-	struct netfs_i_context *ctx = netfs_i_context(mapping->host);
-	int ret;
-
-	_enter("%lx", folio_index(folio));
-
-	rreq = netfs_alloc_request(mapping, file,
-				   folio_file_pos(folio), folio_size(folio),
-				   NETFS_READPAGE);
-	if (IS_ERR(rreq)) {
-		ret = PTR_ERR(rreq);
-		goto alloc_error;
-	}
-
-	if (ctx->ops->begin_cache_operation) {
-		ret = ctx->ops->begin_cache_operation(rreq);
-		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
-			goto discard;
-	}
-
-	netfs_stat(&netfs_n_rh_readpage);
-	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpage);
-	return netfs_begin_read(rreq, true);
-
-discard:
-	netfs_put_request(rreq, false, netfs_rreq_trace_put_discard);
-alloc_error:
-	folio_unlock(folio);
-	return ret;
-}
-EXPORT_SYMBOL(netfs_readpage);
-
-/*
- * Prepare a folio for writing without reading first
- * @folio: The folio being prepared
- * @pos: starting position for the write
- * @len: length of write
- * @always_fill: T if the folio should always be completely filled/cleared
- *
- * In some cases, write_begin doesn't need to read at all:
- * - full folio write
- * - write that lies in a folio that is completely beyond EOF
- * - write that covers the folio from start to EOF or beyond it
- *
- * If any of these criteria are met, then zero out the unwritten parts
- * of the folio and return true. Otherwise, return false.
- */
-static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
-				 bool always_fill)
-{
-	struct inode *inode = folio_inode(folio);
-	loff_t i_size = i_size_read(inode);
-	size_t offset = offset_in_folio(folio, pos);
-	size_t plen = folio_size(folio);
-
-	if (unlikely(always_fill)) {
-		if (pos - offset + len <= i_size)
-			return false; /* Page entirely before EOF */
-		zero_user_segment(&folio->page, 0, plen);
-		folio_mark_uptodate(folio);
-		return true;
-	}
-
-	/* Full folio write */
-	if (offset == 0 && len >= plen)
-		return true;
-
-	/* Page entirely beyond the end of the file */
-	if (pos - offset >= i_size)
-		goto zero_out;
-
-	/* Write that covers from the start of the folio to EOF or beyond */
-	if (offset == 0 && (pos + len) >= i_size)
-		goto zero_out;
-
-	return false;
-zero_out:
-	zero_user_segments(&folio->page, 0, offset, offset + len, len);
-	return true;
-}
-
-/**
- * netfs_write_begin - Helper to prepare for writing
- * @file: The file to read from
- * @mapping: The mapping to read from
- * @pos: File position at which the write will begin
- * @len: The length of the write (may extend beyond the end of the folio chosen)
- * @aop_flags: AOP_* flags
- * @_folio: Where to put the resultant folio
- * @_fsdata: Place for the netfs to store a cookie
- *
- * Pre-read data for a write-begin request by drawing data from the cache if
- * possible, or the netfs if not.  Space beyond the EOF is zero-filled.
- * Multiple I/O requests from different sources will get munged together.  If
- * necessary, the readahead window can be expanded in either direction to a
- * more convenient alighment for RPC efficiency or to make storage in the cache
- * feasible.
- *
- * The calling netfs must provide a table of operations, only one of which,
- * issue_op, is mandatory.
- *
- * The check_write_begin() operation can be provided to check for and flush
- * conflicting writes once the folio is grabbed and locked.  It is passed a
- * pointer to the fsdata cookie that gets returned to the VM to be passed to
- * write_end.  It is permitted to sleep.  It should return 0 if the request
- * should go ahead; unlock the folio and return -EAGAIN to cause the folio to
- * be regot; or return an error.
- *
- * The calling netfs must initialise a netfs context contiguous to the vfs
- * inode before calling this.
- *
- * This is usable whether or not caching is enabled.
- */
-int netfs_write_begin(struct file *file, struct address_space *mapping,
-		      loff_t pos, unsigned int len, unsigned int aop_flags,
-		      struct folio **_folio, void **_fsdata)
-{
-	struct netfs_io_request *rreq;
-	struct netfs_i_context *ctx = netfs_i_context(file_inode(file ));
-	struct folio *folio;
-	unsigned int fgp_flags;
-	pgoff_t index = pos >> PAGE_SHIFT;
-	int ret;
-
-	DEFINE_READAHEAD(ractl, file, NULL, mapping, index);
-
-retry:
-	fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
-	if (aop_flags & AOP_FLAG_NOFS)
-		fgp_flags |= FGP_NOFS;
-	folio = __filemap_get_folio(mapping, index, fgp_flags,
-				    mapping_gfp_mask(mapping));
-	if (!folio)
-		return -ENOMEM;
-
-	if (ctx->ops->check_write_begin) {
-		/* Allow the netfs (eg. ceph) to flush conflicts. */
-		ret = ctx->ops->check_write_begin(file, pos, len, folio, _fsdata);
-		if (ret < 0) {
-			trace_netfs_failure(NULL, NULL, ret, netfs_fail_check_write_begin);
-			if (ret == -EAGAIN)
-				goto retry;
-			goto error;
-		}
-	}
-
-	if (folio_test_uptodate(folio))
-		goto have_folio;
-
-	/* If the page is beyond the EOF, we want to clear it - unless it's
-	 * within the cache granule containing the EOF, in which case we need
-	 * to preload the granule.
-	 */
-	if (!netfs_is_cache_enabled(ctx) &&
-	    netfs_skip_folio_read(folio, pos, len, false)) {
-		netfs_stat(&netfs_n_rh_write_zskip);
-		goto have_folio_no_wait;
-	}
-
-	rreq = netfs_alloc_request(mapping, file,
-				   folio_file_pos(folio), folio_size(folio),
-				   NETFS_READ_FOR_WRITE);
-	if (IS_ERR(rreq)) {
-		ret = PTR_ERR(rreq);
-		goto error;
-	}
-	rreq->no_unlock_folio	= folio_index(folio);
-	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
-
-	if (ctx->ops->begin_cache_operation) {
-		ret = ctx->ops->begin_cache_operation(rreq);
-		if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
-			goto error_put;
-	}
-
-	netfs_stat(&netfs_n_rh_write_begin);
-	trace_netfs_read(rreq, pos, len, netfs_read_trace_write_begin);
-
-	/* Expand the request to meet caching requirements and download
-	 * preferences.
-	 */
-	ractl._nr_pages = folio_nr_pages(folio);
-	netfs_rreq_expand(rreq, &ractl);
-
-	/* We hold the folio locks, so we can drop the references */
-	folio_get(folio);
-	while (readahead_folio(&ractl))
-		;
-
-	ret = netfs_begin_read(rreq, true);
-	if (ret < 0)
-		goto error;
-
-have_folio:
-	ret = folio_wait_fscache_killable(folio);
-	if (ret < 0)
-		goto error;
-have_folio_no_wait:
-	*_folio = folio;
-	_leave(" = 0");
-	return 0;
-
-error_put:
-	netfs_put_request(rreq, false, netfs_rreq_trace_put_failed);
-error:
-	folio_unlock(folio);
-	folio_put(folio);
-	_leave(" = %d", ret);
-	return ret;
-}
-EXPORT_SYMBOL(netfs_write_begin);


