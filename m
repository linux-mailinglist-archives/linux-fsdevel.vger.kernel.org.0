Return-Path: <linux-fsdevel+bounces-14678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B99F87E19F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 02:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D726E28279F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 01:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6511E89D;
	Mon, 18 Mar 2024 01:26:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752531E871;
	Mon, 18 Mar 2024 01:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725218; cv=none; b=nxz9wXKfpi/i/QCvtcO5X2AbP717YRbWlcBsaph75WxS9AY4jxeqWpzCB8VQ+qTGHZ07JSHK8DCHOD6idZzv74ufp499odlKVZ/gllv2mjegVE50B3PLu9Vsz0mFhEmyBPyWuwrVQFCmznZ0Uhh0TK2fr+Lxbbjx40K2uF5IJI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725218; c=relaxed/simple;
	bh=DiwD1KKygurl6AnELy0/qNGnnXYROZXkXmMXr0xzi3Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Tl9pxhD6A0ycsGkRvRiVqAknrO8y0n0wAwtIkqdpjtQ29Y6pRC5At+B6t0wdrW+8OhnasBdXHt3CzWdKFPCtG0vx7pE8xALSTR3mg3Zyk9eYI55V6eOQ8x5VDRkOwrRflNDQQXJrLxn3L52m6VBW6uHru0zzE3BWp4x+JSjc2+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tycdg1D9zz4f3jM7;
	Mon, 18 Mar 2024 09:26:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F1A811A0172;
	Mon, 18 Mar 2024 09:26:50 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFZmPdloeolHQ--.29175S3;
	Mon, 18 Mar 2024 09:26:50 +0800 (CST)
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
To: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, brauner@kernel.org, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-20-yukuai1@huaweicloud.com>
 <20240317213847.GD10665@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com>
Date: Mon, 18 Mar 2024 09:26:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240317213847.GD10665@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFZmPdloeolHQ--.29175S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XrW5CFy3CrWxGrWUGrWxJFb_yoW3ZwcE9a
	43uF18Jw4kA39avF4SgayFgrZ2yF9rGrWSqF9YqrW7Xw13tasxZaykZryvyr1Uta13Kr9Y
	vr45Zrn8WrWSkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
	Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/03/18 5:38, Christoph Hellwig Ð´µÀ:
> On Thu, Feb 22, 2024 at 08:45:55PM +0800, Yu Kuai wrote:
>> The only user that doesn't rely on files is the block layer itself in
>> block/fops.c where we only have access to the block device. As the bdev
>> filesystem doesn't open block devices as files obviously.
> 
> Why is that obvious?  Maybe I'm just thick but this seems odd to me.

Because there is a real filesystem(devtmpfs) used for raw block devcie
file operations, open syscall to devtmpfs:

blkdev_open
  bdev = blkdev_get_no_open
  bdev_open -> pass in file is from devtmpfs
  -> in this case, file inode is from devtmpfs,

Then later, in blkdev_iomap_begin(), bd_inode is passed in and there is
no access to the devtmpfs file, we can't use s_bdev_file() as other
filesystems here.

Thanks,
Kuai

> 
> .
> 


