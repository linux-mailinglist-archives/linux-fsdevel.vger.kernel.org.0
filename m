Return-Path: <linux-fsdevel+bounces-42391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2E1A418CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 10:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB9F188E822
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 09:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7703E2512DA;
	Mon, 24 Feb 2025 09:14:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3530F250BF5;
	Mon, 24 Feb 2025 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388464; cv=none; b=T9eZLxlktYG+U1eDag91nLiLKIX7JTX79m0x+220kLoLy1PrxYL/Gti6+prqOUtlYar/uO04qhSePjiY2DKM+4yNQSQObnyw1/OF2QJ0EQD6Ir3JJYyAFmY23gN09W6xqnBbQ1lXqO4WTwvxFMqG0ucdrrFoxQ1bxMRgQw4mQeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388464; c=relaxed/simple;
	bh=xE7aUErbiDztzX+71IbFc2aZbX+2Svq8XwoBSdlaCSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AYfYQgYh5OnZO8ClYeWC9j1BSew1lt7jVGRNSh94nj1tGuunyfPFrK75UR+EPXU5EFDlyYmKMW6TWChb+HVcZvyC/ji5Gx0nx+Qp+nIymSf77X5GFEq28HEBAXYsNdvyXBm/0x+uiqAX7bgevNBLZZdVQTWJvEx4csyDwIx+4eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z1Zl1643NzTmwd;
	Mon, 24 Feb 2025 17:12:45 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 480A8140257;
	Mon, 24 Feb 2025 17:14:18 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 24 Feb
 2025 17:14:17 +0800
Message-ID: <0f485e7b-80a5-4e72-a301-4c362092f4ab@huawei.com>
Date: Mon, 24 Feb 2025 17:14:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: Modify the comment about mb_optimize_scan
To: Zizhi Wo <wozizhi@huawei.com>
CC: <jack@suse.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>, <tytso@mit.edu>,
	<linux-ext4@vger.kernel.org>
References: <20250224012005.689549-1-wozizhi@huawei.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250224012005.689549-1-wozizhi@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/2/24 9:20, Zizhi Wo wrote:
> Commit 196e402adf2e ("ext4: improve cr 0 / cr 1 group scanning") introduces
> the sysfs control interface "mb_max_linear_groups" to address the problem
> that rotational devices performance degrades when the "mb_optimize_scan"
> feature is enabled, which may result in distant block group allocation.
>
> However, the name of the interface was incorrect in the comment to the
> ext4/mballoc.c file, and this patch fixes it, without further changes.
>
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Looks good.

Reviewed-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/ext4/mballoc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index b25a27c86696..68b54afc78c7 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -187,7 +187,7 @@
>    * /sys/fs/ext4/<partition>/mb_min_to_scan
>    * /sys/fs/ext4/<partition>/mb_max_to_scan
>    * /sys/fs/ext4/<partition>/mb_order2_req
> - * /sys/fs/ext4/<partition>/mb_linear_limit
> + * /sys/fs/ext4/<partition>/mb_max_linear_groups
>    *
>    * The regular allocator uses buddy scan only if the request len is power of
>    * 2 blocks and the order of allocation is >= sbi->s_mb_order2_reqs. The
> @@ -209,7 +209,7 @@
>    * get traversed linearly. That may result in subsequent allocations being not
>    * close to each other. And so, the underlying device may get filled up in a
>    * non-linear fashion. While that may not matter on non-rotational devices, for
> - * rotational devices that may result in higher seek times. "mb_linear_limit"
> + * rotational devices that may result in higher seek times. "mb_max_linear_groups"
>    * tells mballoc how many groups mballoc should search linearly before
>    * performing consulting above data structures for more efficient lookups. For
>    * non rotational devices, this value defaults to 0 and for rotational devices



