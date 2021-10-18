Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E51B432158
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhJRPC6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:02:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233213AbhJRPCx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0rLWjOac2bldltPLSIvO7t4xwzOfczTlvO1pL5kPDYk=;
        b=bzipQAIsjMrV11iBqzSqtPppzlefxhmrvwPSa12U1LmrKgU0xkNpGANyq6kqxqL3B9+xDF
        BRcqTsye1KduA/q75bYPZRi3ExoB7h3RqTzN9QTdTsm2LTHmc4ZXtMBdu4TsUwktaoA+9F
        Sm/M+VRce5UGH/Co4CLWmYyxkh/i538=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-hJFmt2ErMya7D3FK-BzwiQ-1; Mon, 18 Oct 2021 11:00:35 -0400
X-MC-Unique: hJFmt2ErMya7D3FK-BzwiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B317180DDE1;
        Mon, 18 Oct 2021 15:00:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A878A60D30;
        Mon, 18 Oct 2021 15:00:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 38/67] fscache: Remove more obsolete stats
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
Date:   Mon, 18 Oct 2021 16:00:28 +0100
Message-ID: <163456922892.2614702.12945425715751699836.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove some more stats that have become obsolete.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/internal.h |    3 ---
 fs/fscache/stats.c    |   13 +++----------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 1cb1effa7cba..65fb4e88f655 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -101,14 +101,11 @@ extern atomic_t fscache_n_acquires;
 extern atomic_t fscache_n_acquires_null;
 extern atomic_t fscache_n_acquires_no_cache;
 extern atomic_t fscache_n_acquires_ok;
-extern atomic_t fscache_n_acquires_nobufs;
 extern atomic_t fscache_n_acquires_oom;
 
 extern atomic_t fscache_n_invalidates;
-extern atomic_t fscache_n_invalidates_run;
 
 extern atomic_t fscache_n_relinquishes;
-extern atomic_t fscache_n_relinquishes_null;
 extern atomic_t fscache_n_relinquishes_retire;
 extern atomic_t fscache_n_relinquishes_dropped;
 
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index a16473df8be0..44b3b901e191 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -6,7 +6,6 @@
  */
 
 #define FSCACHE_DEBUG_LEVEL CACHE
-#include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include "internal.h"
@@ -48,17 +47,14 @@ atomic_t fscache_n_acquires;
 atomic_t fscache_n_acquires_null;
 atomic_t fscache_n_acquires_no_cache;
 atomic_t fscache_n_acquires_ok;
-atomic_t fscache_n_acquires_nobufs;
 atomic_t fscache_n_acquires_oom;
 
 atomic_t fscache_n_invalidates;
-atomic_t fscache_n_invalidates_run;
 
 atomic_t fscache_n_updates;
 EXPORT_SYMBOL(fscache_n_updates);
 
 atomic_t fscache_n_relinquishes;
-atomic_t fscache_n_relinquishes_null;
 atomic_t fscache_n_relinquishes_retire;
 atomic_t fscache_n_relinquishes_dropped;
 
@@ -83,13 +79,11 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_volumes_nomem)
 		   );
 
-	seq_printf(m, "Acquire: n=%u nul=%u noc=%u ok=%u nbf=%u"
-		   " oom=%u\n",
+	seq_printf(m, "Acquire: n=%u nul=%u noc=%u ok=%u oom=%u\n",
 		   atomic_read(&fscache_n_acquires),
 		   atomic_read(&fscache_n_acquires_null),
 		   atomic_read(&fscache_n_acquires_no_cache),
 		   atomic_read(&fscache_n_acquires_ok),
-		   atomic_read(&fscache_n_acquires_nobufs),
 		   atomic_read(&fscache_n_acquires_oom));
 
 	seq_printf(m, "LRU    : n=%u exp=%u rmv=%u drp=%u at=%ld\n",
@@ -100,9 +94,8 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   timer_pending(&fscache_cookie_lru_timer) ?
 		   fscache_cookie_lru_timer.expires - jiffies : 0);
 
-	seq_printf(m, "Invals : n=%u run=%u\n",
-		   atomic_read(&fscache_n_invalidates),
-		   atomic_read(&fscache_n_invalidates_run));
+	seq_printf(m, "Invals : n=%u\n",
+		   atomic_read(&fscache_n_invalidates));
 
 	seq_printf(m, "Updates: n=%u\n",
 		   atomic_read(&fscache_n_updates));


