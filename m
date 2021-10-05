Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2AB422146
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 10:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhJEIxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 04:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21584 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233325AbhJEIxJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633423878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aS5R4ZQ0gp+0Ysi3i/mjuS/AbU0dkZMW30EtcC6cCAk=;
        b=U30be6omKMWmG1FiWgNIa9hne3Wt5E0lg7lf37+0wNhTEW6xsukspnV0C3pvA211BZI+uz
        eJB7YNYJM7QIhbQWFVK0k/eqn1WHcSw1t+YZNBPXs9pwIX62J/IBrGFvHDEuv/lrplDXhy
        otYrpxTYH7FwUfAT3jj8mVnDZaGlSkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-6CB-PjIINViFNtvEUn2b8Q-1; Tue, 05 Oct 2021 04:51:15 -0400
X-MC-Unique: 6CB-PjIINViFNtvEUn2b8Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A63DA19057A0;
        Tue,  5 Oct 2021 08:51:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C6EF60BF4;
        Tue,  5 Oct 2021 08:50:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 4/5] fscache: Fix some kerneldoc warnings shown up by W=1
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Jeff Layton <jlayton@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        torvalds@linux-foundation.org,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 05 Oct 2021 09:50:54 +0100
Message-ID: <163342385474.876192.4489461265011092810.stgit@warthog.procyon.org.uk>
In-Reply-To: <163342376338.876192.10313278824682848704.stgit@warthog.procyon.org.uk>
References: <163342376338.876192.10313278824682848704.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix some kerneldoc warnings in the fscache driver that are shown up by W=1.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: Mauro Carvalho Chehab <mchehab@kernel.org>
cc: linux-fsdevel@vger.kernel.org
cc: linux-doc@vger.kernel.org
Link: https://lore.kernel.org/r/163214005516.2945267.7000234432243167892.stgit@warthog.procyon.org.uk/ # rfc v1
Link: https://lore.kernel.org/r/163281899704.2790286.9177774252843775348.stgit@warthog.procyon.org.uk/ # rfc v2
---

 fs/fscache/object.c    |    1 +
 fs/fscache/operation.c |    3 +++
 2 files changed, 4 insertions(+)

diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index f346a78f4bd6..7b9e7a366226 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -907,6 +907,7 @@ static void fscache_dequeue_object(struct fscache_object *object)
  * @object: The object to ask about
  * @data: The auxiliary data for the object
  * @datalen: The size of the auxiliary data
+ * @object_size: The size of the object according to the server.
  *
  * This function consults the netfs about the coherency state of an object.
  * The caller must be holding a ref on cookie->n_active (held by
diff --git a/fs/fscache/operation.c b/fs/fscache/operation.c
index 433877107700..e002cdfaf3cc 100644
--- a/fs/fscache/operation.c
+++ b/fs/fscache/operation.c
@@ -22,7 +22,10 @@ static void fscache_operation_dummy_cancel(struct fscache_operation *op)
 
 /**
  * fscache_operation_init - Do basic initialisation of an operation
+ * @cookie: The cookie to operate on
  * @op: The operation to initialise
+ * @processor: The function to perform the operation
+ * @cancel: A function to handle operation cancellation
  * @release: The release function to assign
  *
  * Do basic initialisation of an operation.  The caller must still set flags,


