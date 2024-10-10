Return-Path: <linux-fsdevel+bounces-31641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B809994A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 23:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C77A1F2479E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 21:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1704E1E47A3;
	Thu, 10 Oct 2024 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hvMGW1Y9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C624319A2A3;
	Thu, 10 Oct 2024 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728597034; cv=none; b=ZAkM+3j4rz/nIM1UsYRQmTatqlbENDOAY2eN5c6kg8l64fgKCLonBzn3THs8/Yj7/6BI/evXUVROkiHQfGNeMyQL7QAEXuTLdYp/ymcHKfYxwZqLpnwif9m4Jw4kWBOs7Ol/u032ZtXETRD34J/BBiJFqSbO34QmNyodo42xPjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728597034; c=relaxed/simple;
	bh=CNPvI1N4Wcjl9PFS32qMlGlxyv1CESaoJiYlUz/BucU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mY+K/H6SraCyqnZAKjIEtZPmAm7nCXJnbNtywIaXq7XfDMDAqkf+Fbi2s4FpwhnSNUBmp2kMt2hWGQuXpRNjshPmLRA35OLg4UXKrRO6Z/s9DbR6KeM4cU+0V7aSS2XU7ip62eCVXkxJRvgy/j1XEW9znUYCKANC/moBtkrjosw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hvMGW1Y9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=orMCFhyMJn782vmTUq+Q3NOxuHBE9KmJ0XirtiWn0Vs=; b=hvMGW1Y9QpQhvNCLn2WA02/5be
	2gUb3UgensqSVz7kb0i08EJyuhHN6r+Z3hSrXWHdZupnEK9Cp5RD0aw6KvpSEDf+daiBqPHWN1EsK
	y/tpuX2ZVQT+nkAVIaYKSgv+j6f587kGEgn4QLiBdLyNG/R8DBuh0mio1qfyISR7+TOle0WYcT49i
	91tgXyFxczxkMMnFLRS2eNONNpu3IwZNr48odwXiVu50XTXY3bbMq2dq5jZvbBxaKAKxccBTS5K8e
	BCAHqePY3iyJ8AaQPyXSxLfuAcpeICTyQ1aDEow8nSbjdVgSh5xB7y1kQHbANavbTPuo5w+gAuYHq
	EjxyaVhA==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sz13D-00000005gOY-0Dfh;
	Thu, 10 Oct 2024 21:50:28 +0000
Message-ID: <1f10bfa9-5a49-4f9b-bbbd-05c7c791684b@infradead.org>
Date: Thu, 10 Oct 2024 14:50:24 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] XArray: minor documentation improvements
To: Tamir Duberstein <tamird@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CAJ-ks9mz5deGSA_GNXyqVfW5BtK0+C5d+LT9y33U2OLj7+XSOw@mail.gmail.com>
 <20241010214150.52895-2-tamird@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241010214150.52895-2-tamird@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/10/24 2:41 PM, Tamir Duberstein wrote:
> - Replace "they" with "you" where "you" is used in the preceding
>   sentence fragment.
> - Mention `xa_erase` in discussion of multi-index entries.  Split this
>   into a separate sentence.
> - Add "call" parentheses on "xa_store" for consistency and
>   linkification.
> - Add caveat that `xa_store` and `xa_erase` are not equivalent in the
>   presence of `XA_FLAGS_ALLOC`.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> V3 -> V4: Remove latent sentence fragment.
> V2 -> V3:
>   - metion `xa_erase`/`xa_store(NULL)` in multi-index entry discussion.
>   - mention non-equivalent of `xa_erase`/`xa_store(NULL)` in the
>     presence of `XA_FLAGS_ALLOC`.
> V1 -> V2: s/use/you/ (Darrick J. Wong)
> 
>  Documentation/core-api/xarray.rst | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 

I'm satisfied with this change although obviously it's up to Matthew.
Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

