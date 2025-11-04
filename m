Return-Path: <linux-fsdevel+bounces-66888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBA7C2F85F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 07:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B391422611
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 06:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AB92EDD6D;
	Tue,  4 Nov 2025 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4yyPL4xi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C42EB5BD;
	Tue,  4 Nov 2025 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762239347; cv=none; b=Gzy/2yhD26lrEj4UE/xL5z5CJrDVMnTjWmpbYKzHuE0wZb4/cDFngSOrfoMyhc3wlheu+KLtPCRv3YxMhJ6o5oHRKYn2CDCiPBIYdODNVNLbMbEZmoXnWvBhzA7KW5QaH/dI0VS4lPKLmepbrNhRQPA/vjsgtjjWLGUHVSB/SeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762239347; c=relaxed/simple;
	bh=3OJez3SrS0xfhYeSl6yizweVWk27hMOpJMOwLFmUXmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=onInwz+RPQLmbBMggFAybcyreua9dfuh255Gbu1RZ+Cu03v+oaGvu30vctEQJEyk9AbLZsm9c1FR0kbjEFWmjEBjGaoXd1wjYOi6qljXDqIvGMZUIwyPfBtVTY4ZJL/tGCoe1oUPJoscoOqs8/Jafxe/OmDlCtu9itFk9mvCupo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4yyPL4xi; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MY0q0WzHzhej6e9lThaMmg4zC+Z3TXTsGd/cLJf2rak=;
	b=4yyPL4xi/ls053nVqnalitPx7VgIaq/rBG8XJASRMmS2b7Cw10ZVBz3UkPwm66Plu5391QSC+
	B0jFPLdUO7Z7GOvz5NuNCAUSmOSxAAa445EKsEB8lrd0G8Bt+WHoGqs3fMeYu4GLF2IJCuNJR5/
	g2l0nI5e6JspjfsegSUCtOQ=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d0zhN3DzczpStT;
	Tue,  4 Nov 2025 14:54:12 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 41CCF140EE4;
	Tue,  4 Nov 2025 14:55:41 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 14:55:39 +0800
Message-ID: <4eb369fa-b03c-4883-8e01-2233dac81044@huawei.com>
Date: Tue, 4 Nov 2025 14:55:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/25] ext4: make ext4_punch_hole() support large block
 size
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-kernel@vger.kernel.org>, <kernel@pankajraghav.com>,
	<mcgrof@kernel.org>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<libaokun1@huawei.com>, Baokun Li <libaokun@huaweicloud.com>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-5-libaokun@huaweicloud.com>
 <v55t7ujgvjf2wfrlbyiva4zuu6xv5pjl7lac5ykgzvgrgluipc@moyoiqdnyinl>
Content-Language: en-GB
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <v55t7ujgvjf2wfrlbyiva4zuu6xv5pjl7lac5ykgzvgrgluipc@moyoiqdnyinl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-03 16:05, Jan Kara wrote:
> On Sat 25-10-25 11:22:00, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Since the block size may be greater than the page size, when a hole
>> extends beyond i_size, we need to align the hole's end upwards to the
>> larger of PAGE_SIZE and blocksize.
>>
>> This is to prevent the issues seen in commit 2be4751b21ae ("ext4: fix
>> 2nd xfstests 127 punch hole failure") from reappearing after BS > PS
>> is supported.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> When going for bs > ps support, I'm very suspicious of any code that keeps
> using PAGE_SIZE because it doesn't make too much sense anymore. Usually that
> should be either appropriate folio size or something like that. For example
> in this case if we indeed rely on freeing some buffers then with 4k block
> size in an order-2 folio things would be already broken.
>
> As far as I'm checking truncate_inode_pages_range() already handles partial
> folio invalidation fine so I think we should just use blocksize in the
> rounding (to save pointless tail block zeroing) and be done with it.

Right. I missed that truncate_inode_pages_range already handles this.

I will directly use the blocksize in v2.

Thank you for your review!

>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 4c04af7e51c9..a63513a3db53 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -4401,7 +4401,8 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>>  	 * the page that contains i_size.
>>  	 */
>>  	if (end > inode->i_size)
> BTW I think here we should have >= (not your fault but we can fix it when
> changing the code).

Yes, I didn’t notice this bug. I will fix it together in v2.


Cheers,
Baokun

>
>> -		end = round_up(inode->i_size, PAGE_SIZE);
>> +		end = round_up(inode->i_size,
>> +			       umax(PAGE_SIZE, sb->s_blocksize));
>>  	if (end > max_end)
>>  		end = max_end;
>>  	length = end - offset;
> 								Honza

