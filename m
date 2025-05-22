Return-Path: <linux-fsdevel+bounces-49652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2119AC01A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 03:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD8E17B1E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 01:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4D747F4A;
	Thu, 22 May 2025 01:02:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F5F33F7;
	Thu, 22 May 2025 01:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747875725; cv=none; b=CPRuNdUxlsJmkwAo/NHjtli80GE4SYwWRzmqUj9IswaPmI4397W7s8MCC2FQUtyNCWJE6uoqQ2XtMb+pHhX9tyqqAhw1g9+NaLKMi++HEOKaPx5EfRq0qhY6wz/Ymc6T3iefZiliKS307V6uOYPgriGFS0lqci+Flu9yKmSAj+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747875725; c=relaxed/simple;
	bh=+KZuYa6hzZ+YGJxjVtRTfGAXCLTKEjv57gJd0aKTKPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmI3xS5Uamt6e02YNaS6ov5WU0HaesY4hEdXmr/FHwaXB09B5tN3LlMt5yY5aF3yOVQry9KM1/kQvogzLyCfgQ8D+VVB6JwsyfOGz/hGEc/JzeZ1NcIYDV2oiNNTi1htfV8y/Q3F5RH0kXaDNpcpR2W7B7ddXA9tp7xlyXLtmz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4b2qkc2mbczKHMVC;
	Thu, 22 May 2025 09:02:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DE1061A018D;
	Thu, 22 May 2025 09:01:58 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP4 (Coremail) with SMTP id gCh0CgAHa1+Edy5ofVaCNA--.14635S3;
	Thu, 22 May 2025 09:01:58 +0800 (CST)
Message-ID: <f6a9c6ef-1fd8-41d2-8f6a-396b6b191f97@huaweicloud.com>
Date: Thu, 22 May 2025 09:01:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Rename the parameter of mnt_get_write_access()
To: Zizhi Wo <wozizhi@huaweicloud.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: yangerkun@huawei.com
References: <20250516032147.3350598-1-wozizhi@huaweicloud.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20250516032147.3350598-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHa1+Edy5ofVaCNA--.14635S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWUAryUuFyruw48KryrXrb_yoW5GF48pr
	W5KF98Kw4xAF129rnrAa9xXa4rW340kFW7K34UWw45ZFZ8Zr1aga40gr1Iqr18Ar97ZrWx
	WF40y3sxX342v37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

Hello!

There are currently two possible approaches to this patch.
The first is to directly change the declaration, which would be
straightforward and involve minimal modifications.

However, per Al Viro's suggestion — that "mnt for vfsmount, m for mount" 
is an informal convention. This is in line with what the current
patch does, although I understand Jan Kara might feel that the scope of 
the changes is a bit large.

I would appreciate any suggestions or guidance on how to proceed. So
friendly ping...

在 2025/5/16 11:21, Zizhi Wo 写道:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> Rename the parameter in mnt_get_write_access() from "m" to "mnt" for
> consistency between declaration and implementation.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   fs/namespace.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 1b466c54a357..b1b679433ab3 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -483,7 +483,7 @@ static int mnt_is_readonly(struct vfsmount *mnt)
>    */
>   /**
>    * mnt_get_write_access - get write access to a mount without freeze protection
> - * @m: the mount on which to take a write
> + * @mnt: the mount on which to take a write
>    *
>    * This tells the low-level filesystem that a write is about to be performed to
>    * it, and makes sure that writes are allowed (mnt it read-write) before
> @@ -491,13 +491,13 @@ static int mnt_is_readonly(struct vfsmount *mnt)
>    * frozen. When the write operation is finished, mnt_put_write_access() must be
>    * called. This is effectively a refcount.
>    */
> -int mnt_get_write_access(struct vfsmount *m)
> +int mnt_get_write_access(struct vfsmount *mnt)
>   {
> -	struct mount *mnt = real_mount(m);
> +	struct mount *m = real_mount(mnt);
>   	int ret = 0;
>   
>   	preempt_disable();
> -	mnt_inc_writers(mnt);
> +	mnt_inc_writers(m);
>   	/*
>   	 * The store to mnt_inc_writers must be visible before we pass
>   	 * MNT_WRITE_HOLD loop below, so that the slowpath can see our
> @@ -505,7 +505,7 @@ int mnt_get_write_access(struct vfsmount *m)
>   	 */
>   	smp_mb();
>   	might_lock(&mount_lock.lock);
> -	while (READ_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD) {
> +	while (READ_ONCE(m->mnt.mnt_flags) & MNT_WRITE_HOLD) {
>   		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>   			cpu_relax();
>   		} else {
> @@ -530,8 +530,8 @@ int mnt_get_write_access(struct vfsmount *m)
>   	 * read-only.
>   	 */
>   	smp_rmb();
> -	if (mnt_is_readonly(m)) {
> -		mnt_dec_writers(mnt);
> +	if (mnt_is_readonly(mnt)) {
> +		mnt_dec_writers(m);
>   		ret = -EROFS;
>   	}
>   	preempt_enable();


