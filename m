Return-Path: <linux-fsdevel+bounces-76164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJZ5LbSjgWnuIAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 08:28:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3984D5B21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 08:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C3433003BE4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 07:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C873921C0;
	Tue,  3 Feb 2026 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WX4Yqe79"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49234392814
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 07:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770103726; cv=none; b=YgmEhmk1PSurg1HR8i9+++Eo4a4wqoGxgl2j4eeh2N6WXpldVCtnXJlhJfLtfPrjGLFvX6i5mCSaVDar0MsXDnw1MJgW/R7yln0UjGQ3C4k3loHwu8daapncdDtla2H9YjVN4VM4KQD4XozPYYV3cxHy7J8jC/iU+NOGz9RhcPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770103726; c=relaxed/simple;
	bh=bbNZ7NIwDBvrQMoRulPfQNw2JKiEB5LPYaqB36YjD/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=A1umVq8FTJ9LWv+2moSdKF46QNSI0FiwnqgjeZLebvIcS9miyARi6gjhsRz1lgIX/PLypHNE6BIO6IXAbi0Pz+imJUeeKhmQ/VlFiUI9ubcQLTwnh/+YX/bYhPnRDzuSVazCFLfacCuWv6Z1AWGLFi9aLh+P1vL+wjBCwiGtW7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WX4Yqe79; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260203072841epoutp02d4eb7cc8b23c81d93b02c99f1033c349~Qq-THybVm2142921429epoutp02B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 07:28:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260203072841epoutp02d4eb7cc8b23c81d93b02c99f1033c349~Qq-THybVm2142921429epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770103721;
	bh=hVnXV5I1ungw4oMzJjmOhnnPWVP5XkxXpd/tF3zKk2U=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=WX4Yqe79e+sqXjef+Sh+x/yUXP/GYVAitaXMBt05wbkhGni2dyzuxqIa/b+Io0X8l
	 4BBr/zf2CGXlQqXqaA3y50iKZQwJRI9GQiq8wMipWYgdmHFIKDsWxMR3YfDyxKSNx4
	 He9vfRFZhbgXyq+GLOz4Exfvzxo9R9auvz98CR1U=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260203072840epcas5p3b5d281879db8a64669f9c7123300df04~Qq-SYfO8L0974709747epcas5p34;
	Tue,  3 Feb 2026 07:28:40 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.92]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4f4w872S54z2SSKb; Tue,  3 Feb
	2026 07:28:39 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260203072838epcas5p1076f207b2f19cada65df4a04ead3408e~Qq-QP4EUR2252922529epcas5p1l;
	Tue,  3 Feb 2026 07:28:38 +0000 (GMT)
Received: from [107.111.86.57] (unknown [107.111.86.57]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260203072835epsmtip1689fa13a25b0afd7d679874f42ec2e2e~Qq-Ndf7TL2522925229epsmtip1U;
	Tue,  3 Feb 2026 07:28:35 +0000 (GMT)
Message-ID: <7dc267e7-b6e0-4be2-a60e-9d90dcf472eb@samsung.com>
Date: Tue, 3 Feb 2026 12:58:34 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] xfs: tag folios with AG number during buffered
 write via iomap attach hook
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	dave@stgolabs.net, cem@kernel.org, wangyufei@vivo.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, gost.dev@samsung.com, anuj20.g@samsung.com,
	vishak.g@samsung.com, joshi.k@samsung.com
