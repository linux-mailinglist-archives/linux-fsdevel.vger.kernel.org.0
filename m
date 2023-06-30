Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D979743E8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 17:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjF3PT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 11:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjF3PTA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFCF449B
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 08:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sac/z7qt8qX/jw2GCw1Fghx39S+xMjFejmZ6Kx/zzF8=;
        b=cOPMPnqorr0gKHXmVkoER77+zUzuT58TULvk8s0HP8oMsJgzMi5DCc3w/ctcJffM19bblh
        QkE3vUQWAUEy7WnrGgCs5tJdA/ro6VYMC1JWv2z5A5z5wFnt3FvDE+1F2sOvXq/qAg9XwY
        5I0W4Dbi/s3zA8+/WsH4Cyp5gu1c5aE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-wd4BOK4CNAGGF3o5uSBHdw-1; Fri, 30 Jun 2023 11:16:57 -0400
X-MC-Unique: wd4BOK4CNAGGF3o5uSBHdw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D66FB2812949;
        Fri, 30 Jun 2023 15:16:56 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.39.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B1CB492B02;
        Fri, 30 Jun 2023 15:16:53 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>
Subject: [RFC PATCH 01/11] iov_iter: Fix comment refs to iov_iter_get_pages/pages_alloc()
Date:   Fri, 30 Jun 2023 16:16:18 +0100
Message-ID: <20230630151628.660343-2-dhowells@redhat.com>
In-Reply-To: <20230630151628.660343-1-dhowells@redhat.com>
References: <20230630151628.660343-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix references to iov_iter_get_pages/pages_alloc() in comments to refer to
the *2 interfaces instead.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christian Brauner <christian@brauner.io>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/ceph/file.c           | 4 ++--
 include/linux/mm_types.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index b1925232dc08..3bb27b9ce751 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -75,7 +75,7 @@ static __le32 ceph_flags_sys2wire(u32 flags)
  */
 
 /*
- * How many pages to get in one call to iov_iter_get_pages().  This
+ * How many pages to get in one call to iov_iter_get_pages2().  This
  * determines the size of the on-stack array used as a buffer.
  */
 #define ITER_GET_BVECS_PAGES	64
@@ -115,7 +115,7 @@ static ssize_t __iter_get_bvecs(struct iov_iter *iter, size_t maxsize,
 }
 
 /*
- * iov_iter_get_pages() only considers one iov_iter segment, no matter
+ * iov_iter_get_pages2() only considers one iov_iter segment, no matter
  * what maxsize or maxpages are given.  For ITER_BVEC that is a single
  * page.
  *
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index de10fc797c8e..f49029c943b0 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1249,7 +1249,7 @@ enum {
 	/*
 	 * FOLL_LONGTERM indicates that the page will be held for an indefinite
 	 * time period _often_ under userspace control.  This is in contrast to
-	 * iov_iter_get_pages(), whose usages are transient.
+	 * iov_iter_get_pages2(), whose usages are transient.
 	 */
 	FOLL_LONGTERM = 1 << 8,
 	/* split huge pmd before returning */

