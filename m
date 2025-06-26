Return-Path: <linux-fsdevel+bounces-53042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3966BAE9335
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 02:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B7CA7A637B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 00:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C7E3F9D2;
	Thu, 26 Jun 2025 00:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kihzCd+/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A78D2F1FFE;
	Thu, 26 Jun 2025 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750896416; cv=none; b=Z05PnjYgjfF7s2hotQWuMZ8ulm6bg0eCCVscR8jbmHWTVh0AmBZYv+Rx7wHpA5WCIq4pUzgzaIT+zuNJ31tzc0KDDU9xyKD9QbUhg6udzQiuxSWyldVD9/AVQyu/SGGW+2pl+Rhq9Zcy8Wna+bdkcyAbfjSVRWTb9/b1zHDF17I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750896416; c=relaxed/simple;
	bh=eEqjGbSoovShjbdge3UkJFXT/FMIpos5T8CvZNZ0BeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I94sSQBP/dS2RyLQjXzicRlyheW+qmH9SM11pHUt1gl2+PlxyZHtLj9KD/T9htqDRI8mdrxGWpSXn5PYKNC0+LpCgIQ647ZGA5MmYcRiF7n0LxcoXpm6hu7J3jphOogimxbu7sIAZH1LYuiELJaFXG23bQTJr9bz7Z/CsU71y7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kihzCd+/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=7OPjKGEprNsfxcHZCkamjZBCKBHpBSWh2A3k0lKJL0U=; b=kihzCd+/9fHsdU52PCGaMUBLbY
	XbAOIB8miBJwza4l37/4KJOYSlo3CQmsPNF3xvZszakrH2z6nANGWvmTWtSQokEOPhin2Q1St5sqE
	KXjhMcNY3f9tXR+PCuIcqxnSEO23ka6c+vvsuFiDoPvEwwZGkf5b+T63u19GnkRk+ERwtVss4O9xb
	983h5xjcElMrq86eYGPKb5muxoW1J8ShPXCZm1FSlypwx9rBA9DzjlxTBvwhi2URktnaykkm2pVo1
	ULoDoXtJPwLVTyL3bD+kLnJ8ceDF9aw2S2JImmryv1bFQjsXUB+ILfLb/jCH5JP51savgmVSD55ON
	qfQ/BHTw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUa8K-000000060eN-285a;
	Thu, 26 Jun 2025 00:06:29 +0000
Message-ID: <829fa3b2-58be-493f-b26c-8d68063b96ed@infradead.org>
Date: Wed, 25 Jun 2025 17:06:10 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 21/32] liveupdate: add selftests for subsystems
 un/registration
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
 <20250625231838.1897085-22-pasha.tatashin@soleen.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250625231838.1897085-22-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/25/25 4:18 PM, Pasha Tatashin wrote:
> diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> index 75a17ca8a592..db7bbff3edec 100644
> --- a/kernel/liveupdate/Kconfig
> +++ b/kernel/liveupdate/Kconfig
> @@ -47,6 +47,21 @@ config LIVEUPDATE_SYSFS_API
>  
>  	  If unsure, say N.
>  
> +config LIVEUPDATE_SELFTESTS
> +	bool "Live Update Orchestrator - self tests"

	                                 self-tests"

as below...

> +	depends on LIVEUPDATE
> +	help
> +	  Say Y here to build self-tests for the LUO framework. When enabled,
> +	  these tests can be initiated via the ioctl interface to help verify
> +	  the core live update functionality.
> +
> +	  This option is primarily intended for developers working on the
> +	  live update feature or for validation purposes during system
> +	  integration.
> +
> +	  If you are unsure or are building a production kernel where size
> +	  or attack surface is a concern, say N.

-- 
~Randy


