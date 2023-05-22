Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7609370C090
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbjEVN50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbjEVN5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8181FEB
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684763551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1dW3gfal+wiqS1BsUQ7v1POUMzsncK8bE2BxQUdT+Fw=;
        b=RVYThWwnK4XXCbKfyz26W1eztJFWTLbGvRsNVH0Vx0mG5+AFKxY0PQkyGfLlrqhlKJF5TD
        /BdCIlk58kKhPb0hrhprfSDvQvTDjmfHSHVQ9gOG8sY7bGetzK16S0MdZSOa2Fw8VSvsW3
        R8eqZ8kOj5yBGfgErTHSlX/rftCRVfw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-O78IS1gQNUW2bLyo8CEsOA-1; Mon, 22 May 2023 09:52:26 -0400
X-MC-Unique: O78IS1gQNUW2bLyo8CEsOA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 213773C025AD;
        Mon, 22 May 2023 13:52:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AEE4140E95D;
        Mon, 22 May 2023 13:52:22 +0000 (UTC)
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Steve French <smfrench@gmail.com>, linux-cifs@vger.kernel.org
Subject: [PATCH v22 31/31] splice: kdoc for filemap_splice_read() and copy_splice_read()
Date:   Mon, 22 May 2023 14:50:18 +0100
Message-Id: <20230522135018.2742245-32-dhowells@redhat.com>
In-Reply-To: <20230522135018.2742245-1-dhowells@redhat.com>
References: <20230522135018.2742245-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide kerneldoc comments for filemap_splice_read() and
copy_splice_read().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christian Brauner <brauner@kernel.org>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Steve French <smfrench@gmail.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/splice.c  | 21 +++++++++++++++++++--
 mm/filemap.c | 21 ++++++++++++++++++---
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 9be4cb3b9879..2420ead610a7 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -299,8 +299,25 @@ void splice_shrink_spd(struct splice_pipe_desc *spd)
 	kfree(spd->partial);
 }
 
-/*
- * Copy data from a file into pages and then splice those into the output pipe.
+/**
+ * copy_splice_read -  Copy data from a file and splice the copy into a pipe
+ * @in: The file to read from
+ * @ppos: Pointer to the file position to read from
+ * @pipe: The pipe to splice into
+ * @len: The amount to splice
+ * @flags: The SPLICE_F_* flags
+ *
+ * This function allocates a bunch of pages sufficient to hold the requested
+ * amount of data (but limited by the remaining pipe capacity), passes it to
+ * the file's ->read_iter() to read into and then splices the used pages into
+ * the pipe.
+ *
+ * Return: On success, the number of bytes read will be returned and *@ppos
+ * will be updated if appropriate; 0 will be returned if there is no more data
+ * to be read; -EAGAIN will be returned if the pipe had no space, and some
+ * other negative error code will be returned on error.  A short read may occur
+ * if the pipe has insufficient space, we reach the end of the data or we hit a
+ * hole.
  */
 ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 			 struct pipe_inode_info *pipe,
diff --git a/mm/filemap.c b/mm/filemap.c
index 603b562d69b1..f87e2ad8cff1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2871,9 +2871,24 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
 	return spliced;
 }
 
-/*
- * Splice folios from the pagecache of a buffered (ie. non-O_DIRECT) file into
- * a pipe.
+/**
+ * filemap_splice_read -  Splice data from a file's pagecache into a pipe
+ * @in: The file to read from
+ * @ppos: Pointer to the file position to read from
+ * @pipe: The pipe to splice into
+ * @len: The amount to splice
+ * @flags: The SPLICE_F_* flags
+ *
+ * This function gets folios from a file's pagecache and splices them into the
+ * pipe.  Readahead will be called as necessary to fill more folios.  This may
+ * be used for blockdevs also.
+ *
+ * Return: On success, the number of bytes read will be returned and *@ppos
+ * will be updated if appropriate; 0 will be returned if there is no more data
+ * to be read; -EAGAIN will be returned if the pipe had no space, and some
+ * other negative error code will be returned on error.  A short read may occur
+ * if the pipe has insufficient space, we reach the end of the data or we hit a
+ * hole.
  */
 ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 			    struct pipe_inode_info *pipe,

