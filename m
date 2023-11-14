Return-Path: <linux-fsdevel+bounces-2821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CE27EB163
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 14:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4581F24C64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 13:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE291405DC;
	Tue, 14 Nov 2023 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgLN95MK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBEC405C2
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 13:58:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4C5172A
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 05:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699970278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8xKpw0yCHL7thUwOPPjVX7/DHEx8QBr3fVJ8bfvExuQ=;
	b=hgLN95MKj9Grapzs3jpXTSxkti3CjaXx/14Ualk8i2WxNiKa44buu2U/2yGoIHs9q3091s
	nmKJyUMkDM7+AldvJjoKrywkIGaRepEn41iZdMWIhHV/UwZsyd9dCqOofSj0N32TtxFz9d
	aRhbjxAwC3bRqIJ3FUZ3Wr0I7ENous8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-u6TIBVp4OYSULRwvgqGc8g-1; Tue, 14 Nov 2023 08:57:54 -0500
X-MC-Unique: u6TIBVp4OYSULRwvgqGc8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7140981B563;
	Tue, 14 Nov 2023 13:57:54 +0000 (UTC)
Received: from vishnu.users.ipa.redhat.com (unknown [10.22.8.180])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 33D661121306;
	Tue, 14 Nov 2023 13:57:54 +0000 (UTC)
From: Bob Peterson <rpeterso@redhat.com>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] Remove myself as maintainer of GFS2
Date: Tue, 14 Nov 2023 07:57:53 -0600
Message-ID: <20231114135753.583088-1-rpeterso@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

I am retiring from Red Hat and will no longer be a maintainer of the
gfs2 file system.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf0f54c24f81..a45cdab67496 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8779,7 +8779,6 @@ S:	Maintained
 F:	scripts/get_maintainer.pl
 
 GFS2 FILE SYSTEM
-M:	Bob Peterson <rpeterso@redhat.com>
 M:	Andreas Gruenbacher <agruenba@redhat.com>
 L:	gfs2@lists.linux.dev
 S:	Supported
-- 
2.41.0


