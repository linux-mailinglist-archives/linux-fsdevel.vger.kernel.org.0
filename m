Return-Path: <linux-fsdevel+bounces-75886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLAVFaebe2m5HAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 18:40:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3ADB315D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 18:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71F713003D07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 17:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA34353EFD;
	Thu, 29 Jan 2026 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiTTqFES"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD52353EF8;
	Thu, 29 Jan 2026 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708450; cv=none; b=LKZYhfG1P+U0qkaaXTPFMfnRKpDhhyOyjJyGq5h4Oay20WYkIfh8Uc+eKiLz5xwCNW6x7NViAFSMJnZzeEbJ5rkEyV56vo/BUJa2WXBQu+dVD3xOAQHllhzCmnQAPGir94uhcFbqU5Wr0usVymgVbsfw/PbymaUAi6DrFo38JnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708450; c=relaxed/simple;
	bh=ID/IGLGdS4zlcblJ9Rju76WUTjWpKt0FdiTrQP50wu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZnTCiFWOWBBLu/STTWAiUcrxolqKJDLvnfTf6o62g17kPwTfs2aIOsgGHgC/3G0FmtqstDaqpQmtnlPqZDjypKBseglxihUux+3RjcIyWINMXXKYIG3Bi3efstAkOsjpBpwS7tCr1VuY+WJd0eay6/p64E7jmpBfH3MPENM5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiTTqFES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B829BC4CEF7;
	Thu, 29 Jan 2026 17:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769708449;
	bh=ID/IGLGdS4zlcblJ9Rju76WUTjWpKt0FdiTrQP50wu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aiTTqFESxx1FG4gg97WZZo28OnobZfMFUNLdfy4LSvuicJoKcy0gKBnrcGCYSEJ2e
	 CZcV4xFmoDW7mkT9I8ZiBmybChD/4WTavYrRuq99mJmTykO02JMeZZRvM1B6ooOdHT
	 AJt4Z3wnSVk5Q/gH7IX2cQG0HxgWY/XeuWZWurErfVMmXYbmBTsl/+Uy5GyiNfi6mt
	 JBwZRWlnKAU4FpM88Yl5yyTOiadQE9c43LFsCz9qbzZQCvZzQfrf4mZQklU51EkdER
	 Adkv3LPnAYR20AX+OzL4SrWP+R1qvxRdFtudRGGmaoiL2aYkjCzK4ldornb8MEr7s5
	 MKgRp9AImMGrg==
Date: Thu, 29 Jan 2026 09:40:15 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: fsverity@lists.linux.dev, Andrey Albershteyn <aalbersh@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 0/2] Add traces and file attributes for fs-verity
Message-ID: <20260129174015.GA2240@sol>
References: <20260126115658.27656-1-aalbersh@kernel.org>
 <20260129-beieinander-klein-bcbb23eb6c7b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129-beieinander-klein-bcbb23eb6c7b@brauner>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75886-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F3ADB315D
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 04:01:29PM +0100, Christian Brauner wrote:
> On Mon, 26 Jan 2026 12:56:56 +0100, Andrey Albershteyn wrote:
> > This two small patches grew from fs-verity XFS patchset. I think they're
> > self-contained improvements which could go without XFS implementation.
> > 
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > 
> > v3:
> > - Make tracepoints arguments more consistent
> > - Make tracepoint messages more consistent
> > v2:
> > - Update kernel version in the docs to v7.0
> > - Move trace point before merkle tree block hash check
> > - Update commit message in patch 2
> > - Add VERITY to FS_COMMON_FL and FS_XFLAG_COMMON constants
> > - Fix block index argument in the tree block hash trace point
> > 
> > [...]
> 
> Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-7.0.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-7.0.misc
> 
> [1/2] fs: add FS_XFLAG_VERITY for fs-verity files
>       https://git.kernel.org/vfs/vfs/c/0e6b7eae1fde
> [2/2] fsverity: add tracepoints
>       https://git.kernel.org/vfs/vfs/c/fa19d42cc791

I guess this means you want me to drop them.  So, dropped now.

- Eric

