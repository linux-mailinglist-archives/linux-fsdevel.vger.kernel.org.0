Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B824D4EBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 17:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241848AbiCJQSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 11:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbiCJQRx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:17:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D934191413
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 08:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646929011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m0zrrGDSu3YpWsafJE6HK4NAMWnjg+E7bcoPNDsGgLA=;
        b=ir8gOBWEioFpGO2S+r7OCiQhdno+xSPkD48uMCXJLoUnAV8DTS8smAZkVaG0qc9AJ9xVe3
        ffbEAAbQhcc49kjjQ2HGJKTiyLmSArWb5CCzYxBALAj9M+q7KODkFK+VwtAdF9F3AkhDEC
        YdAxvLs+TvbDog7JjaTR/xWVmWK9CvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-oBrO6CweM-uyQIPhsOA3Gw-1; Thu, 10 Mar 2022 11:16:46 -0500
X-MC-Unique: oBrO6CweM-uyQIPhsOA3Gw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDF78824FA7;
        Thu, 10 Mar 2022 16:16:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B11CC86C33;
        Thu, 10 Mar 2022 16:16:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 06/20] netfs: Adjust the netfs_rreq tracepoint slightly
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Jeff Layton <jlayton@kernel.org>, dhowells@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
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
Date:   Thu, 10 Mar 2022 16:16:26 +0000
Message-ID: <164692898684.2099075.12153225958137716567.stgit@warthog.procyon.org.uk>
In-Reply-To: <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
References: <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Adjust the netfs_rreq tracepoint to include the origin of the request and
to increase the size of the "what trace" output strings by a character so
that "ENCRYPT" and "DECRYPT" will fit without abbreviation.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/164622996715.3564931.4252319907990358129.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/164678199468.1200972.17275585970238114726.stgit@warthog.procyon.org.uk/ # v2
---

 fs/netfs/read_helper.c       |    2 +-
 include/trace/events/netfs.h |   18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index ef23ef9889d5..181aeda32649 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -181,7 +181,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
 	struct iov_iter iter;
 	int ret;
 
-	trace_netfs_rreq(rreq, netfs_rreq_trace_write);
+	trace_netfs_rreq(rreq, netfs_rreq_trace_copy);
 
 	/* We don't want terminating writes trying to wake us up whilst we're
 	 * still going through the list.
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index b40809c0bd74..0c7a26c4d11c 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -22,13 +22,13 @@
 	E_(netfs_read_trace_write_begin,	"WRITEBEGN")
 
 #define netfs_rreq_traces					\
-	EM(netfs_rreq_trace_assess,		"ASSESS")	\
-	EM(netfs_rreq_trace_done,		"DONE  ")	\
-	EM(netfs_rreq_trace_free,		"FREE  ")	\
-	EM(netfs_rreq_trace_resubmit,		"RESUBM")	\
-	EM(netfs_rreq_trace_unlock,		"UNLOCK")	\
-	EM(netfs_rreq_trace_unmark,		"UNMARK")	\
-	E_(netfs_rreq_trace_write,		"WRITE ")
+	EM(netfs_rreq_trace_assess,		"ASSESS ")	\
+	EM(netfs_rreq_trace_copy,		"COPY   ")	\
+	EM(netfs_rreq_trace_done,		"DONE   ")	\
+	EM(netfs_rreq_trace_free,		"FREE   ")	\
+	EM(netfs_rreq_trace_resubmit,		"RESUBMT")	\
+	EM(netfs_rreq_trace_unlock,		"UNLOCK ")	\
+	E_(netfs_rreq_trace_unmark,		"UNMARK ")
 
 #define netfs_sreq_sources					\
 	EM(NETFS_FILL_WITH_ZEROES,		"ZERO")		\
@@ -134,7 +134,7 @@ TRACE_EVENT(netfs_rreq,
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		rreq		)
-		    __field(unsigned short,		flags		)
+		    __field(unsigned int,		flags		)
 		    __field(enum netfs_rreq_trace,	what		)
 			     ),
 
@@ -182,8 +182,8 @@ TRACE_EVENT(netfs_sreq,
 
 	    TP_printk("R=%08x[%u] %s %s f=%02x s=%llx %zx/%zx e=%d",
 		      __entry->rreq, __entry->index,
-		      __print_symbolic(__entry->what, netfs_sreq_traces),
 		      __print_symbolic(__entry->source, netfs_sreq_sources),
+		      __print_symbolic(__entry->what, netfs_sreq_traces),
 		      __entry->flags,
 		      __entry->start, __entry->transferred, __entry->len,
 		      __entry->error)


