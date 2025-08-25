Return-Path: <linux-fsdevel+bounces-59122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159F5B34A05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 20:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7CB169520
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9903128AF;
	Mon, 25 Aug 2025 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="OTYvM1Cc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A6230E0F5;
	Mon, 25 Aug 2025 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145696; cv=pass; b=uroeRQNEwqsVgGbGQux7jZ/wV0JgfLlyErVzFnPoIDdnlX+2GO6wnye2il9EnqjJMbon+EMRqTDBDGLAlALSb+aooQHzQ+XXrLmzl/mEAsMFR4CP84i8ajg9232wem/cfcuFlaqpG9bWFVYNAYDD07CSZRxX+pYd5BkUjLm7o+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145696; c=relaxed/simple;
	bh=QPITvLz9gUGW/oniaS21rexE/DY31/TovEoMqCZm7a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhFrYVYb1xwCvW6S2dPWLw+kvpFY1IZPr5j2myqOD7U2zitTABGHaPqqCv8zHij3wMiJ1ucoOHyxjihZJ4FFWn38n6xNlmNlKwByLPz6iPXKO1rFBz7hRXk9kULp0rPHadGvF+FVWlCIS7286wMzcl0VOMSatBxNbC52lStiVR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=OTYvM1Cc; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756145580; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=na21YKGbGcURGmKEdxEMxHmlnnvAMLVFp1pTvKqRDR5dOY252PIiHauU1mIGhLpgVqKauu7Qm0Sw05yJmGWN0Avm3AmviUHitRtl45I2MWZSM7+wA/ryusDEfb3YdXUOxJskLXQHvtG42OeQMsT+ha8AQTuX6Mx8zEki7s8fcW8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756145580; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Q5L43a7SCFi9YXWsFLFnxHh2K1K9dp3nwyR5XOVg4ns=; 
	b=c2XPsI62/uZyuTStltugQvZPmKoCPqF0qHdwjgdu3xZjx3NKf7q+D6xpWal1eSleCWzKp7SGMfU6GJVILRZd7I5PinA7XS8oevnLhK9UBYAiL07pEujGSCZMGs2dfdpkuFqmXo2cWCSKRCaFQvzIy5VuQsWjLct9OCHnAXYhhak=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756145580;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Q5L43a7SCFi9YXWsFLFnxHh2K1K9dp3nwyR5XOVg4ns=;
	b=OTYvM1Cc9CJfQGHAIk8gfaKFAAaW+v60IwFRm81t2/ew5v5JUHesC+UXSkHH6p0f
	B9ZUvnNyOPhh7VhKzWZV8uJ53rD+1JrlBvSHQHtWWRXu3vtlEhIhYlLfAh0B/F6TF9w
	DWwB/+x86tvVSDia1c+AO813jU8k7xjxe/2pLlAE=
Received: by mx.zohomail.com with SMTPS id 1756145576474761.7926770765196;
	Mon, 25 Aug 2025 11:12:56 -0700 (PDT)
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
Subject: [PATCH v2 3/4] namei: move cross-device check to __traverse_mounts
Date: Mon, 25 Aug 2025 18:12:32 +0000
Message-ID: <20250825181233.2464822-4-safinaskar@zohomail.com>
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
Feedback-ID: rr08011227b2de6db93194bab2478fd9930000534eca4a5a4f0dc30a08a4380fb9613e5742075f90f86f0b3e:zu08011227bcfcdf305a58f7bc29a35f860000c0125f02e22c033761fb6aff176da4d7b1e63848d3b5297e47:rf0801122c0ba6cbdafa1f2307e428f163000052d43bd6342b396d7f912e435de8d0a9c7dd60337e3d258c1cb4d1264f31:ZohoMail
X-ZohoMailClient: External

This is preparation to RESOLVE_NO_XDEV fix in following commits.
Also this commit makes LOOKUP_NO_XDEV logic more clear: now we
immediately fail with EXDEV on first mount crossing
instead of waiting for very end.

No functional change intended

Signed-off-by: Askar Safin <safinaskar@zohomail.com>
---
 fs/namei.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 00f79559e135..c23e5a076ab3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1489,6 +1489,10 @@ static int __traverse_mounts(struct path *path, unsigned flags, bool *jumped,
 				// here we know it's positive
 				flags = path->dentry->d_flags;
 				need_mntput = true;
+				if (unlikely(lookup_flags & LOOKUP_NO_XDEV)) {
+					ret = -EXDEV;
+					break;
+				}
 				continue;
 			}
 		}
@@ -1518,7 +1522,6 @@ static inline int traverse_mounts(struct path *path, bool *jumped,
 				  int *count, unsigned lookup_flags)
 {
 	unsigned flags = smp_load_acquire(&path->dentry->d_flags);
-	int ret;
 
 	/* fastpath */
 	if (likely(!(flags & DCACHE_MANAGED_DENTRY))) {
@@ -1527,11 +1530,7 @@ static inline int traverse_mounts(struct path *path, bool *jumped,
 			return -ENOENT;
 		return 0;
 	}
-
-	ret = __traverse_mounts(path, flags, jumped, count, lookup_flags);
-	if (*jumped && unlikely(lookup_flags & LOOKUP_NO_XDEV))
-		return -EXDEV;
-	return ret;
+	return __traverse_mounts(path, flags, jumped, count, lookup_flags);
 }
 
 int follow_down_one(struct path *path)
-- 
2.47.2


