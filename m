Return-Path: <linux-fsdevel+bounces-9683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FDE8446A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C241C22BB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549F6130E58;
	Wed, 31 Jan 2024 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="D05OZuhO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF7212BE8D;
	Wed, 31 Jan 2024 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723983; cv=none; b=LL9PlGWnlUKDv5+CIl85H3fq2vh98T57Jq85YrQXsS6vQgTDT8fWIrahSWjuLx2hsVl6ZcSVZfR3d8pF1nyUsjmF902o+xReFCnEyYocmOPsKtAJnl1myJPuYuSmQlKTMX9WZEbacjDiH72HHNqPx90JjVxnqywieMhHpjPisCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723983; c=relaxed/simple;
	bh=0GkUVq/ahRHhqG1Lv0Xl+fmCnh259a4a56wCyZhcZ88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsM8P7VT7bNMW/hCGb1jZd6h4BMX0adKgmQcGBVUHp8eEIV60wTsgezVq87CSIaEsJtgGChFS/eqnXdGLorL6fHJYVTMO02T4LykwNuo13YP6wAlUA7PUkz/qP3JGNMu2yd4D/V+R3HPAjbfPxaIqDXeT1v+oYI+8qQFGND60ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=D05OZuhO; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706723974;
	bh=0GkUVq/ahRHhqG1Lv0Xl+fmCnh259a4a56wCyZhcZ88=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D05OZuhOW4czsWFTu8ytaJaVLY1/dzi+uxJdNLV6D2fqQbMbN8dPDZQ0JMksKwGDF
	 53R8n9ef24qPhVTDg/AE92rO1SBtT4bi+uzg8BOn5OaNhk0IIbBWx+ebEB68vPcAX+
	 TDHbw1PJagl/OvuTQwrdJ8rReiZ2MUbgsODPZDB5E/ohtUmE7G2ex6mDbI8IwwVZPf
	 3qGI1v3H5fkgSDiy3Sy3YxYBQq7akzk4eS1LxcLk+feaokC/bRYUM9in34gmdn9G6j
	 D6MioQ064jKketls/qz7dWPdjTf4lv7siDSvSgLAbLH7fySP9kNEtvKAl95RAjeZuk
	 OGSx/oGCgLPJA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TQ8tt0CrzzVYs;
	Wed, 31 Jan 2024 12:59:34 -0500 (EST)
Message-ID: <64e4a411-f35b-4e29-89d5-310420df4884@efficios.com>
Date: Wed, 31 Jan 2024 12:59:31 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 3/4] Introduce cpu_dcache_is_aliasing() across all
 architectures
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Russell King <linux@armlinux.org.uk>, linux-cxl@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org, dm-devel@lists.linux.dev,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <20240131162533.247710-1-mathieu.desnoyers@efficios.com>
 <20240131162533.247710-4-mathieu.desnoyers@efficios.com>
 <ZbqAl3gerwe2o6jy@infradead.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZbqAl3gerwe2o6jy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-31 12:17, Christoph Hellwig wrote:
> So this is the third iteration and you still keep only sending patch
> 3 to the list.  How is anyone supposed to review it if you don't send
> them all the pieces?

My bad. I was aiming for not spamming mailing lists on unrelated patches. I did
not CC linux-xfs@vger.kernel.org on the other patches. But the missing
context is just confusing. And I forgot to CC linux-fsdevel@vger.kernel.org
on patch 3 as well.

You can find the entire series on lore:

https://lore.kernel.org/lkml/20240131162533.247710-1-mathieu.desnoyers@efficios.com/T/#t

I'll make sure to copy all lists for all patches in the next
round, namely:

     Cc: linux-arch@vger.kernel.org
     Cc: linux-cxl@vger.kernel.org
     Cc: linux-fsdevel@vger.kernel.org
     Cc: linux-mm@kvack.org
     Cc: linux-xfs@vger.kernel.org
     Cc: dm-devel@lists.linux.dev
     Cc: nvdimm@lists.linux.dev

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


