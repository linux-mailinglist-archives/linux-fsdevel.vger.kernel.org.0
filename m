Return-Path: <linux-fsdevel+bounces-77761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCsyJYqyl2mb6QIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 02:02:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A631640F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 02:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 464AA30180AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 01:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B5119DF8D;
	Fri, 20 Feb 2026 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8nNuxlE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AF12AD2C;
	Fri, 20 Feb 2026 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771549310; cv=none; b=GqxHYlG3giqz55SBYF9BcefjMYXHKuJiZXAUS4fITIIWNP0aIGczrOAl5CzDvvf7SbNLK5MjdlvehqejSYKqKL/d0uYmTbNTzT3ov2zS5oVGSjRJs5Lg0uqnk5swV61AKgTllLFXSkDObVxiCPYyZFYtv2xmRG4zWG8ROPDEz4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771549310; c=relaxed/simple;
	bh=/6PLUY+VqVHTIhdrOQk+tEXgqkpbJCYy9NyWc4FR+r8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZgKFTGZ4MWHDQe2sP0ntctEsrA4fJbyB7H8cNCtq+LJriBtztTvvZSJm8VGZkyU6jT9pIEjuZTm6wjl23uSDQMVMqR75gfA/kjZF9hwAoj3nE7FbpNk+NZoL+T7Kel8eJ5Asy/vrtIq/oHI+KbeZ9OOsP9mfrguWsB0QK+rpvFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8nNuxlE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C76C4CEF7;
	Fri, 20 Feb 2026 01:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771549309;
	bh=/6PLUY+VqVHTIhdrOQk+tEXgqkpbJCYy9NyWc4FR+r8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=a8nNuxlEs0B4fKaqEdSG1zHq0pBoLcgg+znyKcBRq/oVQ+f29jwl0gLCrpwq7ZFn8
	 La1jYhmW2Se3zWoSJVa4N8qdsVOKWmgg5y63utYQOJguVS3bjS8r2VcqegSI37rttm
	 kgguDBb6nWPrHJbfQ/tHPwU90iUyggV4UInxeSwQa2iKWaecoCnJ3Lc3qPqXTFfuq2
	 +uZwnwnpTU0oT0cVQN31l2YfJTymH+QMLjJUm2GTduZg62rdrxkZ+SirMAeGw+Vcou
	 +3LbVHfZHb76xCFWvvDB+YitaQL47JIfGik81Qv1N8/nde2gEv2JKwfimt1l20KWa/
	 VLLqjJlgIzi7w==
Date: Thu, 19 Feb 2026 17:01:49 -0800
Subject: [PATCH 1/2] fsnotify: drop unused helper
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: amir73il@gmail.com, hch@lst.de, jack@suse.cz, linux-xfs@vger.kernel.org,
 brauner@kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <177154904025.1351989.18130031325957531561.stgit@frogsfrogsfrogs>
In-Reply-To: <177154903995.1351989.7277473944406826383.stgit@frogsfrogsfrogs>
References: <177154903995.1351989.7277473944406826383.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lst.de,suse.cz,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-77761-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33A631640F0
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Remove this helper now that all users have been converted to
fserror_report_metadata as of 7.0-rc1.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Acked-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 include/linux/fsnotify.h |   13 -------------
 1 file changed, 13 deletions(-)


diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 28a9cb13fbfa38..079c18bcdbde68 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -495,19 +495,6 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
 		fsnotify_dentry(dentry, mask);
 }
 
-static inline int fsnotify_sb_error(struct super_block *sb, struct inode *inode,
-				    int error)
-{
-	struct fs_error_report report = {
-		.error = error,
-		.inode = inode,
-		.sb = sb,
-	};
-
-	return fsnotify(FS_ERROR, &report, FSNOTIFY_EVENT_ERROR,
-			NULL, NULL, NULL, 0);
-}
-
 static inline void fsnotify_mnt_attach(struct mnt_namespace *ns, struct vfsmount *mnt)
 {
 	fsnotify_mnt(FS_MNT_ATTACH, ns, mnt);


