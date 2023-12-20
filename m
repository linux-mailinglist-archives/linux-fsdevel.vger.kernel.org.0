Return-Path: <linux-fsdevel+bounces-6538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE28D819678
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 02:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE7D2B23853
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 01:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE6710A3C;
	Wed, 20 Dec 2023 01:44:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4371F9D5;
	Wed, 20 Dec 2023 01:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VysQptC_1703036628;
Received: from 30.221.146.138(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VysQptC_1703036628)
          by smtp.aliyun-inc.com;
          Wed, 20 Dec 2023 09:43:49 +0800
Message-ID: <9f11d308-54a8-4152-9da7-90a49de8d5e0@linux.alibaba.com>
Date: Wed, 20 Dec 2023 09:43:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] mm: fix arithmetic for bdi min_ratio and max_ratio
Content-Language: en-US
To: Stefan Roesch <shr@devkernel.io>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, willy@infradead.org
References: <20231219142508.86265-1-jefflexu@linux.alibaba.com>
 <79e0cb77-ea6a-427f-af5e-c1762049ac89@app.fastmail.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <79e0cb77-ea6a-427f-af5e-c1762049ac89@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/20/23 1:56 AM, Stefan Roesch wrote:
> It would be good if the cover letter describes what this fixes.

Thanks. Would notice that next time :)

> 
> On Tue, Dec 19, 2023, at 6:25 AM, Jingbo Xu wrote:
>> changes since v2:
>> - patch 2: drop div64_u64(), instead write it out mathematically
>>   (Matthew Wilcox)
>>
>> changes since v1:
>> - split the previous v1 patch into two separate patches with
>>   corresponding "Fixes" tag (Andrew Morton)
>> - patch 2: remove "UL" suffix for the "100" constant
>>
>> v1: 
>> https://lore.kernel.org/all/20231218031640.77983-1-jefflexu@linux.alibaba.com/
>> v2: 
>> https://lore.kernel.org/all/20231219024246.65654-1-jefflexu@linux.alibaba.com/
>>
>> Jingbo Xu (2):
>>   mm: fix arithmetic for bdi min_ratio
>>   mm: fix arithmetic for max_prop_frac when setting max_ratio
>>
>>  mm/page-writeback.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> -- 
>> 2.19.1.6.gb485710b

-- 
Thanks,
Jingbo

