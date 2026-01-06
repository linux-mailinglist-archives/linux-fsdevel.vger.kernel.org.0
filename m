Return-Path: <linux-fsdevel+bounces-72558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1875BCFB59F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 00:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 221A03020348
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 23:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619C52FF14D;
	Tue,  6 Jan 2026 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHIGLAWB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF84DAD24;
	Tue,  6 Jan 2026 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767742430; cv=none; b=LdaNsbISPFyoD2MGJqXoPW4CoLo2jywCugqDOCF4PwhOe+pdA/JO1/48jPPd+jo7w2YFbRoOlA+YCOJS30sOkclaaWde/CBVS1lDNjM4o9eVHChB4f4Xp10uT8CKL7Q52EJe9vsBw/IMh5g+jiGB4Wb5kLp+kfkZ4hSR0lUKsRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767742430; c=relaxed/simple;
	bh=51Mf1jtyugfdrBHzcpwBgck3+J4uCtDVXn8KnskGVIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyI4LQjCgrLtvh5qXrATFoY/wnCjqhzim2ykOAELibSu8rwf2Av/XfNlxtloVq5rmqvwCYELvnl7Z4ecJYi0gRgZ1Q90hbxK/TsatRramxt7VB+0CEs3iv5rP6RtUE3/zNkAN2UcN1vetwzTO+nGhxErDdao64gzIMF1vgjocK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHIGLAWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20794C116C6;
	Tue,  6 Jan 2026 23:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767742430;
	bh=51Mf1jtyugfdrBHzcpwBgck3+J4uCtDVXn8KnskGVIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IHIGLAWBckTuW90Tqk9AwWGKjF2td8rqovwg0NRbguo2bIlxwGpBGzsf1NLvMUILi
	 BQoWFioS862+nXI2dd8mWKpoXaJJ1YWihNNSbfnN5KPg9hqcMRvsKDOpqV4CPEorYY
	 5k4soKXZgcFh4/+7DO0jYUjkOFfrT4QBt41+h1q4KuL73AWbgVyQ+kIsfuEhj7rUSN
	 NTAm6kdG9jmZ0/CYsQaP/SRQ2kEhUibnKmP4QypshaRpk5WPy+MeWmqOyUXsvufo3I
	 6XAJSSfoKz67Z5XGzg3bxR5KXG5l1dB4Phf1Aujw4wJcFiq9b4bQHdjN9FgVMgfKEY
	 j9N30nD73TzCA==
Date: Tue, 6 Jan 2026 15:33:49 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: jack@suse.cz, brauner@kernel.org
Cc: linux-api@vger.kernel.org, hch@lst.de, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gabriel@krisman.be, amir73il@gmail.com
Subject: [PATCH 7/6] fs: improve comment in fserror_alloc_event
Message-ID: <20260106233349.GL191501@frogsfrogsfrogs>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

Document the ordering requirements between SB_ACTIVE and
s_pending_errors in the new fserror code.

Cc: jack@suse.cz
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fserror.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/fserror.c b/fs/fserror.c
index ec92f5a6db59ce..06ca86adab9b76 100644
--- a/fs/fserror.c
+++ b/fs/fserror.c
@@ -79,6 +79,11 @@ static inline struct fserror_event *fserror_alloc_event(struct super_block *sb,
 	 * If pending_errors already reached zero or is no longer active,
 	 * the superblock is being deactivated so there's no point in
 	 * continuing.
+	 *
+	 * The order of the check of s_pending_errors and SB_ACTIVE are
+	 * mandated by order of accesses in generic_shutdown_super and
+	 * fserror_unmount.  Barriers are implicitly provided by the refcount
+	 * manipulations in this function and fserror_unmount.
 	 */
 	if (!refcount_inc_not_zero(&sb->s_pending_errors))
 		return NULL;

