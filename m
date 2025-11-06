Return-Path: <linux-fsdevel+bounces-67256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C64F2C38E8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 03:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CAF54E783E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 02:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25481253359;
	Thu,  6 Nov 2025 02:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xgwHqogv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73BD245022;
	Thu,  6 Nov 2025 02:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762397065; cv=none; b=jVAUobPwiNXMSq/inXJgO5s7i1RXgMDaThNmDIZMlTzC6Cp9cxTO6Tu8Ouu16ZVMCP/YyZ81Kjh31MgMzx/soQqajpMuGwg6IkSj8IlX4RH5+VA0oomsJBKVt31xqUpsY73sTR0NEUdhYy8eD89dm6tmGVlzPyqvXykdSUlrYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762397065; c=relaxed/simple;
	bh=IcASH1qtY0SIFs42x0ctyhoiDa7gsdtJ7fmK5+xGdLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XP/9O3Rc7jjHDHwJgkHyD8UpCVGjHECQB8mzFQBfhe2kzsZ2+ezqEL011YMElXif/kM9yFjZE4JsaMUX39mC8kD0mQhEFoESEhQ6x+WjpWbdGiaT5y4bh3dewl504GqQu80YtJze7RadhPD7yeoG687Mkat1OmazTPqqL+9IkfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xgwHqogv; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SmiGeerJpItekeBrZ0vp8zm0YzZ1kocpU6u3YhL4BMc=;
	b=xgwHqogvKdjdSjQOEiNXt3yMJngtWo0Y3iXn2mRqv7EpqxcVd312T/rdqLXC8B4Ld5dCDQJdA
	X16AvLmzek4Fl5/+heqACTw+WUdIqjjuNZrTxJVMbinUXaT0bUyaJ/Ii3lrIm7lg+Ev+H+0MyZb
	Uq/4Xu/yXujZiDi+0Wfnd1s=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d261908K0z1prKm;
	Thu,  6 Nov 2025 10:42:37 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B608140276;
	Thu,  6 Nov 2025 10:44:13 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 6 Nov
 2025 10:44:12 +0800
Message-ID: <242f4438-d84d-46a6-86fe-8629c7e028cf@huawei.com>
Date: Thu, 6 Nov 2025 10:44:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/25] ext4: enable block size larger than page size
Content-Language: en-GB
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-kernel@vger.kernel.org>, <kernel@pankajraghav.com>,
	<mcgrof@kernel.org>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<libaokun1@huawei.com>, Baokun Li <libaokun@huaweicloud.com>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-26-libaokun@huaweicloud.com>
 <yp4gorgjhh6c3qeopjabmknimeifhnpbz63irrrtjpplatnk4k@ycofoucc4ry3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <yp4gorgjhh6c3qeopjabmknimeifhnpbz63irrrtjpplatnk4k@ycofoucc4ry3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-05 18:14, Jan Kara wrote:
> On Sat 25-10-25 11:22:21, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Since block device (See commit 3c20917120ce ("block/bdev: enable large
>> folio support for large logical block sizes")) and page cache (See commit
>> ab95d23bab220ef8 ("filemap: allocate mapping_min_order folios in the page
>> cache")) has the ability to have a minimum order when allocating folio,
>> and ext4 has supported large folio in commit 7ac67301e82f ("ext4: enable
>> large folio for regular file"), now add support for block_size > PAGE_SIZE
>> in ext4.
>>
>> set_blocksize() -> bdev_validate_blocksize() already validates the block
>> size, so ext4_load_super() does not need to perform additional checks.
>>
>> Here we only need to enable large folio by default when s_min_folio_order
>> is greater than 0 and add the FS_LBS bit to fs_flags.
>>
>> In addition, mark this feature as experimental.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> ...
>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 04f9380d4211..ba6cf05860ae 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -5146,6 +5146,9 @@ static bool ext4_should_enable_large_folio(struct inode *inode)
>>  	if (!ext4_test_mount_flag(sb, EXT4_MF_LARGE_FOLIO))
>>  		return false;
>>  
>> +	if (EXT4_SB(sb)->s_min_folio_order)
>> +		return true;
>> +
> But now files with data journalling flag enabled will get large folios
> possibly significantly greater that blocksize. I don't think there's a
> fundamental reason why data journalling doesn't work with large folios, the
> only thing that's likely going to break is that credit estimates will go
> through the roof if there are too many blocks per folio. But that can be
> handled by setting max folio order to be equal to min folio order when
> journalling data for the inode.
>
> It is a bit scary to be modifying max folio order in
> ext4_change_inode_journal_flag() but I guess less scary than setting new
> aops and if we prune the whole page cache before touching the order and
> inode flag, we should be safe (famous last words ;).
>
Good point! This looks feasible.

We just need to adjust the folio order range based on the journal data,
and in ext4_inode_journal_mode only ignore the inode’s journal data flag
when max_order > min_order.

I’ll make the adaptation and run some tests.
Thank you for your review!


Cheers,
Baokun

>
>>  	if (!S_ISREG(inode->i_mode))
>>  		return false;
>>  	if (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index fdc006a973aa..4c0bd79bdf68 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -5053,6 +5053,9 @@ static int ext4_check_large_folio(struct super_block *sb)
>>  		return -EINVAL;
>>  	}
>>  
>> +	if (sb->s_blocksize > PAGE_SIZE)
>> +		ext4_msg(sb, KERN_NOTICE, "EXPERIMENTAL bs(%lu) > ps(%lu) enabled.",
>> +			 sb->s_blocksize, PAGE_SIZE);
>>  	return 0;
>>  }
>>  
>> @@ -7432,7 +7435,8 @@ static struct file_system_type ext4_fs_type = {
>>  	.init_fs_context	= ext4_init_fs_context,
>>  	.parameters		= ext4_param_specs,
>>  	.kill_sb		= ext4_kill_sb,
>> -	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
>> +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME |
>> +				  FS_LBS,
>>  };
>>  MODULE_ALIAS_FS("ext4");
>>  
>> -- 
>> 2.46.1
>>


