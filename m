Return-Path: <linux-fsdevel+bounces-59978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A09EB3FE34
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 13:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3186188C91A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 11:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0CC286D73;
	Tue,  2 Sep 2025 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="jXmzEnXa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20302FF159;
	Tue,  2 Sep 2025 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813502; cv=none; b=GqVCtkGags45mKFqBAVTH1SuSl8cOdxReSIHiVDZK4PtJwXMZrWkUUW28i+ltsja/j2PSQdc2bVpZEZ9kdzKilKaqVolRm1feS6udwLb/ia3eNfhP7ZAxnr9pzelqUOxSW6SoGqv95zxrDD+uUTVA7SDeodfkyMSG+m++krA4BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813502; c=relaxed/simple;
	bh=0o5C5Ly/rHsnoowmYx3m8IcTZ1cPVbKim17lOjF7UUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yr99fq3LKd2sOGPqzXWTUgrntYafMafyWYpftc7jDAzWfecr0WG1Ub7D8gMijEC4SwxcBl6NFyyJsXN1ld62UMoKvIvLOlitEsQhmblHnR6Fq6O/AY91Lt7Nxv02Mz5VrJhsVI6HlMjwvwjOaRYaMnspm/e0NWPvOj1le/Ik8WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=jXmzEnXa reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cGP6x6Rpwz1FZPJ;
	Tue,  2 Sep 2025 13:44:57 +0200 (CEST)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cGP6w5mgsz1FXjD;
	Tue,  2 Sep 2025 13:44:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1756813497;
	bh=voGobjfJ+JDIyxPuu8fGQb2u9QP7Z513vboXRHjWrpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jXmzEnXapdgWj3k2C76LGG7k/5mt1kwvMqAYSfMFYlJ0dMOQ80Oj2YE0pnZAtNJ4t
	 tXQk/LzaZA57Nv160y42KGcSc12HLtx5zDkXLTwO001yujBIUCUp0jXWbSqOup1wEK
	 caelEQWo/j1aiLxV7BPWjSbstlue7ClkuM93YSG2cSzlCJSLWryT6cSw2EEQcr+aVF
	 FTt0lGn6fnMuHg7U0U6sd3U2Ku9tEiPKwlVMzDHUsOHxPUryMAOV1qAvelOgjen0aR
	 RoDQinmHdiIG1eCVLztKOXDNMYphrSPAPE4G8u5ceaF4FDq1DzCH6UTTJUx5w29cc0
	 vZYTj+Lq2QLjQ==
Message-ID: <92bace9a-b5c4-4ea1-a1f7-4742c15a64a0@gaisler.com>
Date: Tue, 2 Sep 2025 13:44:56 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arch: copy_thread: pass clone_flags as u64
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com,
 selinux@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org
References: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
 <20250901-nios2-implement-clone3-v2-3-53fcf5577d57@siemens-energy.com>
 <f2371539-cd4e-4d70-9576-4bb1c677104c@gaisler.com>
 <11a4d0a953e3a9405177d67f287c69379a2b2f8f.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <11a4d0a953e3a9405177d67f287c69379a2b2f8f.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-09-02 09:15, John Paul Adrian Glaubitz wrote:
>> Thanks for this and for the whole series! Needed foundation for a
>> sparc32 clone3 implementation as well.
> 
> Can you implement clone3 for sparc64 as well?

(heavily pairing down the to list)

We'll take a look at that as well.

Cheers,
Andreas


