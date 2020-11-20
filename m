Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D297D2BACBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgKTPFO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:05:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727806AbgKTPFN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605884711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ayCAPqtLTSavJ+rMgifYdt7Jk2/mYxGniv+xR152w/c=;
        b=ihtdS8eymYj+zq+EtvNOgqrXkZCZ/vEsMAugmBqVRkJ2SWPRAs0lRIReCxjGiCBVAZyo9S
        1vQ8JkIrVm0ysPK5+6liqXduInUF5F8sDe2eU80oI0IZ1mnCqze3aIQ0nBW2GS5075LwGx
        KL/uUuGAOTK/KZQEtJbGA0G5CsHbMzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-l-xpyUsgPvSo-u25RO3F0A-1; Fri, 20 Nov 2020 10:05:09 -0500
X-MC-Unique: l-xpyUsgPvSo-u25RO3F0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA18A100C601;
        Fri, 20 Nov 2020 15:05:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E89235C1D5;
        Fri, 20 Nov 2020 15:04:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 11/76] fscache: Remove obsolete stats
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:04:59 +0000
Message-ID: <160588469905.3465195.11662839857493623334.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove a bunch of now-unused fscache stats counters that were obsoleted by
the removal of the old I/O routines.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/internal.h |   61 -----------------------
 fs/fscache/stats.c    |  129 -------------------------------------------------
 2 files changed, 1 insertion(+), 189 deletions(-)

diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 20cbd1288b5a..360137fd19a7 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -166,9 +166,6 @@ extern void fscache_proc_cleanup(void);
  * stats.c
  */
 #ifdef CONFIG_FSCACHE_STATS
-extern atomic_t fscache_n_ops_processed[FSCACHE_MAX_THREADS];
-extern atomic_t fscache_n_objs_processed[FSCACHE_MAX_THREADS];
-
 extern atomic_t fscache_n_op_pend;
 extern atomic_t fscache_n_op_run;
 extern atomic_t fscache_n_op_enqueue;
@@ -179,52 +176,6 @@ extern atomic_t fscache_n_op_gc;
 extern atomic_t fscache_n_op_cancelled;
 extern atomic_t fscache_n_op_rejected;
 
-extern atomic_t fscache_n_attr_changed;
-extern atomic_t fscache_n_attr_changed_ok;
-extern atomic_t fscache_n_attr_changed_nobufs;
-extern atomic_t fscache_n_attr_changed_nomem;
-extern atomic_t fscache_n_attr_changed_calls;
-
-extern atomic_t fscache_n_allocs;
-extern atomic_t fscache_n_allocs_ok;
-extern atomic_t fscache_n_allocs_wait;
-extern atomic_t fscache_n_allocs_nobufs;
-extern atomic_t fscache_n_allocs_intr;
-extern atomic_t fscache_n_allocs_object_dead;
-extern atomic_t fscache_n_alloc_ops;
-extern atomic_t fscache_n_alloc_op_waits;
-
-extern atomic_t fscache_n_retrievals;
-extern atomic_t fscache_n_retrievals_ok;
-extern atomic_t fscache_n_retrievals_wait;
-extern atomic_t fscache_n_retrievals_nodata;
-extern atomic_t fscache_n_retrievals_nobufs;
-extern atomic_t fscache_n_retrievals_intr;
-extern atomic_t fscache_n_retrievals_nomem;
-extern atomic_t fscache_n_retrievals_object_dead;
-extern atomic_t fscache_n_retrieval_ops;
-extern atomic_t fscache_n_retrieval_op_waits;
-
-extern atomic_t fscache_n_stores;
-extern atomic_t fscache_n_stores_ok;
-extern atomic_t fscache_n_stores_again;
-extern atomic_t fscache_n_stores_nobufs;
-extern atomic_t fscache_n_stores_oom;
-extern atomic_t fscache_n_store_ops;
-extern atomic_t fscache_n_store_calls;
-extern atomic_t fscache_n_store_pages;
-extern atomic_t fscache_n_store_radix_deletes;
-extern atomic_t fscache_n_store_pages_over_limit;
-
-extern atomic_t fscache_n_store_vmscan_not_storing;
-extern atomic_t fscache_n_store_vmscan_gone;
-extern atomic_t fscache_n_store_vmscan_busy;
-extern atomic_t fscache_n_store_vmscan_cancelled;
-extern atomic_t fscache_n_store_vmscan_wait;
-
-extern atomic_t fscache_n_marks;
-extern atomic_t fscache_n_uncaches;
-
 extern atomic_t fscache_n_acquires;
 extern atomic_t fscache_n_acquires_null;
 extern atomic_t fscache_n_acquires_no_cache;
