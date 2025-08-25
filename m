Return-Path: <linux-fsdevel+bounces-59121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0ECB349E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 20:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6485E11F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC417309DAA;
	Mon, 25 Aug 2025 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="dIKRMvqt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96019D081;
	Mon, 25 Aug 2025 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145664; cv=pass; b=D4XbPWCLI2laoetGMiYP2rXL7Tb4bmGLdraQFDKI7T6RJu5OPGWhAtMqZYrtP/qwJYthoWCNrVd9I9Lw2eszSKjJpa8MY69LL/lvTJKga22Nz48eA4YbZs5BAAQMWq5KXm2BguYcKUk6TSHXLyZ36w2XKcabnJO27328tHE6f3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145664; c=relaxed/simple;
	bh=ZcJq0FeeOQAfydDCUktql9wKTEsRvM9ks5Dvz8TNN9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAg8eF9Y6fn+MDU9JpBpjisqt5RII1wo3VwuZ8Gn/9ObNMdtDNVrz8IM5DAqxyr3s18e+V+0wLBXJ7K7OT4WkLl+DZUmn02RczP53CNE/7pspkA0/KeGC2XF6xw/0a8pJYfjyn13WjdGl2kMJyV52XKAIwSuU/41P28+xwcbe9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=dIKRMvqt; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756145576; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FuBExLLEpX5qXYvXesT4TGkU+YdffRqBE9tpiiblEyN33qE5aJim/YE0s6vkfeJtPU3KcTDB/m5QEH1LegPQJdL2bJcf6cXZRr1PTluRKC6Zbj/6N81ErLXoa7XEkbSgnJumY4jhDeFi3TXTZr+D2s1R1nehynL+6x0uvX/4tGI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756145576; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1A3+dNxIL3hI8sWOc6X4o79fhQ9EvzXN0iHkMlRtKtA=; 
	b=YH3Ro4QPfbc8Tn9CZq4HL3Y3SM+CbFNSi9+G9+UYaeO8FoFf6cquDuvmp9HwfIvQxKzNfz0shR12o+vkopOu6sovbZKRO5EgU3FWA9dyI4oM6DvhGQcunvy3Hkx8lpPYMYt/9J5Liff43cbZQP8ozlEiSXFCDHQsqzOhpTr3RlQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756145576;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=1A3+dNxIL3hI8sWOc6X4o79fhQ9EvzXN0iHkMlRtKtA=;
	b=dIKRMvqtRtWX4bdv5j/J8g9gkcyokHPI7NeglXBsZwVRxOdXmTy7/Pzpjby4J+gh
	Zn4n5DbGtD/+9bxFkdwdr8d+MdTDngH/lrjMfQGrCaWU5YT313kXgHRu9RmennjOPZA
	xj7KVJL4dTgmQPZ1Ok3oGd+y2Qf3pSiq9azwoBAg=
Received: by mx.zohomail.com with SMTPS id 1756145572994163.84681759608372;
	Mon, 25 Aug 2025 11:12:52 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	cyphar@cyphar.com,
	Ian Kent <raven@themaw.net>,
	autofs mailing list <autofs@vger.kernel.org>,
	patches@lists.linux.dev
Subject: [PATCH v2 2/4] namei: remove LOOKUP_NO_XDEV check from handle_mounts
Date: Mon, 25 Aug 2025 18:12:31 +0000
Message-ID: <20250825181233.2464822-3-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825181233.2464822-1-safinaskar@zohomail.com>
References: <20250825181233.2464822-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112272a819ce91e2a3aa401a6d3ef0000695560bf454820a6ba2f9ae8c214d3e742f73e2f8883c77150:zu08011227d68e21e551d4349b50bdf2900000775f7c363530d6df9a481d42e4efa682d06b9d3088be8aed17:rf0801122c08f102251cdc3cab0408e1100000d1406714883d284e3a2079ed4a8ff39f309def2e4ab9101ecc9587e65cee:ZohoMail
X-ZohoMailClient: External

This is preparation to RESOLVE_NO_XDEV fix in following commits.
No functional change intended.

The only place that ever looks at
ND_JUMPED in nd->state is complete_walk()
and we are not going to reach
it if handle_mounts() returns an error

Signed-off-by: Askar Safin <safinaskar@zohomail.com>
---
 fs/namei.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1e13d8e119a4..00f79559e135 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1635,10 +1635,8 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 			return -ECHILD;
 	}
 	ret = traverse_mounts(path, &jumped, &nd->total_link_count, nd->flags);
-	if (jumped) {
-		if (!unlikely(nd->flags & LOOKUP_NO_XDEV))
-			nd->state |= ND_JUMPED;
-	}
+	if (jumped)
+		nd->state |= ND_JUMPED;
 	if (unlikely(ret)) {
 		dput(path->dentry);
 		if (path->mnt != nd->path.mnt)
-- 
2.47.2


