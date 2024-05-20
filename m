Return-Path: <linux-fsdevel+bounces-19770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B93F8C9A43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F39B1F213F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B911CD20;
	Mon, 20 May 2024 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sgEHnjXN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B3EFC1D;
	Mon, 20 May 2024 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197055; cv=none; b=ec89MqhCQHIx5zKcWTNyMIZdr9MMFdAcNyKqVMKOIquh9m3jeRyWxEfnNq/39QHRrJVWsqHbIttmVWUmgBc8WXw2o4X6ZrtmzJgbe5Rbxg6YsEtB5nud/tGTDWidMkYOGlmEaL65Hz5XcKOq/rjxdSagj9xcyzzdaGgGBIg9PUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197055; c=relaxed/simple;
	bh=YaRWz5ZPAgxsyx3A/YCS4XSvpzdxlutVvqHz7AR9X6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgxcwZ0kZ6F+pjrKKq9QBZraCTMJX64sFNu7bajKkjMvXMhvlyg9ctHhO+Nk0DMICDihFh26w4tBRnmpjtRhKuygGBrsMcB/tYFObRyk2hHk9HFYy4HznsWIcqNXV0w2GXlV/qi3I7vxLMzS9g4scRreGSRYeXKSKa0v5XRIhR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sgEHnjXN; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716197043; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ypw9L8vrY/zJiXV/6qIjcOg86oiLiLLexz5cMQSyyW4=;
	b=sgEHnjXN4dLRHHa9shmzQuKv862c4R7/C9/qg7nsq23BivIxoTEHFVbb+WSlT36YyymYDu8BJln/Ez0kxc15cDYFf1l/BQYd+iAMx4nXcjR+pa5qQbF6Wl1qnRcG3KE/NopAtkqF9EhZyhVZSRlpBthIMIEMd4y//3P/uG1BFcI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6qKcWT_1716197041;
Received: from 30.221.148.185(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W6qKcWT_1716197041)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 17:24:03 +0800
Message-ID: <a3ca2292-0218-45f6-8afe-4319a10b69e2@linux.alibaba.com>
Date: Mon, 20 May 2024 17:24:00 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] cachefiles: never get a new anonymous fd if
 ondemand_id is valid
To: Baokun Li <libaokun@huaweicloud.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-9-libaokun@huaweicloud.com>
 <f4d24738-76a2-4998-9a28-493599cd7eae@linux.alibaba.com>
 <d62b162d-acb3-2fa7-085e-79da3278091a@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <d62b162d-acb3-2fa7-085e-79da3278091a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/20/24 5:07 PM, Baokun Li wrote:
> On 2024/5/20 16:43, Jingbo Xu wrote:
>>
>> On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
>>> From: Baokun Li <libaokun1@huawei.com>
>>>
>>> Now every time the daemon reads an open request, it gets a new
>>> anonymous fd
>>> and ondemand_id. With the introduction of "restore", it is possible
>>> to read
>>> the same open request more than once, and therefore an object can
>>> have more
>>> than one anonymous fd.
>>>
>>> If the anonymous fd is not unique, the following concurrencies will
>>> result
>>> in an fd leak:
>>>
>>>       t1     |         t2         |          t3
>>> ------------------------------------------------------------
>>>   cachefiles_ondemand_init_object
>>>    cachefiles_ondemand_send_req
>>>     REQ_A = kzalloc(sizeof(*req) + data_len)
>>>     wait_for_completion(&REQ_A->done)
>>>              cachefiles_daemon_read
>>>               cachefiles_ondemand_daemon_read
>>>                REQ_A = cachefiles_ondemand_select_req
>>>                cachefiles_ondemand_get_fd
>>>                  load->fd = fd0
>>>                  ondemand_id = object_id0
>>>                                    ------ restore ------
>>>                                    cachefiles_ondemand_restore
>>>                                     // restore REQ_A
>>>                                    cachefiles_daemon_read
>>>                                     cachefiles_ondemand_daemon_read
>>>                                      REQ_A =
>>> cachefiles_ondemand_select_req
>>>                                        cachefiles_ondemand_get_fd
>>>                                          load->fd = fd1
>>>                                          ondemand_id = object_id1
>>>               process_open_req(REQ_A)
>>>               write(devfd, ("copen %u,%llu", msg->msg_id, size))
>>>               cachefiles_ondemand_copen
>>>                xa_erase(&cache->reqs, id)
>>>                complete(&REQ_A->done)
>>>     kfree(REQ_A)
>>>                                    process_open_req(REQ_A)
>>>                                    // copen fails due to no req
>>>                                    // daemon close(fd1)
>>>                                    cachefiles_ondemand_fd_release
>>>                                     // set object closed
>>>   -- umount --
>>>   cachefiles_withdraw_cookie
>>>    cachefiles_ondemand_clean_object
>>>     cachefiles_ondemand_init_close_req
>>>      if (!cachefiles_ondemand_object_is_open(object))
>>>        return -ENOENT;
>>>      // The fd0 is not closed until the daemon exits.
>>>
>>> However, the anonymous fd holds the reference count of the object and
>>> the
>>> object holds the reference count of the cookie. So even though the
>>> cookie
>>> has been relinquished, it will not be unhashed and freed until the
>>> daemon
>>> exits.
>>>
>>> In fscache_hash_cookie(), when the same cookie is found in the hash
>>> list,
>>> if the cookie is set with the FSCACHE_COOKIE_RELINQUISHED bit, then
>>> the new
>>> cookie waits for the old cookie to be unhashed, while the old cookie is
>>> waiting for the leaked fd to be closed, if the daemon does not exit
>>> in time
>>> it will trigger a hung task.
>>>
>>> To avoid this, allocate a new anonymous fd only if no anonymous fd has
>>> been allocated (ondemand_id == 0) or if the previously allocated
>>> anonymous
>>> fd has been closed (ondemand_id == -1). Moreover, returns an error if
>>> ondemand_id is valid, letting the daemon know that the current userland
>>> restore logic is abnormal and needs to be checked.
>>>
>>> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking
>>> up cookie")
>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> The LOCs of this fix is quite under control.  But still it seems that
>> the worst consequence is that the (potential) malicious daemon gets
>> hung.  No more effect to the system or other processes.  Or does a
>> non-malicious daemon have any chance having the same issue?
> If we enable hung_task_panic, it may cause panic to crash the server.

Then this issue has nothing to do with this patch?  As long as a
malicious daemon doesn't close the anonymous fd after umounting, then I
guess a following attempt of mounting cookie with the same name will
also wait and hung there?

-- 
Thanks,
Jingbo

