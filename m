Return-Path: <linux-fsdevel+bounces-78258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIYWOzefnWnwQgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 13:53:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C6218740F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 13:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D70AE3018580
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5003806CA;
	Tue, 24 Feb 2026 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK7AgtdE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F56938E108
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937323; cv=none; b=L/BG+HqYYh8+1HJ3XTXZkx1yyHVisq769cSyCuFOMbtbALSY+5foU9jDeR1U6PXPKxQYMZwf/Dv4/DMKJ93M0auxI7eVVFrJ8adAAJorVB7f5ZzsW3ZVxAvP0CT9l+q3OG1fdi6CTfrzjG8Y8XZPckFTUiP2xe8JnNt9vk87gY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937323; c=relaxed/simple;
	bh=rLsKRdv0wSkaHZNeOW9km1RrK2e9jwPNSrtfxf1yb44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5Mk2c+bLZPEw/c0Vzcv+Vt+xRV4h9gkUMPzqIjR2CUgTGBIQcll+2gNHlcbCmSO6Hb1qFBS4wlgGNptxP5NoBqZal/WoVHdtCES0t0GXnX3+3BOVUM7uhtl/9UvKlY84fijVcwugKaMfGk0o4l00KzjR/9tsLTr0CHvzebgHmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK7AgtdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0219BC19422;
	Tue, 24 Feb 2026 12:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771937323;
	bh=rLsKRdv0wSkaHZNeOW9km1RrK2e9jwPNSrtfxf1yb44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZK7AgtdEhdtPHl1mlPF39oMgxknHmYDZzYtv/gIhWxzJo89g8gPg7x/rKQDu6rdcm
	 kcVbDSB1JGlFwZtvy9FZgQXkGGoAgWOaawR4bPbYE0Sskg1cXF7Wpb1UocJcjcW2OG
	 ciLy0IkgcVlPAgPyVPrdRNEfyXaxzrmXmkAnm+r7VrQS4sZDbpP/A77PA6G/yWd7OY
	 Svf+9r5XYZ7u3mf9XOdi1pE/Xy4wLqHBuIglV8pxWOHl8rEZTphF/NwGcReM21R5Pu
	 Hyd1FsdbPxvoLCzuBtEMA+OFz6U4qxFbkGchG5qW08JHzrQE3J0qj33mSUcXQPo88/
	 6AcfPW9qUCkJw==
Date: Tue, 24 Feb 2026 13:48:38 +0100
From: Carlos Maiolino <cem@kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] File system testing
Message-ID: <aZ2UA2l3o9Z2j9H-@nidhogg.toxiclabs.cc>
References: <20260218150736.GD45984@macsyma-wired.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218150736.GD45984@macsyma-wired.lan>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78258-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71C6218740F
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 10:07:36AM -0500, Theodore Tso wrote:
> I'd like to propose a perennial favorite file system testing as a
> topic for the FS track.  Topics to cover would include:
> 

+1 for the topic.
> 1) Standardizing test scenarios for various file systems.
> 
>    I have test scenarios for ext4 and xfs in my test appliance (e.g.,
>    4k, 64k, and 1k blocksizes, with fscrypt enabled, with dax enabled,
>    etc.)  But I don't have those for other file systems, such as
>    btrfs, etc.  It would be nice if this could be centrally documented
>    some where, perhaps in the kernel sources?
> 
> 2) Standardized way of expressing that certain tests are expected to
>    fail for a given test scenario.  Ideally, we can encode this in
>    xfstests upstream (an example of this is requiring metadata
>    journalling for generic/388).  But in some cases the failure is
>    very specific to a particular set of file system configurations,
>    and it may vary depending on kernel version (e.g., a problem that
>    was fixed in 6.6 and later LTS kernels, but it was too hard to
>    backport to earlier LTS kernels).

IIUC, this might be something that frequently needs to be updated. This
would add more burden to the maintainer with (probably) frequent updates
to update such information.

I wonder if perhaps we could simply use a shared repository
where we can push test results and the respective kernel/xfstests
configuration used? And a section for 'expected/common failures'.

> 
> 3) Automating the use of tests to validate file system backports to
>    LTS kernels, so that commits which might cause file system
>    regressions can be automatically dropped from a LTS rc kernel.

This seems useful for me even for mainline, if a regression has been
found in LTS, it's likely it shouldn't have got into mainline anyway.

