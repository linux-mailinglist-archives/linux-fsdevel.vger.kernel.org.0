Return-Path: <linux-fsdevel+bounces-75278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMGBHb1pc2mivQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:29:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB48475CD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93F7E31952B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5164231D725;
	Fri, 23 Jan 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EaCiZh5A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053632FE048
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769171113; cv=none; b=nth+D42nUEjPTE9ZqFbIUZIWTrAMlFwV71iBIRt9+b0oVYoPN5f4/mFW5cq2JxAZtzTh+QQA5NrWrTUTDqpl3lgXA5mXjFMYW0MhaPmDraKNP6HimDva/EAcrSNmQcGoGhrT0vnLMt4PU0Bq6AsIcRL1lhlZwQOWw2fdO2B6tVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769171113; c=relaxed/simple;
	bh=MaHOma0efUDlj0h9t53FX6P5BmsxWu98DpeJ6qmkNLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=cDeucp+lq/z1lPJB9vE3J26fU7iQYewDGCPplLN5/N83SnZz1xjNwOrkNbVUmow8YXW3ssKzPDCPhGnuuEjPBvq/Gy3L7FGLAdFn5riUIO9dKSsu+wNCiOKya764VGrhRiDLLBUn9ZDa3B+NPFOn4+P4RJlHj1C5GxECj8+moPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EaCiZh5A; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260123122510epoutp03c4f4aeafd4e227b7a06ff89b38fcbc11~NW8BTsG0q3124031240epoutp03-
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 12:25:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260123122510epoutp03c4f4aeafd4e227b7a06ff89b38fcbc11~NW8BTsG0q3124031240epoutp03-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769171110;
	bh=SeX3v0qWWpxp41MS12UgsBRF91mTWn1NcAmLb+gsNgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EaCiZh5A+hxpONWmD4ls9BDrI92FWylHWbyuvtfJueTwfJIigoBFaiy5CqByjhkcl
	 q6xaT90OlmFKZN+jPAfxtNBKuD0/1gfBueE+51PNQANMRfJEth2qxZidduimPa5NGV
	 Mn7krHPOouUTNsDrMfaJPO+nB5U4nba9oHd/lzr0=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260123122509epcas5p4eccec6ebc055a3bbdfdc949ba346d3f9~NW8AktzEx3114531145epcas5p4_;
	Fri, 23 Jan 2026 12:25:09 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.93]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dyHFJ3RCgz6B9m7; Fri, 23 Jan
	2026 12:25:08 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260123122508epcas5p391c1fb8720a8f1323860431b93da9a53~NW7-TYNTI3097430974epcas5p3t;
	Fri, 23 Jan 2026 12:25:08 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260123122506epsmtip2c18e842c141830db4d4e99801abb9607~NW798qyeb2585125851epsmtip2K;
	Fri, 23 Jan 2026 12:25:06 +0000 (GMT)
Date: Fri, 23 Jan 2026 17:50:47 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, Qu
	Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/14] block: add helpers to bounce buffer an iov_iter
 into bios
Message-ID: <20260123122047.by424afpy5swmhqw@green245.gost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260119074425.4005867-6-hch@lst.de>
X-CMS-MailID: 20260123122508epcas5p391c1fb8720a8f1323860431b93da9a53
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----uUAw3F.Lk_UAUO08rJsbYBgyLSlm5c8z3L48n3TH2NgWyj3Z=_11efce_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260123122508epcas5p391c1fb8720a8f1323860431b93da9a53
References: <20260119074425.4005867-1-hch@lst.de>
	<20260119074425.4005867-6-hch@lst.de>
	<CGME20260123122508epcas5p391c1fb8720a8f1323860431b93da9a53@epcas5p3.samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75278-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[green245.gost:mid,samsung.com:email,samsung.com:dkim,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anuj20.g@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: DB48475CD9
X-Rspamd-Action: no action

------uUAw3F.Lk_UAUO08rJsbYBgyLSlm5c8z3L48n3TH2NgWyj3Z=_11efce_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 19/01/26 08:44AM, Christoph Hellwig wrote:
>Add helpers to implement bounce buffering of data into a bio to implement
>direct I/O for cases where direct user access is not possible because
>stable in-flight data is required.  These are intended to be used as
>easily as bio_iov_iter_get_pages for the zero-copy path.
>
>The write side is trivial and just copies data into the bounce buffer.
>The read side is a lot more complex because it needs to perform the copy
>from the completion context, and without preserving the iov_iter through
>the call chain.  It steals a trick from the integrity data user interface
>and uses the first vector in the bio for the bounce buffer data that is
>fed to the block I/O stack, and uses the others to record the user
>buffer fragments.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com

------uUAw3F.Lk_UAUO08rJsbYBgyLSlm5c8z3L48n3TH2NgWyj3Z=_11efce_
Content-Type: text/plain; charset="utf-8"


------uUAw3F.Lk_UAUO08rJsbYBgyLSlm5c8z3L48n3TH2NgWyj3Z=_11efce_--

