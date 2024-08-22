Return-Path: <linux-fsdevel+bounces-26657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 257FC95ABA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 05:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58FB11C2650F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B661F947;
	Thu, 22 Aug 2024 02:56:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00071EB2F
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295375; cv=none; b=qKuKCAKK3BSHjxBTsqoM7HqKrFe27BPIgUKcBWcscw2/E1hvJOGWoZZ5ygrucUZK7tEBvF3WyQpGbnZu+onnA8IWLig6QIgfuTpSlBpWfmMZj+09ogNyxK6XlnzCsde4BYpnssoHAzEU0ggnRPT95+0flkOxa+g5DpLyAitOtzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295375; c=relaxed/simple;
	bh=i39Jsxe9N7HgMctbFlfTE5NbwkE4AUiM6k3hpaPiU2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IGkFbmQLqlBWAiaum+AT5XtKFkk/ziubEEQDTCxxM7wE96vp0RaFRegfxT56dKQljvGYozU0SAi4aXVqdv1fEhnI9RHdWH5m0eWr3o2fTBK0C0FirGwviiV8BUffa32ZsShoUxuLKz5ZsegSZTaKcSNdW2EuPqFAnUaunebQbkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wq7B94xpVz1j6p4;
	Thu, 22 Aug 2024 10:56:01 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id AC8981A016C;
	Thu, 22 Aug 2024 10:56:04 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 10:56:04 +0800
Message-ID: <82b27758-a4dd-4fa1-a853-84f6fd803a3f@huawei.com>
Date: Thu, 22 Aug 2024 10:56:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] radix tree test suite: Remove usage of the
 deprecated ida_simple_xx() API
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: <linux-fsdevel@vger.kernel.org>
References: <20240821065927.2298383-1-lihongbo22@huawei.com>
 <ZsXkSG_jFPCyCTLi@casper.infradead.org>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <ZsXkSG_jFPCyCTLi@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/21 20:57, Matthew Wilcox wrote:
> On Wed, Aug 21, 2024 at 02:59:27PM +0800, Hongbo Li wrote:
>> ida_alloc() and ida_free() should be preferred to the deprecated
>> ida_simple_get() and ida_simple_remove().
> 
> Already sent by Christopher JAILLET.
> https://lore.kernel.org/linux-fsdevel/cover.1722853349.git.christophe.jaillet@wanadoo.fr/
> 
ha, I haven't notice that. I'll drop this.

Thanks
Hongbo

