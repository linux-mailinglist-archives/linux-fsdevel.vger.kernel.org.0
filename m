Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1916421410E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 23:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgGCVnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 17:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgGCVnp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:43:45 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFC6C061794;
        Fri,  3 Jul 2020 14:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hofn6sBAbTd2HcWy0kbqF2KoGz2MeYQfT0WYKeLl/94=; b=vRPA0RBJSRNx+4xaR47L24tptq
        BHkA0Mtx/7VoSGsa2aKDwsNNkntcBodFVXfxh5dJJvRlQE+jRFL2ORa3+bIcmDh+E6uwyxVOWm3y9
        ooWTTRczp4CV8td/BUYUXa7mM42iTMzMqy+kEVaquBG6AvDKZ+Ue7rZwJX4WwXnqUVjlT432L2rpX
        iK51avkugZjnvNH3Kb8HguBYcJxI89tP93mCk8UxTYHgQpTqYNk4DAX53SrAAHU/314cKFrPT4R8V
        /KZxnYzBfEJn6cHi1djB5wJgCvUfiLjVOrsjspLfw3SEKPc335KgqwST6NuRlCNwuarPkZ6TEuAmf
        m1L97n4A==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTTD-0006uZ-1T; Fri, 03 Jul 2020 21:43:43 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Ian Kent <raven@themaw.net>, autofs@vger.kernel.org,
        David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, linux-fscrypt@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH 02/10] Documentation: filesystems: caching/operations: drop doubled word
Date:   Fri,  3 Jul 2020 14:43:17 -0700
Message-Id: <20200703214325.31036-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703214325.31036-1-rdunlap@infradead.org>
References: <20200703214325.31036-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Drop the doubled word "be".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: linux-cachefs@redhat.com
---
 Documentation/filesystems/caching/operations.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/filesystems/caching/operations.rst
+++ linux-next-20200701/Documentation/filesystems/caching/operations.rst
@@ -27,7 +27,7 @@ data storage and retrieval routines.  It
 fscache_operation structs, though these are usually embedded into some other
 structure.
 
-This facility is available to and expected to be be used by the cache backends,
+This facility is available to and expected to be used by the cache backends,
 and FS-Cache will create operations and pass them off to the appropriate cache
 backend for completion.
 
