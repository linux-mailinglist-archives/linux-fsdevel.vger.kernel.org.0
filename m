Return-Path: <linux-fsdevel+bounces-18803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70F08BC660
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 06:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046241C21633
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 04:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363F444391;
	Mon,  6 May 2024 04:02:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E9A41A81;
	Mon,  6 May 2024 04:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714968176; cv=none; b=CGREmJcdkhpxw2p2HBmNJ2cRwxml4awdPVg7CqPj/tbwGb4hkE788GgXMOAwCpJZQqCC6gedXn8kYEJltsVUSRbURa79DL36wPT3focJFIAltL0Cyee5sgeg+gGU21alIuD8LH6ORoHiAoymwYWxgaUkiv49h2ulMAbdi9N7Iac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714968176; c=relaxed/simple;
	bh=w2mIEHb1FX0xHYK9nCgdIaQaDhdD7nnojVP4YG3F/dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loqYZTJmFRxQy1QydGDlA6iSj6qJgsUDJjTJ/u8gMDzIUxgB8AUaendSEDd2polN5sOf5kkM5WD/ya+nApsa7GNpv/vMb00+UF/ipfFwGeUhhHWRUDu6Ue+l1Tm15eKGZ7eRbAUy5a5M62h9dkW9bcB7fNTVQ12FdJyFOroKZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VXnn14b42z4f3kkF;
	Mon,  6 May 2024 12:02:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DAD741A016E;
	Mon,  6 May 2024 12:02:50 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFoVjhmHoqLLw--.43088S3;
	Mon, 06 May 2024 12:02:50 +0800 (CST)
Message-ID: <aace11c7-d399-6966-02d0-2f08d1fa8b13@huaweicloud.com>
Date: Mon, 6 May 2024 12:02:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 02/12] cachefiles: remove err_put_fd tag in
 cachefiles_ondemand_daemon_read()
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, libaokun@huaweicloud.com,
 yangerkun <yangerkun@huawei.com>
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-3-libaokun@huaweicloud.com>
 <795cd804-f7a1-44ba-99ac-01070edd5a9a@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <795cd804-f7a1-44ba-99ac-01070edd5a9a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAX6RFoVjhmHoqLLw--.43088S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1kCFW7ur4DCr4kWr13XFb_yoW8Wr4xpF
	WSya43Kr109F13ur97Aas8X3ySy395JFnrWwnYqws3A3Zagr1rZr48Kw45ZFyDurs3GF4I
	q3W2gF97G34jy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

On 2024/5/6 11:55, Jingbo Xu wrote:
>
> On 4/24/24 11:39 AM, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> The err_put_fd tag is only used once, so remove it to make the code more
>> readable.
> I think it's a conventional style to put error handling in the bottom of
> the function so that it could be reused.  Indeed currently err_put_fd
> has only one caller but IMHO it's only styling issues.
>
> By the way it seems that this is not needed anymore if patch 9 is applied.
This is just to make patch 3 look clearer, if you insist on dropping it
I will drop it in the next revision.

Cheers,
Baokun
>> ---
>>   fs/cachefiles/ondemand.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index 4ba42f1fa3b4..fd49728d8bae 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -347,7 +347,9 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   
>>   	if (copy_to_user(_buffer, msg, n) != 0) {
>>   		ret = -EFAULT;
>> -		goto err_put_fd;
>> +		if (msg->opcode == CACHEFILES_OP_OPEN)
>> +			close_fd(((struct cachefiles_open *)msg->data)->fd);
>> +		goto error;
>>   	}
>>   
>>   	/* CLOSE request has no reply */
>> @@ -358,9 +360,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   
>>   	return n;
>>   
>> -err_put_fd:
>> -	if (msg->opcode == CACHEFILES_OP_OPEN)
>> -		close_fd(((struct cachefiles_open *)msg->data)->fd);
>>   error:
>>   	xa_erase(&cache->reqs, id);
>>   	req->error = ret;



