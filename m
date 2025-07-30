Return-Path: <linux-fsdevel+bounces-56320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7006AB15952
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 09:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4723188BF9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 07:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DAB1F8747;
	Wed, 30 Jul 2025 07:10:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DA0BA33;
	Wed, 30 Jul 2025 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753859433; cv=none; b=Z5QdSJHZD5Z7lXEO/P5bjHGj+hWiMel8/ae7IapwcNIe6GV+WJSjMH99x+onW0cPqo4boVPH1/+VwkiG916xOkRAwAsn7Zq7fl8F7uGIuX8ZjsMOGPOhWfz2IasspErbtA4DkJErAHImxfmJLue07lyzPtkfZXGcnTVKUg9Hr1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753859433; c=relaxed/simple;
	bh=AYXgVU+NUpq51qEoouH9W91fgq+DWPYCXeIQaUhV9mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qM/IF6f1WNxQ9sKMdoqo/RC0Cd/ukjmhj6c3gci/QCzbkNHnbmCdya4xkgN++iXzBEvXmctnVKNlZZziNYoUtBql0z5FZVzB7z4CZa1MxnRkSZAuP/hunS59gUwOs1wL5THaRAwcOhzNxsTHtH1dbBLPuw1Ipio8iX95iVevPTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [IPV6:2a02:8084:255b:aa00:1726:a1d9:9a49:d971] (unknown [IPv6:2a02:8084:255b:aa00:1726:a1d9:9a49:d971])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 7F9F6410A7;
	Wed, 30 Jul 2025 07:10:28 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 2a02:8084:255b:aa00:1726:a1d9:9a49:d971) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[IPV6:2a02:8084:255b:aa00:1726:a1d9:9a49:d971]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <b3310f8e-3e71-42d2-a4f6-1df2c2d294c1@arnaud-lcm.com>
Date: Wed, 30 Jul 2025 08:10:27 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: syztest
To: Yu Kuai <yukuai1@huaweicloud.com>,
 syzbot+fa3a12519f0d3fd4ec16@syzkaller.appspotmail.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <68894408.a00a0220.26d0e1.0013.GAE@google.com>
 <20250730055126.114185-1-contact@arnaud-lcm.com>
 <a166383d-a19a-deb4-e170-2350f8fdafd0@huaweicloud.com>
Content-Language: en-US
From: Arnaud Lecomte <contact@arnaud-lcm.com>
In-Reply-To: <a166383d-a19a-deb4-e170-2350f8fdafd0@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175385942907.4005.1019230276540793814@Plesk>
X-PPP-Vhost: arnaud-lcm.com


On 30/07/2025 07:09, Yu Kuai wrote:
> Hi,
>
> 在 2025/07/30 13:51, Arnaud Lecomte 写道:
>> #syz test
>>
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -5978,10 +5978,6 @@ struct mddev *md_alloc(dev_t dev, char *name)
>>         disk->events |= DISK_EVENT_MEDIA_CHANGE;
>>       mddev->gendisk = disk;
>> -    error = add_disk(disk);
>> -    if (error)
>> -        goto out_put_disk;
>> -
>>       kobject_init(&mddev->kobj, &md_ktype);
>>       error = kobject_add(&mddev->kobj, &disk_to_dev(disk)->kobj, 
>> "%s", "md");
>
> This is wrong, you can't add mddev >kobj under the disk without
> kobject_add for the disk kobj.
>
Will dive a bit more into that after work,
Thanks

> Thanks,
> Kuai
>
>>       if (error) {
>> @@ -5999,6 +5995,9 @@ struct mddev *md_alloc(dev_t dev, char *name)
>>       kobject_uevent(&mddev->kobj, KOBJ_ADD);
>>       mddev->sysfs_state = sysfs_get_dirent_safe(mddev->kobj.sd, 
>> "array_state");
>>       mddev->sysfs_level = sysfs_get_dirent_safe(mddev->kobj.sd, 
>> "level");
>> +    error = add_disk(disk);
>> +    if (error)
>> +        goto out_put_disk;
>>       mutex_unlock(&disks_mutex);
>>       return mddev;
>>
>

