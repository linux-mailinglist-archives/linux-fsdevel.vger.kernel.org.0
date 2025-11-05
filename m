Return-Path: <linux-fsdevel+bounces-67102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8E3C355AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 12:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4E3A4E8E70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 11:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FAE30FC22;
	Wed,  5 Nov 2025 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GCfExblq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87873090E2;
	Wed,  5 Nov 2025 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342092; cv=none; b=A3dyiXCuwAgBoCocKF+obO3xEqyA2rEmmjoAzU9+j/ryagzxi0KV74LQTkRZrKadvzEoiNPhM9e9kzIdVsJRS/KrLjQvkAOrZUh53VOly4sEpKiCQSXV3ojR+WJiOlcXy//jEE1yM+ouC3+nSZG2nbTRaT2immqRg/xI4V+EMOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342092; c=relaxed/simple;
	bh=51kAj3mxGvtwzhIbBQU5GLiDIuk1/cHhbSaleM79+Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bPbGe+EX30hY27/qUzP8PLlMoAuBe09AyJtKSTBwj6dhAuqvQSJfGyR4YJ98Mtj4auNSXiqaVf4/qx8vGy/mQyEekv+Uurv4znD91jK9V4VoPIPbw8tFmaPIBahB9PuXkCfF8EIxIXG4/su55wpRVaNpqhcTW1K6ZxKOm47vjfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GCfExblq; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SkZh9i1Zfd/xokAhDMNj3UEulbb0AiWAB3EnRI9sUYA=;
	b=GCfExblq2jRclquDnThI5trTH0weauEHZb90UtA93ev+Gnzmd6/deHREjW7lXJMXrjid1t7/I
	N9pFy1xaIwGfgtNCFCHDle105TULT54fq4fvsf3vgTHxPu7FR6AGboixBcZKxT5nBqNqh9cHEm+
	cUGFLsBYIKCri3FBSfnWJHI=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d1jh26ldtz12LCs;
	Wed,  5 Nov 2025 19:26:26 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 695A918006C;
	Wed,  5 Nov 2025 19:28:02 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Nov
 2025 19:28:01 +0800
Message-ID: <adbcac4d-e1fc-47a0-ad36-4672ff3c71f5@huawei.com>
Date: Wed, 5 Nov 2025 19:28:00 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/25] ext4: make online defragmentation support large
 block size
Content-Language: en-GB
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-kernel@vger.kernel.org>, <kernel@pankajraghav.com>,
	<mcgrof@kernel.org>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<libaokun1@huawei.com>, Baokun Li <libaokun@huaweicloud.com>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-22-libaokun@huaweicloud.com>
 <vkbarfyd6ozrrljhvwhmy2cq23mby6mxl2kxlsxp2wqgmvxvgi@6sgmqhhdnmru>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <vkbarfyd6ozrrljhvwhmy2cq23mby6mxl2kxlsxp2wqgmvxvgi@6sgmqhhdnmru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-05 17:50, Jan Kara wrote:
> On Sat 25-10-25 11:22:17, libaokun@huaweicloud.com wrote:
>> From: Zhihao Cheng <chengzhihao1@huawei.com>
>>
>> There are several places assuming that block size <= PAGE_SIZE, modify
>> them to support large block size (bs > ps).
>>
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ...
>
>> @@ -565,7 +564,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>>  	struct inode *orig_inode = file_inode(o_filp);
>>  	struct inode *donor_inode = file_inode(d_filp);
>>  	struct ext4_ext_path *path = NULL;
>> -	int blocks_per_page = PAGE_SIZE >> orig_inode->i_blkbits;
>> +	int blocks_per_page = 1;
>>  	ext4_lblk_t o_end, o_start = orig_blk;
>>  	ext4_lblk_t d_start = donor_blk;
>>  	int ret;
>> @@ -608,6 +607,9 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>>  		return -EOPNOTSUPP;
>>  	}
>>  
>> +	if (i_blocksize(orig_inode) < PAGE_SIZE)
>> +		blocks_per_page = PAGE_SIZE >> orig_inode->i_blkbits;
>> +
> I think these are strange and the only reason for this is that
> ext4_move_extents() tries to make life easier to move_extent_per_page() and
> that doesn't really work with larger folios anymore. I think
> ext4_move_extents() just shouldn't care about pages / folios at all and
> pass 'cur_len' as the length to the end of extent / moved range and
> move_extent_per_page() will trim the length based on the folios it has got.
>
> Also then we can rename some of the variables and functions from 'page' to
> 'folio'.

Yes, the code here doesn’t really support folios. YI mentioned earlier
that he would make online defragmentation support large folios. So in
this patch I only avoided shifting negative values, without doing a
deeper conversion.

YI’s conversion work looks nearly complete, so in the next version I will
rebase on top of his patches. Since his patch already removes the
function modified here, the next version will likely drop this patch or
adapt it accordingly.

Thanks for your review!


Cheers,
Baokun

>>  	/* Protect orig and donor inodes against a truncate */
>>  	lock_two_nondirectories(orig_inode, donor_inode);
>>  
>> @@ -665,10 +667,8 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>>  		if (o_end - o_start < cur_len)
>>  			cur_len = o_end - o_start;
>>  
>> -		orig_page_index = o_start >> (PAGE_SHIFT -
>> -					       orig_inode->i_blkbits);
>> -		donor_page_index = d_start >> (PAGE_SHIFT -
>> -					       donor_inode->i_blkbits);
>> +		orig_page_index = EXT4_LBLK_TO_P(orig_inode, o_start);
>> +		donor_page_index = EXT4_LBLK_TO_P(donor_inode, d_start);
>>  		offset_in_page = o_start % blocks_per_page;
>>  		if (cur_len > blocks_per_page - offset_in_page)
>>  			cur_len = blocks_per_page - offset_in_page;
>> -- 
>> 2.46.1
>>


