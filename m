Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F31A42212C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 10:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhJEIvp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 04:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233477AbhJEIvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633423792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TosRxRN3WQ/up4K+sevrujbcFo3VdyvSQBYM4g+OCZ8=;
        b=ZhwHVMD5QoI8jSFXmCAECg60xtmZI3H+62iz3PnPWXMm4t6ZFojC8xeNpHfmHfYkBjgF1Z
        sFvrQVKrkr0Za1Cy/pbnvDj+IbjXcxOqI1x4dInYt88lzN8jT2zW80XqUSGyF8n3ZTML/M
        TcnlBIAw1J3Vvbo2Su+2e7ltMYV3tCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-y7FN56EqNL6ai9kMOm7Viw-1; Tue, 05 Oct 2021 04:49:51 -0400
X-MC-Unique: y7FN56EqNL6ai9kMOm7Viw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DBCF1006AA2;
        Tue,  5 Oct 2021 08:49:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E7D560843;
        Tue,  5 Oct 2021 08:49:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 1/5] nfs: Fix kerneldoc warning shown up by W=1
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
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
Date:   Tue, 05 Oct 2021 09:49:41 +0100
Message-ID: <163342378161.876192.6553771342861206270.stgit@warthog.procyon.org.uk>
In-Reply-To: <163342376338.876192.10313278824682848704.stgit@warthog.procyon.org.uk>
References: <163342376338.876192.10313278824682848704.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix a kerneldoc warning in nfs due to documentation for a parameter that
isn't present.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Anna Schumaker <anna.schumaker@netapp.com>
cc: Mauro Carvalho Chehab <mchehab@kernel.org>
cc: linux-nfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-doc@vger.kernel.org
Link: https://lore.kernel.org/r/163214005516.2945267.7000234432243167892.stgit@warthog.procyon.org.uk/ # rfc v1
Link: https://lore.kernel.org/r/163281899704.2790286.9177774252843775348.stgit@warthog.procyon.org.uk/ # rfc v2
---

 fs/nfs_common/grace.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfs_common/grace.c b/fs/nfs_common/grace.c
index edec45831585..0a9b72685f98 100644
--- a/fs/nfs_common/grace.c
+++ b/fs/nfs_common/grace.c
@@ -42,7 +42,6 @@ EXPORT_SYMBOL_GPL(locks_start_grace);
 
 /**
  * locks_end_grace
- * @net: net namespace that this lock manager belongs to
  * @lm: who this grace period is for
  *
  * Call this function to state that the given lock manager is ready to


