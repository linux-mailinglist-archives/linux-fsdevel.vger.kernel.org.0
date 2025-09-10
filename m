Return-Path: <linux-fsdevel+bounces-60744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E15B51153
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 10:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6B024E2AE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 08:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDFF30FF2A;
	Wed, 10 Sep 2025 08:31:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A7F2D5947;
	Wed, 10 Sep 2025 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493115; cv=none; b=vCGhlW1oIehzzqcihZ5IWJ4rfKYiHYgCVytTO+L3mBmKzEmvCxGSWTV4wzqLCdHxe2DN1/GjzyB4rJQ+E8zGczIiESa6zKFn4IG/07L2BpyCbI0ofnhJJ4pv518UsupJfdHrRaXV2LMUsMCSUBwQkHqevRNIBuf7UuxWnWY4Ky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493115; c=relaxed/simple;
	bh=btYuSerNDcokDO6Y/one3a829eB8ISvBdG67DcBTu9c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fhq/dL/3BGLaMAtv4lnvq3QpLFjVUO/cT0wr9wUKsL9tKG9zymYE6NWtlsX3sPd3IzWXJ6NoDts+eykiTerneg0DjlhVRx9nbJ/zSO0b9l2bpi8JOaeghHXlcRnHfeak7A1tvKkFzP8IViYwt6pDvz5Ah92EJZUi43jJsv0GPiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cMDSR0LhGzYQvcg;
	Wed, 10 Sep 2025 16:31:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 881DB1A23A5;
	Wed, 10 Sep 2025 16:31:49 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCn8IxzN8Fol3MSCA--.51693S3;
	Wed, 10 Sep 2025 16:31:49 +0800 (CST)
Subject: Re: [PATCH 1/2] md: init queue_limits->max_hw_wzeroes_unmap_sectors
 parameter
To: John Garry <john.g.garry@oracle.com>, Zhang Yi
 <yi.zhang@huaweicloud.com>, linux-block@vger.kernel.org,
 linux-raid@vger.kernel.org, drbd-dev@lists.linbit.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
 martin.petersen@oracle.com, axboe@kernel.dk, yi.zhang@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250825083320.797165-1-yi.zhang@huaweicloud.com>
 <20250825083320.797165-2-yi.zhang@huaweicloud.com>
 <5b0fd2a0-dffc-4f51-bdff-746e9bd611bd@oracle.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <05249654-3088-d3e1-570d-79f58019377c@huaweicloud.com>
Date: Wed, 10 Sep 2025 16:31:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5b0fd2a0-dffc-4f51-bdff-746e9bd611bd@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8IxzN8Fol3MSCA--.51693S3
X-Coremail-Antispam: 1UD129KBjvdXoWruw45WFyUuF4kGr43Jw4Utwb_yoWkCrgEkr
	sxXa98XFW5AF42qw4UKr13ZrW3ta95Wr1kZF1rWrs8XFyrZrykursxZ3sa9F15JFWIqr90
	kan7Xw1I9FZFvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/02 20:25, John Garry 写道:
>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>> index 408c26398321..35c6498b4917 100644
>> --- a/drivers/md/raid1.c
>> +++ b/drivers/md/raid1.c
>> @@ -3211,6 +3211,7 @@ static int raid1_set_limits(struct mddev *mddev)
>>       md_init_stacking_limits(&lim);
>>       lim.max_write_zeroes_sectors = 0;
>> +    lim.max_hw_wzeroes_unmap_sectors = 0;
> 
> It would be better if we documented why we cannot support this on 
> raid1/10, yet we can on raid0.
> 
> I am looking through the history of why max_write_zeroes_sectors is set 
> to zero. I have gone as far back as 5026d7a9b, and this tells us that 
> the retry mechanism for WRITE SAME causes an issue where mirrors are 
> offlined (and so we disabled the support); and this was simply copied 
> for write zeroes in 3deff1a70.

Yes, we don't support it for now, and I think it is not too hard to
support write zeros, and finaly to support unmap zeros. BTW, raid5
discard is in the same suituation.

However, I feel this is not related to this set, perhaps a seperate
patch to add comments, I can accept that.

Thanks,
Kuai


