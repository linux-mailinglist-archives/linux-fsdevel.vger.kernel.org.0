Return-Path: <linux-fsdevel+bounces-75442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIMhGnYKd2lebAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 07:32:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C51FA848C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 07:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D87730028CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6751C2765D7;
	Mon, 26 Jan 2026 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAoQ28br"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB9225A3B;
	Mon, 26 Jan 2026 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769409137; cv=none; b=PqvTiqb7zCRX8s44oMou3V3SuS/BhDZWoSpzzv2MOzo4eg9or2eGrNnVwAAwGy1rASAu281Uru6YPCYyImrQM5QMTnj19IhpW+v8yI0R3/EG8CD5s7g2+hjRSSR7dz8mjtK7qHQUq8MBtQKIDFNjkl0Ez5L1FL6aTynuhQ4htU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769409137; c=relaxed/simple;
	bh=cEiPux5uVHZDoFNzWa4F7vf525z2LRW0mx7NpMS28Bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HX1/3wz5VA6uyZNTjvT+gol+t7WDUxd9Buc/89mFVApGu+38u8vfYcnzj6J8aoybujTarfyYxG4+P5J/uIDXjtRxJs+cI3jcBaP+d18vdUGC8QhpnMpY2/ht7E2duX4aU9Y4oQ/DffhHYriUckS8IXi3T/urnLG97s6OYr8330M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAoQ28br; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675F9C116C6;
	Mon, 26 Jan 2026 06:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769409136;
	bh=cEiPux5uVHZDoFNzWa4F7vf525z2LRW0mx7NpMS28Bw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rAoQ28brH0P0hlGeG2tUYNzcfiI8wN60/J/4MCxdL4soyjrKGNvw8Jr5r2OgCO32X
	 MwlmNYshBnYFo3V7RwEGohaqTSEexCUSqkxOJMhIoR1suWgsEm1DeCgpp8C4ijTJvF
	 1HHBubLl7lyTAsFS9LqZrxeE4WDnwpEAO9oyEuBtWO4A0xCnOqH979pXEeHRhjmP6a
	 YGgMCeEvVve5cGwM69ZnlgSnznuoQBAfOt/jKrU/ecdClpmEsP7fohyp/z9kIClJlJ
	 yCLD8uoaXeCSvPkEL+q29Bq6TY5nbvnGwYaDCCiq5ZW9CK0QccEltWVsUn/apkIVCE
	 VeXoDZs8+owvQ==
Message-ID: <c8ec9ff0-a445-49d1-8b84-6b0ed39c9b92@kernel.org>
Date: Mon, 26 Jan 2026 15:27:16 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] iov_iter: extract a iov_iter_extract_bvecs helper
 from bio code
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260126055406.1421026-1-hch@lst.de>
 <20260126055406.1421026-5-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260126055406.1421026-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75442-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: C51FA848C0
X-Rspamd-Action: no action

On 1/26/26 2:53 PM, Christoph Hellwig wrote:
> Massage __bio_iov_iter_get_pages so that it doesn't need the bio, and
> move it to lib/iov_iter.c so that it can be used by block code for
> other things than filling a bio and by other subsystems like netfs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>


> +ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
> +		size_t max_size, unsigned short *nr_vecs,
> +		unsigned short max_vecs, iov_iter_extraction_t extraction_flags)
> +{
> +	unsigned short entries_left = max_vecs - *nr_vecs;

Do we need to check that *nrvecs > 0 && *nrvecs < max_vecs ?
Also, if *nr_vecs == max_vecs, we should warn and return 0, no ?



-- 
Damien Le Moal
Western Digital Research

