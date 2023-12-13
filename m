Return-Path: <linux-fsdevel+bounces-5879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ACC81138A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C6C1F21FBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7381A2E852;
	Wed, 13 Dec 2023 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjGIz7Ua"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015641707
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldTnN6NaoKpn3Pzj4ymAXo4AbMSJji+PzTFvbDmK2dY=;
	b=JjGIz7UanfJ2Q7tjvxUY8tBsuasj2VYmD6w5c3DJm/L4UTpgYW31xCsv7ToM/tYb1H+OQ6
	G3rJDz+ZAp1t8xXbD+K2+s16a6COFGgzAgFSkTD4F8JGC5xlKvL7ymRGJS6s2qjOAl/u8y
	eJ9vUGZ/V1okOzMhwSWPKzWsIawf3Zg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-YEpkbhlmOCyZaM5FVkfGtA-1; Wed,
 13 Dec 2023 08:50:44 -0500
X-MC-Unique: YEpkbhlmOCyZaM5FVkfGtA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EDBD29AC03C;
	Wed, 13 Dec 2023 13:50:43 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C56791C060B1;
	Wed, 13 Dec 2023 13:50:42 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/40] afs: Remove the unimplemented afs_cmp_addr_list()
Date: Wed, 13 Dec 2023 13:49:45 +0000
Message-ID: <20231213135003.367397-24-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Remove afs_cmp_addr_list() as it was never implemented.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/addr_list.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 18c286efa3a5..6d42f85c6be5 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -244,19 +244,6 @@ struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *net,
 	return ERR_PTR(ret);
 }
 
-/*
- * Compare old and new address lists to see if there's been any change.
- * - How to do this in better than O(Nlog(N)) time?
- *   - We don't really want to sort the address list, but would rather take the
- *     list as we got it so as not to undo record rotation by the DNS server.
- */
-#if 0
-static int afs_cmp_addr_list(const struct afs_addr_list *a1,
-			     const struct afs_addr_list *a2)
-{
-}
-#endif
-
 /*
  * Perform a DNS query for VL servers and build a up an address list.
  */


