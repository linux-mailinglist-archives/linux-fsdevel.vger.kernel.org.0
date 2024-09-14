Return-Path: <linux-fsdevel+bounces-29373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4737978F00
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 10:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81EA31F2358E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 08:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3F313D51B;
	Sat, 14 Sep 2024 08:09:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D9810E9;
	Sat, 14 Sep 2024 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726301376; cv=none; b=aYv3G5Ay1IpwBG4P4Ld04KzvZn9GZ/+D6lGVjVQGfXntxqHRd2f5cC5MPr3xbf/bGfw5HnKi6/ayB+eNFTpnGPl/8F+7cvB02yuk/JtXo8uAg+0YI9soQVUeggKCYrIDRmnQnIb5ECeATQ2BPXlqcuNiVZtcSFOaeUpEZKXleG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726301376; c=relaxed/simple;
	bh=hsbtLFpJhDGNRlHyhZUO4BRjdVPEg0v1yCWp3kAGgSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mDcz+eAnnwmTt5ly/T0/gHn+xURDiB1bSATl4Pr8Ibl9EaXgORZJSSRRjz+inGHwfOOAebD/h9ykDtvDWtNNMpANtFwK6E4tkgTzOFCXjwIJm/ScwVESFbc+k4UPktg5B99B9s6i0g+pYIGxbLOT6eMyJtnMSwC31HcevSB+1yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X5P0t1LSLzmYkK;
	Sat, 14 Sep 2024 16:07:26 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 175F91800A0;
	Sat, 14 Sep 2024 16:09:31 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 14 Sep 2024 16:09:30 +0800
Message-ID: <bc88a7b9-3be8-4084-86a1-fe464ce99213@huawei.com>
Date: Sat, 14 Sep 2024 16:09:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 0/2] Introduce tracepoint for hugetlbfs
Content-Language: en-US
To: <muchun.song@linux.dev>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-mm@kvack.org>,
	<david@fromorbit.com>, <songmuchun@bytedance.com>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <20240829064110.67884-1-lihongbo22@huawei.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240829064110.67884-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Hi,

Just a gently ping for this. Does this patch have a change of making it 
into this cycle?

Thanks,
Hongbo

On 2024/8/29 14:41, Hongbo Li wrote:
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

