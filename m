Return-Path: <linux-fsdevel+bounces-75391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPjnFSBzdmmcQwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 20:46:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAB18240C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 20:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 483F23001018
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 19:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE1F2FF150;
	Sun, 25 Jan 2026 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j2S+hU8Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FA32FB97D
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jan 2026 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769370394; cv=none; b=ikslvc/ZSftA5GW1rQmdGKI9jH51VpcQjLOebWqLwMbj7tyi3OPQ9Nx7SWKhLwpMSiHA5l0tdP3VKexbn6C5mFf8otgUa3pcm/I9yAQNQUyaLHKBG+YsizRyKY709aMAGq3mx3izL4xSCr2ZZFT+NxAz0sZexRLyiq+V2txz8cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769370394; c=relaxed/simple;
	bh=pnpfW+3fa7GgKGziyGk3v46fN4NDxNkxD05HOURtW1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=byKeDyH5RTz3JhbbHXAOq8RsrS7IiTkyAnHDMzKEhfkp902/k5uCgKpWgvpYygHXzI0gaROe/Yxrlf36ySJYn3+mFj3gib/+r+mdUQZ6VE4B82HyBItlkjAvIRl66Z41bbrNvkGhLVdbE7CPm8QBb3EiTuxn95Gl6GQ2ymyK3VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=j2S+hU8Q; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260125194624epoutp034bba08de47b6dbd1f13644d88ab4fdfa~OEP2Chg2G2247022470epoutp03N
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jan 2026 19:46:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260125194624epoutp034bba08de47b6dbd1f13644d88ab4fdfa~OEP2Chg2G2247022470epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769370384;
	bh=01TZlvzYtBsjbZhLHZ4rreHMj5t508L0uHzvLErt79E=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=j2S+hU8Q9aMda7RiAShlaT0F3weoz3hQBBtjrHTxqT2U52GrKIbfIiVKzJ9rjNdFK
	 myD6VSCIsAutEWqOoFTeV4nOYDx7/75fA30YIBJBJ7Ft3BN7bJOcjgzcloqv+BmwKK
	 GIPmUJJ2t7yielrk92nlp+dSloeTkgNqn+pjfs8I=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260125194623epcas5p2a76fe24f719fb026c9131beda0b5d7f7~OEP1XVGHq0871508715epcas5p20;
	Sun, 25 Jan 2026 19:46:23 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.92]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4dzhxW1T0Tz3hhT3; Sun, 25 Jan
	2026 19:46:23 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260125194622epcas5p2a833c6825df4933f14d0cdf4deba1296~OEPz-Ifgh0871508715epcas5p2z;
	Sun, 25 Jan 2026 19:46:22 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260125194619epsmtip1b8917c6c089783eb7d6bdeb2b45b1180~OEPxb2Ly80686606866epsmtip1c;
	Sun, 25 Jan 2026 19:46:19 +0000 (GMT)
Message-ID: <513ddb72-b891-48a7-a2e0-4b8a983580bf@samsung.com>
Date: Mon, 26 Jan 2026 01:16:17 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] block: factor out a bio_integrity_action helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Christian
	Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta
	<anuj20.g@samsung.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260121064339.206019-2-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260125194622epcas5p2a833c6825df4933f14d0cdf4deba1296
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260121064649epcas5p1ce059a9a4bd5a10b231bd5fa87df87f7
References: <20260121064339.206019-1-hch@lst.de>
	<CGME20260121064649epcas5p1ce059a9a4bd5a10b231bd5fa87df87f7@epcas5p1.samsung.com>
	<20260121064339.206019-2-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75391-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:email,samsung.com:dkim,samsung.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshi.k@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: DFAB18240C
X-Rspamd-Action: no action

On 1/21/2026 12:13 PM, Christoph Hellwig wrote:
> +	case REQ_OP_WRITE:
> +		/*
> +		 * Flush masquerading as write?
> +		 */
> +		if (!bio_sectors(bio))
> +			return 0;
> +

Earlier this check was happening for REQ_OP_READ too but not sure 
whether that was superfluous or actually filtering out zero-sector 
reads. For everything else,

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>



