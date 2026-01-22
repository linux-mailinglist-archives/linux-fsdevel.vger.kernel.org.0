Return-Path: <linux-fsdevel+bounces-75057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOYmGjQ/cmnpfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:16:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B1F6888A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85C3A305B946
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 15:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E78A34CFBB;
	Thu, 22 Jan 2026 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HllnF4h7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B737734B40F;
	Thu, 22 Jan 2026 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094591; cv=none; b=tynYNI/fsYIsgQ2Qv2vvDZEWxV5MNnnlr83HzK5Wcbi57iwlDKZnPyTqPQa6N9PL73pZLUiyUSdbvgXQAR0BON/9Q7bREMaI/MwkBGKbhtbkIZvLB4uuDY0Fyl6GfvUbibZ6HoXpNGNTeXRMRQfq8v87jlTyQj+RiGfuzrG5Ul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094591; c=relaxed/simple;
	bh=zEGfwSfTwXetgXirMPcfi80hMxNYkQ60rX5EPLoEwbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ARoA/dNdqWI5pNRSLp4WOix8HPr7C+zo1KBAdu79vSug42VA2j27VtzHoHmTLf2uqOIpCN0v7OvbO3F43XhZ/22/OgSeiCWTl2NiZmT8yUZSZFXAzePhZ2OTsPKdlsGe5RXoubjwrIBPr5iVXJ9ouK2LFP+Scic3tZkUTzK2K5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HllnF4h7; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6YeK8+XEQ06p0sml2YP2VgVDLD9DnuRaQ8bZqQQ3Apw=;
	b=HllnF4h7vOqZ07JwjUfmVyRa6FO+FLtenoVNbW9wZ5Emt+xwzycb2QbYJT0P2NX9npL2kwnyf
	dkubgZdIwuGWlZN7i8fo2w0TSpSQMtW5XNhErVFXuzPFfJ0GK8nD8tEyGQaAQm6Om+KhobX4vqH
	YrUpWoj9YMKnvSviXtN7leM=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dxksm6v28zLlSx;
	Thu, 22 Jan 2026 23:06:20 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id CED1440562;
	Thu, 22 Jan 2026 23:09:44 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 Jan 2026 23:09:44 +0800
Message-ID: <46110ee5-ee70-47ec-bd4d-c0c76bdfda13@huawei.com>
Date: Thu, 22 Jan 2026 23:09:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 06/10] erofs: introduce the page cache share feature
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <chao@kernel.org>,
	<brauner@kernel.org>
CC: <hch@lst.de>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
References: <20260122133718.658056-1-lihongbo22@huawei.com>
 <20260122133718.658056-7-lihongbo22@huawei.com>
 <a59ef332-fc67-4890-94b1-9c3f2b37a9fa@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <a59ef332-fc67-4890-94b1-9c3f2b37a9fa@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75057-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99B1F6888A
X-Rspamd-Action: no action



On 2026/1/22 22:01, Gao Xiang wrote:
> 
> 
> On 2026/1/22 21:37, Hongbo Li wrote:
>> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>
>> Currently, reading files with different paths (or names) but the same
>> content will consume multiple copies of the page cache, even if the
>> content of these page caches is the same. For example, reading
>> identical files (e.g., *.so files) from two different minor versions of
>> container images will cost multiple copies of the same page cache,
>> since different containers have different mount points. Therefore,
>> sharing the page cache for files with the same content can save memory.
>>
>> This introduces the page cache share feature in erofs. It allocate a
>> shared inode and use its page cache as shared. Reads for files
>> with identical content will ultimately be routed to the page cache of
>> the shared inode. In this way, a single page cache satisfies
>> multiple read requests for different files with the same contents.
>>
>> We introduce new mount option `inode_share` to enable the page
>> sharing mode during mounting. This option is used in conjunction
>> with `domain_id` to share the page cache within the same trusted
>> domain.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   Documentation/filesystems/erofs.rst |   5 +
>>   fs/erofs/Makefile                   |   1 +
>>   fs/erofs/inode.c                    |   1 -
>>   fs/erofs/internal.h                 |  31 ++++++
>>   fs/erofs/ishare.c                   | 167 ++++++++++++++++++++++++++++
>>   fs/erofs/super.c                    |  62 ++++++++++-
>>   fs/erofs/xattr.c                    |  34 ++++++
>>   fs/erofs/xattr.h                    |   3 +
>>   8 files changed, 301 insertions(+), 3 deletions(-)
>>   create mode 100644 fs/erofs/ishare.c
>>
>> diff --git a/Documentation/filesystems/erofs.rst 
>> b/Documentation/filesystems/erofs.rst
>> index 40dbf3b6a35f..bfef8e87f299 100644
>> --- a/Documentation/filesystems/erofs.rst
>> +++ b/Documentation/filesystems/erofs.rst
>> @@ -129,7 +129,12 @@ fsid=%s                Specify a filesystem image 
>> ID for Fscache back-end.
>>   domain_id=%s           Specify a trusted domain ID for fscache mode 
>> so that
>>                          different images with the same blobs, 
>> identified by blob IDs,
>>                          can share storage within the same trusted 
>> domain.
>> +                       Also used for different filesystems with inode 
>> page sharing
>> +                       enabled to share page cache within the trusted 
>> domain.
>>   fsoffset=%llu          Specify block-aligned filesystem offset for 
>> the primary device.
>> +inode_share            Enable inode page sharing for this 
>> filesystem.  Inodes with
>> +                       identical content within the same domain ID 
>> can share the
>> +                       page cache.
>>   ===================    
>> =========================================================
>>   Sysfs Entries
>> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
>> index 549abc424763..a80e1762b607 100644
>> --- a/fs/erofs/Makefile
>> +++ b/fs/erofs/Makefile
>> @@ -10,3 +10,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += 
>> decompressor_zstd.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_ACCEL) += decompressor_crypto.o
>>   erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
>>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
>> +erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += ishare.o
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index 389632bb46c4..202cbbb4eada 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -203,7 +203,6 @@ static int erofs_read_inode(struct inode *inode)
>>   static int erofs_fill_inode(struct inode *inode)
>>   {
>> -    struct erofs_inode *vi = EROFS_I(inode);
> 
> Why this line is in this patch other than
> "erofs: add erofs_inode_set_aops helper to set the aops[.]"
> 
> And there is an unneeded dot at the end of the subject.
> 
> Could you check the patches carefully before sending
> out the next version?

I am very sorry for making such stupid mistake. :(

Thanks,
Hongbo

> 
> Thanks,
> Gao Xiang

