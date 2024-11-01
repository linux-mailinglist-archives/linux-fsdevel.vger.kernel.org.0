Return-Path: <linux-fsdevel+bounces-33473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7B49B92A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 14:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093FA1C20EEA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 13:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B501A706F;
	Fri,  1 Nov 2024 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="guDDIzi1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UbwuWuXH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE80E1A4E70;
	Fri,  1 Nov 2024 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730469322; cv=none; b=QS8G54SserF0p/FNU2o8rHI1Xm3jiaMVbuSYsKcgWaKGxlBL3dn5RwpwR8U9OyLFq1xIim+ummjUxyk3JqVS9ApB+d13IbkkXcEhCocW6RuifXEOkAOJSJ+qmeVpBHCCswcxjnHPUxYoodiCF7X0cU4ehBKMojR5BlOgeNELR6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730469322; c=relaxed/simple;
	bh=mgPZr/2l3Vdj4PWdgnHmZvjQV6jfJRSwzIH8IQQ/Fzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPKqtYOZlb9kOptit67ddotmEKtkHQ6oMEra7HyiOzdGWsfF9Dn4wLU8pOt+OcvQ4+2P/HPoGUFC3B0K3cg8RcjvHLH6MmV5ILp9WocauQkCc9PmpMuJkRxDduI9wW/h5azs2BU2uWZJVrMOwXgEtUsZZOi0RlJXG4fqVmGj8EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=guDDIzi1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UbwuWuXH; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id E09FC1140115;
	Fri,  1 Nov 2024 09:55:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 01 Nov 2024 09:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1730469317; x=
	1730555717; bh=BlFQzpSaBBPnijLCt7o+tl9i1lAU4R5ZjW5of+lcDtU=; b=g
	uDDIzi1BzeL9Y+TnlBGQJ87tEz3wKfHUufV0HOL3RPMh776Jt/fD0iO3Q8SbMUVe
	PR4keUGR1C+26lHcMP76xhP4Z0zjxf1fCBK3PIC4C1tboswJh63i+Bqp/R/Mw+z1
	38XerA6a1yVx2RTXxvv3U6K8NGnYACVALSq51GBzrMUIKrhn1w8zJ5gAGr9k5MgC
	uxwlYMxc+5O3lswstc00PWBqB9aKb8zm0IKJ1Dltj86dZUhgl76XoIR7OUrvmCRj
	LCX17LVUceRmX1ZDRyS8B6UZc6Id2yAbNXsPdXN1E7ZOtavNJfSrelVOu/ATc8Ej
	qdT4FP5AIXu64XtSyzsMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730469317; x=1730555717; bh=B
	lFQzpSaBBPnijLCt7o+tl9i1lAU4R5ZjW5of+lcDtU=; b=UbwuWuXHS5Ja1ZR72
	UIGH/Jt2/n9fQqG60gcXcu+N0QSdwwMUBddmgN9Iu/W+QP4hKiHuvKBwCnBo5OwM
	f3NJba+Gm1yd8gkrhVWSqGZ2nPVjvbrPDO6n9XwjNictjEJc6uTQL4RZspHhYjgZ
	lCD9HjS3JX7cPN6W/Z9t2N14x3PTIJGY7cws396clThP3QgsLFoecLe+dehxrOSS
	ytYmc4Lq0LWOx0ta87RW2HvMUjHqpQvV67U26M4nWlfsc8HroCjOTpN1cTXtJOpT
	2FgJ7rwosxfVxayrENgYT5yHJGKkI9jeoCQOWbRYt4aYwYRid3aETjsss4XqW3wT
	bpTLA==
X-ME-Sender: <xms:xd0kZ9VXUk2mqZJykxgD-RiGH3H8jmBUXEWfveQtP9R9dK1Yf6vUCA>
    <xme:xd0kZ9nfSt2Ab8IInPTSdTArLL7dhxZcnrgbiIOBhaJAfpa-leAk2lnlkN_wewzYZ
    dtchIOgiulY9kgJyf4>
X-ME-Received: <xmr:xd0kZ5adav8VANR4mLj3ObY_LFWCROU1zqIKGbOvm9Ku-bzlw6QqB4WIlZxKxoocMRtWYbX8EhHgSUNKW8JKcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekledgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefgrhhinhcuufhhvghphhgvrhgu
    uceovghrihhnrdhshhgvphhhvghrugesvgegfedrvghuqeenucggtffrrghtthgvrhhnpe
    eggedvkedtuedvgfevvdehieevveejkeelieektdfggeevgfeiieejtdffledtieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegvrhhinhdrsh
    hhvghphhgvrhgusegvgeefrdgvuhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnsegsrhgruhhnvghrrdhioh
    dprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtohep
    sghluhgtrgesuggvsghirghnrdhorhhgpdhrtghpthhtohepvghrihhnrdhshhgvphhhvg
    hrugesvgegfedrvghu
X-ME-Proxy: <xmx:xd0kZwVJJSkjjLzphZAfP3Nj6HeHmgA9QMuU82e-inaWDHUKtGBW-w>
    <xmx:xd0kZ3lZWuemPxKOdkEjUaG-KHzOauPyvGia9jMwsRa2gmS5vGVuAQ>
    <xmx:xd0kZ9dqTZhAcUnpu15tJuVn_2mptpUcM3lkjYkTkQgJ8NMEVnV6Kg>
    <xmx:xd0kZxE5xckm5KVBOEobFfRgiOQuNH_HD_4A90gmD3uZraYGsLlOyw>
    <xmx:xd0kZ1ZciZ6O0G7-k9E59zslCBetm9eeWXv0ATPx2Tem4klBLltyJFyO>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 09:55:17 -0400 (EDT)
From: Erin Shepherd <erin.shepherd@e43.eu>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: christian@brauner.io,
	paul@paul-moore.com,
	bluca@debian.org,
	erin.shepherd@e43.eu
Subject: [PATCH 1/4] pseudofs: add support for export_ops
Date: Fri,  1 Nov 2024 13:54:49 +0000
Message-ID: <20241101135452.19359-2-erin.shepherd@e43.eu>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241101135452.19359-1-erin.shepherd@e43.eu>
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pseudo-filesystems might reasonably wish to implement the export ops
(particularly for name_to_handle_at/open_by_handle_at); plumb this
through pseudo_fs_context

Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
---
 fs/libfs.c                | 1 +
 include/linux/pseudo_fs.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 46966fd8bcf9..698a2ddfd0cb 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -669,6 +669,7 @@ static int pseudo_fs_fill_super(struct super_block *s, struct fs_context *fc)
 	s->s_blocksize_bits = PAGE_SHIFT;
 	s->s_magic = ctx->magic;
 	s->s_op = ctx->ops ?: &simple_super_operations;
+	s->s_export_op = ctx->eops;
 	s->s_xattr = ctx->xattr;
 	s->s_time_gran = 1;
 	root = new_inode(s);
diff --git a/include/linux/pseudo_fs.h b/include/linux/pseudo_fs.h
index 730f77381d55..2503f7625d65 100644
--- a/include/linux/pseudo_fs.h
+++ b/include/linux/pseudo_fs.h
@@ -5,6 +5,7 @@
 
 struct pseudo_fs_context {
 	const struct super_operations *ops;
+	const struct export_operations *eops;
 	const struct xattr_handler * const *xattr;
 	const struct dentry_operations *dops;
 	unsigned long magic;
-- 
2.46.1