@@ -241,7 +192,6 @@ extern atomic_t fscache_n_updates_run;
 
 extern atomic_t fscache_n_relinquishes;
 extern atomic_t fscache_n_relinquishes_null;
-extern atomic_t fscache_n_relinquishes_waitcrt;
 extern atomic_t fscache_n_relinquishes_retire;
 
 extern atomic_t fscache_n_cookie_index;
@@ -258,11 +208,6 @@ extern atomic_t fscache_n_object_created;
 extern atomic_t fscache_n_object_avail;
 extern atomic_t fscache_n_object_dead;
 
-extern atomic_t fscache_n_checkaux_none;
-extern atomic_t fscache_n_checkaux_okay;
-extern atomic_t fscache_n_checkaux_update;
-extern atomic_t fscache_n_checkaux_obsolete;
-
 extern atomic_t fscache_n_cop_alloc_object;
 extern atomic_t fscache_n_cop_lookup_object;
 extern atomic_t fscache_n_cop_lookup_complete;
@@ -273,12 +218,6 @@ extern atomic_t fscache_n_cop_drop_object;
 extern atomic_t fscache_n_cop_put_object;
 extern atomic_t fscache_n_cop_sync_cache;
 extern atomic_t fscache_n_cop_attr_changed;
-extern atomic_t fscache_n_cop_read_or_alloc_page;
-extern atomic_t fscache_n_cop_read_or_alloc_pages;
-extern atomic_t fscache_n_cop_allocate_page;
-extern atomic_t fscache_n_cop_allocate_pages;
-extern atomic_t fscache_n_cop_write_page;
-extern atomic_t fscache_n_cop_uncache_page;
 
 extern atomic_t fscache_n_cache_no_space_reject;
 extern atomic_t fscache_n_cache_stale_objects;
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index 281022871e70..5b1cec456199 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -24,52 +24,6 @@ atomic_t fscache_n_op_gc;
 atomic_t fscache_n_op_cancelled;
 atomic_t fscache_n_op_rejected;
 
-atomic_t fscache_n_attr_changed;
-atomic_t fscache_n_attr_changed_ok;
-atomic_t fscache_n_attr_changed_nobufs;
-atomic_t fscache_n_attr_changed_nomem;
-atomic_t fscache_n_attr_changed_calls;
-
-atomic_t fscache_n_allocs;
-atomic_t fscache_n_allocs_ok;
-atomic_t fscache_n_allocs_wait;
-atomic_t fscache_n_allocs_nobufs;
-atomic_t fscache_n_allocs_intr;
-atomic_t fscache_n_allocs_object_dead;
-atomic_t fscache_n_alloc_ops;
-atomic_t fscache_n_alloc_op_waits;
-
-atomic_t fscache_n_retrievals;
-atomic_t fscache_n_retrievals_ok;
-atomic_t fscache_n_retrievals_wait;
-atomic_t fscache_n_retrievals_nodata;
-atomic_t fscache_n_retrievals_nobufs;
-atomic_t fscache_n_retrievals_intr;
-atomic_t fscache_n_retrievals_nomem;
-atomic_t fscache_n_retrievals_object_dead;
-atomic_t fscache_n_retrieval_ops;
-atomic_t fscache_n_retrieval_op_waits;
-
-atomic_t fscache_n_stores;
-atomic_t fscache_n_stores_ok;
-atomic_t fscache_n_stores_again;
-atomic_t fscache_n_stores_nobufs;
-atomic_t fscache_n_stores_oom;
-atomic_t fscache_n_store_ops;
-atomic_t fscache_n_store_calls;
-atomic_t fscache_n_store_pages;
-atomic_t fscache_n_store_radix_deletes;
-atomic_t fscache_n_store_pages_over_limit;
-
-atomic_t fscache_n_store_vmscan_not_storing;
-atomic_t fscache_n_store_vmscan_gone;
-atomic_t fscache_n_store_vmscan_busy;
-atomic_t fscache_n_store_vmscan_cancelled;
-atomic_t fscache_n_store_vmscan_wait;
-
-atomic_t fscache_n_marks;
-atomic_t fscache_n_uncaches;
-
 atomic_t fscache_n_acquires;
 atomic_t fscache_n_acquires_null;
 atomic_t fscache_n_acquires_no_cache;
