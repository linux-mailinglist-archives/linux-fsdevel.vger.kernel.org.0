Return-Path: <linux-fsdevel+bounces-76163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPJyMuihgWmJIAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 08:21:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 055BFD5A7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 08:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D668030028EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 07:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7D13921F6;
	Tue,  3 Feb 2026 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FtDqY0jO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B1338F22E
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770103267; cv=none; b=VBq9tUUC4JKu1R/PvRbWL9D3zKo9rEP8BzMQ6qhM5fDiAM0N3OuSXHmLRAD2AkJTXVOvvOU4o0HhcEr4Sj12FFBCTu0a05isl2hlgzBkTALBGjdlfVDN7lREy4UnJ1VrY4zAOtxXQ5InHDivqXADx8Nry5+MiNFFVDTpZ8+tfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770103267; c=relaxed/simple;
	bh=uKcHvwJ2vE/MavK0G4hw29ISn3VqewE5bb6skSgnXKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=GI0ZOktWD5VBPcqf+XQLya42r0YL9HyoBXUTSvwNNfhWni8I4Rfp73gIHfOz1qL1kESvXNJuqpL9QYzlap2tx6hn+Oipr24kGSd1ll1a14DGXwhNvr2erWTyiU/wUBhO6ah9x71xBHRm8MWb885dSHOW+3S8qqCsZhblLwJGvak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FtDqY0jO; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260203072102epoutp0290d1f712f407983a450612a87006aa9b~Qq4oGPJ5C1237512375epoutp02G
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 07:21:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260203072102epoutp0290d1f712f407983a450612a87006aa9b~Qq4oGPJ5C1237512375epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770103262;
	bh=fU5UyW4TQBK4QZd2CbsYlFx1O86s7n1w5wLjdGsNZ+A=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=FtDqY0jO+eLa9u3h4UKS4StbEmZBUfqc82VxuvSvynZ87jXBtdJdPE0cdFrSNgzuL
	 +enY5i3DeVdavugczdsrGAGQTyJ43A/YArU8TGkKv/icsvI1Yq/CFk11BBVE/Vs9ka
	 1oPd9b94SHLzqaVX5Vkx084Q68WSxqOTpLbSuXNo=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260203072102epcas5p1c5d76f538d2ab9b98fc1da3fc8f740ca~Qq4nc4qhl2896128961epcas5p11;
	Tue,  3 Feb 2026 07:21:02 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.90]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4f4vzJ60CMz6B9mX; Tue,  3 Feb
	2026 07:21:00 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260203072100epcas5p1a872be2e07362e5a2206231d7bf44630~Qq4lnf84l1044110441epcas5p1U;
	Tue,  3 Feb 2026 07:21:00 +0000 (GMT)
Received: from [107.111.86.57] (unknown [107.111.86.57]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260203072054epsmtip25565e34a3716ee5a6822dcc5c6176bb6~Qq4gwBjnd2486424864epsmtip2i;
	Tue,  3 Feb 2026 07:20:54 +0000 (GMT)
Message-ID: <2c485586-83c9-4697-91fc-7b0cee697704@samsung.com>
Date: Tue, 3 Feb 2026 12:50:53 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] xfs: add per-inode AG prediction map and
 dirty-AG bitmap
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
In-Reply-To: <20260129004404.GA7712@frogsfrogsfrogs>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260203072100epcas5p1a872be2e07362e5a2206231d7bf44630
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260116101251epcas5p1cf5b48f2efb14fe4387be3053b3c3ebc
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
	<CGME20260116101251epcas5p1cf5b48f2efb14fe4387be3053b3c3ebc@epcas5p1.samsung.com>
	<20260116100818.7576-4-kundan.kumar@samsung.com>
	<20260129004404.GA7712@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-76163-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,samsung.com:email,samsung.com:dkim,samsung.com:mid];
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
X-Rspamd-Queue-Id: 055BFD5A7D
X-Rspamd-Action: no action

