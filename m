Return-Path: <linux-fsdevel+bounces-74353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36602D39BE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 02:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76CD03008F92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 01:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A161C860C;
	Mon, 19 Jan 2026 01:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5sx6wMC/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266033B28D;
	Mon, 19 Jan 2026 01:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768785827; cv=none; b=qbIK0NahkHoWnV5gFU31BWlLk6a8177/bXMZOfmKN9Yj0i78HGHE3KSRorcRNhuH+NNBeRfhDLMTvd0YYY1xFzj1/WxsmgDnTgHmr+NBONyFF2rS5qjVpJCoG5zRacn8w45dQpzp+jxy9QDTBBs48y7T3td6l6UZWx5tvFy3Jd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768785827; c=relaxed/simple;
	bh=RWiszc1RJ1JBInh4yUYC+PGB1Hc+m/WqkB61cgLQwVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a3dyEgy/mRNVQD1nT8geqjxOB8u4ZR/TFzvxy9EBdJ6p1TMOeB7C4/bJP2FJO/RGjw3sydin+aKElwyTkkHMVTFPY0DmA7hNHo7jTLj0gTlrW/SAx0k2kAD/cN3ZaMzFIm2FFj+6qMGDfl1cvd9c+7v6f+bhhnEmdukQW+95+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5sx6wMC/; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gba2ktAjy+g71eevs0XUENyEHWbD0Qkbdb1/QKJXxK0=;
	b=5sx6wMC/nc8WBo/cRYm/rpR6NqMoGK1/b5Dh82yOsbRZBDc5767PZtHZfUv8w2lvELDWgZARO
	lcxMYVF89CRW8F+V6ErvUK40hkRwkROchxRRpvwq/QShXniCu6BE9vEDijul5IDmackJNTY23I3
	aZGv4isjWr+h+/A1qplP81Y=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dvXgz0W98z1K9D6;
	Mon, 19 Jan 2026 09:20:15 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 6735340565;
	Mon, 19 Jan 2026 09:23:35 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Jan 2026 09:23:34 +0800
Message-ID: <dd20d5d5-3623-40ff-8462-3a36f3b116ed@huawei.com>
Date: Mon, 19 Jan 2026 09:23:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 0/9] erofs: Introduce page cache sharing feature
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Christoph Hellwig <hch@lst.de>
CC: <chao@kernel.org>, <brauner@kernel.org>, <djwong@kernel.org>,
	<amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116153656.GA21174@lst.de>
 <e8a5f615-b527-4530-bc3d-0adc4b0b05d6@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <e8a5f615-b527-4530-bc3d-0adc4b0b05d6@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)

Thanks for comments and attention.

So in short: Two files with identical content fingerprints 
(user-defined, such as sha256) will share the same page cache which 
associated with an anonymous inode. Data operations are redirected to 
the anonymous inode while metadata operations (include locating the data 
position on disk) are still performed on the original inode(realinode).

Sorry for the ambiguous annotation, and I will refine the cover-letter 
in next iteration to make it clear as possible.

Thanks,
Hongbo

On 2026/1/17 0:43, Gao Xiang wrote:
> 
> 
> On 2026/1/16 23:36, Christoph Hellwig wrote:
> 
>>
>> Also do you have a git tree for the whole feature?
> 
> I prepared a test tree for Hongbo but it's v14:
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/log/?h=erofs/pagecache-share
> 
> I think v15 is almost close to the final status,
> I hope Hongbo addresses your comment and I will
> review the remaining parts too and apply to
> linux-next at the beginning of next week.
> 
> Thanks,
> Gao Xiang

