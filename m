Return-Path: <linux-fsdevel+bounces-7562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F47827631
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 18:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2CA1C2270D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 17:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044515466F;
	Mon,  8 Jan 2024 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U13rKMET"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EDE54661
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704734448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jXj6+vog8lkpiIHeuntshmR6yPJPv8Wa8nkp3OFZIl8=;
	b=U13rKMETcpYznQIyMwmjdsvz7X58IKQ1CvW9keNtQ3w0TqMeKS7SiRgROAI6Dl2YyHbeef
	3ysrnWW3EbPF6p28Z7BJJoY7CiG9JWWRV78++emrbBYv5VEUAD3+3OjfX7IHBGXDvLKpHT
	MqW6bnNGFphbylAGkQsUX4XtANZWwqc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-m0XviofFPey-b0ya_YH0vg-1; Mon, 08 Jan 2024 12:20:42 -0500
X-MC-Unique: m0XviofFPey-b0ya_YH0vg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD280101A555;
	Mon,  8 Jan 2024 17:20:41 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.227.7])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E97602026D66;
	Mon,  8 Jan 2024 17:20:40 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] fs: Wrong function name in comment
Date: Mon,  8 Jan 2024 18:20:40 +0100
Message-ID: <20240108172040.178173-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

This comment refers to function mark_buffer_inode_dirty(), but the
function is actually called mark_buffer_dirty_inode(), so fix the
comment.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 967f34b70aa8..6bdca819033f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -465,7 +465,7 @@ EXPORT_SYMBOL(mark_buffer_async_write);
  * a successful fsync().  For example, ext2 indirect blocks need to be
  * written back and waited upon before fsync() returns.
  *
- * The functions mark_buffer_inode_dirty(), fsync_inode_buffers(),
+ * The functions mark_buffer_dirty_inode(), fsync_inode_buffers(),
  * inode_has_buffers() and invalidate_inode_buffers() are provided for the
  * management of a list of dependent buffers at ->i_mapping->private_list.
  *
-- 
2.43.0


