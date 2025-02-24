Return-Path: <linux-fsdevel+bounces-42375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 066B6A4131B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 03:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9644189315B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 02:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73A919ABC6;
	Mon, 24 Feb 2025 01:59:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7111E7485;
	Mon, 24 Feb 2025 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740362393; cv=none; b=WlBrGcCi8fQksRRTIMNu8DNCNCgrLtXn8p2OeDYs/ZHwFYKRhR6riuK7fEz7WGvTtS5Rq7lXF8kYIwLxoSzSquTSVlbx8cWxyMW26LiHhT0BRDKCYgAqiCdf/D6tFE7w0RLN+ML9ztNiKfG1vWqltbvMKWYCzBihkXoBKFsTS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740362393; c=relaxed/simple;
	bh=fKrszG9NHCY6e29PEfyo0QFYgGgQ/ryEJE73agr7ors=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YbNpcSXuivyNjkAwnm7xT+y7fsvvw3TdFBUbWa9K4stm3HCkIshA+aYOq/26Cb/yINeMglhJb1CKFYdH8ZKVV6cxyL0b4CzVBfth7MlOGzl9g94fM50CieoErxSAFUbYOtOXhxNsPzSJxTcHMGyj9FVlgewFuWIy5XI44P1yAhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z1P6t4Lykz4f3js1;
	Mon, 24 Feb 2025 09:59:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5D43E1A06D7;
	Mon, 24 Feb 2025 09:59:40 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXul6K0rtnie_kEg--.41699S3;
	Mon, 24 Feb 2025 09:59:40 +0800 (CST)
Message-ID: <18453da2-35f1-4f65-b84e-d62a89ff3bab@huaweicloud.com>
Date: Mon, 24 Feb 2025 09:59:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: Modify the comment about mb_optimize_scan
To: Zizhi Wo <wozizhi@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ext4@vger.kernel.org, jack@suse.com, tytso@mit.edu,
 yangerkun@huawei.com
References: <20250224012005.689549-1-wozizhi@huawei.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250224012005.689549-1-wozizhi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXul6K0rtnie_kEg--.41699S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1rtFy7uF13JFy5ur1kuFg_yoW8Zr4rp3
	9xCF18GF1rWr45Cw47Wa4ku3WYqws7Gw48XF1Yvw1Y9FZrCFZ2yasFyw18uFyUArZ5Za45
	XFnFgFn5C3Z093DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

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

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/mballoc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index b25a27c86696..68b54afc78c7 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -187,7 +187,7 @@
>   * /sys/fs/ext4/<partition>/mb_min_to_scan
>   * /sys/fs/ext4/<partition>/mb_max_to_scan
>   * /sys/fs/ext4/<partition>/mb_order2_req
> - * /sys/fs/ext4/<partition>/mb_linear_limit
> + * /sys/fs/ext4/<partition>/mb_max_linear_groups
>   *
>   * The regular allocator uses buddy scan only if the request len is power of
>   * 2 blocks and the order of allocation is >= sbi->s_mb_order2_reqs. The
> @@ -209,7 +209,7 @@
>   * get traversed linearly. That may result in subsequent allocations being not
>   * close to each other. And so, the underlying device may get filled up in a
>   * non-linear fashion. While that may not matter on non-rotational devices, for
> - * rotational devices that may result in higher seek times. "mb_linear_limit"
> + * rotational devices that may result in higher seek times. "mb_max_linear_groups"
>   * tells mballoc how many groups mballoc should search linearly before
>   * performing consulting above data structures for more efficient lookups. For
>   * non rotational devices, this value defaults to 0 and for rotational devices


