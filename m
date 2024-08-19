Return-Path: <linux-fsdevel+bounces-26218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B1F956238
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 06:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11AB282940
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 04:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8460145A18;
	Mon, 19 Aug 2024 03:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="Gkz5/qiT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFE413D50C;
	Mon, 19 Aug 2024 03:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039798; cv=pass; b=TYpX2ewowzLxQ31KOKvi+sSTCAhWaVxhc+eOvBnzVbJZCfd0Cdf9i4yHatqUZL1QcoNoeqvf7hPpeYl7+08j8HghZjROWRK7/N1z2V+dr2e3uop81dlhkIeaflQJWPUrt4dgaJH3LnFMPeWL/AoqmDY/1EY3hmjitmMe+PYX0/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039798; c=relaxed/simple;
	bh=SnF0ARMpU7owXXoSn6pPtnvTb4UqNZplw5MXjOQ3Woc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ubDKOnd2QzuAuIQrSJub1oxtFGl/9FR2sXZw+ag9lPA3tODwV7b44hJGPz8d2iQn94Y9eBMS7+574nmIY8JoSjh21+XrIqsV6QoL64EjzZYJQo47f0QzkrcKtL0nK9VVX02gLgv/39+6YznzzAv5BLMxuKQ06NNC3SCqK8BieEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=Gkz5/qiT; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: Usama.Anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724039736; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iPB7sh/7rHXRK+RmibFdURVZP4YOvVT/O+8fPYjZaAVXycsif2EmE8cA1ACGInYq4nlIhltaaN/Trigd4QqYK86g3fAE72JwcoBb3jXkYhgkJMYg2xG6XqaqQDGjzjJCOMjlQUIUL/QmE5uAyIfPQgJCoKGg40w+t53MyCevNO4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724039736; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nuoETxDyz8Wi4VYO4tRFWUm8X8NzlfpD28R7Rjba/II=; 
	b=dmvP4nbHto1UaxixKwm9LrjvngQpejF5gy/2vCY4sdiprrzPbf3Xhr4ZLPPeq4WODAyow0OtnJw48aZcn4GFuH5Sr9Z0ItjWYErzYAzDlkLZvYJ1iSpgFxf1a8g8lCMp0tOF42LLtogSreVXf3pk8KGecx/JmFQVeSFsKAn1GU4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724039736;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nuoETxDyz8Wi4VYO4tRFWUm8X8NzlfpD28R7Rjba/II=;
	b=Gkz5/qiT72RIMb6EbL4kx+ZAoyGP7kXpHMthTtWPgkg3/GsS/iEfTc1bwOx6ZOA+
	bUKm6QDYcLDy2iSXfDiWy/wiUTvT3C7uYN04aQsgtN5bQy1Xgy6J2V9523Xs2RmoRz+
	DTm8rh33mll5VXkHzTI9ZGeT2eMXY6QZocG5z8ts=
Received: by mx.zohomail.com with SMTPS id 1724039733936278.3957400387692;
	Sun, 18 Aug 2024 20:55:33 -0700 (PDT)
Message-ID: <c2ed3020-f0c7-4077-aa63-648f7cd6bc75@collabora.com>
Date: Mon, 19 Aug 2024 08:55:17 +0500
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
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 1/3] selftests/exec: Build both static and non-static
 load_address tests
To: Kees Cook <keescook@chromium.org>
References: <20240508172848.work.131-kees@kernel.org>
 <20240508173149.677910-1-keescook@chromium.org>
 <1f6a2905-395d-4f81-9ee0-57c541fb2486@nvidia.com>
 <202405082312.D922795@keescook>
 <a1e8ab86-64e1-4cf1-bd2f-145b4c173e6d@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <a1e8ab86-64e1-4cf1-bd2f-145b4c173e6d@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 8/7/24 3:22 PM, Muhammad Usama Anjum wrote:
> On 5/9/24 11:16 AM, Kees Cook wrote:
>> On Wed, May 08, 2024 at 07:54:13PM -0700, John Hubbard wrote:
>>> Didn't we learn recently, though, that -static-pie is gcc 8.1+, while the
>>> kernel's minimum gcc version is 5?
>>
>> Yes, that's true. If we encounter anyone trying to build the selftests
>> with <8.1 I think we'll have to add a compiler version test in the
>> Makefile to exclude the static pie tests.
>>
>> There's also the potential issue with arm64 builds that caused the
>> original attempt at -static. We'll likely need an exclusion there too.
>>
> I'm not getting failures for arm64 instead for arm. I'm trying to find
> this "rcrt1.o" file. Does anybody have any idea if this error can be
> resolved by missing file or is it something arm-linux-gnueabihf
> toolchain doesn't support?
Do you have any idea?

> 
> make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
> arm-linux-gnueabihf-gcc -Wall -Wno-nonnull -D_GNU_SOURCE=
> -Wl,-z,max-page-size=0x1000 \
>         -fPIE -static-pie load_address.c -o
> /home/usama/repos/kernel/linux_mainline/tools/testing/selftests/exec/load_address.static.0x1000
> /usr/lib/gcc-cross/arm-linux-gnueabihf/12/../../../../arm-linux-gnueabihf/bin/ld:
> cannot find rcrt1.o: No such file or directory
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:39:
> /home/usama/repos/kernel/linux_mainline/tools/testing/selftests/exec/load_address.static.0x1000]
> Error 1


-- 
BR,
Muhammad Usama Anjum


