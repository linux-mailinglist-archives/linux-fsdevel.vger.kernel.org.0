Return-Path: <linux-fsdevel+bounces-24388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5DA93EB16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 04:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52CBAB20DF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CF876056;
	Mon, 29 Jul 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KbtP0N8H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8028C1B86D6
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219629; cv=none; b=VMg0Wf4GtvsoasX1mUMNg6DUxzr+KKyYPssR2o9aAfoi5GRMG3/GDNLsVmMH3A/lOrG10t99yHmEKFxTiCLqZ7JBJ4HrAR+ThdCmxj3t2w2plHJZwAumd5ip69McehNGUud2vNjostjVcdc6s3cqyrkl6AKCZaa2wdVEdnQSpqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219629; c=relaxed/simple;
	bh=TOcjLJ3Q7aq0Y0wMqLD2U3vKTqvBxXGyhfDDTyLgTV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HB5x460vhnr0CZ3WRwbrGkwVh98/tUMY5Qmad52YLEWa6h1gJ6bazNjnFw4yhWC6dh/Ry8ko7NQm2APgXj5TRlYBls/JouR1nECWolxgFcRwgxdk2GHU1p0Vs/rcIh+r1O6zwAjxAhD6N0auS56G2kX0ElpMFlrRs/sx6CZnMdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KbtP0N8H; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722219623; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XWqXxcMtZJVh+eWtzpJgIPAZcbvyzFDMAW4PdY6+PMg=;
	b=KbtP0N8HrqMV+S/hB2hC5vfUaYyh6N+TUkl4AvKaQU5Y8S7YbAY0wR+qkdS6su5DHhRXHfEnNZL/LM3Z2+AqUa+ToRTIb9sYGl2MsyeWlv//ky6vINKbpv/KLG9cOzRRZcAWNGQM5z/D8xF+LQt/fW4rhqvzQwverajXyhmrvQg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0WBShre1_1722219621;
Received: from 30.221.145.83(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WBShre1_1722219621)
          by smtp.aliyun-inc.com;
          Mon, 29 Jul 2024 10:20:22 +0800
Message-ID: <4d278183-32ff-496d-bb42-26dee48f4684@linux.alibaba.com>
Date: Mon, 29 Jul 2024 10:20:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: check aborted connection before adding requests to
 pending list for resending
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: winters.zc@antgroup.com, josef@toxicpanda.com,
 bs_lists@aakef.fastmail.fm, kernel-team@meta.com
References: <20240725175334.473546-1-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240725175334.473546-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/26/24 1:53 AM, Joanne Koong wrote:
> There is a race condition where inflight requests will not be aborted if
> they are in the middle of being re-sent when the connection is aborted.
> 
> If fuse_resend has already moved all the requests in the fpq->processing
> lists to its private queue ("to_queue") and then the connection starts
> and finishes aborting, these requests will be added to the pending queue
> and remain on it indefinitely.
> 
> Fixes: 760eac73f9f6 ("fuse: Introduce a new notification type for resend pending requests")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 9eb191b5c4de..a11461ef6022 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -31,6 +31,8 @@ MODULE_ALIAS("devname:fuse");
>  
>  static struct kmem_cache *fuse_req_cachep;
>  
> +static void end_requests(struct list_head *head);
> +
>  static struct fuse_dev *fuse_get_dev(struct file *file)
>  {
>  	/*
> @@ -1820,6 +1822,13 @@ static void fuse_resend(struct fuse_conn *fc)
>  	}
>  
>  	spin_lock(&fiq->lock);
> +	if (!fiq->connected) {
> +		spin_unlock(&fiq->lock);
> +		list_for_each_entry(req, &to_queue, list)
> +			clear_bit(FR_PENDING, &req->flags);
> +		end_requests(&to_queue);
> +		return;
> +	}
>  	/* iq and pq requests are both oldest to newest */
>  	list_splice(&to_queue, &fiq->pending);
>  	fiq->ops->wake_pending_and_unlock(fiq);


LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo

