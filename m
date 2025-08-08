Return-Path: <linux-fsdevel+bounces-57142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BC0B1EF9D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 22:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FC9C7B3543
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 20:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A27525392D;
	Fri,  8 Aug 2025 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="hG9Kz/5y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774D5241695;
	Fri,  8 Aug 2025 20:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754685620; cv=none; b=t6ux0tx7B2WB4N6OuwwCxFEhOt7dDArNwRnNzAEYwy0xhCOn2rJ5RefX4kMc5PkIMbvNlyAZRpKC+Kj6ujrSKS+oIE5hZN32Mm+LKquNjVZNNqhDHciPszJ06EL0Y+TxhZ1qm4z99yu3t8DETCEb/N2WGfVT4M/w4ul9y7i0bSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754685620; c=relaxed/simple;
	bh=bTGFD2/2bcT9alY7qwJn5EsSznhn0m8yNz6wwuY7Wt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pZkrPT8tdvkt9HjuQg+rAALEcvPydbRxYv/OzZ/TOB8XTfrEc5GalZAUbMMuKdv/7pBBIJFK7rtiA8MiDeAUoMVFZCrzrv0JrC5NkM66Kj6iMZVRHzdMcNOHjZJZWLZb7+quNyjWxdWIoaZw0ZI9b+H5Rbn31OCpTFhNRpuKTkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=hG9Kz/5y; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bzGB66Sppz9sWF;
	Fri,  8 Aug 2025 22:40:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754685614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqFHaT9eot7e8JTZuFttQxIxVA/lkTUjjI9C+5YSP+k=;
	b=hG9Kz/5ygwPKYDnVKf+jdnrbsGhcgaywYwRqx2PXl6XrSYnJMJuH8E6qHeOdtEeczqDNJN
	4CfmBFMSQdhmHgdHCn69Bx68YMPb3KsckodqL4WgBRHif6YYwCoRJxp7oS4qqjzTWeu1MA
	gQrYkmv7o2O8deUzmrpdHoaArRSjXgXrqM+OUTEpv9tjxcU7ADR0sfRIHa7tslBoOYkxPz
	dbEOA4ey/HfGigOIdUCs8vIfLit7EmOsgfP4QhQ13VQObuTtNapWs5xQkG4WMQ3mtR+zqE
	+A/QuIlFKXuJ/kQL6lGER17NTxnnUyw3S9Jy/K/TbBCCSniUgR9in7WBrzXejA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Sat, 09 Aug 2025 06:39:46 +1000
Subject: [PATCH v3 02/12] man/man2/mount_setattr.2: fix stray quote in
 SYNOPSIS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-new-mount-api-v3-2-f61405c80f34@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
In-Reply-To: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=798; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=bTGFD2/2bcT9alY7qwJn5EsSznhn0m8yNz6wwuY7Wt0=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMS5i2QizWLzXVQSOs/lRsoG4ou/C3B1qnOw0yJ81ON
 5x1R6Kgo5SFQYyLQVZMkWWbn2fopvmLryR/WskGM4eVCWQIAxenAEzEQpeRYelz0Z6F235WcOic
 3v89y0bzSXfqR/03ZXNF1ryw7XYt72b4yfhr6bZz8YFLOZ74F994I3FE9v/7AkHlA43H3DZVGlb
 fYAcA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4bzGB66Sppz9sWF

Fixes: eb0f8239bc35 ("man/man2/mount_setattr.2: Document glibc >= 2.36 syscall wrappers")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/mount_setattr.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
index c96f0657f0468fc4d2bc0132e08d1328570073b1..e1a975dcc8e2b263f68d18dc0492e8ecc518459e 100644
--- a/man/man2/mount_setattr.2
+++ b/man/man2/mount_setattr.2
@@ -14,7 +14,7 @@ .SH SYNOPSIS
 .B #include <sys/mount.h>
 .P
 .BI "int mount_setattr(int " dirfd ", const char *" path ", unsigned int " flags ","
-.BI "                  struct mount_attr *" attr ", size_t " size );"
+.BI "                  struct mount_attr *" attr ", size_t " size ");"
 .fi
 .SH DESCRIPTION
 The

-- 
2.50.1


