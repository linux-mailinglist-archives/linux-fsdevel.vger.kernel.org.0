Return-Path: <linux-fsdevel+bounces-72576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 894F9CFC1E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 06:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8A5D30221B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 05:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0F219E992;
	Wed,  7 Jan 2026 05:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Gv5IdJzP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF473BB5A;
	Wed,  7 Jan 2026 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767765120; cv=none; b=qGX0tIE3mLh+rOvEkcsqM3I9uAGailaeaPsJjkS+D4HwPxwg4flLZoLuLENnv+F0DBdlm2A2/1UhJTwPJg8Vv+tRRjtZ/254q5ubmRUPmbuHOB/3ic44qrpDO5/qNJfGc5Qg64gkapYn4OJZ/aGyavkVuvVOgwRg5UUCV8CG9QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767765120; c=relaxed/simple;
	bh=EP9GGIXvhrmUJ1l7F5Fbn5rgOdqEu0tPeQoDbjNBdbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yqj95m7fzGJW0pArtKIvlq21TTpu13a2qJAyY0+Vgl/Z73oumZ7P6zSEqYHWXRqolfxoK/D3xKVkEzokIqit7doUxjPbVWluCOJ171M1HeJ/CrZbH7NNjC8ilIZi8dwVC+d+jbwNbAbsCHMeZ8TH+l4vmTx3VrJu+P76zfG7oUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Gv5IdJzP; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767765108; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=riAjk1mLYj44mzUokmcOFJgCmy8gwS2bayryYTykvbs=;
	b=Gv5IdJzPSVK2JSeKBAFApi0+/ssmxZXx867Hs2WrL9VgFjn9eGPfLchxvkiclK6rlTTvMr4Mxb9pFnXO4dUSoqPjP7mxlzvxhw5P4YRiyEdDcA7J7yjWKKPP0fVlUh30kAICB94nOaiVcSEt2dMMvL5z7e6EFIqA5jZLJGNMX/8=
Received: from 30.221.132.240(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwXh5Jz_1767765107 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 Jan 2026 13:51:47 +0800
Message-ID: <cc4a2a0f-0bb1-4e18-92ac-0fea09ffc2f3@linux.alibaba.com>
Date: Wed, 7 Jan 2026 13:51:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 05/10] erofs: support user-defined fingerprint name
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251231090118.541061-1-lihongbo22@huawei.com>
 <20251231090118.541061-6-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251231090118.541061-6-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/31 17:01, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> When creating the EROFS image, users can specify the fingerprint name.
> This is to prepare for the upcoming inode page cache share.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

