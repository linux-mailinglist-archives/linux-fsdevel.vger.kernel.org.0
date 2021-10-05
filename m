Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29C842214A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 10:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhJEIxa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 04:53:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233574AbhJEIxX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633423893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SzIKShd8U21M23BZYRLg2njihFTOZw5S9K9ysZYMhAI=;
        b=bvVxMUIbpdi3HzGQ1QqzeS7vCJREOJysSt20DwLYm6cN7BCcjLi7ono2/ECzr7IQIqkKG/
        qOxMSpZvc52u6t94ulnOemMkQpwUABWPaDl6wFQdjYxLVfzpHDqH6+AumR+kiN+SSlYKNv
        0oP6C7rJfYjlE8Qewa7GMUrOULhDJ0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-4-VfjO1uPCCAi3wRDiEUYA-1; Tue, 05 Oct 2021 04:51:30 -0400
X-MC-Unique: 4-VfjO1uPCCAi3wRDiEUYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19F991084694;
        Tue,  5 Oct 2021 08:51:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1FB39AA36;
        Tue,  5 Oct 2021 08:51:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 5/5] fscache: Remove an unused static variable
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, dhowells@redhat.com,
        Marc Dionne <marc.dionne@auristor.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Jeff Layton <jlayton@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        torvalds@linux-foundation.org,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 05 Oct 2021 09:51:18 +0100
Message-ID: <163342387890.876192.10223297869496086216.stgit@warthog.procyon.org.uk>
In-Reply-To: <163342376338.876192.10313278824682848704.stgit@warthog.procyon.org.uk>
References: <163342376338.876192.10313278824682848704.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The fscache object CREATE_OBJECT work state isn't ever referred to, so
remove it and avoid the unused variable warning caused by W=1.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: linux-fsdevel@vger.kernel.org
cc: linux-doc@vger.kernel.org
Link: https://lore.kernel.org/r/163214005516.2945267.7000234432243167892.stgit@warthog.procyon.org.uk/ # rfc v1
Link: https://lore.kernel.org/r/163281899704.2790286.9177774252843775348.stgit@warthog.procyon.org.uk/ # rfc v2
---

 fs/fscache/object.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index 7b9e7a366226..6a675652129b 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -77,7 +77,6 @@ static WORK_STATE(INIT_OBJECT,		"INIT", fscache_initialise_object);
 static WORK_STATE(PARENT_READY,		"PRDY", fscache_parent_ready);
 static WORK_STATE(ABORT_INIT,		"ABRT", fscache_abort_initialisation);
 static WORK_STATE(LOOK_UP_OBJECT,	"LOOK", fscache_look_up_object);
-static WORK_STATE(CREATE_OBJECT,	"CRTO", fscache_look_up_object);
 static WORK_STATE(OBJECT_AVAILABLE,	"AVBL", fscache_object_available);
 static WORK_STATE(JUMPSTART_DEPS,	"JUMP", fscache_jumpstart_dependents);
 


