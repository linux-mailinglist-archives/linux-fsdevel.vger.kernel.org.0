Return-Path: <linux-fsdevel+bounces-19763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF288C9A0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09AD11C218B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 09:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E2F1C6A3;
	Mon, 20 May 2024 09:02:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE041CA9E;
	Mon, 20 May 2024 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716195760; cv=none; b=FBBYVKw6Czp2OmUZXW7f4Fesw8UpbdHC2ogG9/FLX3dS1V1JccINJjOxruaVVkphqgJ5R4GDswEYCeh600I/wp7Ky10a45OhcV3oXJM+kCArDuw2xUcPDOlH2CImJboJ/RYx/1Mh108WdbIdpxE0vfRG8FqxnY8gdCuL2LK/AnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716195760; c=relaxed/simple;
	bh=6CusUao6PpuMkyjBw+xlQ/YqOhA5Bv+pa0SxkFDMIQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k04lYu67OUW0FtTXsXxSxojkZhBWCi/IJ5+sOc9NFdDbLmPowXCdzVO+RosmErwdF6HYIE1dkEk5ptW75s3sBUDZiGjsMYvY06hGRxMaiR5yOuKd5idjpvnKJ7mmpGiPJmpadO6IUBcJrgrNuWJegKkeNE7+mE7TbXR95qyk24k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VjWmJ2cjCz4f3lg2;
	Mon, 20 May 2024 17:02:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BB7DD1A10E3;
	Mon, 20 May 2024 17:02:34 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g6nEUtmLYqyNA--.2293S3;
	Mon, 20 May 2024 17:02:34 +0800 (CST)
Message-ID: <f933cc64-970d-7be5-8409-f96122254eda@huaweicloud.com>
Date: Mon, 20 May 2024 17:02:31 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 05/12] cachefiles: add output string to
 cachefiles_obj_[get|put]_ondemand_fd
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>,
 libaokun@huaweicloud.com
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-6-libaokun@huaweicloud.com>
 <af4b9591-d82e-4da3-b681-eb677369ced3@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <af4b9591-d82e-4da3-b681-eb677369ced3@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAn9g6nEUtmLYqyNA--.2293S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4UWrW5CF4fGr4kZw4fKrg_yoW8ArWkpF
	ZIk3WUKFyI9397Krn7uF13Jr18GayDKF9Fq34UWr1YywsxXrnYqrn7Wr1YyF98Ar4xArZ7
	KwnF9asakrWjv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
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

On 2024/5/20 15:40, Jingbo Xu wrote:
>
> On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> This lets us see the correct trace output.
>>
>> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>
> Could we move this simple fix to the beginning of the patch set?
>
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>
Thanks for the review!

This patch is here because when adding trace-related output in the
last patch (path 4), it was found that cachefiles_obj_[get|put]_ondemand_fd
did not have any relevant trace output, so it is added in this patch.
Putting it in the first patch may confuse the reader as to why it was
added, but it is easier to understand with cachefiles_obj_[get|put]_read_req
in front of it.
>> ---
>>   include/trace/events/cachefiles.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
>> index 119a823fb5a0..bb56e3104b12 100644
>> --- a/include/trace/events/cachefiles.h
>> +++ b/include/trace/events/cachefiles.h
>> @@ -130,6 +130,8 @@ enum cachefiles_error_trace {
>>   	EM(cachefiles_obj_see_lookup_failed,	"SEE lookup_failed")	\
>>   	EM(cachefiles_obj_see_withdraw_cookie,	"SEE withdraw_cookie")	\
>>   	EM(cachefiles_obj_see_withdrawal,	"SEE withdrawal")	\
>> +	EM(cachefiles_obj_get_ondemand_fd,      "GET ondemand_fd")      \
>> +	EM(cachefiles_obj_put_ondemand_fd,      "PUT ondemand_fd")      \
>>   	EM(cachefiles_obj_get_read_req,		"GET read_req")		\
>>   	E_(cachefiles_obj_put_read_req,		"PUT read_req")
>>   

-- 
With Best Regards,
Baokun Li