On 1/29/2026 6:14 AM, Darrick J. Wong wrote:
> On Fri, Jan 16, 2026 at 03:38:15PM +0530, Kundan Kumar wrote:
>> Add per-inode structures to track predicted AGs of dirty folios using
>> an xarray and bitmap. This enables efficient identification of AGs
>> involved in writeback.
>>
>> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>> ---
>>   fs/xfs/xfs_icache.c | 27 +++++++++++++++++++++++++++
>>   fs/xfs/xfs_inode.h  |  5 +++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
>> index e44040206851..f97aa6d66271 100644
>> --- a/fs/xfs/xfs_icache.c
>> +++ b/fs/xfs/xfs_icache.c
>> @@ -80,6 +80,25 @@ static inline xa_mark_t ici_tag_to_mark(unsigned int tag)
>>   	return XFS_PERAG_BLOCKGC_MARK;
>>   }
>>   
>> +static int xfs_inode_init_ag_bitmap(struct xfs_inode *ip)
>> +{
>> +	unsigned int bits = ip->i_mount->m_sb.sb_agcount;
>> +	unsigned int nlongs;
>> +
>> +	xa_init_flags(&ip->i_ag_pmap, XA_FLAGS_LOCK_IRQ);
> 
> This increases the size of struct xfs_inode by 40 bytes...
> 

I’ll make this lazy and sparse: move AG writeback state behind a pointer
allocated on first use, and replace the bitmap with a sparse dirty-AG
set(xarray keyed by agno) so memory scales with AGs actually touched by
the inode.

>> +	ip->i_ag_dirty_bitmap = NULL;
>> +	ip->i_ag_dirty_bits = bits;
>> +
>> +	if (!bits)
>> +		return 0;
>> +
>> +	nlongs = BITS_TO_LONGS(bits);
>> +	ip->i_ag_dirty_bitmap = kcalloc(nlongs, sizeof(unsigned long),
>> +					GFP_NOFS);
> 
> ...and there could be hundreds or thousands of AGs for each filesystem.
> That's a lot of kernel memory to handle this prediction stuff, and I"m
> not even sure what ag_dirty_bitmap does yet.
> 

The bit for an AG is set in ag_dirty_bitmap at write time. During
writeback, we check which AG bits are set, wake only those AG-specific
workers, and each worker scans the page cache, filters folios tagged for
its AG, and submits the I/O.

>> +
>> +	return ip->i_ag_dirty_bitmap ? 0 : -ENOMEM;
>> +}
>> +
>>   /*
>>    * Allocate and initialise an xfs_inode.
>>    */
>> @@ -131,6 +150,8 @@ xfs_inode_alloc(
>>   	ip->i_next_unlinked = NULLAGINO;
>>   	ip->i_prev_unlinked = 0;
>>   
>> +	xfs_inode_init_ag_bitmap(ip);
> 
> Unchecked return value???

Will correct in next version

> 
>> +
>>   	return ip;
>>   }
>>   
>> @@ -194,6 +215,12 @@ xfs_inode_free(
>>   	ip->i_ino = 0;
>>   	spin_unlock(&ip->i_flags_lock);
>>   
>> +	/* free xarray contents (values are immediate packed ints) */
>> +	xa_destroy(&ip->i_ag_pmap);
>> +	kfree(ip->i_ag_dirty_bitmap);
>> +	ip->i_ag_dirty_bitmap = NULL;
>> +	ip->i_ag_dirty_bits = 0;
>> +
>>   	__xfs_inode_free(ip);
>>   }
>>   
>> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
>> index bd6d33557194..dee449168605 100644
>> --- a/fs/xfs/xfs_inode.h
>> +++ b/fs/xfs/xfs_inode.h
>> @@ -99,6 +99,11 @@ typedef struct xfs_inode {
>>   	spinlock_t		i_ioend_lock;
>>   	struct work_struct	i_ioend_work;
>>   	struct list_head	i_ioend_list;
>> +
>> +	/* AG prediction map: pgoff_t -> packed u32 */
> 
> What about blocksize < pagesize filesystems?  Which packed agno do you
> associate with the pgoff_t?
> 
> Also, do you have an xarray entry for each pgoff_t in a large folio?
> 
> --D
> 

pgoff_t here is the pagecache index (folio->index), i.e. file offset in
PAGE_SIZE units, not a filesystem block index. So blocksize < PAGE_SIZE
doesn’t change the association, the packed agno is attached to the folio
at that pagecache index.

We store one xarray entry per folio index (the start of the folio). We 
do not create entries for each base-page inside a large folio. If a 
large folio could span multiple extents/AGs, we’ll treat the hint as 
advisory and tag it invalid (fallback to normal writeback routing) 
rather than trying to encode per-subpage AGs.

>> +	struct xarray           i_ag_pmap;
>> +	unsigned long           *i_ag_dirty_bitmap;
>> +	unsigned int            i_ag_dirty_bits;
>>   } xfs_inode_t;
>>   
>>   static inline bool xfs_inode_on_unlinked_list(const struct xfs_inode *ip)
>> -- 
>> 2.25.1
>>
>>
> 


