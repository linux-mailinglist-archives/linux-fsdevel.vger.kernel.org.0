Return-Path: <linux-fsdevel+bounces-69932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C842C8C3E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 23:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215343AA4F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 22:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAFF2BEC41;
	Wed, 26 Nov 2025 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="jTOlSZ+m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4E713AD26
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764197174; cv=none; b=ul/gUnvQyUsN3PI+ez/1j6z1key4Fh+SYD330SbZ4YlgaWDP79QfcvAqZfdeGFErE+4EGuoxQzhEfHPDIhdWO7Bf0+IZ5IddV8zbKba95m58LckzGmgk0kHUTSYzKOFdEwDZ0himom9FvUNdoiKFt2qVfNEnfSYS6/mugAhXe3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764197174; c=relaxed/simple;
	bh=N7QTwcVxuv4aBOxRWkJ1ISxNAxFa28pwvt9ng3uMXH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmvQPSmnsIF2d7eRYAehzc9uU3zBO69rCb4JPy/PG94avXi+Z1Qsy9MPsqa6T1aYXeR9onrxt2uCulHC7to1EiKAyyyVwHukdQ7DA23JE6rkssdrTiXwvyafNbUqFwKSP0MjAzpLJYRpl1gXDTGQu2B0lDjqLS3pmjoOEgfXSUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=jTOlSZ+m; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764197160; x=1764801960; i=w_armin@gmx.de;
	bh=N7QTwcVxuv4aBOxRWkJ1ISxNAxFa28pwvt9ng3uMXH8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jTOlSZ+mLMSibYeOC9Nc/aeljRI4nbd3twT+Ikz63c402rPlKe7uKyRTu/lFcIDg
	 eqU/eg8p6VqTIQEW4hy/A77qH/aiJEzxqK5zQ/2n0vKlCjxc/a7TzJ2eXhWd4ihaj
	 a8Ib6mZbumLkv0jjCalKvJnB/JOBmxuAxzPUw1BUbMfVpX5Pxo8gg6etYUWJHbMMC
	 7iPPnJF2N7oQB8bsYL5/dPO3jE7n+nt7TL4FUUwBKecoQEII5DRakIhjoTwDkL12V
	 5hQpRE4IBNsv34Vu9h5ospZYldD2zPfO08lTUuVQK7QVlvWL595ULn1H060R8hILq
	 sEvrQaQJzUdWcqTjhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26r3-1vQK4v0rc1-002sW1; Wed, 26
 Nov 2025 23:46:00 +0100
Message-ID: <00274787-71f5-40ae-a2e4-ad13da0137cc@gmx.de>
Date: Wed, 26 Nov 2025 23:45:57 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/nls: Fix inconsistency between utf8_to_utf32() and
 utf32_to_utf8()
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Hans de Goede <hansg@kernel.org>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-fsdevel@vger.kernel.org
References: <20251126204355.337191-1-W_Armin@gmx.de>
 <7b503ef7-2c2a-4dbd-9e6a-bbb16d7876b5@kernel.org>
 <aSdtRQhclLWgXjmu@smile.fi.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <aSdtRQhclLWgXjmu@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8eF+5+pSLrEyc2p3u2qPBlisThz126bfuux4LFhVTJzdp+nGduQ
 bUaVCDRbQSJb6e24QI6pGa/XFzlSxdNzJ1DXI3QXnsD2xKGFclUNdxeJxU7NBvRuuwCTMzk
 /O3H8L6p+dxbU6zf/v8ukccKrMAmuKYCPIfayI7YcCM4zfK2g9dBRiruIoOwnK0+GZ7rsqe
 tZU1ZTMnYt+iWSnXKisuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bCUJQ7p1PL0=;hWtIIxAZGEXkIv1Z/7IYlKK3GFK
 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

Am 26.11.25 um 22:12 schrieb Andy Shevchenko:

> On Wed, Nov 26, 2025 at 09:48:27PM +0100, Hans de Goede wrote:
>> <dropping the lists from the Cc>
>>
>> Hi Armin,
>>
>> I think you've gotten the To: and Cc: lists wrong for this one ?
> (Semi). The other part of the change is part of pending patches in PDx86.
> Two options:
> - apply now via PDx86 to make it consistent (personally my preference)
> - wait for rc1 and push via NLS maintainers / Andrew Morton.

I too would prefer option 1, but i just noticed that get_maintainer.pl does not suggest
the VFS maintainers when asking it about fs/nls/nls_base.c. I changed the MAINTAINERS entry
for "VFS and infrastructure" from fs/* to fs/ to also include all subdirectories below
fs/, and now get_maintainer.pl correctly suggests the VFS maintainers.

Should i send a patch for this too?

Thanks,
Armin Wolf

>> On 26-Nov-25 9:43 PM, Armin Wolf wrote:
>>> After commit 25524b619029 ("fs/nls: Fix utf16 to utf8 conversion"),
>>> the return values of utf8_to_utf32() and utf32_to_utf8() are
>>> inconsistent when encountering an error: utf8_to_utf32() returns -1,
>>> while utf32_to_utf8() returns errno codes. Fix this inconsistency
>>> by modifying utf8_to_utf32() to return errno codes as well.
>

