Return-Path: <linux-fsdevel+bounces-76200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFNeK1UDgmmYNgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 15:16:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AD7DA757
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 15:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A49FD3007B28
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8153A7849;
	Tue,  3 Feb 2026 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5XDxMzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF43A1E60;
	Tue,  3 Feb 2026 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128204; cv=none; b=eOiLR6s4GExux259pVSA+siOBUCiG1op0tUKl1KwH2yXW3gHIFz49MtrvF7s3B8c2LkHJgBYoR+xyU9o6z7TewGwUy6r0bOx1wa+xrIUrPDD811b/DePDQChbFgLm8C4wV1ObrwsOEKKFY0DFJetZJ0iJnRf1x05EfiE5zVb9yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128204; c=relaxed/simple;
	bh=FwDWH4+EWaS0ssfiC4uUSaW04MIsJXeVJZBqZsvQhJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVkYTlzLTCD7EXMWKLeeoKSCCdkVRLe0IgQ/8vJ41YWmyqo9fa6Y2fqjuEqcnUy9bNkCyngfz2lh1i+Qg3zZ6rSr1udyG4p3ler7W32pqVBGv4cxkNxg2+KKpYvoG7lNIM/mW5pK8zxdf1lK2M4QiJC2dxd9xrEip7/kAC/mjIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5XDxMzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FD7C116D0;
	Tue,  3 Feb 2026 14:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770128204;
	bh=FwDWH4+EWaS0ssfiC4uUSaW04MIsJXeVJZBqZsvQhJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5XDxMzW19gfBFjDD4mYolpdGibizAunKFiLgHazT4N5NMIHkLANNWRc+VCb4DcMX
	 d538lkFa+RLOKN8NsOGTBSig1zGGzORgHmi054Y/IOW4mcgJq2pXnhxHYKi5PoZOMA
	 LgINPinxv5DC3HpeiAJl1d96MY/lQB0PeL3Xc0G8ijA1tLacQczbe4qEhmq8wYjwlu
	 d4x/mcWBpkesKeFs/+V9tkNedCRfj1lBBlN1OVxgbzMnIRDoevp+42BurpfzFBH/RN
	 seUiW8zWD2ImlDTJxq6WK+oql30nzMllYbqI3PHq9A+x2IRNS9+jY6EaSZUcaqYVx1
	 tyE08W8VSZy5A==
Date: Tue, 3 Feb 2026 15:16:40 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, Andrey Albershteyn <aalbersh@kernel.org>, 
	linux-fsdevel@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 0/2] Add traces and file attributes for fs-verity
Message-ID: <20260203-wasser-universal-5cc36f5a273e@brauner>
References: <20260126115658.27656-1-aalbersh@kernel.org>
 <20260129-beieinander-klein-bcbb23eb6c7b@brauner>
 <20260129174015.GA2240@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260129174015.GA2240@sol>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76200-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1AD7DA757
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 09:40:15AM -0800, Eric Biggers wrote:
> On Thu, Jan 29, 2026 at 04:01:29PM +0100, Christian Brauner wrote:
> > On Mon, 26 Jan 2026 12:56:56 +0100, Andrey Albershteyn wrote:
> > > This two small patches grew from fs-verity XFS patchset. I think they're
> > > self-contained improvements which could go without XFS implementation.
> > > 
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > > 
> > > v3:
> > > - Make tracepoints arguments more consistent
> > > - Make tracepoint messages more consistent
> > > v2:
> > > - Update kernel version in the docs to v7.0
> > > - Move trace point before merkle tree block hash check
> > > - Update commit message in patch 2
> > > - Add VERITY to FS_COMMON_FL and FS_XFLAG_COMMON constants
> > > - Fix block index argument in the tree block hash trace point
> > > 
> > > [...]
> > 
> > Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
> > Patches in the vfs-7.0.misc branch should appear in linux-next soon.
> > 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> > 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> > 
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs-7.0.misc
> > 
> > [1/2] fs: add FS_XFLAG_VERITY for fs-verity files
> >       https://git.kernel.org/vfs/vfs/c/0e6b7eae1fde
> > [2/2] fsverity: add tracepoints
> >       https://git.kernel.org/vfs/vfs/c/fa19d42cc791
> 
> I guess this means you want me to drop them.  So, dropped now.

Hm, sorry if I missed to reply to another mail on list. That wasn't
intentional.

