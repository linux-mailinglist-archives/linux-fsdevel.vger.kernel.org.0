Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A9C2BAE11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgKTPMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:12:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728619AbgKTPMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hgTdeaebYh2VCRG9KSsvpNQmhVvkLE4rfSTCygGXkCU=;
        b=IgWCAvMXO0moTKY0Toif08gmZHBfMItSQW1VmUkbZ+Uml4xqvIa+3q62tlWU/bf1kruWaC
        aYhP3DB7dIX3L0H/ufJDJ2EPBOqnr3jy5JWtYizV9aYpSBUfeIsibgih/bINvyv7TvfN6K
        9GrOX4Y8Urx1yx88EdZuD6NTtAALUpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-KijSN8yiMWab-J7QtJCBZA-1; Fri, 20 Nov 2020 10:12:48 -0500
X-MC-Unique: KijSN8yiMWab-J7QtJCBZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FF69814411;
        Fri, 20 Nov 2020 15:12:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8299A5C224;
        Fri, 20 Nov 2020 15:12:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 47/76] fscache: Remove more obsolete stats
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
Date:   Fri, 20 Nov 2020 15:12:42 +0000
Message-ID: <160588516273.3465195.185326813484138143.stgit@warthog.procyon.org.uk>
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

Remove some more stats that have become obsolete.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/internal.h |   20 ++---------------
 fs/fscache/obj.c      |    6 +++--
 fs/fscache/stats.c    |   58 +++++++++----------------------------------------
 3 files changed, 16 insertions(+), 68 deletions(-)

diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 2c1f4151c092..ae05f636faac 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -175,32 +175,18 @@ extern void fscache_proc_cleanup(void);
  * stats.c
  */
 #ifdef CONFIG_FSCACHE_STATS
-extern atomic_t fscache_n_op_pend;
-extern atomic_t fscache_n_op_run;
-extern atomic_t fscache_n_op_enqueue;
-extern atomic_t fscache_n_op_deferred_release;
-extern atomic_t fscache_n_op_initialised;
-extern atomic_t fscache_n_op_release;
-extern atomic_t fscache_n_op_gc;
-extern atomic_t fscache_n_op_cancelled;
-extern atomic_t fscache_n_op_rejected;
-
 extern atomic_t fscache_n_acquires;
 extern atomic_t fscache_n_acquires_null;
 extern atomic_t fscache_n_acquires_no_cache;
 extern atomic_t fscache_n_acquires_ok;
-extern atomic_t fscache_n_acquires_nobufs;
 extern atomic_t fscache_n_acquires_oom;
 
 extern atomic_t fscache_n_invalidates;
-extern atomic_t fscache_n_invalidates_run;
 
 extern atomic_t fscache_n_updates;
-extern atomic_t fscache_n_updates_null;
 extern atomic_t fscache_n_updates_run;
 
 extern atomic_t fscache_n_relinquishes;
-extern atomic_t fscache_n_relinquishes_null;
 extern atomic_t fscache_n_relinquishes_retire;
 
 extern atomic_t fscache_n_cookie_index;
@@ -212,15 +198,13 @@ extern atomic_t fscache_n_object_no_alloc;
 extern atomic_t fscache_n_object_lookups;
 extern atomic_t fscache_n_object_lookups_negative;
 extern atomic_t fscache_n_object_lookups_positive;
-extern atomic_t fscache_n_object_lookups_timed_out;
-extern atomic_t fscache_n_object_created;
+extern atomic_t fscache_n_object_creates;
 extern atomic_t fscache_n_object_avail;
 extern atomic_t fscache_n_object_dead;
 
 extern atomic_t fscache_n_cop_alloc_object;
 extern atomic_t fscache_n_cop_lookup_object;
-extern atomic_t fscache_n_cop_lookup_complete;
-extern atomic_t fscache_n_cop_grab_object;
+extern atomic_t fscache_n_cop_create_object;
 extern atomic_t fscache_n_cop_invalidate_object;
 extern atomic_t fscache_n_cop_update_object;
 extern atomic_t fscache_n_cop_drop_object;
diff --git a/fs/fscache/obj.c b/fs/fscache/obj.c
index 7286d3e2eb31..23598bec639e 100644
--- a/fs/fscache/obj.c
+++ b/fs/fscache/obj.c
@@ -47,10 +47,10 @@ static int fscache_do_lookup_object(struct fscache_object *object, void *data)
 static int fscache_do_create_object(struct fscache_object *object, void *data)
 {
 	int ret;
-	fscache_stat(&fscache_n_object_lookups);
-	fscache_stat(&fscache_n_cop_lookup_object);
+	fscache_stat(&fscache_n_object_creates);
+	fscache_stat(&fscache_n_cop_create_object);
 	ret = object->cache->ops->create_object(object, data);
-	fscache_stat_d(&fscache_n_cop_lookup_object);
+	fscache_stat_d(&fscache_n_cop_create_object);
 	return ret;
 }
 
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index 583817f4f113..dffe6925aadb 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -14,32 +14,18 @@
 /*
  * operation counters
  */
-atomic_t fscache_n_op_pend;
-atomic_t fscache_n_op_run;
-atomic_t fscache_n_op_enqueue;
-atomic_t fscache_n_op_deferred_release;
-atomic_t fscache_n_op_initialised;
-atomic_t fscache_n_op_release;
-atomic_t fscache_n_op_gc;
-atomic_t fscache_n_op_cancelled;
-atomic_t fscache_n_op_rejected;
-
 atomic_t fscache_n_acquires;
 atomic_t fscache_n_acquires_null;
 atomic_t fscache_n_acquires_no_cache;
 atomic_t fscache_n_acquires_ok;
