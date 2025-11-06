Return-Path: <linux-fsdevel+bounces-67257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7FBC38EE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 03:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A23A4EAB2C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 02:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1BD23D7E0;
	Thu,  6 Nov 2025 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KPEardFY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778788F54;
	Thu,  6 Nov 2025 02:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762397976; cv=none; b=LCOZZg/BE4wVgabyQamozol2EhM4f2ri5xpb9u79lCQ9ngETsRE/8gXxA182++leX8upKKvjQZu6a3T3fJGFmDkedP1j0u6K6i2RRJgDNpon7+wl11s6PeIaBGw5+6F2s+ak0mlNZ6fM17n3Ivij0vO3ApHTq6H6MZsdzVcWMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762397976; c=relaxed/simple;
	bh=V8TNS9dNxXR0zWHObvitpEYCt973H8x54ShhkJB3MO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o2zSGz/thwgMK8QuQ54q4dmw55y2QBZTM01NTlJIgaGmGPGPiMAbAE8eq1WkwE64txFlshTdVu/sF5JsG+B6pW21uYRAlGA21mScEMziQ6BoCXYY1nSs0S5p2S3P/428uS1Db8q59OX0oveWKogT7270iE7IzujQsdq22Wy8Dpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KPEardFY; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zwOS0Tgg9NpAXRY+rZECq7sOks+zzOAcXCnMLrbHfw8=;
	b=KPEardFYwxVOKHR54BS8Vck8SHj1jjhIKku52jA1EndDMP9tNF++SaIBQWkFo5grl7IMQgd90
	RBNqGTXjmXXulCsCF4wuJyk2XxC3kNY1B0n0jd0vRwkpo5U8vML74FEJTikFvT464SXW2tvryf0
	gY8SdV3rex6g477Rok8DtBs=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d26Lg0PkBzKm4y;
	Thu,  6 Nov 2025 10:57:47 +0800 (CST)
Received: from kwepemr100006.china.huawei.com (unknown [7.202.194.218])
	by mail.maildlp.com (Postfix) with ESMTPS id 5399F140143;
	Thu,  6 Nov 2025 10:59:23 +0800 (CST)
