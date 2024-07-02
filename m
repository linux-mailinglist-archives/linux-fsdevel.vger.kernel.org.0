Return-Path: <linux-fsdevel+bounces-22941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD8F923DAB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 14:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B028E1C220BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 12:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D645A16C6BD;
	Tue,  2 Jul 2024 12:25:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE7B167D8C;
	Tue,  2 Jul 2024 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923117; cv=none; b=SYyxc+EViFmQuKpmkkyOwwlHfoA/W/05aTCicXdmX3Ew7FEQtI6nRg8P5jc1cDlOokUyKAiI0Hf9E++g4h2oFqo+7eDBGDurUxcshGtIjtXt79zCgNFxkm9ppVIxG4D1rPPxsfQsU13/MzlTJ+gP5OLhz812XZnjfayrQLIezu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923117; c=relaxed/simple;
	bh=ktCITwpxHpI1W1hj/sUArc8rIdogsyyInYcXkBWuLH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+kehe7JDYqZ7awSj9wIKc9kwNProwtT3pm0rAe8CxbfN+wZ3rMRDUqV0wm/oxmOgbBZB8Zb91TFjntkrYMWPRWTr8C+6YS9WEZGbhYv/EmUBUrtUXwfdfE2s2lfJxZBkZlHZBgqqmJj8RBnsKYCEA9ah4lTWyf1KqNegzPHdBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WD2DK2qWwz4f3jtx;
	Tue,  2 Jul 2024 20:25:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B2B4A1A016E;
	Tue,  2 Jul 2024 20:25:12 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgBXgHyi8YNm6TG7Aw--.61077S3;
	Tue, 02 Jul 2024 20:25:10 +0800 (CST)
Message-ID: <5e3ffecd-4def-44b4-b141-e24429d13929@huaweicloud.com>
Date: Tue, 2 Jul 2024 20:25:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] cachefiles: random bugfixes
To: netfs@lists.linux.dev, dhowells@redhat.com, jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
 zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>,
 Baokun Li <libaokun@huaweicloud.com>
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240628062930.2467993-1-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXgHyi8YNm6TG7Aw--.61077S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF13tr18Wr1kZw45uFy8Zrb_yoWrCw17pF
	WakanxArykWryxCws3Zw4xtFyFy3yxX3Z2gr1xXw15A3s8XF1FvrWIkr15ZFy5Crs7GrW2
	vr1q9Fn3Gw1qv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvt
	AUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAMBV1jkHxNzQAAsZ

Friendly ping...

On 2024/6/28 14:29, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
>
> Hi all!
>
> This is the third version of this patch series, in which another patch set
> is subsumed into this one to avoid confusing the two patch sets.
> (https://patchwork.kernel.org/project/linux-fsdevel/list/?series=854914)
>
> Thank you, Jia Zhu, Gao Xiang, Jeff Layton, for the feedback in the
> previous version.
>
> We've been testing ondemand mode for cachefiles since January, and we're
> almost done. We hit a lot of issues during the testing period, and this
> patch series fixes some of the issues. The patches have passed internal
> testing without regression.
>
> The following is a brief overview of the patches, see the patches for
> more details.
>
> Patch 1-2: Add fscache_try_get_volume() helper function to avoid
> fscache_volume use-after-free on cache withdrawal.
>
> Patch 3: Fix cachefiles_lookup_cookie() and cachefiles_withdraw_cache()
> concurrency causing cachefiles_volume use-after-free.
>
> Patch 4: Propagate error codes returned by vfs_getxattr() to avoid
> endless loops.
>
> Patch 5-7: A read request waiting for reopen could be closed maliciously
> before the reopen worker is executing or waiting to be scheduled. So
> ondemand_object_worker() may be called after the info and object and even
> the cache have been freed and trigger use-after-free. So use
> cancel_work_sync() in cachefiles_ondemand_clean_object() to cancel the
> reopen worker or wait for it to finish. Since it makes no sense to wait
> for the daemon to complete the reopen request, to avoid this pointless
> operation blocking cancel_work_sync(), Patch 1 avoids request generation
> by the DROPPING state when the request has not been sent, and Patch 2
> flushes the requests of the current object before cancel_work_sync().
>
> Patch 8: Cyclic allocation of msg_id to avoid msg_id reuse misleading
> the daemon to cause hung.
>
> Patch 9: Hold xas_lock during polling to avoid dereferencing reqs causing
> use-after-free. This issue was triggered frequently in our tests, and we
> found that anolis 5.10 had fixed it. So to avoid failing the test, this
> patch is pushed upstream as well.
>
> Comments and questions are, as always, welcome.
> Please let me know what you think.
>
> Thanks,
> Baokun
>
> Changes since v2:
>    * Collect Acked-by from Jeff Layton.(Thanks for your ack!)
>    * Collect RVB from Gao Xiang.(Thanks for your review!)
>    * Patch 1-4 from another patch set.
>    * Pathch 4,6,7: Optimise commit messages and subjects.
>
> Changes since v1:
>    * Collect RVB from Jia Zhu and Gao Xiang.(Thanks for your review!)
>    * Pathch 1,2：Add more commit messages.
>    * Pathch 3：Add Fixes tag as suggested by Jia Zhu.
>    * Pathch 4：No longer changing "do...while" to "retry" to focus changes
>      and optimise commit messages.
>    * Pathch 5: Drop the internal RVB tag.
>
> v1: https://lore.kernel.org/all/20240424033409.2735257-1-libaokun@huaweicloud.com
> v2: https://lore.kernel.org/all/20240515125136.3714580-1-libaokun@huaweicloud.com
>
> Baokun Li (7):
>    netfs, fscache: export fscache_put_volume() and add
>      fscache_try_get_volume()
>    cachefiles: fix slab-use-after-free in fscache_withdraw_volume()
>    cachefiles: fix slab-use-after-free in cachefiles_withdraw_cookie()
>    cachefiles: propagate errors from vfs_getxattr() to avoid infinite
>      loop
>    cachefiles: stop sending new request when dropping object
>    cachefiles: cancel all requests for the object that is being dropped
>    cachefiles: cyclic allocation of msg_id to avoid reuse
>
> Hou Tao (1):
>    cachefiles: wait for ondemand_object_worker to finish when dropping
>      object
>
> Jingbo Xu (1):
>    cachefiles: add missing lock protection when polling
>
>   fs/cachefiles/cache.c          | 45 ++++++++++++++++++++++++++++-
>   fs/cachefiles/daemon.c         |  4 +--
>   fs/cachefiles/internal.h       |  3 ++
>   fs/cachefiles/ondemand.c       | 52 ++++++++++++++++++++++++++++++----
>   fs/cachefiles/volume.c         |  1 -
>   fs/cachefiles/xattr.c          |  5 +++-
>   fs/netfs/fscache_volume.c      | 14 +++++++++
>   fs/netfs/internal.h            |  2 --
>   include/linux/fscache-cache.h  |  6 ++++
>   include/trace/events/fscache.h |  4 +++
>   10 files changed, 123 insertions(+), 13 deletions(-)
>

-- 
With Best Regards,
Baokun Li


