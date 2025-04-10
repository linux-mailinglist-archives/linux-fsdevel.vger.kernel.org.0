Return-Path: <linux-fsdevel+bounces-46182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F13AA83E65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 11:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCCBB16CE6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 09:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84F720DD72;
	Thu, 10 Apr 2025 09:16:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EB920C486;
	Thu, 10 Apr 2025 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744276564; cv=none; b=MjSEo9OuqZ/E71taEbxkusB3r10mgZMAoNpkpyl3l2RcRn+O6u25TUhTCKdcqDrrkCvlFJ7CQGxx/Fwd1NMKzPxrrF+SmLhPu8PrZJA1BXI1mgpdXNV7DP342Mm3bH/T06Jqqu1sISReRYBW454LvYZFnVt1A51dhNuVLXo/Pxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744276564; c=relaxed/simple;
	bh=NuaiFWf/MGmb/slPvCMgGIM4CudTdEL+DN/zBMIEYWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFvcuT3X0vWsGhnokBrDYjlgGCzJCd7hMmBfNI0eNoWm06pV/gh+7I5Zilypq+rGo2cXu2L80L0CZTY/MqGVjeUP5PHjY8H51LIPCK42ITbuNVVzFyAjpv12MVRhSrfVi/Ey1ueqo64Stjj7Q1/lSUHcHxGCbDW3NXgBCNC/u00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZYDgT20LXz4f3m7N;
	Thu, 10 Apr 2025 17:15:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 47F631A058E;
	Thu, 10 Apr 2025 17:15:58 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgB32l5LjPdnfjI5JA--.26910S3;
	Thu, 10 Apr 2025 17:15:57 +0800 (CST)
Message-ID: <1131e6ec-9b78-4758-9250-02bde792e6b3@huaweicloud.com>
Date: Thu, 10 Apr 2025 17:15:55 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next v3 01/10] block: introduce
 BLK_FEAT_WRITE_ZEROES_UNMAP to queue limits features
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 djwong@kernel.org, john.g.garry@oracle.com, bmarzins@redhat.com,
 chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
 <20250318073545.3518707-2-yi.zhang@huaweicloud.com>
 <20250409103148.GA4950@lst.de>
 <43a34aa8-3f2f-4d86-be53-8a832be8532f@huaweicloud.com>
 <20250410071559.GA32420@lst.de>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250410071559.GA32420@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB32l5LjPdnfjI5JA--.26910S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr45Jr48uF17tw1fXr13Arb_yoW8ZryDpF
	W3KFs2yFn3tr4Ikwn2gw10gFyF9wn7AF45GanavryjywnxWFWIgF1IgF10vFyDurn7Wr4Y
	vF4Uta4xurn0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/4/10 15:15, Christoph Hellwig wrote:
> On Thu, Apr 10, 2025 at 11:52:17AM +0800, Zhang Yi wrote:
>>
>> Thank you for your review and comments. However, I'm not sure I fully
>> understand your points. Could you please provide more details?
>>
>> AFAIK, the NVMe protocol has the following description in the latest
>> NVM Command Set Specification Figure 82 and Figure 114:
>>
>> ===
>> Deallocate (DEAC): If this bit is set to ‘1’, then the host is
>> requesting that the controller deallocate the specified logical blocks.
>> If this bit is cleared to ‘0’, then the host is not requesting that
>> the controller deallocate the specified logical blocks...
>>
>> DLFEAT:
>> Write Zeroes Deallocation Support (WZDS): If this bit is set to ‘1’,
>> then the controller supports the Deallocate bit in the Write Zeroes
>> command for this namespace...
> 
> Yes.  The host is requesting, not the controller shall.  It's not
> guaranteed behavior and the controller might as well actually write
> zeroes to the media.  That is rather stupid, but still.

IIUC, the DEAC is requested by the host, but the WZDS and DRB bits in
DLFEAT is returned by the controller(no?). The host will only initiate
a DEAC request when both WZDS and DRB are satisfied. So I think that
if the disk controller returns WZDS=1 and DRB=1, the kernel can only
trust it according to the protocol and then set
BLK_FEAT_WRITE_ZEROES_UNMAP flag, the kernel can't and also do not
need to identify those irregular disks.

> 
> Also note that some write zeroes implementations in consumer devices
> are really slow even when deallocation is requested so that we had
> to blacklist them.

Yes, indeed. For now, the kernel can only detect through protocol
specifications, and there seems to be no better way to distinguish
the specific behavior of the disk. Perhaps we should emphasize that
this write_zeroes_unmap tag is not equivalent to disk support for
'fast' write zeros in the DOC.

Thanks.
Yi.


