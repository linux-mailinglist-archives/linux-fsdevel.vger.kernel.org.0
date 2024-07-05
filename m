Return-Path: <linux-fsdevel+bounces-23182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C75159281FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 08:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B681285928
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 06:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374C813BAC4;
	Fri,  5 Jul 2024 06:24:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C902C1E494;
	Fri,  5 Jul 2024 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160676; cv=none; b=dFCl/o5GMl7E+TG/zE2ySBHFznDvKGQv/Cbw+1NvfuGJ8aBTRxyg2JThVIQf0kyEnNjNkmFshsFarJbdSFKyw2LlXo7UdRMhKK4fWI2QnUYsorNVJe23WUUUmVN/dq733lzlo+/rbzlrz8ImPeOwfD7ZO7AVlRvndtqFYD3I/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160676; c=relaxed/simple;
	bh=wWLJqDfALFxXxpYQhQJ07mIjsuZYN1jZpqtAbk29Fvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sbrNs48YxMykPfW723JZHfqtJ4ZS3dGCJXsogGMVb128xGmjEz7dBmrr+0CA9Un6vOyNinrv5js6ECmHDqOndexKYp6A3YGTQiDBfTssJwVrjq6HHqufCYwJ5epYI+kcJCE/4QLCmvNxtFmy79purqXKV80IP8lHRLnBPBiXgyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WFk0Q47LlzQkMZ;
	Fri,  5 Jul 2024 14:20:38 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id AFB4618009B;
	Fri,  5 Jul 2024 14:24:28 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 14:24:28 +0800
Message-ID: <f23470ee-52cf-497c-b8c8-b44b09bee7eb@huawei.com>
Date: Fri, 5 Jul 2024 14:24:27 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hugetlbfs: support tracepoint
To: Dave Chinner <david@fromorbit.com>, Steven Rostedt <rostedt@goodmis.org>
CC: Matthew Wilcox <willy@infradead.org>, <muchun.song@linux.dev>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
	<linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
References: <20240704030704.2289667-1-lihongbo22@huawei.com>
 <20240704030704.2289667-2-lihongbo22@huawei.com>
 <ZoYY-sfj5jvs8UpQ@casper.infradead.org>
 <Zoab/VXoPkUna7L2@dread.disaster.area>
 <20240704101322.2743ec24@rorschach.local.home>
 <ZocxiSIQdm0tyaVG@dread.disaster.area>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <ZocxiSIQdm0tyaVG@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/7/5 7:34, Dave Chinner wrote:
> On Thu, Jul 04, 2024 at 10:13:22AM -0400, Steven Rostedt wrote:
>> On Thu, 4 Jul 2024 22:56:29 +1000
>> Dave Chinner <david@fromorbit.com> wrote:
>>
>>> Having to do this is additional work when writing use-once scripts
>>> that get thrown away when the tracepoint output analysis is done
>>> is painful, and it's completely unnecessary if the tracepoint output
>>> is completely space separated from the start.
>>
>> If you are using scripts to parse the output, then you could just
>> enable the "fields" options, which will just ignore the TP_printk() and
>> print the fields in both their hex and decimal values:
>>
>>   # trace-cmd start -e filemap -O fields
>>
>> // the above fields change can also be done with:
>> //  echo 1 > /sys/kernel/tracing/options/fields
>>
>>   # trace-cmd show
>> # tracer: nop
>> #
>> # entries-in-buffer/entries-written: 8/8   #P:8
>> #
>> #                                _-----=> irqs-off/BH-disabled
>> #                               / _----=> need-resched
>> #                              | / _---=> hardirq/softirq
>> #                              || / _--=> preempt-depth
>> #                              ||| / _-=> migrate-disable
>> #                              |||| /     delay
>> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>> #              | |         |   |||||     |         |
>>              less-2527    [004] ..... 61949.896458: mm_filemap_add_to_page_cache: pfn=0x144625 (1328677) i_ino=0x335c6 (210374) index=0x0 (0) s_dev=0xfe00003 (266338307) order=(0)
>>              less-2527    [004] d..2. 61949.896926: mm_filemap_delete_from_page_cache: pfn=0x152b07 (1387271) i_ino=0x2d73a (186170) index=0x0 (0) s_dev=0xfe00003 (266338307) order=(0)
>>       jbd2/vda3-8-268     [005] ..... 61954.461964: mm_filemap_add_to_page_cache: pfn=0x152b70 (1387376) i_ino=0xfe00003 (266338307) index=0x30bd33 (3194163) s_dev=0x3 (3) order=(0)
>>       jbd2/vda3-8-268     [005] ..... 61954.462669: mm_filemap_add_to_page_cache: pfn=0x15335b (1389403) i_ino=0xfe00003 (266338307) index=0x30bd40 (3194176) s_dev=0x3 (3) order=(0)
>>       jbd2/vda3-8-268     [005] ..... 62001.565391: mm_filemap_add_to_page_cache: pfn=0x13a996 (1288598) i_ino=0xfe00003 (266338307) index=0x30bd41 (3194177) s_dev=0x3 (3) order=(0)
>>       jbd2/vda3-8-268     [005] ..... 62001.566081: mm_filemap_add_to_page_cache: pfn=0x1446b5 (1328821) i_ino=0xfe00003 (266338307) index=0x30bd43 (3194179) s_dev=0x3 (3) order=(0)
>>              less-2530    [004] ..... 62033.182309: mm_filemap_add_to_page_cache: pfn=0x13d755 (1300309) i_ino=0x2d73a (186170) index=0x0 (0) s_dev=0xfe00003 (266338307) order=(0)
>>              less-2530    [004] d..2. 62033.182801: mm_filemap_delete_from_page_cache: pfn=0x144625 (1328677) i_ino=0x335c6 (210374) index=0x0 (0) s_dev=0xfe00003 (266338307) order=(0)
> 
> Yes, I know about that. But this just makes things harder, because
> now there are *3* different formats that have to be handled (i.e.
> now we also have to strip "()" around numbers).
Perhaps if users want to filter the format, they could enable the 
"fields" option in a unified manner. As for TP_printk(), it depends on 
how to better display the data used for debugging.

Thanks,
Hongbo
> 
> -Dave.

