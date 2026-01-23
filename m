Return-Path: <linux-fsdevel+bounces-75252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sITZLdE5c2kFtgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 10:05:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9EB72F44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 10:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D4203040308
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A7832FA3F;
	Fri, 23 Jan 2026 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWbVwJt2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258CF2EFDA4;
	Fri, 23 Jan 2026 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158849; cv=none; b=XtkVAIiVrls+btVP/rff8Epl974xwLkeRPSibSt4V9BMRqxdFWMwqxzUeFP/BrR3fFvWYPfgLMROeSXCar3fNCKTU7+LOofRDH+DhX3h6ozM3LXfb6aZHYNMvwQC43m7HZGbYNilVtJWS5F81wJWJOCkTBGL8WAyCU5nrKX67Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158849; c=relaxed/simple;
	bh=pToJvEtdbpwdGl5lnBQ6BjWknjdVmmPbW2qjatpsbIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FrsqBVRTFic11za5+ddYF+CXKpv2iHlHxINkVOP/K4gAIbkT5p84jhKQEJj0gity2zRZcfMb+vApFCenCKhtVdagj58xj16Q6Ve/RPxtuf5e0os35uh2nkHNhv1gzJSIbs630eUtbR753RcJMQJi5aJ5EWtNEfVT5aOfvmS7wFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWbVwJt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3E4C4CEF1;
	Fri, 23 Jan 2026 09:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769158848;
	bh=pToJvEtdbpwdGl5lnBQ6BjWknjdVmmPbW2qjatpsbIY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GWbVwJt2RlBGELCZzuT/f6PYMnxU9T0jWbhdg/+IrHokoU4raKG2Z84F6lliAon8f
	 T7nxEMeFtQv9xZm1jLtfxi2/QqrTWsB5mex2/OpxZ6Ai0gbZ4+dpixNlGaYGbQ+u5S
	 7mn1M/qyBSpyyrxQ1MfjkrvDbQl8URwCz7A8mG3nrMnrTuYv53MvXUggvY+yKWnf2+
	 nxwnpETh2w4BQpb63XHylJEW6QPyI/h/Nd/XS7SMrgZd6U4vecpQ+SmoFiqDkJWgow
	 b24lEbC6PJVdj8DDU8GQr/auVQPfyNbCJgg/17uNFSgcfNl8sf5VOwhdUV8zKVbPJS
	 C1Q4tGnb8xEqg==
Message-ID: <48b4f230-ff67-4cf9-9873-6b7b95c04e5a@kernel.org>
Date: Fri, 23 Jan 2026 20:00:44 +1100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] iomap: rename IOMAP_DIO_DIRTY to
 IOMAP_DIO_USER_BACKED
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-12-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260119074425.4005867-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75252-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B9EB72F44
X-Rspamd-Action: no action

On 2026/01/19 18:44, Christoph Hellwig wrote:
> Match the more descriptive iov_iter terminology instead of encoding
> what we do with them for reads only.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

