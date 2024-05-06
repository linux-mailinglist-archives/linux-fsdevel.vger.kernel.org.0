Return-Path: <linux-fsdevel+bounces-18809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409D28BC726
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 07:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BEB280D98
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 05:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B63D482C8;
	Mon,  6 May 2024 05:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UrliiQYN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D7347F4A;
	Mon,  6 May 2024 05:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714974648; cv=none; b=N0J2uWCfrf8CI817/6F9De6EBF8oJb2eBxdKtVsPynOVagGDGT4fI7ivzCgQyCzPNnj7+Mdx6UALF9E/EF+mA1XLECdXKInYKtKQxxFhgcAuH9t1lXoa7BWbpEMJqs00NTdG0I0TKxr3kjKgvUkrcdj2fZz9/k+VDdZH0Jalu80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714974648; c=relaxed/simple;
	bh=eW3jwfz6bKOXBu7OZKwEXC2aDpMjobO1Pl1Lw7wR61Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1sLbO3QVEyehaP3zDN8nsm9qsjgzpBh3W7dd/TUh34nFfukVL/xfpcAWKKDHrdSTm0+oLP/p/Y9S+9znV7+8vMMgxRqE//MAkgY+qBejuHua+jZp/okdXuZsUPvbFe+yQ9bFImyD1U/PhT6MXNpJVLz/SamnsoRPb6KDXySFnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UrliiQYN; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714974637; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jzjYRYNv9PIVT8Vfr3RNPMl2TSVcXUpCKYYeAEqj4j4=;
	b=UrliiQYNuyFz0FMHPr+J87xJa6HkJFRkGXLn1Fsg7Y7X43mtlUQKYBvrVK1aANLZH+x5k1bD27t9VpzpUV3BXu2XybCCli6k3Hcvy2u/tPb5COChLmlZTBv0rZESuO+TyzMzqWilciHIXwPaMHdPoCjKB9IrjzLTvt4CmI0iags=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5tv91D_1714974635;
Received: from 30.221.146.217(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W5tv91D_1714974635)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 13:50:36 +0800
Message-ID: <876cd180-6268-4f1a-a3bc-6b7b2aa3279f@linux.alibaba.com>
Date: Mon, 6 May 2024 13:50:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] cachefiles: remove request from xarry during flush
 requests
To: Baokun Li <libaokun@huaweicloud.com>, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun <yangerkun@huawei.com>
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-2-libaokun@huaweicloud.com>
 <6e4a20f7-263a-46be-81cc-2667353c452d@linux.alibaba.com>
 <ba40eb22-dc28-54b6-a8cb-7a8ba4464c9a@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <ba40eb22-dc28-54b6-a8cb-7a8ba4464c9a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/6/24 11:57 AM, Baokun Li wrote:
> On 2024/5/6 11:48, Jingbo Xu wrote:
>>
>> On 4/24/24 11:39 AM, libaokun@huaweicloud.com wrote:
>>> From: Baokun Li <libaokun1@huawei.com>
>>>
>>> This prevents concurrency from causing access to a freed req.
>> Could you give more details on how the concurrent access will happen?
>> How could another process access the &cache->reqs xarray after it has
>> been flushed?
> 
> Similar logic to restore leading to UAF:
> 
>      mount  |   daemon_thread1    |    daemon_thread2
> ------------------------------------------------------------
>  cachefiles_ondemand_init_object
>   cachefiles_ondemand_send_req
>    REQ_A = kzalloc(sizeof(*req) + data_len)
>    wait_for_completion(&REQ_A->done)
> 
>             cachefiles_daemon_read
>              cachefiles_ondemand_daemon_read
>               REQ_A = cachefiles_ondemand_select_req
>               cachefiles_ondemand_get_fd
>               copy_to_user(_buffer, msg, n)
>             process_open_req(REQ_A)
>                                   // close dev fd
>                                   cachefiles_flush_reqs
>                                    complete(&REQ_A->done)
>    kfree(REQ_A)


>              cachefiles_ondemand_get_fd(REQ_A)
>               fd = get_unused_fd_flags
>               file = anon_inode_getfile
>               fd_install(fd, file)
>               load = (void *)REQ_A->msg.data;
>               load->fd = fd;
>               // load UAF !!!

How could the second cachefiles_ondemand_get_fd() get called here, given
the cache has been flushed and flagged as DEAD?


> 
>>> ---
>>>   fs/cachefiles/daemon.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
>>> index 6465e2574230..ccb7b707ea4b 100644
>>> --- a/fs/cachefiles/daemon.c
>>> +++ b/fs/cachefiles/daemon.c
>>> @@ -159,6 +159,7 @@ static void cachefiles_flush_reqs(struct
>>> cachefiles_cache *cache)
>>>       xa_for_each(xa, index, req) {
>>>           req->error = -EIO;
>>>           complete(&req->done);
>>> +        __xa_erase(xa, index);
>>>       }
>>>       xa_unlock(xa);
>>>   
> 

-- 
Thanks,
Jingbo

