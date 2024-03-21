Return-Path: <linux-fsdevel+bounces-14952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E27881CC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 08:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142511C20D08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 07:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9442F4F8BC;
	Thu, 21 Mar 2024 07:12:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6E7381AA;
	Thu, 21 Mar 2024 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711005150; cv=none; b=Rbqt2myq3igPvjiKmEM6PK3qETEyYJXWl7FZfn2bM1oB8Po1/bwDbLJOpz05IIVrCumxCfMx3Rdv1SScewH1NLcKb2J1UOZWpoo9Rn/SRvl2U6xaCRBYVrBZv8RrLytIoD6EYzoK7w8Llf11VTAKzpui0QoL8vkp5rPvsrni660=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711005150; c=relaxed/simple;
	bh=mzMLKiw5MQzxQS21Hp1Kb386ukYGSQSd0ad2KKmfIrg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=s5YXMa/P86qS9VFEY/u2tzasOABQDL1Jnd6uJeCBAFl02sbyJfaNpsJQQafKYNNIyProZGJXNQte1r8xN4MT0Ht0XaJmofaWNlezEE9xHdBpkT0QqIfazzcGeSY8VoXEi2UtLJHJW8WKc8ArmwXYX4vW/MmvHZzQXEqDx0YyQhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V0c8x3B9rz4f3jsn;
	Thu, 21 Mar 2024 15:12:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 756BB1A016E;
	Thu, 21 Mar 2024 15:12:23 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgAnRQ7V3ftldCd1Hg--.33160S2;
	Thu, 21 Mar 2024 15:12:23 +0800 (CST)
Subject: Re: [PATCH 6/6] writeback: remove unneeded GDTC_INIT_NO_WB
To: Tejun Heo <tj@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 willy@infradead.org, bfoster@redhat.com, jack@suse.cz, dsterba@suse.com,
 mjguzik@gmail.com, dhowells@redhat.com, peterz@infradead.org
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-7-shikemeng@huaweicloud.com>
 <Zfr9my_tfxO-N6HS@mtj.duckdns.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <becdb16b-a318-ec05-61d2-d190541ae997@huaweicloud.com>
Date: Thu, 21 Mar 2024 15:12:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zfr9my_tfxO-N6HS@mtj.duckdns.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAnRQ7V3ftldCd1Hg--.33160S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZr4rtw1fWrW3Zw1UZF1UJrb_yoW8JF1rpF
	4fWa1UKFW5Ja9a9rnrCw4xXr90grZ7Ka9xJ3s8CwsxZa1fG3Z3Gr1qq3yFqF47Ar1fGr9x
	Z3yIq3Z7AFWUCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/20/2024 11:15 PM, Tejun Heo wrote:
> Hello,
> 
> On Wed, Mar 20, 2024 at 07:02:22PM +0800, Kemeng Shi wrote:
>> We never use gdtc->dom set with GDTC_INIT_NO_WB, just remove unneeded
>> GDTC_INIT_NO_WB
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ...
>>  void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty)
>>  {
>> -	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
>> +	struct dirty_throttle_control gdtc = { };
> 
> Even if it's currently not referenced, wouldn't it still be better to always
> guarantee that a dtc's dom is always initialized? I'm not sure what we get
> by removing this.
As we explicitly use GDTC_INIT_NO_WB to set global_wb_domain before
calculating dirty limit with domain_dirty_limits, I intuitively think the dirty
limit calculation in domain_dirty_limits is related to global_wb_domain when
CONFIG_WRITEBACK_CGROUP is enabled while the truth is not. So this is a little
confusing to me.
Would it be acceptable to you that we keep useing GDTC_INIT_NO_WB but
define GDTC_INIT_NO_WB to null fow now and redefine GDTC_INIT_NO_WB when some
member of gdtc is really needed.
Of couse I'm not insistent on this. Would like to hear you suggestion. Thanks!

> 
> Thanks.
> 


