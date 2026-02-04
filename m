Return-Path: <linux-fsdevel+bounces-76317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LF6HFxEg2nqkgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 14:06:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F05FE62A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 14:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0960E30C6705
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 13:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E52A40B6C3;
	Wed,  4 Feb 2026 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGy6oB2v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA3540758A;
	Wed,  4 Feb 2026 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770210063; cv=none; b=Sdel14oEW0+46BLutoOpkXRs4p0gfIwvzC//9VP3yZX8jzY87zFjyWzTs6i/E8KSGJYfq2+lTYzeqMtok8ztUD5T+FFfG07WSMCbPO/g9wFPekoJmPSgcduqqr71b/oB+yigM94ZxURup+v1PnIKRDapVfpbDsKfn18djGkDmkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770210063; c=relaxed/simple;
	bh=yWHavuZhVnobrvDzZB5WR03rfGaWTx6aPnNFoVuKdfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAttUO440fyH7W53blZPjfVrYBg6vacXyYbnpyQDIuVsOTbiMNhHu+E0eAX4OxwcUbh0y+VxFoiiYVhMeN1Oy5l/IHeKlpbiLvWg1zPYImX2IXMXQDddpAewG0UKYSM/cjaSvqra67dHHEbkTk217vegrNCuAijYphAviBP1tVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGy6oB2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDD0C19422;
	Wed,  4 Feb 2026 13:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770210063;
	bh=yWHavuZhVnobrvDzZB5WR03rfGaWTx6aPnNFoVuKdfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGy6oB2v+3OBcOSP3MXjv3EBG/MA3ltf9wTrE2QWvMGd35VjFeOmTtF0xuaPqPKuY
	 Kg+J50wA8GHrP5SyEQdkxp0ecCOiJc5+U/HGzUo5tWffLMWKfzA9FpaFJON0g47CGp
	 lmzv9DMYaKDRlH19mpiS85LzuBYmb9Baf1iyoqEhaRYR0WzrRmTpmoXwHnLqwDtuVp
	 8WJIZfdjla05d8k7ShjrMspeydj3CpNkgYpzT112VRs/qpGZu0WPweoW8gYXZQqarv
	 8jthGhyw/scnfk8bnsSm9aYujfIYzfDicHS84z/TAPU2qLjNpEnOoHkZRGK1LX6bbX
	 LFuxp99sfpSGQ==
Date: Wed, 4 Feb 2026 14:00:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Askar Safin <safinaskar@gmail.com>
Cc: amir73il@gmail.com, jack@suse.cz, jlayton@kernel.org, 
	josef@toxicpanda.com, lennart@poettering.net, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, viro@zeniv.linux.org.uk, zbyszek@in.waw.pl
Subject: Re: [PATCH v2 0/4] fs: add immutable rootfs
Message-ID: <20260203-prost-lorbeerblatt-abd2df8c83bc@brauner>
References: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
 <20260201195531.1480148-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260201195531.1480148-1-safinaskar@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76317-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,toxicpanda.com,poettering.net,vger.kernel.org,zeniv.linux.org.uk,in.waw.pl];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0F05FE62A1
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 10:55:31PM +0300, Askar Safin wrote:
> Christian, important! Your patchset breaks userspace! (And I tested this.)

If a bug is found in a piece of code we _calmly_ point it out and fix it.

> I tested listmount behavior I'm talking about. On both vfs.all (i. e. with
> nullfs patches applied) and on some older vfs.git commit (without nullfs).

Looking at a foreign mount namespace over which the caller is privileged
intentionally lists all mounts on top of the namespace root. In contrast
to mountinfo which always looks at another mount namespace from the
perspective of the process that is located within that mount namespace
listmount() on a foreing mount namespace looks at the namespace itself
and aims to list all mounts in that namespace. Since it is a new api
there can be no regressions.

