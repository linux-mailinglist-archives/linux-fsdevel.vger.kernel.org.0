Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C624927B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244275AbiARNyk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:54:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244414AbiARNy3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642514069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GZzU3Qzlz4du0HJk3pIy88pOD0oFL5+7cfgc4MIvSjc=;
        b=FUz9kKzf3K2GeERiUUxyKjTkfE+nRlRJn0VC7LcluIESDZc8cxZb1Vfeo+d2EVOT4Voq2r
        h3WraYqIyJPs74i1BQ+ZdR15zujBQhYnZudyJpN1xApFLf1bD6l+ibga+hP+d+Rn6vNo58
        as6Hnu6ZzxhWYW3YmlJrgYVKCxxlrZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-iXKYrVelNbCgNPklJReXeg-1; Tue, 18 Jan 2022 08:54:26 -0500
X-MC-Unique: iXKYrVelNbCgNPklJReXeg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56DF0100C625;
        Tue, 18 Jan 2022 13:54:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12AF77A3F9;
        Tue, 18 Jan 2022 13:54:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/11] cachefiles: Explain checks in a comment
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Jeff Layton <jlayton@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <smfrench@gmail.com>,
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
Date:   Tue, 18 Jan 2022 13:54:16 +0000
Message-ID: <164251405621.3435901.771439791811515914.stgit@warthog.procyon.org.uk>
In-Reply-To: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
References: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a comment to explain the checks that cachefiles is making of the
backing filesystem[1].

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/568749bd7cc02908ecf6f3d6a611b6f9cf5c4afd.camel@kernel.org/ [1]
---

 fs/cachefiles/cache.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
index 1e9c71666c6a..2b2879c5d1d2 100644
--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -49,7 +49,13 @@ int cachefiles_add_cache(struct cachefiles_cache *cache)
 		goto error_unsupported;
 	}
 
-	/* check parameters */
+	/* Check features of the backing filesystem:
+	 * - Directories must support looking up and directory creation
+	 * - We use xattrs to store metadata
+	 * - We need to be able to query the amount of space available
+	 * - We want to be able to sync the filesystem when stopping the cache
+	 * - We use DIO to/from pages, so the blocksize mustn't be too big.
+	 */
 	ret = -EOPNOTSUPP;
 	if (d_is_negative(root) ||
 	    !d_backing_inode(root)->i_op->lookup ||