-atomic_t fscache_n_acquires_nobufs;
 atomic_t fscache_n_acquires_oom;
 
 atomic_t fscache_n_invalidates;
-atomic_t fscache_n_invalidates_run;
 
 atomic_t fscache_n_updates;
-atomic_t fscache_n_updates_null;
 atomic_t fscache_n_updates_run;
 
 atomic_t fscache_n_relinquishes;
-atomic_t fscache_n_relinquishes_null;
 atomic_t fscache_n_relinquishes_retire;
 
 atomic_t fscache_n_cookie_index;
@@ -51,15 +37,13 @@ atomic_t fscache_n_object_no_alloc;
 atomic_t fscache_n_object_lookups;
 atomic_t fscache_n_object_lookups_negative;
 atomic_t fscache_n_object_lookups_positive;
-atomic_t fscache_n_object_lookups_timed_out;
-atomic_t fscache_n_object_created;
+atomic_t fscache_n_object_creates;
 atomic_t fscache_n_object_avail;
 atomic_t fscache_n_object_dead;
 
 atomic_t fscache_n_cop_alloc_object;
 atomic_t fscache_n_cop_lookup_object;
-atomic_t fscache_n_cop_lookup_complete;
-atomic_t fscache_n_cop_grab_object;
+atomic_t fscache_n_cop_create_object;
 atomic_t fscache_n_cop_invalidate_object;
 atomic_t fscache_n_cop_update_object;
 atomic_t fscache_n_cop_drop_object;
@@ -90,53 +74,33 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_object_avail),
 		   atomic_read(&fscache_n_object_dead));
 
-	seq_printf(m, "Acquire: n=%u nul=%u noc=%u ok=%u nbf=%u"
-		   " oom=%u\n",
+	seq_printf(m, "Acquire: n=%u nul=%u noc=%u ok=%u oom=%u\n",
 		   atomic_read(&fscache_n_acquires),
 		   atomic_read(&fscache_n_acquires_null),
 		   atomic_read(&fscache_n_acquires_no_cache),
 		   atomic_read(&fscache_n_acquires_ok),
-		   atomic_read(&fscache_n_acquires_nobufs),
 		   atomic_read(&fscache_n_acquires_oom));
 
-	seq_printf(m, "Lookups: n=%u neg=%u pos=%u crt=%u tmo=%u\n",
+	seq_printf(m, "Lookups: n=%u neg=%u pos=%u crt=%u\n",
 		   atomic_read(&fscache_n_object_lookups),
 		   atomic_read(&fscache_n_object_lookups_negative),
 		   atomic_read(&fscache_n_object_lookups_positive),
-		   atomic_read(&fscache_n_object_created),
-		   atomic_read(&fscache_n_object_lookups_timed_out));
+		   atomic_read(&fscache_n_object_creates));
 
-	seq_printf(m, "Invals : n=%u run=%u\n",
-		   atomic_read(&fscache_n_invalidates),
-		   atomic_read(&fscache_n_invalidates_run));
+	seq_printf(m, "Invals : n=%u\n",
+		   atomic_read(&fscache_n_invalidates));
 
-	seq_printf(m, "Updates: n=%u nul=%u run=%u\n",
+	seq_printf(m, "Updates: n=%u run=%u\n",
 		   atomic_read(&fscache_n_updates),
-		   atomic_read(&fscache_n_updates_null),
 		   atomic_read(&fscache_n_updates_run));
 
-	seq_printf(m, "Relinqs: n=%u nul=%u rtr=%u\n",
+	seq_printf(m, "Relinqs: n=%u rtr=%u\n",
 		   atomic_read(&fscache_n_relinquishes),
-		   atomic_read(&fscache_n_relinquishes_null),
 		   atomic_read(&fscache_n_relinquishes_retire));
 
-	seq_printf(m, "Ops    : pend=%u run=%u enq=%u can=%u rej=%u\n",
-		   atomic_read(&fscache_n_op_pend),
-		   atomic_read(&fscache_n_op_run),
-		   atomic_read(&fscache_n_op_enqueue),
-		   atomic_read(&fscache_n_op_cancelled),
-		   atomic_read(&fscache_n_op_rejected));
-	seq_printf(m, "Ops    : ini=%u dfr=%u rel=%u gc=%u\n",
-		   atomic_read(&fscache_n_op_initialised),
-		   atomic_read(&fscache_n_op_deferred_release),
-		   atomic_read(&fscache_n_op_release),
-		   atomic_read(&fscache_n_op_gc));
-
-	seq_printf(m, "CacheOp: alo=%d luo=%d luc=%d gro=%d\n",
+	seq_printf(m, "CacheOp: alo=%d luo=%d\n",
 		   atomic_read(&fscache_n_cop_alloc_object),
-		   atomic_read(&fscache_n_cop_lookup_object),
-		   atomic_read(&fscache_n_cop_lookup_complete),
-		   atomic_read(&fscache_n_cop_grab_object));
+		   atomic_read(&fscache_n_cop_lookup_object));
 	seq_printf(m, "CacheOp: inv=%d upo=%d dro=%d pto=%d atc=%d syn=%d\n",
 		   atomic_read(&fscache_n_cop_invalidate_object),
 		   atomic_read(&fscache_n_cop_update_object),


