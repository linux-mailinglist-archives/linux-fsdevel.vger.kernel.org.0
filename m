Return-Path: <linux-fsdevel+bounces-75845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOQ0HyAoe2nRBwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 10:28:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 283BCAE20B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 10:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4422302D134
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 09:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2A637998A;
	Thu, 29 Jan 2026 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GzzAzzTV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3D737C0EB
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678847; cv=none; b=dOo1y1Bwl2h2rk35RZarANelkEQUZOguXT0NgjVzUAU5lRmnOTyaeGwyoY9wxDS5+3feSf95ukFh8TVOr0SYwhPqgUjVf3PFoaA68HTLtaeHspWslQ6cn7Hs5zcOTT0oDtobT5IzcFY9KuunGs9qQJd2tTnMyRkwb+8kPiBu+kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678847; c=relaxed/simple;
	bh=4bRaTgrCKseoLnMwWid7iSb2X5Y0CMnCnaMIQDLYSAw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=XqWaTpnr6Xfbu8ZDDJ1+4Rdp13b3AGPYGUrDrFfnMlKURL9SjITQGu3mdWHb3C2gw/7a3RJYi8WwPC6aJmjNUYKN5SiKp6EPu869elS7hvPJXFpZIv16AMcTaj3zDYBfaQf8W61CfANPda3OF9ybXD6l7rq3WwQNHoRLpBqRTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GzzAzzTV; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260129092724epoutp038172e3db59d89f32134908651904d12e~PKYhgbHwd0459904599epoutp031
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 09:27:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260129092724epoutp038172e3db59d89f32134908651904d12e~PKYhgbHwd0459904599epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769678844;
	bh=HTJkzz/t9Yvine6k3rYUCcimE1lwu9jEJYFkbVE5xQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GzzAzzTVXzlBQLcffAa6J4diAS2/dcKB9/cCFco2XOO6/hCKRPCrjmuuLQsRxD/ZM
	 lP73gbJdsDnsgnXQcfO6VHflm4/8wNP9Chs+Vvk4C0kWqEw/158wqIDR7IhE/8ylsf
	 4tlt6ECACReaM66Pu2bEbcpp31HCX+4Er5ZCKhKQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260129092723epcas5p17ea68069b8cddc520c61ea4540435011~PKYhIRM8v2500625006epcas5p1j;
	Thu, 29 Jan 2026 09:27:23 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.90]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4f1v1Q6K97z6B9mC; Thu, 29 Jan
	2026 09:27:22 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260129092722epcas5p262db49c6db5e12931dc0433090b20e57~PKYfn3rZJ2444824448epcas5p2R;
	Thu, 29 Jan 2026 09:27:22 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260129092720epsmtip186b0b3daa7cec921ec0d647610f08fd1~PKYeDuLvH0871908719epsmtip1L;
	Thu, 29 Jan 2026 09:27:20 +0000 (GMT)
Date: Thu, 29 Jan 2026 14:53:06 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Anuj gupta <anuj1072538@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
	<djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: support file system generated / verified integrity information
Message-ID: <20260129092306.7kxrizlwwk2ee756@green245.gost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260127151609.GA1883@lst.de>
X-CMS-MailID: 20260129092722epcas5p262db49c6db5e12931dc0433090b20e57
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_136471_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260129092722epcas5p262db49c6db5e12931dc0433090b20e57
References: <20260121064339.206019-1-hch@lst.de>
	<CACzX3AuDkwEw3v0bNmYLk8updk1ghVJa-T9o=EHXor9FA7badw@mail.gmail.com>
	<20260127151609.GA1883@lst.de>
	<CGME20260129092722epcas5p262db49c6db5e12931dc0433090b20e57@epcas5p2.samsung.com>
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
	TAGGED_FROM(0.00)[bounces-75845-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,kernel.org,oracle.com,samsung.com,vger.kernel.org,lists.linux.dev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[green245.gost:mid,samsung.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anuj20.g@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 283BCAE20B
X-Rspamd-Action: no action

------bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_136471_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 27/01/26 04:16PM, Christoph Hellwig wrote:
>On Tue, Jan 27, 2026 at 08:24:28PM +0530, Anuj gupta wrote:
>> Hi Christoph,
>>
>> Here are the QD1 latency numbers (in usec)
>
>Thanks a lot!
>
>Adding in the baseline numbers, as I wanted to compare those:
>
>> Intel Optane:
>>
>> Sequential read
>>   | size | baseline | xfs-bounce |  xfs-pi  |
>>   +------+----------+-----------+-----------+
>>   |   4k |    7.18  |    13.62   |     7.20 |
>>   |  64K |   36.40  |    99.66   |    34.16 |
>>   |   1M |  206.38  |   258.88   |   306.23 |
>>   +------+----------+------------+----------+
>
>So for 4k and 64k reads we basically get back to the baseline.
>The 1M numbers are puzzling, though.  I wonder if we need to
>add WQ_CPU_INTENSIVE or do some other tweaks to the XFS I/O
>completion workqueue so that we don't overload the scheduler.

Tried adding WQ_CPU_INTENSIVE[1] but didn't see any change in the 1M
latency. Looks like this needs something beyond just workqueue tuning.

------bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_136471_
Content-Type: text/plain; charset="utf-8"


------bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_136471_--

