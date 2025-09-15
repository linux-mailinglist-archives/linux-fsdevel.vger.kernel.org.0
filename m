Return-Path: <linux-fsdevel+bounces-61279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16423B56F6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 06:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 596E37A6448
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 04:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D9C27280A;
	Mon, 15 Sep 2025 04:37:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7017F1AAE17
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 04:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757911078; cv=none; b=IZt5oRUzbOhSbbLdhUI2HlRBcMQV9xt+1J+N32cvzCVORivd/d2B34uKXanJlhrc9QTNTP48Ud9DbwBNDCTnqK/oPzWsDF/32TosBF5EvNkavu16R7EldLq3hlq89kxZw69n0H+hkttIFS1oyyA9Tj4Cg1Rl0xBCzS1DhUGbESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757911078; c=relaxed/simple;
	bh=1vkQNBotpPiT1YqqHYkSaW3jGAli3UKd/UUiXsS5+aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A3i5eB/p8lvDVgux0cgnLvBLfhv2RrHX+fstUXfpVsce0MIjxe51933vT6zNS+NJInQ0TSvIup1gTsEWJyiS/AyU1y7viSew99A01iB/Kzjxj/S8c/q8EJAtH/1JPszxIOt+CQSaJJkizJF0SIT/e/u3gPOLAJhJmnGR1Hrx6wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cQBwp2sRqzQl2l;
	Mon, 15 Sep 2025 12:33:14 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id ADB61180486;
	Mon, 15 Sep 2025 12:37:51 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Sep 2025 12:37:51 +0800
Message-ID: <7c8557f9-1a8a-71ec-94aa-386e5abd3182@huawei.com>
Date: Mon, 15 Sep 2025 12:37:50 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 5/5] fuse: {io-uring} Allow reduced number of ring queues
To: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>
CC: Joanne Koong <joannelkoong@gmail.com>, <linux-fsdevel@vger.kernel.org>
References: <20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com>
 <20250722-reduced-nr-ring-queues_3-v1-5-aa8e37ae97e6@ddn.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <20250722-reduced-nr-ring-queues_3-v1-5-aa8e37ae97e6@ddn.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2025/7/23 5:58, Bernd Schubert 写道:
> Currently, FUSE io-uring requires all queues to be registered before
> becoming ready, which can result in too much memory usage.

Thank you very much for this patchset! We have also encountered this 
issue and have been using per-CPU fiq->ops locally, which combines uring 
ops and dev ops for a single fuse instance. After discussing it, we 
prefer your solution as it seems excellent!

> 
> This patch introduces a static queue mapping system that allows FUSE
> io-uring to operate with a reduced number of registered queues by:
> 
> 1. Adding a queue_mapping array to track which registered queue each
>     CPU should use
> 2. Replacing the is_ring_ready() check with immediate queue mapping
>     once any queues are registered
> 3. Implementing fuse_uring_map_queues() to create CPU-to-queue mappings
>     that prefer NUMA-local queues when available
> 4. Updating fuse_uring_get_queue() to use the static mapping instead
>     of direct CPU-to-queue correspondence

It appears that fuse_uring_do_register can assist in determining which 
CPU has been registered. Perhaps you could also modify libfuse to make 
use of this feature. Could you provide that?

Thanks,
Erkun.

