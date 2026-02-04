Return-Path: <linux-fsdevel+bounces-76241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCZ6LWG+gmk4ZgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 04:34:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2D7E14C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 04:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EBCE3061744
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 03:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7752BDC16;
	Wed,  4 Feb 2026 03:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9x1KEJJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D91528853A;
	Wed,  4 Feb 2026 03:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770176045; cv=none; b=hLu6H67oM+RWFFcDLOFb3ZQdoz5Gnb6hxGHWRZgPr+Krfc/Q0p9zDTDezNLSto1QBrCR9JNbJKgWuum/ItvlGtTo4AEczBoS6/7f4hClJjem/M7VMor9EqHwMLVGL1AyJjZb+luqF5QFAFG5e0K6VXwUfaxWQxauZrfknzF8Sk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770176045; c=relaxed/simple;
	bh=1aED65oWlWXqKZ3DKz8sJRbqvRqUQ9/RAuG62nQFcX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ca7Ll/0fUh5mX6rfUpGdt/5AVEx3KNjDkTvPraMVUTe3aURqdd2rX26brzighsDPOQQob8FWaHi8k+74mjjHXONvg818KR3oGMtdR+ja0cGWtN2LMrKkUPlfrgMvyKeBYYbKHp8WFEc5pBvXcd8oIChgzsm+cRyRsodWO+PbjEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9x1KEJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834C8C116C6;
	Wed,  4 Feb 2026 03:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770176044;
	bh=1aED65oWlWXqKZ3DKz8sJRbqvRqUQ9/RAuG62nQFcX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f9x1KEJJdqLyrst3STM0o7dS45fN/X/4KqG0j3Do7TnJFsaQ7YkJIS1EzNI0cryYr
	 lI8NIHp/SM1ZWxeAfJ/gvd+3HDhMwwejcVoqwluuHuukaLo9nlsFzrOh797fDXVSn4
	 Z/agdJvwrkhxJZyEuUyU7P/W5NffFHF/CWqL9pcpoW3DzFUO5OBbs4aWG3hEjLXDQ8
	 MYnmd/qHlujGi+xLaqFNLRSXXF6CZvhNkerfT34pAgXXIYjX3BYxT+5PIB/iNMb7HU
	 whQKbihBUBJ78sKVaGsJ7nMsKygL8SPXrNcuvHCvf2ain5CMxxp8XyCVujaF+tq5CH
	 DiyKt3TWCixtg==
Date: Tue, 3 Feb 2026 19:33:29 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] fsverity: add missing fsverity_free_info()
Message-ID: <20260204033329.GA3726@sol>
References: <20260202214306.153492-1-ebiggers@kernel.org>
 <20260203053228.GB15956@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203053228.GB15956@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76241-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B2D7E14C2
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 06:32:28AM +0100, Christoph Hellwig wrote:
> On Mon, Feb 02, 2026 at 01:43:06PM -0800, Eric Biggers wrote:
> > If fsverity_set_info() fails, we need to call fsverity_free_info().
> > 
> > Fixes: ada3a1a48d5a ("fsverity: use a hashtable to find the fsverity_info")
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> 
> Looks good.  It might make sense to fold into the offending patch to help
> with bisectability, though.
> 

I folded it into "fsverity: use a hashtable to find the fsverity_info".

- Eric

