Return-Path: <linux-fsdevel+bounces-77715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBFgLx4fl2m9uwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 15:33:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2190E15F878
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 15:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85BD53068F09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 14:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A3B33F8BC;
	Thu, 19 Feb 2026 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVaaqx93"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF3233374F
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511499; cv=none; b=peW3q3OjJ0gAIHq0JuoulSTA/RgjVl/2dDryjOK05ukgT8gkGvNJTu0wio3vCyNaIG7VzcYKM2qgdW5Q+s7S2O31htEJxChNpXNCbAa0fIeXuwVoyHY/Dc46kZxWDWa/3UxcKorH06zuFC3aAykvGFNVb2akB5Y1edNj5WVnjug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511499; c=relaxed/simple;
	bh=tiKZimpL/sJd3I+RYRg7iv8iq/JXXydVHMkEhmQtc/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVh8aHR/svTlDVi4A80Aa4jrJtxfzqXYR8QcPXN4EH6Hr+Zw5fEq7VJ9yw6uYtvAiTFBn6Nr3WRh17mnvfkQvEGABR+V4e+/JSArasHPaL2WCN4djnXYdbUwhmgyz++gSZ326P+OabU8c75Tk+ULTYvzL+oTONcfI+Ib12fbO9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVaaqx93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4482C4CEF7;
	Thu, 19 Feb 2026 14:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771511499;
	bh=tiKZimpL/sJd3I+RYRg7iv8iq/JXXydVHMkEhmQtc/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OVaaqx93UnEx0HVCo++C6fPmTt4RqFUx+JjYXfV6Sk4uYwxs0auvRnZQExik4WZze
	 JuGu0N5SJCMu91782PBVzj8ya6QVdNgtY49vrBR6vfsiLtQ3wq79MCwzUMICtuiXp4
	 K6/7uUXZvzDFepBYDxcDX1FXQ7O6yKVB0cVxVso0wUkelY51dt+mEBCnmaif3MRG+T
	 81anpEqIJV5OCUrvgpZCVHoCGkDyzO58G7e52AhqikuI9CeUVcXmQZxRZZoXyJLYx3
	 CrtVyaPVbK98dlVZPE893k3eBbMthkKWu/28yaDXGchhS7lYCI/9LzLA+wRl5OabOT
	 J9dVRao8Oc0RA==
Date: Thu, 19 Feb 2026 15:31:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [LSF/MM/BPF TOPIC] Should we make inode->i_ino a u64?
Message-ID: <20260219-portrait-winkt-959070cee42f@brauner>
References: <08f8444c7237566ffb4ba8c9eb0ab4b4a5f14440.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08f8444c7237566ffb4ba8c9eb0ab4b4a5f14440.camel@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77715-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2190E15F878
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 10:36:01AM -0500, Jeff Layton wrote:
> For historical reasons, the inode->i_ino field is an unsigned long.
> Because it's only 32 bits on 32-bit CPUs, this has caused a lot of fs-
> specific hacks on filesystems that have native 64-bit inode numbers
> when running a 32-bit arch.
> 
> It would be a lot simpler if we just converted i_ino to be 64-bits and
> dealt with the conversion at the kernel's edges. This would be a non-
> event for the most part on 64-bit arches since unsigned long is already
> 64 bits there.
> 
> The kernel itself doesn't deal much with i_ino, so the internal changes
> look fairly straightforward. The bulk of the patches will be to format
> strings and to tracepoints.
> 
> I think that the biggest problem will be that this will grow struct
> inode on 32-bit arches by at least 4 bytes. That may have cacheline
> alignment and slab sizing implications. We're actively talking about
> deprecating 32-bit arches in the future however, so maybe we can
> rationalize that away.

If you already have a Claude instance open you may want ask it to please
find the last ten mails about 32-bit that Linus sent and what his
opinions are about worrying about it when doing such changes... :)

> FWIW, I had Claude spin up a plan to do this (attached). It's not bad.
> I'm tempted to tell it generate patches for this, since this is mostly
> a mechanical change, but I'm curious whether anyone else might have
> reasons that we shouldn't go ahead and do it.

Please just do it. I didn't have time to do it myself yet.

