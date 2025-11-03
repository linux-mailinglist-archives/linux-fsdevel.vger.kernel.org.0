Return-Path: <linux-fsdevel+bounces-66802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF2DC2C745
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 15:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08471891344
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 14:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9964310625;
	Mon,  3 Nov 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZrVfyp0j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7351FE44B;
	Mon,  3 Nov 2025 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181155; cv=none; b=PZKFuaxTY00YGXcwqyxryHN11gX7CWUBhoNJkeKvFoYPqGWqKloYF2i6tJrxc3GTIdMcQPufTV2CDk34AmpdLB9sX9aLG/ioTUHa+AmMTLKy41KIxnCQjoCawrc0Tz6vp0Pd4ZAVwdLsuXS1XKTjgWP4LpeNpkrh5t8iST18l74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181155; c=relaxed/simple;
	bh=Qh1ab34187lNGuxmAq7NRvD55hi/HhHvUJ6Nhwc3fH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uf2bq1Se7whQhkxDbalHzkkkQRjsfEAB5EzORxa8EtitPb/5kvPNuMIxZ5m1t8M1j6pdXwCdeoYB9HglLezbvZTcd2+/SB2lq91HxRClxpg9Dz7cL2BukfrDcqlAKS+VFf1C+QJb+3/tJtLgfAyHQByAcm0YyqVNvRxHr/VcyDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZrVfyp0j; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0LC8BaVmEmaGtKa9JcwOiElMRg81zujwUDW5FoPzdQI=;
	b=ZrVfyp0j0n+oW0sutIipbJeS8S4W3Wge73tR8pElvBWhuZvtKYACoB7FRnnL6B7bBymggBA+a
	4jILv5r2D4DzvBg45yzGoxCGYRxCZGOTsSUglQVwDCbEnV+qli1fYSIMcIBUnpdo8UPdM+M7Ntx
	en0YEvk8IfHNl+RcM+5dO7c=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d0Z993nq4z1cyPL;
	Mon,  3 Nov 2025 22:44:13 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 07D32140297;
	Mon,  3 Nov 2025 22:45:48 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 3 Nov
 2025 22:45:46 +0800
Message-ID: <761b447d-6e34-4a6d-b1d8-9f744ab548db@huawei.com>
Date: Mon, 3 Nov 2025 22:45:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/25] ext4: add EXT4_LBLK_TO_P and EXT4_P_TO_LBLK for
 block/page conversion
Content-Language: en-GB
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-kernel@vger.kernel.org>, <kernel@pankajraghav.com>,
	<mcgrof@kernel.org>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<libaokun1@huawei.com>, Baokun Li <libaokun@huaweicloud.com>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-11-libaokun@huaweicloud.com>
 <pgrk2x54egzxcvmfi4rra3exooxe3yxuvug6yvbtrgxm2oppym@fy52xh4weeww>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <pgrk2x54egzxcvmfi4rra3exooxe3yxuvug6yvbtrgxm2oppym@fy52xh4weeww>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-03 16:26, Jan Kara wrote:
> On Sat 25-10-25 11:22:06, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> As BS > PS support is coming, all block number to page index (and
>> vice-versa) conversions must now go via bytes. Added EXT4_LBLK_TO_P()
>> and EXT4_P_TO_LBLK() macros to simplify these conversions and handle
>> both BS <= PS and BS > PS scenarios cleanly.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> 'P' in the macro names seems too terse :). I'd probably use PG to give a
> better hint this is about pages? So EXT4_LBLK_TO_PG() and
> EXT4_PG_TO_LBLK(). 

Indeed, EXT4_LBLK_TO_PG reads much clearer. I will use it in v2.

> BTW, patch 8 could already use these macros...
>
> 								Honza

In Patch 8, the conversion is for a physical block number, which has a
different variable type than lblk. Since this is the only location where
this conversion is used in the code, I made a dedicated modification there.

Thank you for your review!


Cheers,
Baokun

>> ---
>>  fs/ext4/ext4.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 9b236f620b3a..8223ed29b343 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -369,6 +369,12 @@ struct ext4_io_submit {
>>  	(round_up((offset), i_blocksize(inode)) >> (inode)->i_blkbits)
>>  #define EXT4_LBLK_TO_B(inode, lblk) ((loff_t)(lblk) << (inode)->i_blkbits)
>>  
>> +/* Translate a block number to a page index */
>> +#define EXT4_LBLK_TO_P(inode, lblk)	(EXT4_LBLK_TO_B((inode), (lblk)) >> \
>> +					 PAGE_SHIFT)
>> +/* Translate a page index to a block number */
>> +#define EXT4_P_TO_LBLK(inode, pnum)	(((loff_t)(pnum) << PAGE_SHIFT) >> \
>> +					 (inode)->i_blkbits)
>>  /* Translate a block number to a cluster number */
>>  #define EXT4_B2C(sbi, blk)	((blk) >> (sbi)->s_cluster_bits)
>>  /* Translate a cluster number to a block number */
>> -- 
>> 2.46.1
>>


