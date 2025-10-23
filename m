Return-Path: <linux-fsdevel+bounces-65249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12542BFEA4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 02:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961E8188A0BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 00:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1867F19D07E;
	Thu, 23 Oct 2025 00:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAWDgCVS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554AE78F4B;
	Thu, 23 Oct 2025 00:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177683; cv=none; b=ucToinM+k+G9Sd5e1PCjKh9sL+pdAdAta9bLHYAeJMXFPfoXHvAu8iyDG5MJ9eqR0uWIvwOuzbWHz2inFWjRaMkPBMyEPzv+usSFJEy7KXgAyQcgaVj1tn8JqoZ4E9V3+S7CkhvbQfqjPQ2vBVppH0Dwj0TPOyiM5SJFPzCbGQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177683; c=relaxed/simple;
	bh=c5DVDn9Yn3MQqewS7FXmrXc6RVxUABy2KnTMaYGOQv8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K39sUbTd34pjhdR+ZE7WP8ALwZbZxKCfwdq7cB0cG7iDKiALikofkEQW9+27Z4pVqRqTzlSXnOo1pwt/8aDrDslrwZjnpTui/kgdLXVdvzhF/i3zwVskuL5BRTykbLCc7KpdoBll6h6M6zkikBJNe4RKnAF2aX+mNYmE24eM8pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAWDgCVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF86C4CEE7;
	Thu, 23 Oct 2025 00:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177683;
	bh=c5DVDn9Yn3MQqewS7FXmrXc6RVxUABy2KnTMaYGOQv8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TAWDgCVSreWfWtGuebz7uPJ4IEpAAvZivW5FRCcjFdpXh70erzBbtTt88xONh2kYJ
	 eU++Lxa/oPMwTz/6pVClt36EQRv7uO6C4DgtN5qYUhShKHO5RW5rSlVOrRbayHYoSf
	 5AlixshA2oIRtTKVZUgnZEI8tQCVNEfbpEU+XwWX8LNQ0StwhH/8iMrwnnmlDJOn/H
	 AR6kTkltOzNWn6VQhM1HHt3/vQxcxYiKiMAznIBENBjt2hsopQcHF6ZVMw+JA1YCAt
	 urT9EzUtqy3bMTJbklK5l44hzXYUyY/VrtisEZ8tKynqyk3eIvi619l2pDFa9LHjWc
	 YCHQ9QuiuG31g==
Date: Wed, 22 Oct 2025 17:01:22 -0700
Subject: [PATCH 03/19] xfs: create debugfs uuid aliases
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176117744562.1025409.15839501418141154383.stgit@frogsfrogsfrogs>
In-Reply-To: <176117744372.1025409.2163337783918942983.stgit@frogsfrogsfrogs>
References: <176117744372.1025409.2163337783918942983.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create an alias for the debugfs dir so that we can find a filesystem by
uuid.  Unless it's mounted nouuid.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_mount.h |    1 +
 fs/xfs/xfs_super.c |   11 +++++++++++
 2 files changed, 12 insertions(+)


diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index f046d1215b043c..8643d539bc4869 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -290,6 +290,7 @@ typedef struct xfs_mount {
 	struct delayed_work	m_reclaim_work;	/* background inode reclaim */
 	struct xfs_zone_info	*m_zone_info;	/* zone allocator information */
 	struct dentry		*m_debugfs;	/* debugfs parent */
+	struct dentry		*m_debugfs_uuid; /* debugfs symlink */
 	struct xfs_kobj		m_kobj;
 	struct xfs_kobj		m_error_kobj;
 	struct xfs_kobj		m_error_meta_kobj;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d8f326d8838036..abe229fa5aa4b6 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -813,6 +813,7 @@ xfs_mount_free(
 	if (mp->m_ddev_targp)
 		xfs_free_buftarg(mp->m_ddev_targp);
 
+	debugfs_remove(mp->m_debugfs_uuid);
 	debugfs_remove(mp->m_debugfs);
 	kfree(mp->m_rtname);
 	kfree(mp->m_logname);
@@ -1963,6 +1964,16 @@ xfs_fs_fill_super(
 		goto out_unmount;
 	}
 
+	if (xfs_debugfs && mp->m_debugfs && !xfs_has_nouuid(mp)) {
+		char	name[UUID_STRING_LEN + 1];
+
+		snprintf(name, UUID_STRING_LEN + 1, "%pU", &mp->m_sb.sb_uuid);
+		mp->m_debugfs_uuid = debugfs_create_symlink(name, xfs_debugfs,
+				mp->m_super->s_id);
+	} else {
+		mp->m_debugfs_uuid = NULL;
+	}
+
 	return 0;
 
  out_filestream_unmount:


