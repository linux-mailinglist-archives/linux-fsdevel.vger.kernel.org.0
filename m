Return-Path: <linux-fsdevel+bounces-16979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABDE8A5E7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 01:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269D3286333
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 23:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592DF15920B;
	Mon, 15 Apr 2024 23:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZkV558E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B991D1DA21;
	Mon, 15 Apr 2024 23:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224370; cv=none; b=IS0rWM/MG5P+Tkk3ROZLOHxlN5LB/dvsRCsCVGPVeG3KoluTpYYBTkaFWsqChJAW0XbnR/sK+Xj1bErdMM1KoKnQ60bXq9B/DKCqnC9MflNEfnWseTT45f0sn6vBqQ3s6xnYRysUrddAw8oVn0kGccAJc9uA1fK9hXCN+Ly9Le0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224370; c=relaxed/simple;
	bh=Y6f9XXbuASfk5okp7bMYS8EWOHBRzxH5IrJwh40v+08=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oytOZSBBQxEm0srZPNBU0odkv2yb0ylVCECEuEFMtBOL1ll2SO9Sg4CI1AhPwapvH6C0Bvjwd6hpv9nGoG8lFsqqGA+AXs4IS7GYEQiMO8wXCFEsAPiovT3OpPd2XVyWf6cYa2J7NRGaESZqa8wTKxOBwuPcEsno5wcODMOS7/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZkV558E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9013AC113CC;
	Mon, 15 Apr 2024 23:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224370;
	bh=Y6f9XXbuASfk5okp7bMYS8EWOHBRzxH5IrJwh40v+08=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VZkV558E+32r4xuD6JUIyjxj/jBOkPVuPP3TQUtqcVYkWSoQeopXpwHyWLJcPrI18
	 +h4s92kwk7kZh+APFyoMpmlL8B/IcA9Y9vn0tncLDlfor12e3xWdFyma59WMjNJNrt
	 MIxCysE4+TVa1eazt1iv1vavCfi0aVQ5F3GWtjvSK3eKSztsuo/ZjBnipWeBtRf2+F
	 QWBfMIXg7DUrAcmzMyOdsayge9ucrm/QIXBTvsusHvLBZYxmx8MVmomzuCczu0vFZM
	 YKW/Akh1DspKR61WbzVE47XPAKyNGG71+GPe0XvGSc9ZAcUkYQrURzhyXmRzV9rgpa
	 L269tthCWT1+w==
Date: Mon, 15 Apr 2024 16:39:30 -0700
Subject: [PATCH 2/7] xfs: move xfs_iops.c declarations out of xfs_inode.h
From: "Darrick J. Wong" <djwong@kernel.org>
To: chandanbabu@kernel.org, djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171322380761.87068.18235427530614561380.stgit@frogsfrogsfrogs>
In-Reply-To: <171322380710.87068.4499164955656161226.stgit@frogsfrogsfrogs>
References: <171322380710.87068.4499164955656161226.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Similarly, move declarations of public symbols of xfs_iops.c from
xfs_inode.h to xfs_iops.h.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_inode.h |    5 -----
 fs/xfs/xfs_iops.h  |    4 ++++
 2 files changed, 4 insertions(+), 5 deletions(-)


diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 5164c5d3e549..b2dde0e0f265 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -569,11 +569,6 @@ int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);
 
-/* from xfs_iops.c */
-extern void xfs_setup_inode(struct xfs_inode *ip);
-extern void xfs_setup_iops(struct xfs_inode *ip);
-extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
-
 static inline void xfs_update_stable_writes(struct xfs_inode *ip)
 {
 	if (bdev_stable_writes(xfs_inode_buftarg(ip)->bt_bdev))
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 7f84a0843b24..8a38c3e2ed0e 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,4 +19,8 @@ int xfs_vn_setattr_size(struct mnt_idmap *idmap,
 int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 		const struct qstr *qstr);
 
+extern void xfs_setup_inode(struct xfs_inode *ip);
+extern void xfs_setup_iops(struct xfs_inode *ip);
+extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
+
 #endif /* __XFS_IOPS_H__ */


