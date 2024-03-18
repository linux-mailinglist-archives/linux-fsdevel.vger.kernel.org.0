Return-Path: <linux-fsdevel+bounces-14691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E40A87E1E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 02:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2021C21BF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 01:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1171CD23;
	Mon, 18 Mar 2024 01:51:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1419F18029;
	Mon, 18 Mar 2024 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710726716; cv=none; b=QF/t++r1zm7U1qRW3ajzba32HBI0GXIoKHnPDMnPvgjsPOTpmxISwkzc3g0lgGRJQuRndiHe5vVe88t9HXhm5U3awmysd6ts+CMlBi0+mqGrlOB36/DVL6VkC853quHhQiee3KgFc9sVZHD4GJ0kQ6H2PFcHP/oaxnGHeHRVz7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710726716; c=relaxed/simple;
	bh=rt5UEDmjpcrw9t+vzPWK0p09J3W1a+ME8M12KLx2kTg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WLP+fATkoQ8QFjl+PTD5NdIgFPrftopXFbPDMBNslNcia5gykMG/9IO3XP5PRuBlseSWQWFr1cqjT5cmejJGhv8i+3MZ69d+jZBLsozcLJMezgvedLQWYKispikQqpBYAICrurdT4WZAmQKft8JgNre3x4hmSBWFV3MeKGwosIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TydBS4BKxz4f3kFN;
	Mon, 18 Mar 2024 09:51:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 79E311A01A7;
	Mon, 18 Mar 2024 09:51:50 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBE0nvdlSrsnHQ--.20502S3;
	Mon, 18 Mar 2024 09:51:50 +0800 (CST)
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
To: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, brauner@kernel.org, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-20-yukuai1@huaweicloud.com>
 <20240317213847.GD10665@lst.de>
 <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com>
 <20240318013208.GA23711@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com>
Date: Mon, 18 Mar 2024 09:51:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240318013208.GA23711@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBE0nvdlSrsnHQ--.20502S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF18tF4xGry8WFWxWry3urg_yoWfuFXE93
	y7uw1kJr4UX3s2yF4S9F17GrZ7JFyDWry3tF9Yqay2vw13tan5uFZ3J34xAr18tr1xKr45
	CF1rXr98Jry7KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1U
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/03/18 9:32, Christoph Hellwig Ð´µÀ:
> On Mon, Mar 18, 2024 at 09:26:48AM +0800, Yu Kuai wrote:
>> Because there is a real filesystem(devtmpfs) used for raw block devcie
>> file operations, open syscall to devtmpfs:
>>
>> blkdev_open
>>   bdev = blkdev_get_no_open
>>   bdev_open -> pass in file is from devtmpfs
>>   -> in this case, file inode is from devtmpfs,
> 
> But file->f_mapping->host should still point to the bdevfs inode,
> and file->f_mapping->host is what everything in the I/O path should
> be using.
> 
>> Then later, in blkdev_iomap_begin(), bd_inode is passed in and there is
>> no access to the devtmpfs file, we can't use s_bdev_file() as other
>> filesystems here.
> 
> We can just pass the file down in iomap_iter.private

I can do this for blkdev_read_folio(), however, for other ops like
blkdev_writepages(), I can't find a way to pass the file to
iomap_iter.private yet.

Any suggestions?

Thanks,
Kuai
> .
> 


