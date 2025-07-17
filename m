Return-Path: <linux-fsdevel+bounces-55243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0BAB08BEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 13:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B39A46CB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EDB29B78E;
	Thu, 17 Jul 2025 11:48:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A622AE8E;
	Thu, 17 Jul 2025 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752752921; cv=none; b=r55qXXUYSjOnZx3Nu5kJZggjj3GClBcbeudE4NnunuqOyH8TOR0CIE9dCIybUO1EYhzwNowddHFtGuTWlKlBSUYKpul4ToG5kX3HccGtRxFrRhtdT3XFdmLQ5ZkFltrY8ZHr1S/99DzeYHXo/pwo2xB5A0yot4YWYat+TZggt+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752752921; c=relaxed/simple;
	bh=MPRnHLK1PLTaRTDeh0MO9ek5E8MNH6YbR3/l8FTEyrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TFdAF8VRy+aAf0ulteDnCxH0Xz4dQgMejNW7zxstgEiiz4Kueg6YGNXrTmUQ6VVwL3eQ6GiTPsGlRjiNMpVKCfeljwah+vQ+mbXCnuTZCcLsskoysjUz/N1NVs/C/TWFSNF390+tyiy1ptDfeVDBSEhecBVUKL68fCfQqv8Sqys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bjWRv2vktz27hyG;
	Thu, 17 Jul 2025 19:49:31 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 363651A016C;
	Thu, 17 Jul 2025 19:48:32 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Jul 2025 19:48:31 +0800
Message-ID: <1b96fdc3-d13f-4646-a935-8edb32670c49@huawei.com>
Date: Thu, 17 Jul 2025 19:48:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] A filesystem abnormal mount issue
To: Christian Brauner <brauner@kernel.org>, <hch@lst.de>
CC: <jack@suse.com>, <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>, <yangerkun@huawei.com>
References: <20250717091150.2156842-1-wozizhi@huawei.com>
 <20250717-friseur-aufrollen-60e89dbd9c89@brauner>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <20250717-friseur-aufrollen-60e89dbd9c89@brauner>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100017.china.huawei.com (7.202.181.16)



在 2025/7/17 17:39, Christian Brauner 写道:
> On Thu, Jul 17, 2025 at 05:11:50PM +0800, Zizhi Wo wrote:
>> Currently, we have the following test scenario:
>>
>> disk_container=$(
>>      ${docker} run...kata-runtime...io.kubernets.docker.type=container...
>> )
>> docker_id=$(
>>      ${docker} run...kata-runtime...io.kubernets.docker.type=container...
>>      io.katacontainers.disk_share="{"src":"/dev/sdb","dest":"/dev/test"}"...
>> )
>>
>> ${docker} stop "$disk_container"
>> ${docker} exec "$docker_id" mount /dev/test /tmp -->success!!
>>
>> When the "disk_container" is started, a series of block devices are
>> created. During the startup of "docker_id", /dev/test is created using
>> mknod. After "disk_container" is stopped, the created sda/sdb/sdc disks
>> are deleted, but mounting /dev/test still succeeds.
>>
>> The reason is that runc calls unshare, which triggers clone_mnt(),
>> increasing the "sb->s_active" reference count. As long as the "docker_id"
>> does not exit, the superblock still has a reference count.
>>
>> So when mounting, the old superblock is reused in sget_fc(), and the mount
>> succeeds, even if the actual device no longer exists. The whole process can
>> be simplified as follows:
>>
>> mkfs.ext4 -F /dev/sdb
>> mount /dev/sdb /mnt
>> mknod /dev/test b 8 16    # [sdb 8:16]
>> echo 1 > /sys/block/sdb/device/delete
>> mount /dev/test /mnt1    # -> mount success
>>
>> The overall change was introduced by: aca740cecbe5 ("fs: open block device
>> after superblock creation"). Previously, we would open the block device
>> once. Now, if the old superblock can be reused, the block device won't be
>> opened again.
>>
>> Would it be possible to additionally open the block device in read-only
>> mode in super_s_dev_test() for verification? Or is there any better way to
>> avoid this issue?
> 
> As long as you use the new mount api you should pass
> FSCONFIG_CMD_CREATE_EXCL which will refuse to mount if a superblock for
> the device already exists. IOW, it ensure that you cannot silently reuse
> a superblock.

Yes, it is indeed exclusive.

> 
> Other than that I think a blkdev_get_no_open(dev, false) after
> lookup_bdev() should sort the issue out. Christoph?

Oh, I didn't consider it before. blkdev_get_no_open() is sufficient.
Thanks for suggestion!

Thanks,
Zizhi Wo