> 
> The mapping prioritizes NUMA locality by first attempting to map CPUs
> to queues on the same NUMA node, falling back to any available
> registered queue if no local queue exists.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>   fs/fuse/dev_uring.c   | 112 ++++++++++++++++++++++++++++++--------------------
>   fs/fuse/dev_uring_i.h |   3 ++
>   2 files changed, 71 insertions(+), 44 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 624f856388e0867f3c3caed6771e61babd076645..8d16880cb0eb9b252dd6b6cf565011c3787ad1d0 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -238,6 +238,7 @@ void fuse_uring_destruct(struct fuse_conn *fc)
>   
>   	fuse_ring_destruct_q_masks(ring);
>   	kfree(ring->queues);
> +	kfree(ring->queue_mapping);
>   	kfree(ring);
>   	fc->ring = NULL;
>   }
> @@ -303,6 +304,12 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>   	if (err)
>   		goto out_err;
>   
> +	err = -ENOMEM;
> +	ring->queue_mapping =
> +		kcalloc(nr_queues, sizeof(int), GFP_KERNEL_ACCOUNT);
> +	if (!ring->queue_mapping)
> +		goto out_err;
> +
>   	spin_lock(&fc->lock);
>   	if (fc->ring) {
>   		/* race, another thread created the ring in the meantime */
> @@ -324,6 +331,7 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>   out_err:
>   	fuse_ring_destruct_q_masks(ring);
>   	kfree(ring->queues);
> +	kfree(ring->queue_mapping);
>   	kfree(ring);
>   	return res;
>   }
> @@ -1040,31 +1048,6 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
>   	return 0;
>   }
>   
> -static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
> -{
> -	int qid;
> -	struct fuse_ring_queue *queue;
> -	bool ready = true;
> -
> -	for (qid = 0; qid < ring->max_nr_queues && ready; qid++) {
> -		if (current_qid == qid)
> -			continue;
> -
> -		queue = ring->queues[qid];
> -		if (!queue) {
> -			ready = false;
> -			break;
> -		}
> -
> -		spin_lock(&queue->lock);
> -		if (list_empty(&queue->ent_avail_queue))
> -			ready = false;
> -		spin_unlock(&queue->lock);
> -	}
> -
> -	return ready;
> -}
> -
>   static int fuse_uring_map_qid(int qid, const struct cpumask *mask)
>   {
>   	int nr_queues = cpumask_weight(mask);
> @@ -1082,6 +1065,41 @@ static int fuse_uring_map_qid(int qid, const struct cpumask *mask)
>   	return -1;
>   }
>   
> +static int fuse_uring_map_queues(struct fuse_ring *ring)
> +{
> +	int qid, mapped_qid, node;
> +
> +	for (qid = 0; qid < ring->max_nr_queues; qid++) {
> +		node = cpu_to_node(qid);
> +		if (WARN_ON_ONCE(node >= ring->nr_numa_nodes) || node < 0)
> +			return -EINVAL;
> +
> +		/* First try to find a registered queue on the same NUMA node */
> +		mapped_qid = fuse_uring_map_qid(
> +			qid, ring->numa_registered_q_mask[node]);
> +		if (mapped_qid < 0) {
> +			/*
> +			 * No registered queue on this NUMA node,
> +			 * use any registered queue
> +			 */
> +			mapped_qid = fuse_uring_map_qid(
> +				qid, ring->registered_q_mask);
> +			if (WARN_ON_ONCE(mapped_qid < 0))
> +				return -EINVAL;
> +		}
> +
> +		if (WARN_ON_ONCE(!ring->queues[mapped_qid])) {
> +			pr_err("qid=%d mapped_qid=%d not created\n", qid,
> +			       mapped_qid);
> +			return -EINVAL;
> +		}
> +
> +		WRITE_ONCE(ring->queue_mapping[qid], mapped_qid);
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * fuse_uring_req_fetch command handling
>    */
> @@ -1094,6 +1112,7 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
>   	struct fuse_conn *fc = ring->fc;
>   	struct fuse_iqueue *fiq = &fc->iq;
>   	int node = queue->numa_node;
> +	int err;
>   
>   	fuse_uring_prepare_cancel(cmd, issue_flags, ent);
>   
> @@ -1105,14 +1124,14 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
>   	cpumask_set_cpu(queue->qid, ring->registered_q_mask);
>   	cpumask_set_cpu(queue->qid, ring->numa_registered_q_mask[node]);
>   
> -	if (!ring->ready) {
> -		bool ready = is_ring_ready(ring, queue->qid);
> +	err = fuse_uring_map_queues(ring);
> +	if (err)
> +		return;
>   
> -		if (ready) {
> -			WRITE_ONCE(fiq->ops, &fuse_io_uring_ops);
> -			WRITE_ONCE(ring->ready, true);
> -			wake_up_all(&fc->blocked_waitq);
> -		}
> +	if (!ring->ready) {
> +		WRITE_ONCE(fiq->ops, &fuse_io_uring_ops);
> +		WRITE_ONCE(ring->ready, true);
> +		wake_up_all(&fc->blocked_waitq);
>   	}
>   }
>   
> @@ -1365,25 +1384,27 @@ fuse_uring_get_first_queue(struct fuse_ring *ring, const struct cpumask *mask)
>    */
>   static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ring)
>   {
> -	unsigned int qid;
> -	struct fuse_ring_queue *queue, *local_queue;
> +	unsigned int mapped_qid;
> +	struct fuse_ring_queue *queue;
>   	int local_node;
>   	struct cpumask *mask;
> +	unsigned int core = task_cpu(current);
>   
> -	qid = task_cpu(current);
> -	if (WARN_ONCE(qid >= ring->max_nr_queues,
> -		      "Core number (%u) exceeds nr queues (%zu)\n", qid,
> -		      ring->max_nr_queues))
> -		qid = 0;
> -	local_node = cpu_to_node(qid);
> +	local_node = cpu_to_node(core);
> +	if (WARN_ON_ONCE(local_node >= ring->nr_numa_nodes) || local_node < 0)
> +		local_node = 0;
>   
> -	local_queue = queue = ring->queues[qid];
> -	if (WARN_ONCE(!queue, "Missing queue for qid %d\n", qid))
> -		return NULL;
> +	if (WARN_ON_ONCE(core >= ring->max_nr_queues))
> +		core = 0;
>   
> +	mapped_qid = READ_ONCE(ring->queue_mapping[core]);
> +	queue = ring->queues[mapped_qid];
> +
> +	/* First check if current CPU's queue is available */
>   	if (queue->nr_reqs <= FUSE_URING_QUEUE_THRESHOLD)
>   		return queue;
>   
> +	/* Second check if there are any available queues on the local node */
>   	mask = ring->per_numa_avail_q_mask[local_node];
>   	queue = fuse_uring_get_first_queue(ring, mask);
>   	if (queue)
> @@ -1394,7 +1415,10 @@ static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ring)
>   	if (queue)
>   		return queue;
>   
> -	return local_queue;
> +	/* no better queue available, use the mapped queue */
> +	queue = ring->queues[mapped_qid];
> +
> +	return queue;
>   }
>   
>   static void fuse_uring_dispatch_ent(struct fuse_ring_ent *ent)
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 0457dbc6737c8876dd7a7d4c9c724da05e553e6a..e72b83471cbfc2e911273966f3715305ca10e9ef 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -153,6 +153,9 @@ struct fuse_ring {
>   
>   	atomic_t queue_refs;
>   
> +	/* static queue mapping */
> +	int *queue_mapping;
> +
>   	bool ready;
>   };
>   
> 

