Return-Path: <linux-fsdevel+bounces-22473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A53909176C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 05:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4384BB20C00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 03:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4E271B3A;
	Wed, 26 Jun 2024 03:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LYrBGatm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D6B4962D;
	Wed, 26 Jun 2024 03:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719372525; cv=none; b=Ap52xiQJMWlep13z9ncCsHG0zHuHCtCPAiYJnQGU/WsGQWjDYkSlgra0/JGxWAtjO0hZ0gu0/ZbuxH4bLfhSqIzmch9Ie+R/1IdTYN9lJvBkJGLhiaiH6elckznXKuakExZvSUxqwpIQZHGuaRGG67HVOYTG/5VBY/XMuDZXMyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719372525; c=relaxed/simple;
	bh=0zrJpY1JkZv2ZzG/zVeUvi0maDu1O7pGTexPM9pzIs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QyUS/8DI904UhA7I7Wd3nTdjDa8OoQkKJBBXAuFTzjmrenzrXr24YHE3WARMOLuGerZ7dYDfYAtEh4anMfkDLqamFQTQ83j3W3JYZV1hijdLGWj6DScNSvHQK8CFZ/2FwQpjG2M7VCPhYzoru0gc8NsXRhzZUE86zglKSsVOjN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LYrBGatm; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719372521; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0zrJpY1JkZv2ZzG/zVeUvi0maDu1O7pGTexPM9pzIs4=;
	b=LYrBGatmjT9nW1IvjWwLOXzUYQy2gl92pgz5Vp0qLbtgnYvS/pXt/DbkzXKmwaolzO/OlIuGYerTABP9tfuLNtjPwIWYXkF0kMpDeBOMnQ/TW0ZmlRNSp6fwCqQh+WsZTKco+Rc7TTQOr1kAI09NmP+Z7/lQogWEojIlf7AEgro=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068164191;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W9Hi27f_1719372519;
Received: from 30.97.48.205(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9Hi27f_1719372519)
          by smtp.aliyun-inc.com;
          Wed, 26 Jun 2024 11:28:40 +0800
Message-ID: <c809cda4-57be-41b5-af2f-5ebac23e95e0@linux.alibaba.com>
Date: Wed, 26 Jun 2024 11:28:39 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] cachefiles: some bugfixes for clean object/send
 req/poll
To: Baokun Li <libaokun@huaweicloud.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org
Cc: jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
 <13b4dd18-8105-44e0-b383-8835fd34ac9e@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <13b4dd18-8105-44e0-b383-8835fd34ac9e@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/26 11:04, Baokun Li wrote:
> A gentle ping.

Since it's been long time, I guess you could just resend
a new patchset with collected new tags instead of just
ping for the next round review?

Thanks,
Gao Xiang


