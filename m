Return-Path: <linux-fsdevel+bounces-66801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FD9C2C701
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 15:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E67654E932D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 14:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146ED3019BD;
	Mon,  3 Nov 2025 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WrwQlH8l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095D627FB21;
	Mon,  3 Nov 2025 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180675; cv=none; b=RgJqiWkJS04JTUJLv0iiiMU6mT059KFTL21f03syjNnWBkHAR5hazh5T+6VDOrgtcR2kt3b2P6FesD4jwlIvS3FLgnQ8LDS5I+5KK9frZkvcro0XHlUYIM7AknnErx0MwlIyqlPpKjJ8z7PnwIWZ1eWbnWTcCoFecMDcJK99274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180675; c=relaxed/simple;
	bh=lQQ+am8tER63NawYmu9xQEDLkM/8ujSRAUA52iOKakk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nb108Lijoax05QFRuLTj2YOiTLcFaO8c4w0gftRBfhUgQc3JRbPLu4Np5jmBg4Kkb5zBExLBbHSuyJfNOvs2wiR2Iq+LBoIH4FPv+lzpXLYzNrUB6wpHyk8lCZh1Zi8V/efWBPVkrqnfMJx+oDg32473K35b92CiIdrMABDDsCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WrwQlH8l; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=eGGeoWjftywpXqd25cgi9W6Zo6I329qDMqJRqqnzkTY=;
	b=WrwQlH8lSAQpoTyjNCrbB3iphcJzncWZfRlf74sQrgsPbwsTrLH2SgEbAsATlmSzSw6vT0jLM
	l2158lRS4FQrFSsxnYpnGG7I719b2wRMI8nvfXfV2sLuvkmks3qJsnNK2TTwyfCOrzgQu1nRYFD
	CR/FzoirvzJ1aIvIPQTLlAc=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d0Yzy64WSzcb1J;
	Mon,  3 Nov 2025 22:36:14 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FB2E180064;
	Mon,  3 Nov 2025 22:37:48 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 3 Nov
 2025 22:37:46 +0800
Message-ID: <70fd2f0e-8fac-4be7-9597-7072a36a58bc@huawei.com>
Date: Mon, 3 Nov 2025 22:37:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/25] ext4: support large block size in
 ext4_calculate_overhead()
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-kernel@vger.kernel.org>, <kernel@pankajraghav.com>,
	<mcgrof@kernel.org>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<libaokun1@huawei.com>, Baokun Li <libaokun@huaweicloud.com>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-8-libaokun@huaweicloud.com>
 <qmsx753xemvacoaghwhv6emusazmlynv54qqxwsdfsoaoeqre4@bp2lgrdufaim>
Content-Language: en-GB
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <qmsx753xemvacoaghwhv6emusazmlynv54qqxwsdfsoaoeqre4@bp2lgrdufaim>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-03 16:14, Jan Kara wrote:
> On Sat 25-10-25 11:22:03, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> ext4_calculate_overhead() used a single page for its bitmap buffer, which
>> worked fine when PAGE_SIZE >= block size. However, with block size greater
>> than page size (BS > PS) support, the bitmap can exceed a single page.
>>
>> To address this, we now use __get_free_pages() to allocate multiple pages,
>> sized to the block size, to properly support BS > PS.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> One comment below:
>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index d353e25a5b92..7338c708ea1d 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -4182,7 +4182,8 @@ int ext4_calculate_overhead(struct super_block *sb)
>>  	unsigned int j_blocks, j_inum = le32_to_cpu(es->s_journal_inum);
>>  	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
>>  	ext4_fsblk_t overhead = 0;
>> -	char *buf = (char *) get_zeroed_page(GFP_NOFS);
>> +	gfp_t gfp = GFP_NOFS | __GFP_ZERO;
>> +	char *buf = (char *)__get_free_pages(gfp, sbi->s_min_folio_order);
> I think this should be using kvmalloc(). There's no reason to require
> physically contiguous pages for this...
>
> 								Honza

Makes sense, I will use kvmalloc() in the next version.


Thanks,
Baokun


