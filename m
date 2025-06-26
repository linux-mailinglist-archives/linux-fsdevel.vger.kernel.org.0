Return-Path: <linux-fsdevel+bounces-53048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60913AE9459
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 04:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599DE1C41FD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 02:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9FA1F4168;
	Thu, 26 Jun 2025 02:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BlvhXbm5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1510918C332;
	Thu, 26 Jun 2025 02:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750905784; cv=none; b=XfEg5/Tuz6sT5gLcxq0m8E/F7FkGQcOks954+Tzq6FcPiJG9nH3U8hm1fovyrJ0hEj1KtYnAkj4eODFrDifc9REZX2ZR4Rf+uZYB0pK/Y2q+54j0VztJ7K4Vdoc6SKWao6edJHdX9dzXC5Td5Qz5tJm0+3GyvZe8YJyDprJ7ju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750905784; c=relaxed/simple;
	bh=JBpdw75QCGr81iwmekoGx8INzICXSF22MAqQ7zgFJ2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F+dhke4beDRbPrqIPgnThgxyP/h5dOMQOV7iU9I/LOktqMgVfXWhoBd0zGBq2q9JtaEtu+8scUXvEr2zf2qH5YlUw9TKJP4MZNs0MNaTSZw8GzS6YfHuZx1TjKXbb+Iak3ntevbm0S2gKQDQUW6tLW+pNXc6heMMDxQ5a8Hjmm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BlvhXbm5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=24+mUdtrCzI4Op7D58pQppiwPVluWWu23vHUqIu9MSA=; b=BlvhXbm5dSfUVXaU4o2nKEHlOP
	/OZ1h5AtCfQReWwNK32UTQm/nbB5948isLYLinOiIeQaR5d4qLeiq6BY2P/R+PlVuWKiM240AFTe+
	TYMq7XLpj/feFD+y9NIACgZa6f6oRCna93ugt2fVtp8oLq3nBsPgMt1B6Iu8fCjTR4S/JhWmhp01o
	Rl8lJ1mpKOUAXI5/DH0ahDc0ogHF0EpU64NZkHj+ta47eRnvj3dFTu1eM6iKH1iEllPelFx+QLR0t
	6/pMHT+TCDqBR37MjaBxcorzic0CROyJ093A/469TMPmW0ionInk5EmBxIdUPb9rbNHgGWBfHWWCA
	nLm3aJcg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUcZE-000000061UF-3fko;
	Thu, 26 Jun 2025 02:42:26 +0000
Message-ID: <5f7b85d3-5c72-482a-9f80-55578c786800@infradead.org>
Date: Wed, 25 Jun 2025 19:42:07 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 29/32] docs: add documentation for memfd preservation
 via LUO
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
 <20250625231838.1897085-30-pasha.tatashin@soleen.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250625231838.1897085-30-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/25/25 4:18 PM, Pasha Tatashin wrote:
> +Cancellation
> +  If the liveupdate is canceled after going into prepared phase, the memfd
> +  functions like in normal phase.

We accept one 'l' or two 'l's in cancel[l]ing words, but it would be nice to be
consistent here.

-- 
~Randy


