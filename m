Return-Path: <linux-fsdevel+bounces-56317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FFEB158BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 08:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 465927A5156
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 06:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FAF1F03D7;
	Wed, 30 Jul 2025 06:09:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B0381732;
	Wed, 30 Jul 2025 06:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753855769; cv=none; b=rIf5KwCVWy6xdMSWQam+zN0kiJXY4dth3S7npYgfak9lgYv7JeOcCRN7ZAEAJfOz/VQns0ejqWRUYfDEx6D1JumEbemlIFU4zZUGAdH0IHkfAgxYAT1YvqkmTLwc0w2rNRoxbrwndBWkWPLXw5qJ7MuJ5XS9+kCC86L86jesnXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753855769; c=relaxed/simple;
	bh=VqcABCOCHphdMKpPlMCUndhXnXhAZz+yaaZntvERK98=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qiufM+xPtWp2/D4pK/dO3o6P95o6j/qQD7GZfR+1N0hiyzFePgbDTuIdVm77t00VB2h2NsrxMMfZcVfE0yaHyxD9BVKWrGtvVrrLQDS3fXN8FxID5nNn/Gw2+ulAYPjB6CPp26w/149Uc0HYXJQzYglhrkQzU8KoSUwfgfUqecY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bsMHM3lrZzYQtt5;
	Wed, 30 Jul 2025 14:09:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 346111A13A7;
	Wed, 30 Jul 2025 14:09:18 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHwhIMt4loQr7aBw--.41129S3;
	Wed, 30 Jul 2025 14:09:18 +0800 (CST)
Subject: Re: syztest
To: Arnaud Lecomte <contact@arnaud-lcm.com>,
 syzbot+fa3a12519f0d3fd4ec16@syzkaller.appspotmail.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <68894408.a00a0220.26d0e1.0013.GAE@google.com>
 <20250730055126.114185-1-contact@arnaud-lcm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a166383d-a19a-deb4-e170-2350f8fdafd0@huaweicloud.com>
Date: Wed, 30 Jul 2025 14:09:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250730055126.114185-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHwhIMt4loQr7aBw--.41129S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZr43uF4kXrWDGrWDXFWUurg_yoWDJwbEgF
	90ya4Y9ayUG3yUKF1Fyw1xZryrt34UGan7uF93tFnxtrn8G3WjkF93Ca15uw10qF47Wwn0
	kr1xG3s0ya1rAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/07/30 13:51, Arnaud Lecomte Ð´µÀ:
> #syz test
> 
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -5978,10 +5978,6 @@ struct mddev *md_alloc(dev_t dev, char *name)
>   
>   	disk->events |= DISK_EVENT_MEDIA_CHANGE;
>   	mddev->gendisk = disk;
> -	error = add_disk(disk);
> -	if (error)
> -		goto out_put_disk;
> -
>   	kobject_init(&mddev->kobj, &md_ktype);
>   	error = kobject_add(&mddev->kobj, &disk_to_dev(disk)->kobj, "%s", "md");

This is wrong, you can't add mddev >kobj under the disk without
kobject_add for the disk kobj.

Thanks,
Kuai

>   	if (error) {
> @@ -5999,6 +5995,9 @@ struct mddev *md_alloc(dev_t dev, char *name)
>   	kobject_uevent(&mddev->kobj, KOBJ_ADD);
>   	mddev->sysfs_state = sysfs_get_dirent_safe(mddev->kobj.sd, "array_state");
>   	mddev->sysfs_level = sysfs_get_dirent_safe(mddev->kobj.sd, "level");
> +	error = add_disk(disk);
> +	if (error)
> +		goto out_put_disk;
>   	mutex_unlock(&disks_mutex);
>   	return mddev;
>   
> 


