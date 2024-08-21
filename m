Return-Path: <linux-fsdevel+bounces-26449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B72959544
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 09:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B284F28596E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 07:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AE1199FBE;
	Wed, 21 Aug 2024 07:03:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7A199FB8;
	Wed, 21 Aug 2024 07:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223785; cv=none; b=knzQEzBa/+NGUuowVF6DCQ8hflHo+EWRpuL/uJ3eoyTBJ+0nWG4UETXucW3oTq2VcJAo5RCXo6OIhlsyRk3P1axDejovnM9fw0TzRUoQvun5nl51fMz9D0qUlkhknwSKwd8MM8WTTbyXeWunRek6Ize4z/hfus4PO85BTwJcd18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223785; c=relaxed/simple;
	bh=uMxsRtpauuHxCh+Ur9x77juooYH+JKjqpkw1YVJytGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ugOV1bSCWs65fHnDjG/h5XQ0vLEP0pYNtqyhL1pHk10TqW/Xg1BNxv1jFP2I9AQGI7MxohG0pjXqbAR0OSBJuiSYO8ChopcMNg9I7DVi+m/t8N7Tj0g8TbzYzpdFRmvOcK7qapkYfa6ZRqPN+R37eRV3K8y6o+LOzKRk78yjK5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WpcgQ6CsSz1xvPD;
	Wed, 21 Aug 2024 15:01:06 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 561EA1400CA;
	Wed, 21 Aug 2024 15:03:01 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 15:03:01 +0800
Message-ID: <eac78afd-aae1-4527-8caf-a67f9381d589@huawei.com>
Date: Wed, 21 Aug 2024 15:03:00 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Introduce tracepoint for hugetlbfs
Content-Language: en-US
To: <muchun.song@linux.dev>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<david@fromorbit.com>
CC: <mathieu.desnoyers@efficios.com>, <linux-mm@kvack.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <20240723030834.213012-1-lihongbo22@huawei.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240723030834.213012-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Give you a friendly ping.🙂

Thanks,
Hongbo

On 2024/7/23 11:08, Hongbo Li wrote:
> Here we add some basic tracepoints for debugging hugetlbfs: {alloc, free,
> evict}_inode, setattr and fallocate.
> 
> v2 can be found at:
> https://lore.kernel.org/all/ZoYY-sfj5jvs8UpQ@casper.infradead.org/T/
> 
> Changes since v2:
>    - Simplify the tracepoint output for setattr.
>    - Make every token be space separated.
> 
> 
> v1 can be found at:
> https://lore.kernel.org/linux-mm/20240701194906.3a9b6765@gandalf.local.home/T/
> 
> Changes since v1:
>    - Decrease the parameters for setattr tracer suggested by Steve and Mathieu.
>    - Replace current_user_ns() with init_user_ns when translate uid/gid.
> 
> Hongbo Li (2):
>    hugetlbfs: support tracepoint
>    hugetlbfs: use tracepoints in hugetlbfs functions.
> 
>   MAINTAINERS                      |   1 +
>   fs/hugetlbfs/inode.c             |  17 +++-
>   include/trace/events/hugetlbfs.h | 156 +++++++++++++++++++++++++++++++
>   3 files changed, 172 insertions(+), 2 deletions(-)
>   create mode 100644 include/trace/events/hugetlbfs.h
> 

