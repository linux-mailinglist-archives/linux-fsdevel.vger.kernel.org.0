Return-Path: <linux-fsdevel+bounces-61291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E019B57418
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148CC3AC1AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 09:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BECF283FF8;
	Mon, 15 Sep 2025 09:07:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B8B27604E
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927273; cv=none; b=bsref3mlYUvlw3DBzOkgOO4c37yp2qymDr5VHJFfjDSXIcPxfjsbSehIPenX/yUzjvY+/G1p83LcV30mngaQOpq6We+gqUHt7196V7TmOo+ExDDKWvo4YuN3+fjN1vm2TUa2BdQD+7vYaHGAsLrjLFZPXd1CHo9L9OZ6Cw/wxnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927273; c=relaxed/simple;
	bh=8wNUBEhQRfJk6tQNCMGgO/dGHU6tf4jeNUQcQAV5+ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MeMBJUZIMQSeyVlovSeXmiAvr7myOOKpdH8j2D6U5GJFisuNZMlEfQDq1XOjUCRBG/oSYcpTyFUmH0YrkdRaYr+azm3/0jKDJXAuQgvbH6pyfuSamaEIRvLX5znnoe5ZWnjc4bS0fjlF4PfDXIMGpHluL+DEebOg3oOpgikDh4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cQJwr61yXz13Mlb;
	Mon, 15 Sep 2025 17:03:40 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id B3E1318048B;
	Mon, 15 Sep 2025 17:07:47 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Sep 2025 17:07:47 +0800
Message-ID: <683bccd5-d6c7-7609-1e40-1633d026e722@huawei.com>
Date: Mon, 15 Sep 2025 17:07:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 5/5] fuse: {io-uring} Allow reduced number of ring queues
To: Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>,
	Miklos Szeredi <miklos@szeredi.hu>
CC: Joanne Koong <joannelkoong@gmail.com>, <linux-fsdevel@vger.kernel.org>
References: <20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com>
 <20250722-reduced-nr-ring-queues_3-v1-5-aa8e37ae97e6@ddn.com>
 <7c8557f9-1a8a-71ec-94aa-386e5abd3182@huawei.com>
 <15ba1a8d-d216-4609-aa7d-5e32e54349e5@bsbernd.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <15ba1a8d-d216-4609-aa7d-5e32e54349e5@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2025/9/15 16:39, Bernd Schubert 写道:
> 
> 
> On 9/15/25 06:37, yangerkun wrote:
>>
>>
>> 在 2025/7/23 5:58, Bernd Schubert 写道:
>>> Currently, FUSE io-uring requires all queues to be registered before
>>> becoming ready, which can result in too much memory usage.
>>
>> Thank you very much for this patchset! We have also encountered this
>> issue and have been using per-CPU fiq->ops locally, which combines uring
>> ops and dev ops for a single fuse instance. After discussing it, we
>> prefer your solution as it seems excellent!
>>
>>>
>>> This patch introduces a static queue mapping system that allows FUSE
>>> io-uring to operate with a reduced number of registered queues by:
>>>
>>> 1. Adding a queue_mapping array to track which registered queue each
>>>      CPU should use
>>> 2. Replacing the is_ring_ready() check with immediate queue mapping
>>>      once any queues are registered
>>> 3. Implementing fuse_uring_map_queues() to create CPU-to-queue mappings
>>>      that prefer NUMA-local queues when available
>>> 4. Updating fuse_uring_get_queue() to use the static mapping instead
>>>      of direct CPU-to-queue correspondence
>>
>> It appears that fuse_uring_do_register can assist in determining which
>> CPU has been registered. Perhaps you could also modify libfuse to make
>> use of this feature. Could you provide that?
> 
> Just had forgotten to post it:
> https://github.com/bsbernd/libfuse/tree/uring-reduce-nr-queues.

Thanks.

> 
> In that branch you can specify the number of queues to use,
> cores are then auto-selected. Or you can specify a core mask on
> which cores queues are supposed to run on.
> 
> Kernel patch series v2 should follow in the evening, I was busy
> till last week with other things.

OK, look forward for this new version!

> 
> 
> Thanks,
> Bernd