@@ -86,7 +40,6 @@ atomic_t fscache_n_updates_run;
 
 atomic_t fscache_n_relinquishes;
 atomic_t fscache_n_relinquishes_null;
-atomic_t fscache_n_relinquishes_waitcrt;
 atomic_t fscache_n_relinquishes_retire;
 
 atomic_t fscache_n_cookie_index;
@@ -103,11 +56,6 @@ atomic_t fscache_n_object_created;
 atomic_t fscache_n_object_avail;
 atomic_t fscache_n_object_dead;
 
-atomic_t fscache_n_checkaux_none;
-atomic_t fscache_n_checkaux_okay;
-atomic_t fscache_n_checkaux_update;
-atomic_t fscache_n_checkaux_obsolete;
-
 atomic_t fscache_n_cop_alloc_object;
 atomic_t fscache_n_cop_lookup_object;
 atomic_t fscache_n_cop_lookup_complete;
@@ -118,12 +66,6 @@ atomic_t fscache_n_cop_drop_object;
 atomic_t fscache_n_cop_put_object;
 atomic_t fscache_n_cop_sync_cache;
 atomic_t fscache_n_cop_attr_changed;
-atomic_t fscache_n_cop_read_or_alloc_page;
-atomic_t fscache_n_cop_read_or_alloc_pages;
-atomic_t fscache_n_cop_allocate_page;
-atomic_t fscache_n_cop_allocate_pages;
-atomic_t fscache_n_cop_write_page;
-atomic_t fscache_n_cop_uncache_page;
 
 atomic_t fscache_n_cache_no_space_reject;
 atomic_t fscache_n_cache_stale_objects;
@@ -147,15 +89,6 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_object_no_alloc),
 		   atomic_read(&fscache_n_object_avail),
 		   atomic_read(&fscache_n_object_dead));
-	seq_printf(m, "ChkAux : non=%u ok=%u upd=%u obs=%u\n",
-		   atomic_read(&fscache_n_checkaux_none),
-		   atomic_read(&fscache_n_checkaux_okay),
-		   atomic_read(&fscache_n_checkaux_update),
-		   atomic_read(&fscache_n_checkaux_obsolete));
-
-	seq_printf(m, "Pages  : mrk=%u unc=%u\n",
-		   atomic_read(&fscache_n_marks),
-		   atomic_read(&fscache_n_uncaches));
 
 	seq_printf(m, "Acquire: n=%u nul=%u noc=%u ok=%u nbf=%u"
 		   " oom=%u\n",
@@ -182,64 +115,11 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_updates_null),
 		   atomic_read(&fscache_n_updates_run));
 
