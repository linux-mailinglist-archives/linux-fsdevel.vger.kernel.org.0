Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D986749E6E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 17:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243380AbiA0QCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 11:02:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47801 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243387AbiA0QCm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643299361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=grgUgfVgMs24xTDdp7Xwmf4GZ7AO1AtKBw4OccoD5vE=;
        b=c9q88Gqjjle8rBnNaSAwyr4/0pHYPVc2JrzZsuQ9RorF1LOAwUIiJ17xu6cyyDBIB+7kfV
        +p8bXzMmsiUP6dowLl4aagx8H2/wkBm/vYz/DgsH6I3M4+qfSWnrxLqw4orH4gPJnoTzfV
        tvvHyp9gkbYz1TFO0pZc/8HQeRoyzhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-HRdacyVINwuZeJox0qoJfA-1; Thu, 27 Jan 2022 11:02:38 -0500
X-MC-Unique: HRdacyVINwuZeJox0qoJfA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02F8C86A8A3;
        Thu, 27 Jan 2022 16:02:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EBCDB22DEB;
        Thu, 27 Jan 2022 16:02:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/4] Fix a warning about a malformed kernel doc comment in
 cifs by removing the
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cifs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 27 Jan 2022 16:02:34 +0000
Message-ID: <164329935406.843658.13491453034739838581.stgit@warthog.procyon.org.uk>
In-Reply-To: <164329930161.843658.7387773437540491743.stgit@warthog.procyon.org.uk>
References: <164329930161.843658.7387773437540491743.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

marker.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cifs/connect.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 11a22a30ee14..ed210d774a21 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -162,7 +162,7 @@ static void cifs_resolve_server(struct work_struct *work)
 	mutex_unlock(&server->srv_mutex);
 }
 
-/**
+/*
  * Mark all sessions and tcons for reconnect.
  *
  * @server needs to be previously set to CifsNeedReconnect.


