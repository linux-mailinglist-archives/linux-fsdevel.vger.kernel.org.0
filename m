Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D0C7163A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 16:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjE3OTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 10:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjE3OSt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 10:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E8D184
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 07:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685456232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZhuY8lo9alWA9NhmnnpTaWvKv5QvMPV1nDbwBiDKtM=;
        b=GEYxyAR+ygzY+A2JljV9Kok+8mzRvo/H83geqqPbJ+EbyFcU7bhn/HwsLZEKlYGkF5AcZ7
        Qi4Iz9XtW38nUBbRxmzLKp82vVxozdoYSb9nOfeGQ5Y0As1OIQ8eZpcKzXb60Ma+G71Q9e
        hlD+2/jKmzFSzpAoVaVPJ2CG3X7Hwro=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-4s_DJpgzMaGbhp4TeKUhEQ-1; Tue, 30 May 2023 10:17:09 -0400
X-MC-Unique: 4s_DJpgzMaGbhp4TeKUhEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C7E7858F18;
        Tue, 30 May 2023 14:17:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75F0E40CFD46;
        Tue, 30 May 2023 14:17:04 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-crypto@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH net-next v2 02/10] Fix a couple of spelling mistakes
Date:   Tue, 30 May 2023 15:16:26 +0100
Message-ID: <20230530141635.136968-3-dhowells@redhat.com>
In-Reply-To: <20230530141635.136968-1-dhowells@redhat.com>
References: <20230530141635.136968-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix a couple of spelling mistakes in a comment.

Suggested-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/ZHH2mSRqeL4Gs1ft@corigine.com/
Link: https://lore.kernel.org/r/ZHH1nqZWOGzxlidT@corigine.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-crypto@vger.kernel.org
cc: linux-cachefs@redhat.com
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: netdev@vger.kernel.org
---
 fs/netfs/iterator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index f8eba3de1a97..f41a37bca1e8 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -312,7 +312,7 @@ static ssize_t extract_xarray_to_sg(struct iov_iter *iter,
 }
 
 /**
- * extract_iter_to_sg - Extract pages from an iterator and add ot an sglist
+ * extract_iter_to_sg - Extract pages from an iterator and add to an sglist
  * @iter: The iterator to extract from
  * @maxsize: The amount of iterator to copy
  * @sgtable: The scatterlist table to fill in
@@ -332,7 +332,7 @@ static ssize_t extract_xarray_to_sg(struct iov_iter *iter,
  * @extraction_flags can have ITER_ALLOW_P2PDMA set to request peer-to-peer DMA
  * be allowed on the pages extracted.
  *
- * If successul, @sgtable->nents is updated to include the number of elements
+ * If successful, @sgtable->nents is updated to include the number of elements
  * added and the number of bytes added is returned.  @sgtable->orig_nents is
  * left unaltered.
  *

