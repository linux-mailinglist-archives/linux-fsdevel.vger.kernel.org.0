Return-Path: <linux-fsdevel+bounces-75239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIb/Nx4wc2mTswAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:23:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 420AE7266D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7675D300EF92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE4133E378;
	Fri, 23 Jan 2026 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZGW//1RY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8F0263C8F;
	Fri, 23 Jan 2026 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769156507; cv=none; b=KYsUkhUkymcO2YIM8ngIlwkgz4L0sf18VJgD1G1KDd3QzCh+TyqUfStQNlmfxTArVt6kLV9ejhgu9CM1a6aLDShwvV+Ufv45meGRVrjIrVMzbfR/AJJRz5cI/7AyJJEpUTxDcFKBfF552uZehLlblPaBOAZ/nLnqPVE1/v/hg10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769156507; c=relaxed/simple;
	bh=2GpzZ9ZYwB5LCNaqoegN9i1n5b7oQh48aowVNuZ/HRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rGxjoH0A+GSdqdUKbcLScSrIqW6zey+aKRRKhjXOzC/I78bDxaFuxZibtFB0cHSLQeUejvXj+wH8jdX4b3pJ/nk0ehcAqmChpdFoZiKBBU9iN8eJNLjy9hODtA6VjcqHHbwP0QQ7rOzE/BIohyj/YnJGvnAHRbH2FSmX7kvzU+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZGW//1RY; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XPpBwN+Ym64kt/gOXADmq5l86PyuqqhVUYveTqcrDUY=;
	b=ZGW//1RYRTolN6mbtqAHV/mZnwIDOA57/XW6eGmsWVCa9shqLkSsNFMTqGQMryfuzuqMAwIh2
	LafjjnwZmwtBhVi6O+pJV8IGfz6D4KIOZOS3oNzf/3DWY3PzdxlQ47ErVvi/dUDp2yxlV/HCca3
	21io3ldhJqtqWJv/W8cgu8M=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dy9mQ56r2z1prKt;
	Fri, 23 Jan 2026 16:18:14 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 942DA40570;
	Fri, 23 Jan 2026 16:21:41 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 23 Jan 2026 16:21:40 +0800
Message-ID: <7b8bd967-bc81-434a-802c-8c2b95259700@huawei.com>
Date: Fri, 23 Jan 2026 16:21:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 04/10] erofs: add erofs_inode_set_aops helper to set
 the aops.
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Christoph Hellwig <hch@lst.de>
CC: <chao@kernel.org>, <brauner@kernel.org>, <djwong@kernel.org>,
	<amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20260122133718.658056-1-lihongbo22@huawei.com>
 <20260122133718.658056-5-lihongbo22@huawei.com>
 <b20b263d-132b-464e-8314-d3f795e5e582@linux.alibaba.com>
 <20260123061825.GA25722@lst.de>
 <e0b170ec-253e-49ed-be62-9a90e9eb9053@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <e0b170ec-253e-49ed-be62-9a90e9eb9053@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75239-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.965];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: 420AE7266D
X-Rspamd-Action: no action

Hi Xiang and Christoph,

On 2026/1/23 15:42, Gao Xiang wrote:
> 
> 
> On 2026/1/23 14:18, Christoph Hellwig wrote:
>> On Thu, Jan 22, 2026 at 09:54:15PM +0800, Gao Xiang wrote:
>>>> @@ -455,6 +455,29 @@ static inline void *erofs_vm_map_ram(struct 
>>>> page **pages, unsigned int count)
>>>>        return NULL;
>>>>    }
>>>>    +static inline int erofs_inode_set_aops(struct inode *inode,
>>>> +                       struct inode *realinode, bool no_fscache)
>>>> +{
>>>> +    if 
>>>> (erofs_inode_is_data_compressed(EROFS_I(realinode)->datalayout)) {
>>>> +        if (!IS_ENABLED(CONFIG_EROFS_FS_ZIP))
>>>> +            return -EOPNOTSUPP;
>>>> +        DO_ONCE_LITE_IF(realinode->i_blkbits != PAGE_SHIFT,
>>>> +              erofs_info, realinode->i_sb,
>>>> +              "EXPERIMENTAL EROFS subpage compressed block support 
>>>> in use. Use at your own risk!");
>>>> +        inode->i_mapping->a_ops = &z_erofs_aops;
>>>
>>> Is that available if CONFIG_EROFS_FS_ZIP is undefined?
>>
>> z_erofs_aops is declared unconditionally, and the IS_ENABLED above
>> ensures the compiler will never generate a reference to it.
>>
>> So this is fine, and a very usualy trick to make the code more
>> readable.
> 
> Yeah, I get your point, that is really helpful and I haven't
> used that trick.
> 
> The other problem was the else part is incorrect, Hongbo,
> how about applying the following code and resend the next
> version, I will apply all patches later:
> 

Thanks you very much for your careful review and help. It was indeed my 
own mistake (I have been making errors too easily lately which taught me 
a lot...).
I have updated the new version in:

https://lore.kernel.org/all/20260123075239.664330-1-lihongbo22@huawei.com/

Thanks,
Hongbo

> static inline int erofs_inode_set_aops(struct inode *inode,
>                                         struct inode *realinode, bool 
> no_fscache)
> {
>          if 
> (erofs_inode_is_data_compressed(EROFS_I(realinode)->datalayout)) {
>                  if (!IS_ENABLED(CONFIG_EROFS_FS_ZIP))
>                          return -EOPNOTSUPP;
>                  DO_ONCE_LITE_IF(realinode->i_blkbits != PAGE_SHIFT,
>                            erofs_info, realinode->i_sb,
>                            "EXPERIMENTAL EROFS subpage compressed block 
> support in use. Use at your own risk!");
>                  inode->i_mapping->a_ops = &z_erofs_aops;
>                  return 0;
>          }
>          inode->i_mapping->a_ops = &erofs_aops;
>          if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !no_fscache &&
>              erofs_is_fscache_mode(realinode->i_sb))
>                  inode->i_mapping->a_ops = &erofs_fscache_access_aops;
>          if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) &&
>              erofs_is_fileio_mode(EROFS_SB(realinode->i_sb)))
>                  inode->i_mapping->a_ops = &erofs_fileio_aops;
>          return 0;
> }
> 
> Thanks,
> Gao Xiang

