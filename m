Return-Path: <linux-fsdevel+bounces-74354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 723BED39BF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 02:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7653530019FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 01:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C25C1C860C;
	Mon, 19 Jan 2026 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xaZj3dYa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE00519D8A8;
	Mon, 19 Jan 2026 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768786218; cv=none; b=KPrY+udTgn0UYaWGTzfZrZMEx/ebZHt4PAo3aFiVet8mPNBLrZlHWno41r4sAtaMvPwUpgMAaVZd3sXKWezRCnSLMQqQuP92Sz2Nb79Lfcs2vH03hdKX/qExZBh4wC9kTzPb3qn34W6BslJudbIWir51hzma8TiOlY6XIkljPtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768786218; c=relaxed/simple;
	bh=k4Lbt1La/Idaa9ZhCp8O5r3v0mAnbZeXzK1Z/a91kLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GJuaMqmKnA15kj3thmF+0aXFJCNf2Nb1m+uY7fleOhwYPIpVcyCdZkSwYqNLmebf7FUVk2+RHaw+/T40FT3wNiFM6lbRE6FXgXj+tOdvvxWntw6Zk0XUyrE4iA9sFlrhgKVc0SNFJg9Gkr9iJnRorOKDMR5NA5FIKqVNfnIxS1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xaZj3dYa; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DX+cVov4fFysjYhRJQyIa6FlEjht2c3WZDD1AZ+Vh30=;
	b=xaZj3dYaUAmJgLAtqYmWF5bWWZGR7qv4prEgcwhNd8LY36Rfmtr9Zarj/uEGHJRxwaWh7uItO
	JAbVtmAxxOgDpzKDwPIh9CDS8ZwzQZqvNQ6DU+N0DbLwSrvB4kSN+N82+FS+p8XLqZvcV6YqZw7
	MtuoGgpmnQCgwyn8hZ9eiWw=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dvXqT5f5tz1cySS;
	Mon, 19 Jan 2026 09:26:45 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id A6E2E40539;
	Mon, 19 Jan 2026 09:30:07 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Jan 2026 09:30:07 +0800
Message-ID: <1444f838-b755-42ad-84a5-bcc76b1a76c2@huawei.com>
Date: Mon, 19 Jan 2026 09:30:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 9/9] erofs: implement .fadvise for page cache share
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
CC: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-10-lihongbo22@huawei.com>
 <20260116154654.GD21174@lst.de>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20260116154654.GD21174@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)



On 2026/1/16 23:46, Christoph Hellwig wrote:
> On Fri, Jan 16, 2026 at 09:55:50AM +0000, Hongbo Li wrote:
>> +static int erofs_ishare_fadvise(struct file *file, loff_t offset,
>> +				      loff_t len, int advice)
>> +{
>> +	return vfs_fadvise((struct file *)file->private_data,
>> +			   offset, len, advice);
> 
> No need to cast a void pointer.
> 
Thanks, will remove in next.

Thanks,
Hongbo

