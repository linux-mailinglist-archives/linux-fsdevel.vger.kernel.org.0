Return-Path: <linux-fsdevel+bounces-1035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEAA7D50FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94945281E33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6732AB29;
	Tue, 24 Oct 2023 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufNUgpUi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85D929CE2
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3851CC433C7;
	Tue, 24 Oct 2023 13:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698152784;
	bh=16J0W4NcQ8UbgHZxida2I/GQkpCT537jEIeeQZxI09c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ufNUgpUi7qzIFl+Os9IZ0dmIHpcSaIGG8kUK4lEuZdKSMS5mYvdhdIc8AR5gI9i19
	 0n3E+YqcncPBQU4wSAffI2n6+uqm7UbDJ40ioshlVb9TQ+uCtT9fDF/UWs+zIl8net
	 9Gx4GrTO2/p2bwHFR7DCLciKCmDbLGuKQBi72JnfmdkqPtRXUeWjiAQbCYlIZ2ACEI
	 hYFaE8xZv37Jjrph0cBCauygJYkJj32kr5bkzznLjktvbcrEBIFmvaCz8v25HW8H4p
	 YA+mwLONc/Z0xfIM5voG12SneH4KJ8GeXFjvIxwMLtMm05R4QquBFH8pY7D7XC1ypP
	 6ePjSXfEqQlHg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Oct 2023 15:01:14 +0200
Subject: [PATCH v2 08/10] fs: remove unused helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-vfs-super-freeze-v2-8-599c19f4faac@kernel.org>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
In-Reply-To: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3498; i=brauner@kernel.org;
 h=from:subject:message-id; bh=16J0W4NcQ8UbgHZxida2I/GQkpCT537jEIeeQZxI09c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSaH3T8Vrr3U+ytngOGXhv2OrV/XfVedfayE84G9n82zAoL
 Cfia01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRu2WMDG3M8+YZTqj49vDR94OxxT
 oGqdcytvxdV1wwiTOl/2HXxTMM/zOucjwSneXw1ex3wr8NCXs2HzD0Pn+h6vS+Y1/6GZufi/MAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The grab_super() helper is now only used by grab_super_dead(). Merge the
two helpers into one.

Link: https://lore.kernel.org/r/20230927-vfs-super-freeze-v1-6-ecc36d9ab4d9@kernel.org
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c | 54 ++++++++++++++----------------------------------------
 1 file changed, 14 insertions(+), 40 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index c9658ddb53f7..b26b302f870d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -520,37 +520,6 @@ void deactivate_super(struct super_block *s)
 
 EXPORT_SYMBOL(deactivate_super);
 
-/**
- *	grab_super - acquire an active reference
- *	@s: reference we are trying to make active
- *
- *	Tries to acquire an active reference.  grab_super() is used when we
- * 	had just found a superblock in super_blocks or fs_type->fs_supers
- *	and want to turn it into a full-blown active reference.  grab_super()
- *	is called with sb_lock held and drops it.  Returns 1 in case of
- *	success, 0 if we had failed (superblock contents was already dead or
- *	dying when grab_super() had been called).  Note that this is only
- *	called for superblocks not in rundown mode (== ones still on ->fs_supers
- *	of their type), so increment of ->s_count is OK here.
- */
-static int grab_super(struct super_block *s) __releases(sb_lock)
-{
-	bool locked;
-
-	s->s_count++;
-	spin_unlock(&sb_lock);
-	locked = super_lock_excl(s);
-	if (locked) {
-		if (atomic_inc_not_zero(&s->s_active)) {
-			put_super(s);
-			return 1;
-		}
-		super_unlock_excl(s);
-	}
-	put_super(s);
-	return 0;
-}
-
 static inline bool wait_dead(struct super_block *sb)
 {
 	unsigned int flags;
@@ -564,7 +533,7 @@ static inline bool wait_dead(struct super_block *sb)
 }
 
 /**
- * grab_super_dead - acquire an active reference to a superblock
+ * grab_super - acquire an active reference to a superblock
  * @sb: superblock to acquire
  *
  * Acquire a temporary reference on a superblock and try to trade it for
@@ -575,16 +544,21 @@ static inline bool wait_dead(struct super_block *sb)
  * Return: This returns true if an active reference could be acquired,
  *         false if not.
  */
-static bool grab_super_dead(struct super_block *sb)
+static bool grab_super(struct super_block *sb)
 {
+	bool locked;
+
 	sb->s_count++;
-	if (grab_super(sb)) {
-		put_super(sb);
-		lockdep_assert_held(&sb->s_umount);
-		return true;
+	spin_unlock(&sb_lock);
+	locked = super_lock_excl(sb);
+	if (locked) {
+		if (atomic_inc_not_zero(&sb->s_active)) {
+			put_super(sb);
+			return true;
+		}
+		super_unlock_excl(sb);
 	}
 	wait_var_event(&sb->s_flags, wait_dead(sb));
-	lockdep_assert_not_held(&sb->s_umount);
 	put_super(sb);
 	return false;
 }
@@ -835,7 +809,7 @@ struct super_block *sget_fc(struct fs_context *fc,
 			warnfc(fc, "reusing existing filesystem in another namespace not allowed");
 		return ERR_PTR(-EBUSY);
 	}
-	if (!grab_super_dead(old))
+	if (!grab_super(old))
 		goto retry;
 	destroy_unused_super(s);
 	return old;
@@ -879,7 +853,7 @@ struct super_block *sget(struct file_system_type *type,
 				destroy_unused_super(s);
 				return ERR_PTR(-EBUSY);
 			}
-			if (!grab_super_dead(old))
+			if (!grab_super(old))
 				goto retry;
 			destroy_unused_super(s);
 			return old;

-- 
2.34.1


