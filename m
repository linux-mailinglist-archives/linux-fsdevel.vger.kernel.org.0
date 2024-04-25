Return-Path: <linux-fsdevel+bounces-17697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A328B1868
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 03:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB86E2855B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 01:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA845F9CC;
	Thu, 25 Apr 2024 01:23:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15CFE545;
	Thu, 25 Apr 2024 01:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714008184; cv=none; b=CZ4ixMlVgpBQs4Cn8RwvODbkFmnYm5LCVX/nxmiNTP7DlxQgVToFozQ/OvU5lpi4JfxuitNyogP7eCDabEmZlWAI9Q9o/3miZ+BMjBH5UHMSe6V5RsqjFim4YzP2markg9Fh0prq4Os2E1bIwfEZkYn2azD26ml2NuOHY560VP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714008184; c=relaxed/simple;
	bh=YIHEoWGRRl7K692oqnAxxTuhe6uaULTZlph26PTJi4Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cW/w2JUJB6nPDvm+3VCYmIYAGrt6DyHxX3rBJQnLod/vjwr32A/qLrKk5NzeXjv5mGZ327C2INL1dLwxZLmNZd2I1DgxbB1qVoaeRegHSnoA4hQRo9c7ONmQduaG+oEBxwWhzctGtXctU+o1wp10FZUiDB4p9YKJfmap9UH4ihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VPylW1PdVz4f3k6f;
	Thu, 25 Apr 2024 09:22:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 131501A016E;
	Thu, 25 Apr 2024 09:22:52 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgB3x2lqsClmubRULA--.62798S2;
	Thu, 25 Apr 2024 09:22:51 +0800 (CST)
Subject: Re: [PATCH v5 3/5] writeback: fix build problems of "writeback:
 support retrieving per group debug writeback stats of bdi"
To: Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org
Cc: willy@infradead.org, jack@suse.cz, bfoster@redhat.com, tj@kernel.org,
 dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240423034643.141219-1-shikemeng@huaweicloud.com>
 <20240423034643.141219-4-shikemeng@huaweicloud.com>
 <20240424132739.GD318022@cmpxchg.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <9de3d0ca-7d51-84d5-3c69-c3de95686f88@huaweicloud.com>
Date: Thu, 25 Apr 2024 09:22:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240424132739.GD318022@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB3x2lqsClmubRULA--.62798S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4UAFyDuFy3Jr18uF1xKrg_yoW8tFW3pa
	y5G3WrGF4Utry8GasxCFW5Wry5tw48tryUJFykKryjyr15Wrn3KFyxurWFvryUurZ3Cw12
	qF4Fvas3WrWjkaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/


Hi Johannes,
on 4/24/2024 9:27 PM, Johannes Weiner wrote:
> Hi Kemeng,
> 
> On Tue, Apr 23, 2024 at 11:46:41AM +0800, Kemeng Shi wrote:
>> Fix two build problems:
>> 1. implicit declaration of function 'cgroup_ino'.
> 
> I just ran into this as well, with defconfig on mm-everything:
Sorry for this.
> 
> /home/hannes/src/linux/linux/mm/backing-dev.c: In function 'wb_stats_show':
> /home/hannes/src/linux/linux/mm/backing-dev.c:175:33: error: 'struct bdi_writeback' has no member named 'memcg_css'
>   175 |                    cgroup_ino(wb->memcg_css->cgroup),
>       |                                 ^~
> make[3]: *** [/home/hannes/src/linux/linux/scripts/Makefile.build:244: mm/backing-dev.o] Error 1
> 
>> ---
>>  mm/backing-dev.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
>> index 6ecd11bdce6e..e61bbb1bd622 100644
>> --- a/mm/backing-dev.c
>> +++ b/mm/backing-dev.c
>> @@ -172,7 +172,11 @@ static void wb_stats_show(struct seq_file *m, struct bdi_writeback *wb,
>>  		   "b_more_io:         %10lu\n"
>>  		   "b_dirty_time:      %10lu\n"
>>  		   "state:             %10lx\n\n",
>> +#ifdef CONFIG_CGROUP_WRITEBACK
>>  		   cgroup_ino(wb->memcg_css->cgroup),
>> +#else
>> +		   1ul,
>> +#endif
>>  		   K(stats->nr_writeback),
>>  		   K(stats->nr_reclaimable),
>>  		   K(stats->wb_thresh),
>> @@ -192,7 +196,6 @@ static int cgwb_debug_stats_show(struct seq_file *m, void *v)
>>  	unsigned long background_thresh;
>>  	unsigned long dirty_thresh;
>>  	struct bdi_writeback *wb;
>> -	struct wb_stats stats;
>>  
>>  	global_dirty_limits(&background_thresh, &dirty_thresh);
> 
> The fix looks right to me, but it needs to be folded into the previous
> patch. No patch should knowingly introduce an issue that is fixed
> later on. This will break bisection.
As I'm not sure if previous patch is already applied to tree, so I
make this fix a individual patch and mentioned in cover letter that
this could be folded if previous patch is not in tree or this could
be applied individually to fix the introduced issue. As Androw told
me that little fixups would be preferred instead of entire resend in
current stage, I guess a new series with this patch foled should not
be necessary. If a new series is still needed, please let me konw.
I would like to it.

Thanks.


