Return-Path: <linux-fsdevel+bounces-75879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MwJO2GHe2mlFQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 17:14:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87471B1FB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 17:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC17E302E7DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC3C33BBC0;
	Thu, 29 Jan 2026 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRPlLdn+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E5335090;
	Thu, 29 Jan 2026 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703238; cv=none; b=rrBcoYjdMoRO2Tc8cKF17DBMF8X5/lDm39j2XcHUFtjz6F4/w8Jvvl7ZdHy+jabGNNyonUqGqc14YuKIoJw80MAwRBsdp9kgcc7V+wcVfHH4WVpssNXrv6ZP/MaO6xPwG7/phqncZZDqPyuM/N5A72o0wdnieh/dUOhr20qZtJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703238; c=relaxed/simple;
	bh=La9o6W4y0vVBdcH6KlN6XyFOKCu8acKZkPR8qhv2+vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZEBplK+140FXvlXjzq/HzJE6vemql/Vf3b81/K70VMvdmtF5ZgBijvSZBcyZSSHMDYkyGVQMMmMSnRIj0xnRK9DraClOpg8KjhiPFn9/R6aH4DxPoorxdLKAJGnT0f728c5kcPmhPsEXROYAnkwG7jB8pnJJY4DHUr9yjMMNDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRPlLdn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74017C4CEF7;
	Thu, 29 Jan 2026 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769703238;
	bh=La9o6W4y0vVBdcH6KlN6XyFOKCu8acKZkPR8qhv2+vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRPlLdn++Td8jmuOq6JleUntXrH91GO4yrJZdWSzMPTDmpPBJ6nv76jPziMi9ovQp
	 bIn02G/pVE0WSFFQmfs4D1nBRF7jyfqdm7ehToSqEm91VEq0IutGkhv3z1n9RPuTNq
	 07q0cp4WRe74VrHEBVTpBegZIA/HFkpII9yOkSQrViRSZbri6Umnol8B8tzJ6/hFgD
	 ooc+izjKn0i5pxc9MlAcI6lh8Xbnz+ypRl6Awzf5VWArZUfWKLIV4l64hYaquEYURB
	 CwO2X2rA1nCqjH75mPKQtKLqEM/8oUvJbHJY7TUdsRFkbGTVS3GiTVhk7thEdz6std
	 VQBPs3W7lUXTA==
Date: Thu, 29 Jan 2026 17:13:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	lwn@lwn.net
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
Message-ID: <20260129-beidseitig-unwohl-9ae543e9f9f5@brauner>
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
 <20260119-bagger-desaster-e11c27458c49@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119-bagger-desaster-e11c27458c49@brauner>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75879-lists,linux-fsdevel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,forms.gle:url]
X-Rspamd-Queue-Id: 87471B1FB7
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 03:26:39PM +0100, Christian Brauner wrote:
> > (1) Fill out the following Google form to request attendance and
> >     suggest any topics for discussion:
> > 
> >           https://forms.gle/hUgiEksr8CA1migCA
> > 
> >     If advance notice is required for visa applications, please point
> >     that out in your proposal or request to attend, and submit the topic
> >     as soon as possible.

This is another reminder to put in your invitation request!

What are you waiting for? The weather in Croatia in May is nice. What
could be better than soaking up some sun through the meeting room window
while someone's asking you to make your locking more complicated, grow
your data structure by just a few bytes, or to add some more spaghetti
to that code?

Please also don't forget to pester^wask^wremind your respective
organizations to sponsor LSF/MM/BPF 2026! Bring it up as much as you
bring up that patch on-list that didn't get accepted but would've made
everything so much better.

Thanks!
Christian

