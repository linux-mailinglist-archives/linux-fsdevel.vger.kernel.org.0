Return-Path: <linux-fsdevel+bounces-58099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1009BB2947F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 19:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948961B21B43
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 17:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93031C3BEB;
	Sun, 17 Aug 2025 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="W/bT/o6m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC92D27453;
	Sun, 17 Aug 2025 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755451008; cv=pass; b=AoFyNa0eMnrdWrdRPCR0H2+vArPScr5c+agFClOHhjjIkAKmHrTLGLzy37p3Jy85wbPtGEEfYpHjzcSbPyMABLC2DVkV6O/H/GOVPsll93Sw1vNuflISOqWrM9aM2fn8g138sRhh+S/A8NgICkeiVKUvnYYlXvllWr3rZKzxwS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755451008; c=relaxed/simple;
	bh=GHW56IwTnR8DZ68dY4DgH2pgKw3Sr/CtY7s7JFfq0wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fe37Hplev8n+OUPA+3D0O5/8FAxWx+zS1kiIWMwyfoi6Ll/dgsDrQOgywjpDHPZ/CCY7IGOqpIZUu4+HsBWlpG7CnAornYs74HTk0LcRqE52DTh5I5dNLECeduOgDyFJrGoGvUktwsbArBFqYZkk8Q94Y80F2Pl7DYZ0JFzv2h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=W/bT/o6m; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1755450939; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CLc8R/HHso/R1FK80Xw7vlHDwUnsoxdSe1ZPR8IyCu540OvkBM/1bHaFLUUW4QHfioFeKa/WHseTohs8Z4wkOut9VCZ1h15+DGIapQQCNUONbAiSMML4Q2T/7ziH8oEAXMBgQEFmPbt8YchVY4CfJY4ZhxKu8vBbkZ/BhirQpos=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755450939; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kqyVLSz7wv9smblV3N8ULdBRdoyfZit5Dl6ZKefYxHA=; 
	b=lYer+aX7WRjI3Wxpqyt+HTmTNjS7uMdbi9GOWYaBO1PX9eyhlbxDQHqNaOhPJIywl6j7EkhOZrISfe7fieVGUhEpzvUMaDeOzeYjmo38jtBVF7Co8mWVxgeei6znCKlBgOeY+/1TiiXS0XdUSVE4ccz5mMTEIBP2c7nFYuUqO4E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755450939;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=kqyVLSz7wv9smblV3N8ULdBRdoyfZit5Dl6ZKefYxHA=;
	b=W/bT/o6mFNjjxjshHYa1c9F065xZnzGRwUvtrygJC96lZb0ML1Hyy8vT6bBFiURE
	+amCoTCoXu6hxeX1Ms57H4X7YSqrGlx69+NDsiAXl0zzxvdVWhnEXP3pLU18Y4gG4Uk
	FCHeU2vyn7/sNC039wARPCK+gcgn88kueBD1LI0A=
Received: by mx.zohomail.com with SMTPS id 175545093682565.71689882490375;
	Sun, 17 Aug 2025 10:15:36 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	cyphar@cyphar.com,
	Ian Kent <raven@themaw.net>
Cc: linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	autofs mailing list <autofs@vger.kernel.org>,
	patches@lists.linux.dev
Subject: [PATCH 2/4] vfs: fs/namei.c: remove LOOKUP_NO_XDEV check from handle_mounts
Date: Sun, 17 Aug 2025 17:15:11 +0000
Message-ID: <20250817171513.259291-3-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250817171513.259291-1-safinaskar@zohomail.com>
References: <20250817171513.259291-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227f1f3cd4c79404d030ed3e4040000480f4c1ac4acebc3fbd4d521bbfa62260be44b27354ee04fcd:zu080112275ded32bee42613b2b95b55d900002a2b5f3008994074d61ab2f90c23bebd4943538544b01fab54:rf0801122c062571df28666cd38943d2d400005b6056c1064d1f67c9d54a37f3ac0cb78d57a34c2e62df339616a6173d52:ZohoMail
X-ZohoMailClient: External

This is preparation to RESOLVE_NO_XDEV fix in following commits.
No functional change intended

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


