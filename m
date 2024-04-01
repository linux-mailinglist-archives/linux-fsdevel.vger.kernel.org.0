Return-Path: <linux-fsdevel+bounces-15820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FB6893902
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 10:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B281F214AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 08:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D026DDA2;
	Mon,  1 Apr 2024 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="jx7XbCKi";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="Y6QW+iGJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C190FBF7
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Apr 2024 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711960040; cv=none; b=mLjK6jo1iR0FRne8Y9oqUtU1d9KR4oCT2PM/DmMV9LfvYAKVbS6HCKtqoItb+j+VPM1bMPGE4qe86UWHk4NF8uIBEmhx+Qb1xn2ka1bv/2XOXR/BoAnjrkc6n83soHzeA7j/1qdGlqcP54Rvmht3XwuuJyreVZGmBK23eFgVZzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711960040; c=relaxed/simple;
	bh=xGCz31NA1YJdiHL3WUeB1Ku7bq5CIg7cM44njKCPpKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoA50ZMJkMIhF2EioucGSbFivPtzQQgjGr2Or7V+Qll4kTwA7eBUDWZsgk2mofZoXzJEQSOYMA1IzDvba9A5ZE/aTPoCqon+c25sF0PoVXsTr+dUAn4ihdPHgbmFWzTQBhZcn8a9rP81O4WoA1Ff03T4mbLmDS/FKaXJOsDKKCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=jx7XbCKi; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=Y6QW+iGJ; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com BE6A0C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1711960028; bh=G67xYXybf4S1qrW02ulM0Iakj7j+SLvnUUYylGZVLyM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=jx7XbCKikc+noqkYhGZT29lpdN5J5Cuy2tJGuVQsLOf716bszuOzM3IDTE4m6gQax
	 bX/jrxlKDJ9s9OY2DjvgFL2qz1x0+m0t226CjBwgGEXnJq5C+IQqDG8wABzoQ3lwHV
	 DsFSwl2LJJZgW6X7AFPJc8N3Gvk5PlSoXAbVGyZvqhyhBE5b++U3X/mO81PqcRzep7
	 jPIJdcJRroNScYp7rGvReT6j2EivJfDj6tmI+VEcm+r7w/ABMmvU7oWN4s+KInkY3z
	 Z40wFK1VPQANC0Iy6hM7/ncM4We0k4GXO76xl8fOJHd+WgjJamrIjBoNnAq716R6yt
	 e9qrW74arLMWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1711960028; bh=G67xYXybf4S1qrW02ulM0Iakj7j+SLvnUUYylGZVLyM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Y6QW+iGJBP9Sz9SUvZFvF1QKvm/iKhuOIzWyK6bKQrPtv32DiD6D3rxrQJlbVtUC/
	 2eNSB52RWcveUn06gIiyZNN/m5golKKszflA9/SxbfftqHjdph9DQwOhdP4sLCt7GQ
	 cahTkl23Q/HKUeOlAFYDuNBMFZuFgL1TQPZSsd4vEa0I5feaAZMTot0FO3xalGLh11
	 4dckg+fhkELiuwwhoqfuvBjDzarAzIPox4upM6tScsCfgAqQAN8vx3rrOhQ+803LW2
	 7cdANLb+5dkp301TPOeg1N87cXjuJrYFfFmmpY5yhgC4I3Fd48XvMFMZFjkJwWSyWt
	 AebgXv+JCWwaw==
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux@yadro.com>, Dmitry Bogdanov
	<d.bogdanov@yadro.com>
Subject: [PATCH 2/2] configfs: make a minimal path of symlink
Date: Mon, 1 Apr 2024 11:26:55 +0300
Message-ID: <20240401082655.31613-3-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401082655.31613-1-d.bogdanov@yadro.com>
References: <20240401082655.31613-1-d.bogdanov@yadro.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)

Symlinks in configfs are used to be created from near places. Currently the
path is artificially inflated by multiple ../ to the configfs root an then
a full path of the target.

For scsi target subsystem the difference between such a path and a minimal
possible path is ~100 characters.

This patch makes a minimal relative path of symlink - from the closest
common parent.

Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 fs/configfs/symlink.c | 59 ++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index 224c9e4899d4..a61f5a4763e1 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -19,62 +19,79 @@
 /* Protects attachments of new symlinks */
 DEFINE_MUTEX(configfs_symlink_mutex);
 
-static int item_depth(struct config_item * item)
-{
-	struct config_item * p = item;
-	int depth = 0;
-	do { depth++; } while ((p = p->ci_parent) && !configfs_is_root(p));
-	return depth;
-}
-
-static int item_path_length(struct config_item * item)
+static int item_path_length(struct config_item *item, int depth)
 {
 	struct config_item * p = item;
 	int length = 1;
+
+	if (!depth)
+		return length;
+
 	do {
 		length += strlen(config_item_name(p)) + 1;
 		p = p->ci_parent;
-	} while (p && !configfs_is_root(p));
+		depth--;
+	} while (depth && p && !configfs_is_root(p));
 	return length;
 }
 
-static void fill_item_path(struct config_item * item, char * buffer, int length)
+
+static void fill_item_path(struct config_item *item, int depth, char *buffer, int length)
 {
 	struct config_item * p;
 
 	--length;
-	for (p = item; p && !configfs_is_root(p); p = p->ci_parent) {
+	for (p = item; depth && p && !configfs_is_root(p); p = p->ci_parent, depth--) {
 		int cur = strlen(config_item_name(p));
 
 		/* back up enough to print this bus id with '/' */
 		length -= cur;
 		memcpy(buffer + length, config_item_name(p), cur);
-		*(buffer + --length) = '/';
+		if (depth > 1)
+			*(buffer + --length) = '/';
 	}
 }
 
 static int configfs_get_target_path(struct config_item *item,
 		struct config_item *target, char **path)
 {
-	int depth, size;
+	struct config_item *pdest, *ptarget;
+	int target_depth = 0, item_depth = 0;
+	int size;
 	char *s;
 
-	depth = item_depth(item);
-	size = item_path_length(target) + depth * 3 - 1;
+	/* find closest common parent to make a minimal path */
+	for (ptarget = target;
+	     ptarget && !configfs_is_root(ptarget);
+	     ptarget = ptarget->ci_parent) {
+		item_depth = 0;
+		for (pdest = item;
+		     pdest && !configfs_is_root(pdest);
+		     pdest = pdest->ci_parent) {
+			if (pdest == ptarget)
+				goto out;
+
+			item_depth++;
+		}
+
+		target_depth++;
+	}
+out:
+	size = 3 * item_depth + item_path_length(target, target_depth) - 1;
 	if (size > PATH_MAX)
 		return -ENAMETOOLONG;
 
-	pr_debug("%s: depth = %d, size = %d\n", __func__, depth, size);
+	pr_debug("%s: item_depth = %d, target_depth = %d, size = %d\n",
+		 __func__, item_depth, target_depth, size);
 
 	*path = kzalloc(size, GFP_KERNEL);
 	if (!*path)
 		return -ENOMEM;
 
+	for (s = *path; item_depth--; s += 3)
+		strcpy(s, "../");
 
-	for (s = *path; depth--; s += 3)
-		strcpy(s,"../");
-
-	fill_item_path(target, *path, size);
+	fill_item_path(target, target_depth, *path, size);
 	pr_debug("%s: path = '%s'\n", __func__, *path);
 	return 0;
 }
-- 
2.25.1


