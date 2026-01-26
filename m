Return-Path: <linux-fsdevel+bounces-75467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ImHInpqd2nCfQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 14:22:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A2188C38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 14:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8210D3027684
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 13:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0616A3385A9;
	Mon, 26 Jan 2026 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4qVM2R8C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57E7277023
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769433708; cv=none; b=c5H8SfF+LexHgqRODNekxTvbHPUsDDrjGi5KEPp/JMNBmy7o/Nl6zbE2LiEXF4x2vOtiKs4lR9vBoOC34R8MIfOvEK2akItJ27tAWD6z4o8Kf/GkSakuWZFmaMJXvUZHpoda1WMKVw0uP273H31g1B615EqmPfpYXAVAnQjWu5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769433708; c=relaxed/simple;
	bh=AjddTCLajgQsyTgd8lExvle+LHxrKXo1LzZSvQ6wHJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d6gwf1H7c1YtZjPTu0gY2QtRkqgA0oHWAg0cW6jzVAo98InzNEemeIoOlYzsi1qV78vIMPG+QC8IfIMBFPDU0uWxlCetg1VV+md5gWP8OaJeR2Eh3FnTrS2Air4+8dtUj3oV/KvXyf3QJJ/bIjmBkXO/GRt0tuzpGgQXmGGk5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4qVM2R8C; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DO0+y6DES9i7FutH27Zm+LkJDdcdPDDEFUz7GTvgvTI=;
	b=4qVM2R8C7/Tfkcfo3H4u5Xv1TitpucfRGcZktU//U7v/+3xhQwUk5RnFuiKeq/lXL59IAjN2j
	AqELhCYzPvrZH9OqNAkUmSfHjYuUI1MoSMhbDIpvoMU/hGMF0ANig3lxvb130rTPwBw9Sm+Y4Xj
	mLRIoyGKQkyAORPPw86r8tI=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4f08GR5lxhzcZyl;
	Mon, 26 Jan 2026 21:17:35 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 5BBEB40569;
	Mon, 26 Jan 2026 21:21:42 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 Jan 2026 21:21:41 +0800
Message-ID: <88b0259d-1fd0-4621-9291-ea777e676529@huawei.com>
Date: Mon, 26 Jan 2026 21:21:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fs/iomap: Describle @private in iomap_readahead()
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <linux-fsdevel@vger.kernel.org>, <brauner@kernel.org>, <djwong@kernel.org>
References: <20260126120020.675179-1-lihongbo22@huawei.com>
 <20260126120020.675179-2-lihongbo22@huawei.com>
 <2e960c83-ff29-4d78-927f-64c5cd84d87d@linux.alibaba.com>
 <de894823-29d7-490c-a3fc-f36c7bc27f3c@huawei.com>
 <851f8dea-f7ae-4d39-b6c4-1188542c0bda@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <851f8dea-f7ae-4d39-b6c4-1188542c0bda@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75467-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,huawei.com:email,huawei.com:dkim,huawei.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25A2188C38
X-Rspamd-Action: no action



On 2026/1/26 21:08, Gao Xiang wrote:
> 
> 
> On 2026/1/26 21:01, Hongbo Li wrote:
>>
>>
>> On 2026/1/26 20:38, Gao Xiang wrote:
>>>
>>>
>>> On 2026/1/26 20:00, Hongbo Li wrote:
>>>> The kernel test rebot reports the kernel-doc warning:
>>>>
>>>> ```
>>>> Warning: fs/iomap/buffered-io.c:624 function parameter 'private'
>>>>   not described in 'iomap_readahead'
>>>> ```
>>>>
>>>> The former commit in "iomap: stash iomap read ctx in the private
>>>> field of iomap_iter" has added a new parameter @private to
>>>> iomap_readahead(), so let's describe the parameter.
>>>>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Closes: 
>>>> https://lore.kernel.org/oe-kbuild-all/202601261111.vIL9rhgD-lkp@intel.com/
>>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>>
>>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>>
>>> btw, I don't think the cover letter is needed for
>>> this single patch.
>>
>> Thank you!
>>
>> I would like to use this to indicate that this is a patch based on the 
>> vfs-iomap branch. Maybe another way might be possible to place this 
>> information in the hidden area after the SOB.
> 
> The best practice for a single patch is to drop those comments
> after the first `---` line.
> 

Ok, got it, and thank you!

Thanks,
Hongbo

> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Hongbo
>>
>>>
>>> Thanks,
>>> Gao Xiang
> 

