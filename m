Return-Path: <linux-fsdevel+bounces-58102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BA7B29488
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 19:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADACD3AD155
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 17:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEDD2E7BD0;
	Sun, 17 Aug 2025 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="GtH1bD3T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FDD1B0F23;
	Sun, 17 Aug 2025 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755451096; cv=pass; b=JJaRf++hNNsa9tLLmnY1wut31iUnuxYgxvgtpndmx99pPj/i/ioBRzQEKnFWgxIZObqZLxoF8g/p1NRno4Tk/mwioGO1VQgDcL0mgR/T0pGonp6x7OyjdToetX4EuE4+hjANWZfxZSZLa/dEXB/6vhQOcaMBKZfApamCjtdaDGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755451096; c=relaxed/simple;
	bh=5uaPBf07hCj63yaAFoCxEND7MCLmzvxkZW7/dK6tHJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+03gZ2leQ4ut97VToRf0OzpiCNVRlQeF4lCh8g74LpfcepWPWtfjh9UfWzToCSLvy22ctfS/0gWQvMLFh+wjqQLfGWrfEjL/u3kmcMnXiKpJW8ZXhiTsJH95WNlLPBlaeB1BQV966IPbchMN1xySWwdT9hHCgN9NovzzWQndDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=GtH1bD3T; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1755450950; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=T7WSRTv05We1bXyBh4f7UozwjOB0TpWQZFZpEWWQDQ/23ZOJvwPet7by7W4vtbq8lj7jz1ayorjA/jKs/oypTHQmTGRu1jOBm6K8RA0MKdxIgfKYiOaFAZS27P27KJND+u7APm8pNmQ/n1pqnBTvMkkq5b0s3E6JGimUCK3wr74=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755450950; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cwTeDTN8vZEoJJgRMRcOqX3jO84JMqfepC8EV4dqZg0=; 
	b=iMNFZ3lbpWZxqo5DQT9asCRYFSqKDJ1CCkhLnJkCU9rDjfdDJkgbkj2GYusVgKrBdW2aY+YmFmc8sBhEwNllHxqL+9n2mKdBQuLsAvb6lP41Qv29EzSvbG4xNvrKTPnGNAVriOJ2Bb7bvUEo7J7japNx5I14+plI1hJDQYObhVk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755450950;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=cwTeDTN8vZEoJJgRMRcOqX3jO84JMqfepC8EV4dqZg0=;
	b=GtH1bD3T6Qcv266F/tME1gBVOE+5G3l/x1EcEZtJ/f8NW5tOZ/OxfRXBhqkeXvV9
	iYWgFVLYzr+StmGfDwP+p75YUez7TxBFRC69I2B95IVps4Rz4/Io0+4hIMBGV8+V/bR
	LJSXA4tNin98ppyzOE7T58jVfsv9c/O/igqB6B8Q=
Received: by mx.zohomail.com with SMTPS id 1755450933547554.6286903848388;
	Sun, 17 Aug 2025 10:15:33 -0700 (PDT)
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
Subject: [PATCH 1/4] vfs: fs/namei.c: move cross-device check to traverse_mounts
Date: Sun, 17 Aug 2025 17:15:10 +0000
Message-ID: <20250817171513.259291-2-safinaskar@zohomail.com>
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
Feedback-ID: rr08011227b7a56901fc46519a4ec525f3000021a20bbca9313a7e4d7b968641def150b417a4b2184ffca9f5:zu0801122785d00b213c0069409631cde50000575b3be1ed3d793896fe05f0e2b8596102cb328fa9de326ba0:rf0801122c0626ead06a823052bb414ed9000062a50369da89b8f9bc40ec4015d0d67cf64536509e0bdf50c06c1ae10190:ZohoMail
X-ZohoMailClient: External

This is preparation to RESOLVE_NO_XDEV fix in following commits.
No functional change intended

Signed-off-by: Askar Safin <safinaskar@zohomail.com>
---
 fs/namei.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index cd43ff89fbaa..1e13d8e119a4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1518,6 +1518,7 @@ static inline int traverse_mounts(struct path *path, bool *jumped,
 				  int *count, unsigned lookup_flags)
 {
 	unsigned flags = smp_load_acquire(&path->dentry->d_flags);
+	int ret;
 
 	/* fastpath */
 	if (likely(!(flags & DCACHE_MANAGED_DENTRY))) {
@@ -1526,7 +1527,11 @@ static inline int traverse_mounts(struct path *path, bool *jumped,
 			return -ENOENT;
 		return 0;
 	}
-	return __traverse_mounts(path, flags, jumped, count, lookup_flags);
+
+	ret = __traverse_mounts(path, flags, jumped, count, lookup_flags);
+	if (*jumped && unlikely(lookup_flags & LOOKUP_NO_XDEV))
+		return -EXDEV;
+	return ret;
 }
 
 int follow_down_one(struct path *path)
@@ -1631,9 +1636,7 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 	}
 	ret = traverse_mounts(path, &jumped, &nd->total_link_count, nd->flags);
 	if (jumped) {
-		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
-			ret = -EXDEV;
-		else
+		if (!unlikely(nd->flags & LOOKUP_NO_XDEV))
 			nd->state |= ND_JUMPED;
 	}
 	if (unlikely(ret)) {
-- 
2.47.2


