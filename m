Return-Path: <linux-fsdevel+bounces-77560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKdMGQ6alWk1SgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 11:53:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C62155AC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 11:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC100301A407
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 10:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BBA302773;
	Wed, 18 Feb 2026 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MYGC1Pxj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52BE2C21ED
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771411976; cv=none; b=rUzIQQcmshg5xm4aLs5vnhw80Cv/VoOReYD3AEFGTPy3FDvnV3wOsv8oEOBaVjIDA6/Um7hQthj38iYnCOrT7sXU00mVwbtzigipdJn04g3GFn3eu0UmrXOUqRWz345nC65g520gGxNTJ/S0kgcIZdhSLWiC7Hd1/Py1O0KtiPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771411976; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=oa1SCYLkUOW7TfWXL+Ct7wEgCo3SFXb4T/Iwb6uXRfN1xOq7r0oaR6e2sygMc0vGH6SKIaA6RzioOJ7FHWqxPHWBv/1ag2sFyPS3cfX3W3byjUbrEkBKWmuPDz8Vdgy2f4ddHF8OC3wwwX22Jzyu7Mghh44BtjOKD4/1wlsN5AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MYGC1Pxj; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260218105252epoutp03e4dd8cda86817b563953e92d94960edb~VUc3Pi-4B2913729137epoutp03X
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 10:52:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260218105252epoutp03e4dd8cda86817b563953e92d94960edb~VUc3Pi-4B2913729137epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1771411972;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=MYGC1PxjznuhiOWZu70tL4bYSlPmvjJ5fGp7ptC6gLYqdx1l7RKpNU69WhRXkh0TH
	 6WydTKrvq7cj3KUxBMpVB59u+9t+tR0lSgd+qBYUyXcHNwMV/rHBSlyIjlImotWKPP
	 9oRd7nDLpBMKXQNg6acGUvjn0o7zDuNfhzpWnyVg=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260218105252epcas5p2a1cd5fd4a4fa3e5a71cbbe99421ef9b6~VUc2nkLM00982209822epcas5p2x;
	Wed, 18 Feb 2026 10:52:52 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.91]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4fGCyq3G6Xz6B9m6; Wed, 18 Feb
	2026 10:52:51 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260218105250epcas5p3d63a86bf5f61784ccd0f02bbaf2cd280~VUc1PEMui1692816928epcas5p3V;
	Wed, 18 Feb 2026 10:52:50 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260218105249epsmtip10a20eda6b4f4ae6e5d841b750a3e92d2~VUczwmyvL1133211332epsmtip11;
	Wed, 18 Feb 2026 10:52:48 +0000 (GMT)
Message-ID: <e40e6a2f-a03a-4133-b863-a88df0b967cf@samsung.com>
Date: Wed, 18 Feb 2026 16:22:48 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] block: pass a maxlen argument to
 bio_iov_iter_bounce
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Christian
	Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta
	<anuj20.g@samsung.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260218061238.3317841-8-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260218105250epcas5p3d63a86bf5f61784ccd0f02bbaf2cd280
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260218061322epcas5p2ad69ece4b346b48d47f90a52a120801e
References: <20260218061238.3317841-1-hch@lst.de>
	<CGME20260218061322epcas5p2ad69ece4b346b48d47f90a52a120801e@epcas5p2.samsung.com>
	<20260218061238.3317841-8-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:mid,samsung.com:dkim,samsung.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77560-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshi.k@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 81C62155AC7
X-Rspamd-Action: no action

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