From: Kundan Kumar <kundan.kumar@samsung.com>
In-Reply-To: <20260129004745.GC7712@frogsfrogsfrogs>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260203072838epcas5p1076f207b2f19cada65df4a04ead3408e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260116101256epcas5p2d6125a6bcad78c33f737fdc3484aca79
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
	<CGME20260116101256epcas5p2d6125a6bcad78c33f737fdc3484aca79@epcas5p2.samsung.com>
	<20260116100818.7576-5-kundan.kumar@samsung.com>
	<20260129004745.GC7712@frogsfrogsfrogs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com,vger.kernel.org,kvack.org,samsung.com];
	TAGGED_FROM(0.00)[bounces-76164-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,samsung.com:dkim,samsung.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kundan.kumar@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E3984D5B21
X-Rspamd-Action: no action

On 1/29/2026 6:17 AM, Darrick J. Wong wrote:
> On Fri, Jan 16, 2026 at 03:38:16PM +0530, Kundan Kumar wrote:
>> Use the iomap attach hook to tag folios with their predicted
>> allocation group at write time. Mapped extents derive AG directly;
>> delalloc and hole cases use a lightweight predictor.
>>
>> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>> ---
>>   fs/xfs/xfs_iomap.c | 114 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 114 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index 490e12cb99be..3c927ce118fe 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -12,6 +12,9 @@
>>   #include "xfs_trans_resv.h"
>>   #include "xfs_mount.h"
>>   #include "xfs_inode.h"
>> +#include "xfs_alloc.h"
>> +#include "xfs_ag.h"
>> +#include "xfs_ag_resv.h"
>>   #include "xfs_btree.h"
>>   #include "xfs_bmap_btree.h"
>>   #include "xfs_bmap.h"
>> @@ -92,8 +95,119 @@ xfs_iomap_valid(
>>   	return true;
>>   }
>>   
>> +static xfs_agnumber_t
>> +xfs_predict_delalloc_agno(const struct xfs_inode *ip, loff_t pos, loff_t len)
>> +{
>> +	struct xfs_mount *mp = ip->i_mount;
>> +	xfs_agnumber_t start_agno, agno, best_agno;
>> +	struct xfs_perag *pag;
>> +
>> +	xfs_extlen_t free, resv, avail;
>> +	xfs_extlen_t need_fsbs, min_free_fsbs;
>> +	xfs_extlen_t best_free = 0;
>> +	xfs_agnumber_t agcount = mp->m_sb.sb_agcount;
>> +
>> +	/* RT inodes allocate from the realtime volume */
>> +	if (XFS_IS_REALTIME_INODE(ip))
>> +		return XFS_INO_TO_AGNO(mp, ip->i_ino);
>> +
>> +	start_agno =  XFS_INO_TO_AGNO(mp, ip->i_ino);
>> +
>> +	/*
>> +	 * size-based minimum free requirement.
>> +	 * Convert bytes to fsbs and require some slack.
>> +	 */
>> +	need_fsbs = XFS_B_TO_FSB(mp, (xfs_fsize_t)len);
>> +	min_free_fsbs = need_fsbs + max_t(xfs_extlen_t, need_fsbs >> 2, 128);
>> +
>> +	/*
>> +	 * scan AGs starting at start_agno and wrapping.
>> +	 * Pick the first AG that meets min_free_fsbs after reservations.
>> +	 * Keep a "best" fallback = maximum (free - resv).
>> +	 */
>> +	best_agno = start_agno;
>> +
>> +	for (xfs_agnumber_t i = 0; i < agcount; i++) {
>> +		agno = (start_agno + i) % agcount;
>> +		pag = xfs_perag_get(mp, agno);
>> +
>> +		if (!xfs_perag_initialised_agf(pag))
>> +			goto next;
>> +
>> +		free = READ_ONCE(pag->pagf_freeblks);
>> +		resv = xfs_ag_resv_needed(pag, XFS_AG_RESV_NONE);
>> +
>> +		if (free <= resv)
>> +			goto next;
>> +
>> +		avail = free - resv;
>> +
>> +		if (avail >= min_free_fsbs) {
>> +			xfs_perag_put(pag);
>> +			return agno;
>> +		}
>> +
>> +		if (avail > best_free) {
>> +			best_free = avail;
>> +			best_agno = agno;
>> +		}
>> +next:
>> +		xfs_perag_put(pag);
>> +	}
>> +
>> +	return best_agno;
>> +}
>> +
>> +static inline xfs_agnumber_t xfs_ag_from_iomap(const struct xfs_mount *mp,
>> +		const struct iomap *iomap,
>> +		const struct xfs_inode *ip, loff_t pos, size_t len)
>> +{
>> +	if (iomap->type == IOMAP_MAPPED || iomap->type == IOMAP_UNWRITTEN) {
>> +		/* iomap->addr is byte address on device for buffered I/O */
>> +		xfs_fsblock_t fsb = XFS_BB_TO_FSBT(mp, BTOBB(iomap->addr));
>> +
>> +		return XFS_FSB_TO_AGNO(mp, fsb);
>> +	} else if (iomap->type == IOMAP_HOLE || iomap->type == IOMAP_DELALLOC) {
>> +		return xfs_predict_delalloc_agno(ip, pos, len);
> 
> Is it worth doing an AG scan to guess where the allocation might come
> from?  The predictions could turn out to be wrong by virtue of other
> delalloc regions being written back between the time that xfs_agp_set is
> called, and the actual bmapi_write call.
> 

The delalloc prediction works well in the common cases: (1) when an AG 
has sufficient free space and allocations stay within it, and (2) when 
an AG becomes full and allocation naturally moves to the next suitable AG.

The only case where the prediction can be wrong is when an AG is in the
process of being exhausted concurrently with writeback, so allocation
shifts between the time we tag the folio and the actual bmapi_write.
My understanding is that window is narrow, and only a small fraction of 
IOs would be misrouted.

>> +	}
>> +
>> +	return XFS_INO_TO_AGNO(mp, ip->i_ino);
>> +}
>> +
>> +static void xfs_agp_set(struct xfs_inode *ip, pgoff_t index,
>> +			xfs_agnumber_t agno, u8 type)
>> +{
>> +	u32 packed = xfs_agp_pack((u32)agno, type, true);
>> +
>> +	/* store as immediate value */
>> +	xa_store(&ip->i_ag_pmap, index, xa_mk_value(packed), GFP_NOFS);
>> +
>> +	/* Mark this AG as having potential dirty work */
>> +	if (ip->i_ag_dirty_bitmap && (u32)agno < ip->i_ag_dirty_bits)
>> +		set_bit((u32)agno, ip->i_ag_dirty_bitmap);
>> +}
>> +
>> +static void
>> +xfs_iomap_tag_folio(const struct iomap *iomap, struct folio *folio,
>> +		loff_t pos, size_t len)
>> +{
>> +	struct inode *inode;
>> +	struct xfs_inode *ip;
>> +	struct xfs_mount *mp;
>> +	xfs_agnumber_t agno;
>> +
>> +	inode = folio_mapping(folio)->host;
>> +	ip = XFS_I(inode);
>> +	mp = ip->i_mount;
>> +
>> +	agno = xfs_ag_from_iomap(mp, iomap, ip, pos, len);
>> +
>> +	xfs_agp_set(ip, folio->index, agno, (u8)iomap->type);
> 
> Hrm, so no, the ag_pmap only caches the ag number for the index of a
> folio, even if it spans many many blocks.
> 
> --D
> 

Thanks for pointing out, I will rework to handle this case.

>> +}
>> +
>>   const struct iomap_write_ops xfs_iomap_write_ops = {
>>   	.iomap_valid		= xfs_iomap_valid,
>> +	.tag_folio		= xfs_iomap_tag_folio,
>>   };
>>   
>>   int
>> -- 
>> 2.25.1
>>
>>
> 


