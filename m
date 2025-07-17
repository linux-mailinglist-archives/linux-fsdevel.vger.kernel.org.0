Return-Path: <linux-fsdevel+bounces-55244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F69B08BF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 13:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0131AA47236
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 11:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4657529B239;
	Thu, 17 Jul 2025 11:50:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024B32AE8E;
	Thu, 17 Jul 2025 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753005; cv=none; b=dkhOjjtRkcUhefiZPfyQY2U/f2YY5apg0EVXSSYy2y6UVO1CvyRcYp/blZcZlQniXhM+36IkFWHdV6/CDxlFU2bl5S27WKhpaDYc2eIj+JxZxZ/QRmc3HsrTw9cr7coBYUir5V7wYjUr0zPzOrI3Pg88uMcHiSPxpGqtAnR9/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753005; c=relaxed/simple;
	bh=RBUWMUNIrlYB1kqk36o/zyxYf3XKgfu7wpmnu8OkUzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=owMLsxhvwbrTLixLTZtM3/LzobK42SCrbVeMw5Bq7ItuwL280v7xsvr0jDTUdPZZ2D3Q8LxNqiqNfxxZYaGi562tt+3fcSQWAIgsEbnoAFCBBTEWhvXpqfcuBCgNb+n25xzy5tM22+Mg176zw4KiPu5NdK+56ybM9SmRHL15mfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bjWLr5jsLz14M1N;
	Thu, 17 Jul 2025 19:45:08 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 11AF8180080;
	Thu, 17 Jul 2025 19:49:56 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Jul 2025 19:49:55 +0800
Message-ID: <7337feb6-73ac-47b8-9a74-d579167ba438@huawei.com>
Date: Thu, 17 Jul 2025 19:49:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] A filesystem abnormal mount issue
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
CC: <jack@suse.com>, <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>, <yangerkun@huawei.com>
References: <20250717091150.2156842-1-wozizhi@huawei.com>
 <20250717-friseur-aufrollen-60e89dbd9c89@brauner>
 <20250717110410.GA15870@lst.de>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <20250717110410.GA15870@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100017.china.huawei.com (7.202.181.16)



在 2025/7/17 19:04, Christoph Hellwig 写道:
> On Thu, Jul 17, 2025 at 11:39:01AM +0200, Christian Brauner wrote:
>> As long as you use the new mount api you should pass
>> FSCONFIG_CMD_CREATE_EXCL which will refuse to mount if a superblock for
>> the device already exists. IOW, it ensure that you cannot silently reuse
>> a superblock.
>>
>> Other than that I think a blkdev_get_no_open(dev, false) after
>> lookup_bdev() should sort the issue out. Christoph?
> 
> Or just check for GD_DEAD before the mount proceeds?


This is indeed concise and effective enough. Thank you for your
suggestion.

Thanks,
Zizhi Wo

