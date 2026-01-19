Return-Path: <linux-fsdevel+bounces-74356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B46D39C15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 02:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 229AA30012D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 01:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A0821FF23;
	Mon, 19 Jan 2026 01:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fCML1mST"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E334500967;
	Mon, 19 Jan 2026 01:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787112; cv=none; b=hyonkmzZkjYj1GmJpd+gl1oUWsBajcvIV3PTkoJ0xaMdY/eGCvAo/MBzJhLoaogg8bi3uegI5hkbZYoTzaPFIbD/H+pbNttbUYpUswuFcICVl8A9qSoATKiBARTm7wkUDLaWsi/RDECbV0edtUs92WAcTOfMRBvVlD9HdUHHDTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787112; c=relaxed/simple;
	bh=QyYz3+kBs83z5qWK7u97XINzXP7JLNnKTx3hc2iOtOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCotJmFeJB5t38krYCnOcLnKgJYmTvFLmChCfF++TceF/fXNw1Jb5TfLZrDeueuEuO7uqfOzJXWlpH6vwTb5hYXleB5M7Q4G2YniwMnJ1tQzx3iY3sBD0jS60yyhQT/ejBlF9sQ6UJsGJDSxDrmLUYOypRHuypmYywJ03EbHYF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fCML1mST; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768787101; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=70OK0vfG6EdaS0YAPabCTxwfq6NC1XRXCyBnAyA6LFo=;
	b=fCML1mST9pZOxY2MnN3Y9083eYoyLSWELWobqamc2w3z00y1DJg63pTwvt0y/0lHs3ELhGAHiCDZ6WhSxfiqVGK5hoj4+P+YEkewYoE/2N5Y8MNIKkTJLxC3Cab4xXeNCzYczaMf5uhwLjAAVsmz2UTNJpEFxBCnrr3drxmfgbo=
Received: from 30.221.131.184(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxHDcRg_1768787100 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Jan 2026 09:45:00 +0800
Message-ID: <e4a45ea4-a0e9-4b8e-ab8b-b4dbb6a2ba21@linux.alibaba.com>
Date: Mon, 19 Jan 2026 09:44:59 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 2/9] erofs: decouple `struct erofs_anon_fs_type`
To: Hongbo Li <lihongbo22@huawei.com>
Cc: chao@kernel.org, brauner@kernel.org, djwong@kernel.org,
 amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-3-lihongbo22@huawei.com>
 <20260116153829.GB21174@lst.de>
 <c2f3f8bd-6319-4f5a-92cf-7717fa0c0972@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <c2f3f8bd-6319-4f5a-92cf-7717fa0c0972@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/19 09:34, Hongbo Li wrote:
> Hi, Xiang
> 
> On 2026/1/16 23:38, Christoph Hellwig wrote:
>>> +#if defined(CONFIG_EROFS_FS_ONDEMAND)
>>
>> Normally this would just use #ifdef.
>>
> How about using #ifdef for all of them? I checked and there are only three places in total, and all of them are related to FS_PAGE_CACHE_SHARE or FS_ONDEMAND config macro.

I'm fine with most cases (including here).

But I'm not sure if there is a case as `#if defined() || defined()`,
it seems it cannot be simply replaced with `#ifdef`.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo


