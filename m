Return-Path: <linux-fsdevel+bounces-74644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFo1EMRTcGlvXQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 05:19:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA83650EFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 05:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 586A6908473
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 13:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE82436370;
	Tue, 20 Jan 2026 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgaYm6RF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289F42E00C;
	Tue, 20 Jan 2026 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916456; cv=none; b=KvqIsG+yvwQByiaTMVmsbEwz5B0qJ/t1VkeWVyfPDYBZo0AAuDLy5jld0ad3j5VJe/drMItbTFiQ+WxPCH31jJ1wzBFEh6GjqByUN0Sjy9BkLtBJfR+LL30cq9FhnJTqApvdpWidtNLqxePSJp9kY2eu2ivKPsrGXuVAIMjF6ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916456; c=relaxed/simple;
	bh=Ww2vxfC7ZENAqiEwBP0gWFkYN0X8gY0coLCd/8tmAYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBERAzdR+5bH926L0+mVG7VQruMqcM9GxMNSR9HimMxFC4CXb30qYvQxOGf4KItQkZTBQaSab4y9Li2wTTWT4Bp5jM5QxtfwtrcRF3IN2QYmwHiFpZahXbxDFui/9nTik2h6P026/bjE5QOhM5b2J+3m/8QSqjGu/lbfUK1Y6rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgaYm6RF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E950C16AAE;
	Tue, 20 Jan 2026 13:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768916456;
	bh=Ww2vxfC7ZENAqiEwBP0gWFkYN0X8gY0coLCd/8tmAYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IgaYm6RFfv8Nv1drQJ6ITXMxHwPX49R+TMVL22Q6Xyi7XsPox85wvP3cDsYLvkgHv
	 01z5GLkgSrOEMm0sxBTDsWkRPGhnKRkEj74rWtV3eu74uyZ7IC4ZrvLZbIU5zIjtGQ
	 DWteKGqT4O52aDMm0GE0kgrPR7uVoFX/5G3OF44t3hgqeqNgNc05XNWC8yKXcFjD/Z
	 FOtoQ3WRbFJOW0ORiZSc3uQGRWPtwGFbY+aji3MLhOqG1/XSIeJSVL7yEY9IfVp/i7
	 mNPx6PvfC3yqJa+7OAl8ERFZnWHHNE3Fr6HTsrcQD03LOUCOtWSLgnOyy3M+E5X+fw
	 1VDIm1TAgbA1A==
Date: Tue, 20 Jan 2026 14:40:50 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, 
	Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, djwong@kernel.org, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
Message-ID: <20260120-neuland-rastplatz-31cc7d61a196@brauner>
References: <20260116154623.GC21174@lst.de>
 <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
 <20260119072932.GB2562@lst.de>
 <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
 <20260119083251.GA5257@lst.de>
 <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com>
 <20260119092220.GA9140@lst.de>
 <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com>
 <50db56b8-4cf9-4d62-b242-c982a260a330@linux.alibaba.com>
 <20260120065242.GA3436@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260120065242.GA3436@lst.de>
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,huawei.com,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org,linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-74644-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: AA83650EFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 07:52:42AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 20, 2026 at 11:07:48AM +0800, Gao Xiang wrote:
> >
> > Hi Christoph,
> >
> > Sorry I didn't phrase things clearly earlier, but I'd still
> > like to explain the whole idea, as this feature is clearly
> > useful for containerization. I hope we can reach agreement
> > on the page cache sharing feature: Christian agreed on this
> > feature (and I hope still):
> >
> > https://lore.kernel.org/linux-fsdevel/20260112-begreifbar-hasten-da396ac2759b@brauner
> 
> He has to ultimatively decide.  I do have an uneasy feeling about this.
> It's not super informed as I can keep up, and I'm not the one in charge,
> but I hope it is helpful to share my perspective.

It always is helpful, Christoph! I appreciate your input.

I'm fine with this feature. But as I've said in person: I still oppose
making any block-based filesystem mountable in unprivileged containers
without any sort of trust mechanism.

I am however open in the future for block devices protected by dm-verity
with the root hash signed by a sufficiently trusted key to be mountable
in unprivileged containers.

