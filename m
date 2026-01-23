Return-Path: <linux-fsdevel+bounces-75245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAo1G0k1c2lItAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:46:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E598572B32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2D22301CFEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7682C11C6;
	Fri, 23 Jan 2026 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzJ/YhhK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C5E3EBF3B;
	Fri, 23 Jan 2026 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157957; cv=none; b=c76YTwGl9D8a9sVCadjTSWwZ1kaytB5kBQaRlawISb/XyZ0D+u+mUXhwuH8vMsIoD1ZDic2N8zTyXpgvnFl0Y2RvgkEu44OvlizPCsjESryy5645t3n2DURulFlXkHf/HiOsMG9PQpid4vX83PH9zQCh5hLRT7DU6BH1ZBaB77Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157957; c=relaxed/simple;
	bh=NVC/nIB8Ob0bKGjmOr7ocSkX4ZAvDbuXj9iNGRRIz+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KAfDY3z8HPArjyn2DPN/Dyj/TT1f+nGwjiXCYx/7WQC9cbZGsmkBDLMCxP8yqsTsh7rMGIep/evkfVWybLOhEdvl6eU1QGYUUORLd1dcrVV1rCjpaXxxYvznKV8UaBLI9CL/rZwQs+m/N8ZmGCjJixtufnYpUPs/IA5aMOHzUFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzJ/YhhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC62EC4CEF1;
	Fri, 23 Jan 2026 08:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769157957;
	bh=NVC/nIB8Ob0bKGjmOr7ocSkX4ZAvDbuXj9iNGRRIz+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BzJ/YhhKdQ5mT4pBGG/HGmkZLNlr3C5obrNvGixbm4+zlnSmuKSXMZ/JfV23LUWWl
	 cY9sbId7lR5qiosT9mXeFN7a+m8aOHbtuaxNLaFofg/+ryd3EyGbAkxNPvsQBoj7TN
	 zDQl+AOW7yO9grDng6rAix1a9NAQowRjdUuxxsazh4qPHu3TqwrXMMxtplHjraRvlB
	 myFPxCcgQKKV6wzBXxhqPzLeZDeBRSjZ7W8LwDNdrtldA6IPG2/73pFW8oXnZ2Olwm
	 /FA38wwuQJ4WmB/tVMPA8VlelfOUl9gWePTCQgCUO5p9MbOdkXCIN/ts1CswWKL+6P
	 tvzdqBVPxxDHQ==
Message-ID: <2e85080d-d056-4cc9-99b2-46b8b571d943@kernel.org>
Date: Fri, 23 Jan 2026 19:45:52 +1100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] block: refactor get_contig_folio_len
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-2-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260119074425.4005867-2-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-75245-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: E598572B32
X-Rspamd-Action: no action

On 2026/01/19 18:44, Christoph Hellwig wrote:
> Move all of the logic to find the contigous length inside a folio into
> get_contig_folio_len instead of keeping some of it in the caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

