Return-Path: <linux-fsdevel+bounces-73054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5166DD0A8E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 15:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C862430A4EC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 14:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A49835CB60;
	Fri,  9 Jan 2026 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="agw0EE83";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YvEI+4KZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA2154763;
	Fri,  9 Jan 2026 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767967541; cv=none; b=bvAkU6DANy45jq6SFvFPHJwgL+fBF37kSAXxTN/Ou1FQPB0j+YRu9Y/TI5pm1hEOCUS4VdRl/loSRFd7L9VX74WBr9cec7KBfKLOfdc5ppIte4EKbHsqjmpKpbiBwgLW288Evi+mDvEPfIGNDevpqQBL93/iyj8qkUm2+RFvKrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767967541; c=relaxed/simple;
	bh=EW4O/9J1aIXJ4HtWuJcqaXNpb4hWL9cAw4Gp+AV6Reo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNgbjM2XJmX22Edv7JWcAfDuf3nfSC3u9QZYEUH5/HRUAg+axh1Js1aqexixDlvb/guPQ2WUeLl5tj6vP42N37DNfTgW261EUOetF8kYLjLhl8xUlVPm9MjtPjhLDeh6wtgV2Egr1dQKHsBNd/AY7DZ8FSWZ6Cygp25dwNQjuas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=agw0EE83; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YvEI+4KZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6085E1400161;
	Fri,  9 Jan 2026 09:05:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 09 Jan 2026 09:05:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767967539;
	 x=1768053939; bh=LspvIQOp1XzYtUwT5/9Tf0sLV2m9KYU+F9UTn0mtc3Y=; b=
	agw0EE83nUdNsBxsjhKddC2R2ldG/Y8dWmyoSXauF6tYLqZS15TbA8wl6GCZVZhl
	tJQ624pBzpfAQPMNlLSFAQdXvDgZ403uYifm/RtxPTlVXH/AQohA5g2eVBlNsdvy
	jVHKhNY+jHvfS26abaomHiuUVimc6vcfcPy4GqJansU62gp7zbpKy7oHiKy/7da9
	vcbcIDUDmoKRY9P1AfV+kP2veTlgZdgEKMH8YQr24/v4YSakNvtsFrUdqNUcoxe2
	jUm0lGgnSQS80LUvCnCKIboHJjh68Px88EVrSXhCvHeCjHuYG5LxUvyl4seQL3Nv
	O5gpq/GCCp0vfpW4bqIFvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767967539; x=
	1768053939; bh=LspvIQOp1XzYtUwT5/9Tf0sLV2m9KYU+F9UTn0mtc3Y=; b=Y
	vEI+4KZ5xu7u5K7b/mkbUS3EN62ZT2EtNLjIDOUkuSvkaV8/QJRQYqGQd6C5ToMP
	2cW4mHC5h4NNdXNQTuWmEOHDNnNyO8gaIzGMA3ZP6f5nsrgTsONZAXK9JGqDw481
	58BIutT1XO1mTqdWeAlPbg5euBd3sV3T3zUK2devb6l2JBKvm8mfsU++ibIOLTug
	ZpIPs8LvS5AlYOzuGNw2DyShwcC9tJaj4JJzzteP3fNDs7KVOYPzPPK7SPk6E/2T
	+TGYAiVNbNo/OdIPzdQsZq4U225dOL97B+07vg7RTPnsjBANGGe03eLD7oammV9A
	9059S7AKCYHse/UIhyCsQ==
X-ME-Sender: <xms:MgthafUsUc_YcAOpGz-tRf9bkm3qAKg3mSBaHl9aIj2e7tyg3NAemw>
    <xme:MgthaQiczB832Xo859WNDgc9ZpIeeLH1pN25X8N1XjP_QSiDr5lKdKQ6n5aPJvPIo
    M07AD4qxq0xBVgqG1lFeFEdEustrQytzE4uxB_7CqKKOOgVvaoTlQ>
X-ME-Received: <xmr:MgthaW_n5nunqvBoC4intVq5ZojU2x0UIVuCIQLfq3ir2zyNz03N5V9s6OWH-wGGMQ166cuNwEPsMc7IxiFiKrNX74b8pbW3EBhJBt_eVcbQyHgSSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeltddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejre
    dttddvjeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugessghs
    sggvrhhnugdrtghomheqnecuggftrfgrthhtvghrnhephefhjeeujeelhedtheetfedvgf
    dtleffuedujefhheegudefvdfhheeuveduueegnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtghomhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgvfhhf
    lhgvgihusehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepmhhikhhloh
    hssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghstghhuhgsvghrthesuggunh
    drtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:MgthaaaFA8nL14YHTAsOQH2EovK9bfitJOb1VOYEE_S9yEMtploK1A>
    <xmx:MgthaV1mXjIunbiBBTADPtEC8CDhEdrhVrWS_cUGsY0n1XnenGbATg>
    <xmx:MgthaVaT0ik7jK3p2E7hA8AVhwz2EI702yITHVkjBYltWpXMbYyYmw>
    <xmx:MgthadLOxcxOKj3rDcvD41Y-OTg7TPEe17uiEaQ-xL9rnPrsA6F6NA>
    <xmx:Mwthaa7rmxiO4pXr-PIORLdbFxfQALJdav40F916K396tAxB-8TRi3n_>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 09:05:38 -0500 (EST)
Message-ID: <b8f7dd35-7702-4c70-be4f-0704abc1976d@bsbernd.com>
Date: Fri, 9 Jan 2026 15:05:36 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: invalidate the page cache after direct write
To: Jingbo Xu <jefflexu@linux.alibaba.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, bschubert@ddn.com
Cc: linux-kernel@vger.kernel.org
References: <20260109070110.18721-1-jefflexu@linux.alibaba.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260109070110.18721-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/9/26 08:01, Jingbo Xu wrote:
> -	return err ?: ia->write.out.size;
> +	/*
> +	 * As in generic_file_direct_write(), invalidate after the write, to
> +	 * invalidate read-ahead cache that may have competed with the write.
> +	 * Without FOPEN_DIRECT_IO, generic_file_direct_write() does the
> +	 * invalidation for synchronous write.
> +	 */
> +	if (!err && written && mapping->nrpages &&
> +	    ((ff->open_flags & FOPEN_DIRECT_IO) || !ia->io->blocking)) {
> +		invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
> +					(pos + written - 1) >> PAGE_SHIFT);
> +	}
> +
> +	return err ?: written;
>  }

Sorry, but I'm confused about "|| !ia->io->blocking". When we go into this
code path it either via generic_file_direct_write(), which then
already invalidates or directly and then 
(ff->open_flags & FOPEN_DIRECT_IO) is set?


Thanks,
Bernd



