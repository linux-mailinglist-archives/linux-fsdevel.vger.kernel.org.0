Return-Path: <linux-fsdevel+bounces-25260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E42094A54E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9C51C20FAA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3971DE84C;
	Wed,  7 Aug 2024 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="IqxrD3KH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3500C1803A;
	Wed,  7 Aug 2024 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026213; cv=pass; b=VC6u0dKKeLZZafM3rFNW8FHWYMunDQdIfHkEtoMbB50vvJ2xxchXyHc+huHcjOyo9lHo8PAqQjY4neUJMWEJLWY21ESoAlXZSMyXPIpVRXltCrCZ7x9dtHbZgr9NdhxD7gbZPiJe91KnXQyRkUPi0ewvJmogc9HjcjpWSa3W3Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026213; c=relaxed/simple;
	bh=wnWSXJaeQCwIHmnEOPhe0/nxJnIM5HR9ZukuJwrGK+Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aYWrZIoeM2N6eLUCNB7eXWLuba2/BXjWJfWCWKsLShJfFk/oSuv8drvLRjDuY+R9nZ8SG/RRkSaLVY2r8rBO6x8i9Yj2vzZbR/v+z4WAM2OUQs2TmwJX+3n4kLdCq1e0qjxT8A7ctC/p1Q/vbGMSgXAvZz87SmEgbiMeMmR8MtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=IqxrD3KH; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: Usama.Anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723026154; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eQDaHF0UtmKq766okb9YAb1uVFKscDK0cg5eoQFjHe698y5wviqxXRXsW/U+dARP112dVe6SCs3C9DiGImo6tGTS10g5HoNfvwhLdToYgm2F5VFnqN+2A4OMgarxjroIe0Eqe2wAqxePPhz6EbiQXCv3sey8nlhhtYyZkJ1lT3o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723026154; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=scd/Y76ACZDqO6vf5zLO5/NvxyWCWABtzKGRnR86dDc=; 
	b=GbBQ/avdO9yzTbjTBILxGRf9s6D02T9dAYDAHW1N530LOH7GX+Shof/q53Wyd2MjSj0B6Ni04ufveBMSh/ZcJkldqyELhp2SHH8LMgVlRrQjS1XNLLUp4+YHeYZRzxbHLF+rw6oSNOzri3U8x2n101AfvtOzCDCcHO5s74MG4uk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723026154;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=scd/Y76ACZDqO6vf5zLO5/NvxyWCWABtzKGRnR86dDc=;
	b=IqxrD3KHgvy2hhbTtPTpF2qv2qv0npSBO6ngLDL3gIJtPUg79y4yVCB7oSKL0j6q
	oB6CR8InZCxv6TekzlOnVqGwQyRnvc76srbPKS/uN3Zah6jiSI/KE1NzMYaDATcLiQO
	tFDeUabmvGYhzpwP7ros+MMlychGkIiOyp0mfnWk=
Received: by mx.zohomail.com with SMTPS id 1723026153049605.1074578697151;
	Wed, 7 Aug 2024 03:22:33 -0700 (PDT)
Message-ID: <a1e8ab86-64e1-4cf1-bd2f-145b4c173e6d@collabora.com>
Date: Wed, 7 Aug 2024 15:22:18 +0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, "H . J . Lu" <hjl.tools@gmail.com>,
 Chris Kennelly <ckennelly@google.com>, Eric Biederman
 <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
 Fangrui Song <maskray@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Yang Yingliang <yangyingliang@huawei.com>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 Mike Rapoport <rppt@kernel.org>, Rui Salvaterra <rsalvaterra@gmail.com>,
 Victor Stinner <vstinner@redhat.com>, Jan Palus <jpalus@fastmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/exec: Build both static and non-static
 load_address tests
To: Kees Cook <keescook@chromium.org>, John Hubbard <jhubbard@nvidia.com>
References: <20240508172848.work.131-kees@kernel.org>
 <20240508173149.677910-1-keescook@chromium.org>
 <1f6a2905-395d-4f81-9ee0-57c541fb2486@nvidia.com>
 <202405082312.D922795@keescook>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <202405082312.D922795@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 5/9/24 11:16 AM, Kees Cook wrote:
> On Wed, May 08, 2024 at 07:54:13PM -0700, John Hubbard wrote:
>> Didn't we learn recently, though, that -static-pie is gcc 8.1+, while the
>> kernel's minimum gcc version is 5?
> 
> Yes, that's true. If we encounter anyone trying to build the selftests
> with <8.1 I think we'll have to add a compiler version test in the
> Makefile to exclude the static pie tests.
> 
> There's also the potential issue with arm64 builds that caused the
> original attempt at -static. We'll likely need an exclusion there too.
> 
I'm not getting failures for arm64 instead for arm. I'm trying to find
this "rcrt1.o" file. Does anybody have any idea if this error can be
resolved by missing file or is it something arm-linux-gnueabihf
toolchain doesn't support?

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
arm-linux-gnueabihf-gcc -Wall -Wno-nonnull -D_GNU_SOURCE=
-Wl,-z,max-page-size=0x1000 \
        -fPIE -static-pie load_address.c -o
/home/usama/repos/kernel/linux_mainline/tools/testing/selftests/exec/load_address.static.0x1000
/usr/lib/gcc-cross/arm-linux-gnueabihf/12/../../../../arm-linux-gnueabihf/bin/ld:
cannot find rcrt1.o: No such file or directory
collect2: error: ld returned 1 exit status
make: *** [Makefile:39:
/home/usama/repos/kernel/linux_mainline/tools/testing/selftests/exec/load_address.static.0x1000]
Error 1

-- 
BR,
Muhammad Usama Anjum


