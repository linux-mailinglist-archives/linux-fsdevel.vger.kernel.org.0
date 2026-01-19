Return-Path: <linux-fsdevel+bounces-74355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E81FD39BFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 02:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 805F73011F89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 01:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552751F03D7;
	Mon, 19 Jan 2026 01:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Ji1Q1BTL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF82019E98D;
	Mon, 19 Jan 2026 01:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768786475; cv=none; b=mt+sEr1WaUQd5CpARquu8lrKQSWQqL+SAXOk/+NQL0TUZY84hQQwSzaOcDpKZ+XZl7B7yIn9hBQB40SKIXdv29YGPza9D0Hm4Ukm98CtQtpkoiXDgr8ajuHqeqJfpoXtYFuPzyAN4Sl19HH4fFBsg2kgvIGaAflzgwxBiGaIJ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768786475; c=relaxed/simple;
	bh=u/hgQuVJ3NkHra8eNfpUmPb56Jwgqc4mnTLFayM3dYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kBnMPAyxCcFBcy/TvIo9+6jz5parkY7UeiiRDZMF68uTkNmoZl1ve8wh/6SugLYIfD/BRr4GBRq9H+47PsW/ZptSs5BP7GHvVsg3TYnVpdSVTkWss49v6D4N4BIR6KQ1dDsI9R8q6oeiuDjVh4pg0UcQ7nNbOfNKVR8P+1qgj70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Ji1Q1BTL; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=k6HtZU31DSV0s0hhsMmtxNdGbjkHvVDM2z5JmaC5ttw=;
	b=Ji1Q1BTLigZODe9ga0Qwmt0qWNF0ppSgMCMS1P1DZWPbonxipxS2uE5YyQlLS6D+1dvrRuUof
	1GyxiJa+HBVelScb58AXuKnDBYlE1un4JDxJOkEdTwGUOwCM1X+QFbnoGKyRNbRzOJeeeTfLJU8
	a4B2zF7fZtyjMgbFfjtVWSw=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dvXwQ22mTzRhQN;
	Mon, 19 Jan 2026 09:31:02 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id E6B94404AD;
	Mon, 19 Jan 2026 09:34:24 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Jan 2026 09:34:24 +0800
Message-ID: <c2f3f8bd-6319-4f5a-92cf-7717fa0c0972@huawei.com>
Date: Mon, 19 Jan 2026 09:34:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 2/9] erofs: decouple `struct erofs_anon_fs_type`
Content-Language: en-US
To: <hsiangkao@linux.alibaba.com>
CC: <chao@kernel.org>, <brauner@kernel.org>, <djwong@kernel.org>,
	<amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-3-lihongbo22@huawei.com>
 <20260116153829.GB21174@lst.de>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20260116153829.GB21174@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)

Hi, Xiang

On 2026/1/16 23:38, Christoph Hellwig wrote:
>> +#if defined(CONFIG_EROFS_FS_ONDEMAND)
> 
> Normally this would just use #ifdef.
> 
How about using #ifdef for all of them? I checked and there are only 
three places in total, and all of them are related to 
FS_PAGE_CACHE_SHARE or FS_ONDEMAND config macro.

Thanks,
Hongbo