-	seq_printf(m, "Relinqs: n=%u nul=%u wcr=%u rtr=%u\n",
+	seq_printf(m, "Relinqs: n=%u nul=%u rtr=%u\n",
 		   atomic_read(&fscache_n_relinquishes),
 		   atomic_read(&fscache_n_relinquishes_null),
-		   atomic_read(&fscache_n_relinquishes_waitcrt),
 		   atomic_read(&fscache_n_relinquishes_retire));
 
-	seq_printf(m, "AttrChg: n=%u ok=%u nbf=%u oom=%u run=%u\n",
-		   atomic_read(&fscache_n_attr_changed),
-		   atomic_read(&fscache_n_attr_changed_ok),
-		   atomic_read(&fscache_n_attr_changed_nobufs),
-		   atomic_read(&fscache_n_attr_changed_nomem),
-		   atomic_read(&fscache_n_attr_changed_calls));
-
-	seq_printf(m, "Allocs : n=%u ok=%u wt=%u nbf=%u int=%u\n",
-		   atomic_read(&fscache_n_allocs),
-		   atomic_read(&fscache_n_allocs_ok),
-		   atomic_read(&fscache_n_allocs_wait),
-		   atomic_read(&fscache_n_allocs_nobufs),
-		   atomic_read(&fscache_n_allocs_intr));
-	seq_printf(m, "Allocs : ops=%u owt=%u abt=%u\n",
-		   atomic_read(&fscache_n_alloc_ops),
-		   atomic_read(&fscache_n_alloc_op_waits),
-		   atomic_read(&fscache_n_allocs_object_dead));
-
-	seq_printf(m, "Retrvls: n=%u ok=%u wt=%u nod=%u nbf=%u"
-		   " int=%u oom=%u\n",
-		   atomic_read(&fscache_n_retrievals),
-		   atomic_read(&fscache_n_retrievals_ok),
-		   atomic_read(&fscache_n_retrievals_wait),
-		   atomic_read(&fscache_n_retrievals_nodata),
-		   atomic_read(&fscache_n_retrievals_nobufs),
-		   atomic_read(&fscache_n_retrievals_intr),
-		   atomic_read(&fscache_n_retrievals_nomem));
-	seq_printf(m, "Retrvls: ops=%u owt=%u abt=%u\n",
-		   atomic_read(&fscache_n_retrieval_ops),
-		   atomic_read(&fscache_n_retrieval_op_waits),
-		   atomic_read(&fscache_n_retrievals_object_dead));
-
-	seq_printf(m, "Stores : n=%u ok=%u agn=%u nbf=%u oom=%u\n",
-		   atomic_read(&fscache_n_stores),
-		   atomic_read(&fscache_n_stores_ok),
-		   atomic_read(&fscache_n_stores_again),
-		   atomic_read(&fscache_n_stores_nobufs),
-		   atomic_read(&fscache_n_stores_oom));
-	seq_printf(m, "Stores : ops=%u run=%u pgs=%u rxd=%u olm=%u\n",
-		   atomic_read(&fscache_n_store_ops),
-		   atomic_read(&fscache_n_store_calls),
-		   atomic_read(&fscache_n_store_pages),
-		   atomic_read(&fscache_n_store_radix_deletes),
-		   atomic_read(&fscache_n_store_pages_over_limit));
-
-	seq_printf(m, "VmScan : nos=%u gon=%u bsy=%u can=%u wt=%u\n",
-		   atomic_read(&fscache_n_store_vmscan_not_storing),
-		   atomic_read(&fscache_n_store_vmscan_gone),
-		   atomic_read(&fscache_n_store_vmscan_busy),
-		   atomic_read(&fscache_n_store_vmscan_cancelled),
-		   atomic_read(&fscache_n_store_vmscan_wait));
-
 	seq_printf(m, "Ops    : pend=%u run=%u enq=%u can=%u rej=%u\n",
 		   atomic_read(&fscache_n_op_pend),
 		   atomic_read(&fscache_n_op_run),
@@ -264,13 +144,6 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_cop_put_object),
 		   atomic_read(&fscache_n_cop_attr_changed),
 		   atomic_read(&fscache_n_cop_sync_cache));
-	seq_printf(m, "CacheOp: rap=%d ras=%d alp=%d als=%d wrp=%d ucp=%d\n",
-		   atomic_read(&fscache_n_cop_read_or_alloc_page),
-		   atomic_read(&fscache_n_cop_read_or_alloc_pages),
-		   atomic_read(&fscache_n_cop_allocate_page),
-		   atomic_read(&fscache_n_cop_allocate_pages),
-		   atomic_read(&fscache_n_cop_write_page),
-		   atomic_read(&fscache_n_cop_uncache_page));
 	seq_printf(m, "CacheEv: nsp=%d stl=%d rtr=%d cul=%d\n",
 		   atomic_read(&fscache_n_cache_no_space_reject),
 		   atomic_read(&fscache_n_cache_stale_objects),


