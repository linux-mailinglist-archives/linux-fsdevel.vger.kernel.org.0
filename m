Return-Path: <linux-fsdevel+bounces-53041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9C8AE931A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7C43B523A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666172D3EC0;
	Wed, 25 Jun 2025 23:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k/KCcCyG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4BE287252;
	Wed, 25 Jun 2025 23:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750895861; cv=none; b=tuv+2crAXWFJm9KklxSH9yjnIfPcjF5tY0wnNHalA4WQsKIwv3lW6Qs26cktgCKz53bvNerSnm7pLYpjwanlAH6SDQ+4EJYKc5QabIBrhmHtqP82M/Y8Xz1z8jQY5PpweHAHEhOVwwPeT/xXkdcl3XAuoPLhFMiWOAGBbLyqTOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750895861; c=relaxed/simple;
	bh=b2p2wLab3AkXhvQjT2HVq8Bz24cBRw35pUZ7w5ivhU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z3Mja29H3gWux5/grDExxGaeaKiFysVfPYZN33vve046I+n3+2kzNtoNfqvfNlOkaSDdk9MH5ZBMo+Nn1qfo3P53EU7O16PHXgaPLGldNjXgzSE0DWYLzuOsuDN7KqQeGechCvpWHunxKRbxncjFaaC3D1oWSBd+Nx1QuwVKMRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k/KCcCyG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=c+rrrcFg6u66Hnzut5Z/WroFwVDDLyZyn8hntHme06U=; b=k/KCcCyGyqyAaxFb2ZKA9rh+VF
	Tw6VTBokl/pf0DZqNobcHM6gtVorsZFwjF1thuG8hsHpYkkudmmJQG7E68zAW5xoaM4FTkmbKJE2x
	O9iRP4tpW1WALUETZlhq3OfEb/qnSTosMFfwVxhZmeTX6c+Z7aA1j+BjwzIegrJUroKPvl+XDbjec
	7uAUmnu7eIXy0AOot45E+8K+/ItaML7t/oFzCCNLc5L2DH6fSZw2wwRtScDNRq2Vdxs3Yw5RQiyBf
	XBS/At592eesDjQ0OjCaWqPi4H4KI6ntoWqNb46K4fPxwU/iHzZ5XEqTDG6ZtNeDN3uHJPjmae4n+
	RjiP4REg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUZzD-000000060Zf-0xuo;
	Wed, 25 Jun 2025 23:57:03 +0000
Message-ID: <ac8efa08-3f85-4532-8762-573ebd258ca7@infradead.org>
Date: Wed, 25 Jun 2025 16:56:48 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/32] kho: warn if KHO is disabled due to an error
To: Pasha Tatashin <pasha.tatashin@soleen.com>, pratyush@kernel.org,
 jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
 rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
 ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org,
 aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org,
 tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com,
 roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk,
 mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org,
 hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com,
 joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com,
 song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
 gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org,
 cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com,
 Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
 aleksander.lobakin@intel.com, ira.weiny@intel.com,
 andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
 bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
 stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
 brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
 <20250625231838.1897085-4-pasha.tatashin@soleen.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250625231838.1897085-4-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/25/25 4:17 PM, Pasha Tatashin wrote:
> During boot scratch area is allocated based on command line
> parameters or auto calculated. However, scratch area may fail
> to allocate, and in that case KHO is disabled. Currently,
> no warning is printed that KHO is disabled, which makes it
> confusing for the end user to figure out why KHO is not
> available. Add the missing warning message.

Are users even going to know what "KHO" means in the warning message?

> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/kexec_handover.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index 1ff6b242f98c..069d5890841c 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -565,6 +565,7 @@ static void __init kho_reserve_scratch(void)
>  err_free_scratch_desc:
>  	memblock_free(kho_scratch, kho_scratch_cnt * sizeof(*kho_scratch));
>  err_disable_kho:
> +	pr_warn("Failed to reserve scratch area, disabling KHO\n");
>  	kho_enable = false;
>  }
>  

-- 
~Randy