Received: from [10.174.179.92] (10.174.179.92) by
 kwepemr100006.china.huawei.com (7.202.194.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Nov 2025 10:59:22 +0800
Message-ID: <2d7f50d1-36f0-452c-9bbe-4baaf7da34ce@huawei.com>
Date: Thu, 6 Nov 2025 10:59:22 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ext4: improve integrity checking in __mb_check_buddy
 by enhancing order-0 validation
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<tytso@mit.edu>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>,
	<libaokun1@huawei.com>, <chengzhihao1@huawei.com>
References: <20251105074250.3517687-1-sunyongjian@huaweicloud.com>
 <20251105074250.3517687-3-sunyongjian@huaweicloud.com>
 <6mjxlmvxs4p7k3rgs2cx3ny5u3o5tuikzpxxuqepq5yv6xcxk3@nvmzrpu2ooel>
From: Sun Yongjian <sunyongjian1@huawei.com>
In-Reply-To: <6mjxlmvxs4p7k3rgs2cx3ny5u3o5tuikzpxxuqepq5yv6xcxk3@nvmzrpu2ooel>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr100006.china.huawei.com (7.202.194.218)



在 2025/11/5 20:04, Jan Kara 写道:
> On Wed 05-11-25 15:42:50, Yongjian Sun wrote:
>> From: Yongjian Sun <sunyongjian1@huawei.com>
>>
>> When the MB_CHECK_ASSERT macro is enabled, we found that the
>> current validation logic in __mb_check_buddy has a gap in
>> detecting certain invalid buddy states, particularly related
>> to order-0 (bitmap) bits.
>>
>> The original logic consists of three steps:
>> 1. Validates higher-order buddies: if a higher-order bit is
>> set, at most one of the two corresponding lower-order bits
>> may be free; if a higher-order bit is clear, both lower-order
>> bits must be allocated (and their bitmap bits must be 0).
>> 2. For any set bit in order-0, ensures all corresponding
>> higher-order bits are not free.
>> 3. Verifies that all preallocated blocks (pa) in the group
>> have pa_pstart within bounds and their bitmap bits marked as
>> allocated.
>>
>> However, this approach fails to properly validate cases where
>> order-0 bits are incorrectly cleared (0), allowing some invalid
>> configurations to pass:
>>
>>                 corrupt            integral
>>
>> order 3           1                  1
>> order 2       1       1          1       1
>> order 1     1   1   1   1      1   1   1   1
>> order 0    0 0 1 1 1 1 1 1    1 1 1 1 1 1 1 1
>>
>> Here we get two adjacent free blocks at order-0 with inconsistent
>> higher-order state, and the right one shows the correct scenario.
>>
>> The root cause is insufficient validation of order-0 zero bits.
>> To fix this and improve completeness without significant performance
>> cost, we refine the logic:
>>
>> 1. Maintain the top-down higher-order validation, but we no longer
>> check the cases where the higher-order bit is 0, as this case will
>> be covered in step 2.
>> 2. Enhance order-0 checking by examining pairs of bits:
>>     - If either bit in a pair is set (1), all corresponding
>>       higher-order bits must not be free.
>>     - If both bits are clear (0), then exactly one of the
>>       corresponding higher-order bits must be free
>> 3. Keep the preallocation (pa) validation unchanged.
>>
>> This change closes the validation gap, ensuring illegal buddy states
>> involving order-0 are correctly detected, while removing redundant
>> checks and maintaining efficiency.
>>
>> Fixes: c9de560ded61f ("ext4: Add multi block allocator for ext4")
>> Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
>> Reviewed-by: Baokun Li <libaokun1@huawei.com>
> 
> The idea looks good but I have one question regarding the implementation...
> 
>> @@ -747,15 +756,29 @@ static void __mb_check_buddy(struct ext4_buddy *e4b, char *file,
>>   				fragments++;
>>   				fstart = i;
>>   			}
>> -			continue;
>> +		} else {
>> +			fstart = -1;
>>   		}
>> -		fstart = -1;
>> -		/* check used bits only */
>> -		for (j = 0; j < e4b->bd_blkbits + 1; j++) {
>> -			buddy2 = mb_find_buddy(e4b, j, &max2);
>> -			k = i >> j;
>> -			MB_CHECK_ASSERT(k < max2);
>> -			MB_CHECK_ASSERT(mb_test_bit(k, buddy2));
>> +		if (!(i & 1)) {
>> +			int in_use, zero_bit_count;
>> +
>> +			in_use = mb_test_bit(i, buddy) || mb_test_bit(i + 1, buddy);
>> +			zero_bit_count = 0;
>> +			for (j = 1; j < e4b->bd_blkbits + 2; j++) {
>> +				buddy2 = mb_find_buddy(e4b, j, &max2);
>> +				k = i >> j;
>> +				MB_CHECK_ASSERT(k < max2);
>> +				if (in_use) {
>> +					/* can not contain any 0 at all orders */
>> +					MB_CHECK_ASSERT(mb_test_bit(k, buddy2));
>> +				} else {
>> +					/* there is and can only be one 0 at all orders */
>> +					if (!mb_test_bit(k, buddy2)) {
>> +						zero_bit_count++;
>> +						MB_CHECK_ASSERT(zero_bit_count == 1);
>> +					}
>> +				}
> 
> Your variant doesn't seem to properly assert that at least 1 bit in the
> buddy is 0 above 0 bit in the bitmap because the MB_CHECK_ASSERT() doesn't
> get executed in that case at all AFAICT.  I think it would be more
> understandable to have the loop like:
> 
> 			for (j = 1; j < e4b->bd_blkbits + 2; j++) {
> 				buddy2 = mb_find_buddy(e4b, j, &max2);
> 				k = i >> j;
> 				MB_CHECK_ASSERT(k < max2);
> 				if (!mb_test_bit(k, buddy2))
> 					zero_bit_count++;
> 			}
> 			MB_CHECK_ASSERT(zero_bit_count == !in_use);
> 
> 									Honza

Thanks a lot for pointing out the logical flaw! Yes, you’re right—if 
order-0 bit pair is clear, then without a single 0 showing up at any 
higher order we’ll never enter the `if` branch to run `MB_CHECK_ASSERT`. 
The code you proposed is indeed a better, more elegant implementation!

Thanks,
Yongjian

