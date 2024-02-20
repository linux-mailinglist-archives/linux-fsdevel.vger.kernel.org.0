Return-Path: <linux-fsdevel+bounces-12152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A378585BB20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 12:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D011C21F47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 11:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6113067C4C;
	Tue, 20 Feb 2024 11:57:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9B066B52;
	Tue, 20 Feb 2024 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430247; cv=none; b=K8UzCvXpVKtptyLL/Gn+BqwCQCsW/0eNOx9/OFPamlNcimVk9NcdKj5QrlRc8ICogeS9m0QBX9QptWpZQyoCFCMCvEDg4U4JO8CWOoosspEHoFgyb5jRfNNcVucGpK3PYJTEScALb8cJRTLsqD6vn9at7GqOSlAUBW58xhVWsa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430247; c=relaxed/simple;
	bh=i9pVEpGB/aWKcR3DQQC4Bq4YJYkwZ4IhGn7GD+dZCds=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tGUi0YgwSUbgVpBm8Y04mLlXjh02evwCQC9mEGrJvqnJRM9l9RHllzPCpcmiQa3HDiimFnyCclY6R4EExhFo+0jClh309EICIXAs15276hUQjw3vz7gXHGd1haNYfitjq1L/GAfID1qMsAxG+DJyEUq4x/ZPuMNoUi1jHHMwmtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TfHvR3kHBz4f3mJB;
	Tue, 20 Feb 2024 19:57:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9AB891A09DD;
	Tue, 20 Feb 2024 19:57:14 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g6Yk9RlAJpkEg--.13854S3;
	Tue, 20 Feb 2024 19:57:14 +0800 (CST)
Subject: Re: [PATCH RFC 1/2] fs & block: remove bdev->bd_inode
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20240129-vfs-bdev-file-bd_inode-v1-0-42eb9eea96cf@kernel.org>
 <20240129-vfs-bdev-file-bd_inode-v1-1-42eb9eea96cf@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8d4156dd-a65e-5baf-a297-b5c36f8c929f@huaweicloud.com>
Date: Tue, 20 Feb 2024 19:57:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240129-vfs-bdev-file-bd_inode-v1-1-42eb9eea96cf@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g6Yk9RlAJpkEg--.13854S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZr4rGF1xZFy5ur4fJF1xuFg_yoWfGwb_X3
	sxCw1kJw1rAwsYvw1SgF97JFZ7ta4UJrW0kF9Yqas5Wrn7Ja98Zr1DZryIvrn8J3W3ZFn8
	Arn0v3y8Kw4SgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Christian

在 2024/01/29 18:56, Christian Brauner 写道:
> The only user that doesn't rely on files is the block layer itself in
> block/fops.c where we only have access to the block device. As the bdev
> filesystem doesn't open block devices as files obviously.
> 
> This introduces a union into struct buffer_head and struct iomap. The
> union encompasses both struct block_device and struct file. In both
> cases a flag is used to differentiate whether a block device or a proper
> file was stashed. Simple accessors bh_bdev() and iomap_bdev() are used
> to return the block device in the really low-level functions where it's
> needed. These are overall just a few callsites.

I just realize that your implementation for iomap and buffer_head is
better, if you don't mind. I'll split related changes into a seperate
patch, and send out together.

Thanks,
Kuai


