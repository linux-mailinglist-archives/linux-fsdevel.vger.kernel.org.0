Return-Path: <linux-fsdevel+bounces-23095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9415B926FBD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 08:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61091C2154D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 06:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBBD1A08BE;
	Thu,  4 Jul 2024 06:40:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EC31A0732;
	Thu,  4 Jul 2024 06:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075226; cv=none; b=iAsWqLnur1gv9NE9g5ZdVl8Q2ofEvf1Qd2+rQV92LdJfqgmC/Ks+8zz5lCgbSf5J+PRa+9f6ffu1CSV7EAQfkHoTUbBdBIwits/eY+s0gMbrvD0pvhXjBJAw3N3nH0uaGLFPUOUIqRErQYyW/yII5v82ZTxjUS6zjQPzid1MWYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075226; c=relaxed/simple;
	bh=bVVSkhG8YaGagEVNZ3Ep1hP9xAfC/Co1NxO3HK12aX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fjXRDE3GrjRn+wK5SIypxnAbZHa5jN5Sfj95Ial7FCYVncVngVng0pMXB/YGHXIcxgc6H+gz3ePYqi/b216axD2SeLh65vwYRrpJXT0likPzisJ6ZAN+Lb83S/XbcXskjOSnqK0XCM596EZVvQXhuta7OZatRwJeff3e82Q4X4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WF6NJ1McjzZhZg;
	Thu,  4 Jul 2024 14:35:44 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id BFADD1400D1;
	Thu,  4 Jul 2024 14:40:18 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 14:40:18 +0800
Message-ID: <b9160595-bcfe-4ea1-852f-f8189e129cbc@huawei.com>
Date: Thu, 4 Jul 2024 14:40:17 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hugetlbfs: support tracepoint
To: Matthew Wilcox <willy@infradead.org>
CC: <muchun.song@linux.dev>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-mm@kvack.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <20240704030704.2289667-1-lihongbo22@huawei.com>
 <20240704030704.2289667-2-lihongbo22@huawei.com>
 <ZoYY-sfj5jvs8UpQ@casper.infradead.org>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <ZoYY-sfj5jvs8UpQ@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/7/4 11:37, Matthew Wilcox wrote:
> On Thu, Jul 04, 2024 at 11:07:03AM +0800, Hongbo Li wrote:
>> +	TP_printk("dev = (%d,%d), ino = %lu, dir = %lu, mode = 0%o",
>> +		MAJOR(__entry->dev), MINOR(__entry->dev),
>> +		(unsigned long) __entry->ino,
>> +		(unsigned long) __entry->dir, __entry->mode)
> 
> erofs and f2fs are the only two places that print devices like this.
> 
> 	"dev=%d:%d inode=%lx"
> 
> Why do we need dir and mode?
Thanks for reviewing!

Here dir and mode are used to track the creation of the directory tree.
> 
> Actually, why do we need a tracepoint on alloc_inode at all?  What
> does it help us debug, and why does no other filesystem need an
> alloc_inode tracepoint?
> 
In fact, f2fs and ext4 have added this tracepoint such as 
trace_f2fs_new_inode(in f2fs) and trace_ext4_allocate_inode(in ext4). 
This can trace the lifecycle of an inode comprehensively. These 
tracepoints are used to debug some closed application scenarios, and 
also helping developers to debug the filesystem logic in hugetlbfs.

Thanks,
Hongbo

