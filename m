Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C45479EF84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 18:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjIMQ57 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 12:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjIMQ5x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 070951BC8
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 09:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694624224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=437kiFAHLHJfEBaWwZrq8WSevs6s9dyVAFCFY8Y8ee4=;
        b=gzn7V6S36ymR1iZf3Te5S+LSSMUpWaUveXgpFbcAXXFf54UJju/FHF7+uHpD6L42QFNRAb
        ACIwaevHigmgN8jeGyE+CzQg+G+p7Cp6moOO//ta/eo+kszmd1hk93eOwByr+Rz+XzRTIu
        HslCdBOebxPDXNCCCAdJg9v4Hx+MfVI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-ofpFxPGzPwO-sSg4BhMp7A-1; Wed, 13 Sep 2023 12:56:59 -0400
X-MC-Unique: ofpFxPGzPwO-sSg4BhMp7A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F9CA8032FE;
        Wed, 13 Sep 2023 16:56:58 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7EE42026D4B;
        Wed, 13 Sep 2023 16:56:56 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/13] iov_iter: Renumber ITER_* constants
Date:   Wed, 13 Sep 2023 17:56:37 +0100
Message-ID: <20230913165648.2570623-3-dhowells@redhat.com>
In-Reply-To: <20230913165648.2570623-1-dhowells@redhat.com>
References: <20230913165648.2570623-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Renumber the ITER_* iterator-type constants to put things in the same order
as in the iteration functions and to group user-backed iterators at the
bottom.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <christian@brauner.io>
cc: Matthew Wilcox <willy@infradead.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: David Laight <David.Laight@ACULAB.COM>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 include/linux/uio.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 42bce38a8e87..d1801c46e89e 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -21,12 +21,12 @@ struct kvec {
 
 enum iter_type {
 	/* iter types */
+	ITER_UBUF,
 	ITER_IOVEC,
-	ITER_KVEC,
 	ITER_BVEC,
+	ITER_KVEC,
 	ITER_XARRAY,
 	ITER_DISCARD,
-	ITER_UBUF,
 };
 
 #define ITER_SOURCE	1	// == WRITE

