Return-Path: <linux-fsdevel+bounces-71653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5C4CCB356
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 10:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CCC030E361A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 09:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1953328F9;
	Thu, 18 Dec 2025 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b7myT6kV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E2832E145;
	Thu, 18 Dec 2025 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050448; cv=none; b=byPqj+XMx582U5Hkc3HsicC1HAwM8Nc5fanuAIodP7QXCsXWgMTeQk7P/Ks+JMEy8VypG3+ccaIyqdJMizTQlbnyRbxGnh1KhpP9lK5WPIq08Q4MghMUaZilLvSUmsEmIzOmtZQyIgI3Y4Fncuc9a5QzrWQwpgG8d9zYdc1uiu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050448; c=relaxed/simple;
	bh=gnHmr4f4PJRMzwW/N/mcGELQtV0HDH15M8WE41z+XOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTCGC5bO4/QWbcnfhs7Y8r+v48FEpXC4RUQWZY2HbDytwNGg8pk73L2qKVm3+M4Tw5voxtFlsniSLViupnFxpq3m1RTo3/oDBBvDosuZCdtMbsDyyFOTqeMrXJvFw0qqYqO1MhGnN8/xIjqSLyEA7WL6uw0OZDeNC8B807tpsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b7myT6kV; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766050441; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lqZxary+PLPBpxkU8D2mX3dYoLxsWyhOdpuBcTYdCJs=;
	b=b7myT6kVzYqRyltehXwfrmPTtGZIcszZLXGgj7lTm5WqHKdPAEY6nDHGNzuN2NhZamtL2jaxBSVnKolxR/JMTI4zwua3mAO+K1MF+5ADGcsK+PQ6nM49+8opHlc1GgfugpLK6LX+pM+G2n0ClDWGFf3W7fbU8zjAFkcmLQ+o8WM=
Received: from 30.221.132.6(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wv852Qi_1766050440 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Dec 2025 17:34:00 +0800
Message-ID: <9602739e-cda9-428d-8af7-528538b0db6f@linux.alibaba.com>
Date: Thu, 18 Dec 2025 17:33:59 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] uapi: promote EFSCORRUPTED and EUCLEAN to errno.h
To: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org
Cc: linux-api@vger.kernel.org, linux-ext4@vger.kernel.org, jack@suse.cz,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 gabriel@krisman.be, hch@lst.de, amir73il@gmail.com
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
 <176602332146.686273.6355079912638580915.stgit@frogsfrogsfrogs>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <176602332146.686273.6355079912638580915.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/18 10:02, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Stop definining these privately and instead move them to the uapi
> errno.h so that they become canonical instead of copy pasta.
> 
> Cc: linux-api@vger.kernel.org
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

(...I really think it could be done earlier)
Thanks,
Gao Xiang

