Return-Path: <linux-fsdevel+bounces-67026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D9DC33839
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DB018C35E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C282E23ABB9;
	Wed,  5 Nov 2025 00:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrV0bS04"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D4F34D396;
	Wed,  5 Nov 2025 00:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303754; cv=none; b=uL75qW7Mu5DyA9s6qURYX7+8j9/k2ql2cbjCs5i9WWq5/EiDIALb3aBo2lrpCho8Pf7fQorI3klBlHfp3nNZLS3Q5UQZrhUvM1pDhCWS3K9W3wQyE9Bt40yWUau9ntbUxDo+2iPUCZVr49gNaSUnCw6N2GzCABuZ1Frdg8+VylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303754; c=relaxed/simple;
	bh=OoPi3EiECx+wib8P9OwmltQcfh+UVvc113vT7bHSuwA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkQ+VEM9bdHH3sbLinRc5rrEYitRcVDTviUCipL0axTbWHsP9u6S974ETh5N6P8niyFDoRcESFgSyXY1eOfNPMsVxX68pZ+9CqBwN9WThC4NE8dUOkf7Gj9ENQJl84i/2zZ6RszhUXpaJ351L5g/Fl4pjx8jmnsfslw2izNYLqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrV0bS04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F60C116B1;
	Wed,  5 Nov 2025 00:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303752;
	bh=OoPi3EiECx+wib8P9OwmltQcfh+UVvc113vT7bHSuwA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VrV0bS04SIdB0z5u6utDgT8d+nf/KChnNKkQy8CeIYY5EeQtPA/rKacR2AtTH5fVl
	 OTVCKQwmxEot/vhV1f5+u4y4U1oyq1kcUcnr+P+ePJOO8fqYG+VlIL9qu3YIO2x1+F
	 AjFCq/Jui/rVMpW1W5IERktOmAJsp2HOtP0AVBjAVrN2a6/Ws/l4ykq4ICbVFJtQtS
	 Zm45HxhiRl96zQGHEAWpI6yxQuZSEUDiNUOBZxnWLNsnj/Jc+uN/aICvI7xsUKjUIM
	 ewzATibBsaSjDl3CnHa76KslI8NzAvhuZdHVy+2+xVewOvK4rK9/NFa3Y8/5jbpvxl
	 M8d3mSpk2Rf/w==
Date: Tue, 04 Nov 2025 16:49:12 -0800
Subject: [PATCH 03/22] xfs: create debugfs uuid aliases
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <176230365752.1647136.12281465672929020624.stgit@frogsfrogsfrogs>
In-Reply-To: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
References: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
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
index b871dfde372b52..94108668ddabbd 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -289,6 +289,7 @@ typedef struct xfs_mount {
 	struct delayed_work	m_reclaim_work;	/* background inode reclaim */
 	struct xfs_zone_info	*m_zone_info;	/* zone allocator information */
 	struct dentry		*m_debugfs;	/* debugfs parent */
+	struct dentry		*m_debugfs_uuid; /* debugfs symlink */
 	struct xfs_kobj		m_kobj;
 	struct xfs_kobj		m_error_kobj;
 	struct xfs_kobj		m_error_meta_kobj;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 1067ebb3b001bf..ba07e4a4ae3ffa 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -819,6 +819,7 @@ xfs_mount_free(
 	if (mp->m_ddev_targp)
 		xfs_free_buftarg(mp->m_ddev_targp);
 
+	debugfs_remove(mp->m_debugfs_uuid);
 	debugfs_remove(mp->m_debugfs);
 	kfree(mp->m_rtname);
 	kfree(mp->m_logname);
@@ -1969,6 +1970,16 @@ xfs_fs_fill_super(
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


