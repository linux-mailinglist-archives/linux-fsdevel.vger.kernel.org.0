Return-Path: <linux-fsdevel+bounces-78801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF0MI/Aaoml7zQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 23:30:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BB41BEB31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 23:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D1D6301AB87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 22:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D20E47B407;
	Fri, 27 Feb 2026 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mblv7DHD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE05E47AF64;
	Fri, 27 Feb 2026 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772231399; cv=none; b=hSmRmwQC47B/5YdcIkU15scJdfXsg972yiKpRA/M0uDw0sJ7MbCl83pUKCWAFiCBySkFfkY1wTpjYvLYJPYlz7alyXlIinN7/06CpMu1FHG3Ssag5femupi61PfGqRGvos2SV6oWPKYT2aeEe90F2lTJ1hRNHYWSlu5vuOpp6uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772231399; c=relaxed/simple;
	bh=qOWr/grtHIj1V1K+NCTt0HpJP/AofwCqzIkHf3d79hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcMXkWr7hM2pCZurEtxawQE+mj9rxJe0dFLRw9IB7RjG3Uv2iGDgdgPgA3HVe/jKq0m606Fr5jcPzc8BMsdPTHKxJDc4zO0y/u7V+Rq89hA+qGP67Q1Ie6HfOid2/m9A6USkr+WB/43ZRFxUG3d+E4S7jkHGDvQEH9ErXxCuLiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mblv7DHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41B9C116C6;
	Fri, 27 Feb 2026 22:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772231399;
	bh=qOWr/grtHIj1V1K+NCTt0HpJP/AofwCqzIkHf3d79hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mblv7DHD9IvkrAApTsDnl40aXVl5qo41uma3D9q78e0fmMER6HJG7Qhnm+uyDI7pP
	 JoguTvkQa1p+sTVUWtrgdYZ+IjVqT4POkPlTdLyKcvMF8/Qxtmg/kJAN+lP4fWE3z8
	 KZhYqMZM1bz6a0OHhjdtfx7YUgv/Ak0VWMCvvWCOavLMT+82821r+OTE7Tqm3WdHYt
	 6ch7v+luemKnkTIpjkMXv2++8bcCVGZqwkd7++6ubi8YSgR04lgsm/plZDSdx7xvXD
	 kD3nMYP1Xm2fIEe5HRSmnx7fM8/K13BvamUZLCAH0S9FFW/gKRIDcMIr7HyFpzblzA
	 kEEB1wSHkKMXw==
Date: Fri, 27 Feb 2026 14:29:50 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/14] ext4: use a byte granularity cursor in
 ext4_mpage_readpages
Message-ID: <20260227222950.GC5357@quark>
References: <20260226144954.142278-1-hch@lst.de>
 <20260226144954.142278-15-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226144954.142278-15-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78801-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44BB41BEB31
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 06:49:34AM -0800, Christoph Hellwig wrote:
> +		block_in_file = EXT4_PG_TO_LBLK(inode, folio->index);
> +		pos = (loff_t)block_in_file << blkbits;

The EXT4_PG_TO_LBLK() expands to:

        (((loff_t)(folio->index) << PAGE_SHIFT) >> (inode)->i_blkbits)

So it calculates the pos as an intermediate step, and we end up with the
redundant pos = (pos >> blkbits) << blkbits.

It probably would make more sense to calculate the pos first, similar to
what other places in this series do:

        pos = folio_pos(folio);                                          
        block_in_file = pos >> blkbits;

- Eric

