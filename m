Return-Path: <linux-fsdevel+bounces-63096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CADBABE43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 09:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01FD188EE32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 07:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023A3243968;
	Tue, 30 Sep 2025 07:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="UTmMmVsO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2379121FF35;
	Tue, 30 Sep 2025 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218412; cv=none; b=mIXm7YORz8Ew2um3HEsZgkYn1KPOVMb3IlehiatibaQKa3m1rij1u2l26sJE5FdnxZmw+qkS4ufN5xyx4UDb302jWwO5HN4iVksNbQDDpd39ZUHMPy0Jb1MtZwe6pI8skXBcFFx7+LihndZRkxY4v17MJ/ZRp+lGcz2pxuzbqWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218412; c=relaxed/simple;
	bh=95fMoTQh0bo0BzmYci/Zzv5/hRiWx+7onjHlNikE3YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iQ5SuGU/V+fOmkKNZj2ZRkfnukZUbg7y7dLr8PN2KHRwY+UEt6cjUjSeCBJU+8DkBpIBIlx9ExbGmEPGOCSkx48o561b+ng/m6p/5HNVUHWVv/0kPQo09a3xgA3mNoKbysGs+S9T88SAQDNrMs90ZY4R3vuyLeAabcfeY7RtHwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=UTmMmVsO; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4yVBWN40KFRCJyogD6bEHezduKbNYUszb3revB5puE4=;
	b=UTmMmVsOlCafkjb9SR77hPSgp5RCV+u79zh0qkYxIzTVZIivSP0AKeBOHluWQ0iMlBuGiZ8an
	rMr/h2Vhc8XgkLz5jfHBLuWC6HEIB1PEDvQ7QeS8u7vFhzGkiYoK58U0S3JY9pWGzIZlUooky0S
	zVwcRwCnlst3hzhH0SVWWxk=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cbVVy2QzNzKmcs;
	Tue, 30 Sep 2025 15:46:34 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 478741A0188;
	Tue, 30 Sep 2025 15:46:45 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Sep 2025 15:46:44 +0800
Message-ID: <4710f8cf-4abe-0f3b-fac0-74379a755824@huawei.com>
Date: Tue, 30 Sep 2025 15:46:44 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 6.6.y] loop: Avoid updating block size under exclusive
 owner
To: Greg KH <gregkh@linuxfoundation.org>, Zheng Qixing
	<zhengqixing@huaweicloud.com>
CC: <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <stable@vger.kernel.org>, <jack@suse.cz>,
	<sashal@kernel.org>, <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
	<houtao1@huawei.com>, <zhengqixing@huawei.com>
References: <20250930064933.1188006-1-zhengqixing@huaweicloud.com>
 <2025093029-clavicle-landline-0a31@gregkh>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <2025093029-clavicle-landline-0a31@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2025/9/30 15:34, Greg KH 写道:
> On Tue, Sep 30, 2025 at 02:49:33PM +0800, Zheng Qixing wrote:
>> From: Zheng Qixing <zhengqixing@huawei.com>
>>
>> From: Jan Kara <jack@suse.cz>
>>
>> [ Upstream commit 7e49538288e523427beedd26993d446afef1a6fb ]
> 
> This is already in the 6.6.103 release, so how can we apply it again?

147338df3487 (tag: v6.6.108, origin/linux-6.6.y) Linux 6.6.108
42a6aeb4b238 Revert "loop: Avoid updating block size under exclusive owner"

We revert this in 6.6.108 since this incorrect adaptation will introduce 
some hungtask bug. And patch from Qixing is correct.

Thanks,
Erkun.


> 
> thanks,
> 
> greg k-h
> 

