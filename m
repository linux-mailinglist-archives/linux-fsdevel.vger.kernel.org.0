Return-Path: <linux-fsdevel+bounces-15331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB1A88C363
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 14:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36EA2E5246
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 13:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DFF7442C;
	Tue, 26 Mar 2024 13:30:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441FB70CC2;
	Tue, 26 Mar 2024 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459832; cv=none; b=neSN9XbzZ33b615wj6Q3Wh8GUfttVKIQL+lOf2KtI914V5Im/AVS5XyKvPGFbCH7IJkucap3ZPhwH7UbT2+R9ucrNZ6n5vanSNwGhnT11+FHOz/b3fr8DPXUcM+3npCqW+JBpouHQA8+hQlN4njF0hajVBy/le4vXu2aiXoTy8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459832; c=relaxed/simple;
	bh=4lRRYxCm99C7bS5GE8+hJil4QP2rifr8KGGpETgr1Cc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UEIdnwxCmxuPDSuFEhkVQr1SIf9q4+9+TqNUTBX1OK6SUPtXW+ziteQQqrRRXfOlgL46jGZI7bA9pH6DuUHwDri9Cbm48+tW50gNcWwtt88mMwMsBDz1nu/2N8tQ1IKfx+QUIZOAv77yYgY27fQBkuU/wR45myL7B6+0m33zbQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V3rJk2brhz4f3jXb;
	Tue, 26 Mar 2024 21:30:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8B44E1A0199;
	Tue, 26 Mar 2024 21:30:20 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP2 (Coremail) with SMTP id Syh0CgAnlQjpzQJmxEQ+IQ--.31963S2;
	Tue, 26 Mar 2024 21:30:18 +0800 (CST)
Subject: Re: [PATCH 6/6] writeback: remove unneeded GDTC_INIT_NO_WB
To: Jan Kara <jack@suse.cz>
Cc: akpm@linux-foundation.org, tj@kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, bfoster@redhat.com, dsterba@suse.com,
 mjguzik@gmail.com, dhowells@redhat.com, peterz@infradead.org
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-7-shikemeng@huaweicloud.com>
 <20240326123503.kxyxg75xr7wk3ux3@quack3>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <2e1ac568-1883-700c-ba41-575f5db339c2@huaweicloud.com>
Date: Tue, 26 Mar 2024 21:30:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240326123503.kxyxg75xr7wk3ux3@quack3>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnlQjpzQJmxEQ+IQ--.31963S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4rKr1xCw45Kr4xWr15Arb_yoW8KF4kpF
	sxGa1UKF45Ars29rnxCas7WrnIqrZ7tFZrKwsrCw4ayF4xGF1rGFyj9w1Iyr1UAr93Kry7
	Arsrta4fZayjyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUrcTmDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/26/2024 8:35 PM, Jan Kara wrote:
> On Wed 20-03-24 19:02:22, Kemeng Shi wrote:
>> We never use gdtc->dom set with GDTC_INIT_NO_WB, just remove unneeded
>> GDTC_INIT_NO_WB
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> Please no, this leaves a trap for the future. If anything, I'd teach
> GDTC_INIT() that 'wb' can be NULL and replace GDTC_INIT_NO_WB with
> GDTC_INIT(NULL).
Would it be acceptable to define GDTC_INIT_NO_WB to null for now as
discussed in [1].

[1] https://lore.kernel.org/lkml/becdb16b-a318-ec05-61d2-d190541ae997@huaweicloud.com/

Thanks,
Kemeng
> 
> 								Honza
> 
>> ---
>>  mm/page-writeback.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
>> index 481b6bf34c21..09b2b0754cc5 100644
>> --- a/mm/page-writeback.c
>> +++ b/mm/page-writeback.c
>> @@ -154,8 +154,6 @@ struct dirty_throttle_control {
>>  				.dom = &global_wb_domain,		\
>>  				.wb_completions = &(__wb)->completions
>>  
>> -#define GDTC_INIT_NO_WB		.dom = &global_wb_domain
>> -
>>  #define MDTC_INIT(__wb, __gdtc)	.wb = (__wb),				\
>>  				.dom = mem_cgroup_wb_domain(__wb),	\
>>  				.wb_completions = &(__wb)->memcg_completions, \
>> @@ -210,7 +208,6 @@ static void wb_min_max_ratio(struct bdi_writeback *wb,
>>  
>>  #define GDTC_INIT(__wb)		.wb = (__wb),                           \
>>  				.wb_completions = &(__wb)->completions
>> -#define GDTC_INIT_NO_WB
>>  #define MDTC_INIT(__wb, __gdtc)
>>  
>>  static bool mdtc_valid(struct dirty_throttle_control *dtc)
>> @@ -438,7 +435,7 @@ static void domain_dirty_limits(struct dirty_throttle_control *dtc)
>>   */
>>  void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty)
>>  {
>> -	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
>> +	struct dirty_throttle_control gdtc = { };
>>  
>>  	gdtc.avail = global_dirtyable_memory();
>>  	domain_dirty_limits(&gdtc);
>> @@ -895,7 +892,7 @@ unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh)
>>  
>>  unsigned long wb_calc_cg_thresh(struct bdi_writeback *wb)
>>  {
>> -	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
>> +	struct dirty_throttle_control gdtc = { };
>>  	struct dirty_throttle_control mdtc = { MDTC_INIT(wb, &gdtc) };
>>  	unsigned long filepages, headroom, writeback;
>>  
>> -- 
>> 2.30.0
>>


