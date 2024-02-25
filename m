Return-Path: <linux-fsdevel+bounces-12714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B54B862A03
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 11:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BACF1F21314
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8CCFC0B;
	Sun, 25 Feb 2024 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="PPkO4O+u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5242CFBE5;
	Sun, 25 Feb 2024 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708858058; cv=none; b=QlF7q9XaEQtmwyx5pYuHYAyhiqXnUefC0qzsqKAJEDeiCQCqZR0Uk7OHFM++0R4nU4aGwSJmc9Mn52IzKkX2jPpTdst+hbnWYSs/jto0Bhb38IzZ8WAKN0Hfjo34J54ZxeCFCgRzBxGcgOOb7x/UBAUviL5yQUJnzf3NEXSU5D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708858058; c=relaxed/simple;
	bh=uUcuYqjCTeb1ugX+riKAIX3o7pOCGZNVL9mvJt1yjDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Je57WNhJL1e1i9E8rdnvxtYfua8nDb9Ro9xvu9/3E+QTaQqkTBKqqYfUIibUOz8v+7cs0lJel/2jH8xpdg33+EkpXYseNrJNvwA1C1c13W3jYvtPA/CfNL4ijXgEf6J/pmzyIdMuNsvgNn0L9CRROpX1mzIompeEKS+m7kXZxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=PPkO4O+u; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1708858051; x=1709462851; i=wahrenst@gmx.net;
	bh=uUcuYqjCTeb1ugX+riKAIX3o7pOCGZNVL9mvJt1yjDs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=PPkO4O+uKo8zQag0O6zBB6Out/TIIk/rrJg8YQmev3m3kfubM0ZyZVUz6h109q6S
	 4a1Ka5oR9uUMjU9RUisJAlXd6bSp9oIXLd83+kVIFoZMOb+lYBXmcve2x3HQ3OQs4
	 sSIs2eJWFE7IT2p1XotyK780CKJDpjFQZa/RI+d5wPPTRChEJHEdqeVf4wiSlwDF7
	 S2ySEYeBgvwfsle7Oa/DGEyDoy7nsq7vInt2MNQgLyMK4R2yR21t1siGURtos/7mF
	 scYXKbWRT9A5muJx+Y+Be6vUHJkmXdeiBtGItQIfhKJgMaKzOsr+LA8dV2vwlF7SO
	 JITpz+YVRxlGDFeYCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiacH-1r0zg42jvb-00fn1d; Sun, 25
 Feb 2024 11:47:31 +0100
Message-ID: <c51a282a-bdbf-4ced-9fcf-e38a33152761@gmx.net>
Date: Sun, 25 Feb 2024 11:47:30 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING: fs/proc/generic.c:173 __xlate_proc_name
Content-Language: en-US
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>,
 linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CACVxJT8T8u+XK7GnyCus19KDVqfquGbAM-0x8bSFgKTeqhD2Ug@mail.gmail.com>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CACVxJT8T8u+XK7GnyCus19KDVqfquGbAM-0x8bSFgKTeqhD2Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IELdsSLR+NFbCh9yElhseAfVmWhYyoixGwwFKPVHbwC7CS25RTd
 EQUQRRm1ltniT0f+XBOoVf0Uqx1dfnQPo+dZrYwE58dMDEVMQp7yxkarOkpBBQIwGXEvHVe
 iyu/vf13RZ1pObgJW8K1hPepoon/HbzChGemI/3rW9Eo2z+vwETfGci90aTYGhG0ykwhFjx
 IkIvwnZlsk01yyNHXyRug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dhkRUMWhQwg=;HrQL903rxlwldUPHEusVgq4ZtMd
 cvyEys01wUHFTZlq34ZVuiJHbUwgG9lS+1Ql4RfdczGlIYaQQFaHzTauHt7bS7JFDkhtjkKFT
 WEo/bxt/i/Hqau9wettFXQwq6THQjcfI4Tv4GJYIZvCBHb0EZ80hQXBofLPIrnSCQAI9QZX6o
 qEJ7ghCrHzhnWARY3D2maxTFGvCTrYezvqjfQyD1Yvf6fvjOJvH5imBDvuqzO6nLwP+wwokdp
 2F/kT4UGNSTzt8e2Nt8vBrcrPCcY/S9lSP6pc2r/62oY+XzbzIrZgibS6iFlqfoCltXCxVSDP
 9EYzJTfgfEhvWQmS4nSnI8Edege+OBPyWJxY3GLEihTUv5nlGFIhvvSsaObfncT/8DDeCSOcg
 elpj8+v4NWft+lOhDL9zNf4Z5nXcNATtJC3fCTJkFIoG7K4qv/fDBVT1pDHYd/TClD0C7luVX
 nMxjEIsgXIqbERIkkivmYF7Orv4nrXenoID5qnbXpHn/paJgypwebIy//7kAjV4AHh9CenElG
 T2bik2RJUWvKe9GHHhijNSZ53WkD2sy8qzzzGZFz0a5DQzs4RzLM54Af93JsIkEMw7Op1AkaK
 kovp05bllgQb4rJ4KZm/fIVQ0PewImI4vSiqbp/K3s3ipw3MQX9QT1EgyXFszmmaaBPwyqisa
 vjSpHFqpUm5A36wk3yKLBQRf5U1ohW9CcVGMZbY/bvBDwKM/YaNi/8/bVgOtGyuyMHajU8XVy
 tkxzaUO23QYMsf7HMV5iCHhHhoP/r3hxNZ5FwDJEmj5VuYYCUo7WEvfNL6miXIEz/icPiQn0T
 tWfjSp8JQ05vjQmLthfC7oWzmXi7LzeWgSTSiZSw89YDw=

Hi Alexey,

Am 25.02.24 um 11:37 schrieb Alexey Dobriyan:
>> WARNING: CPU: 0 PID: 429 at fs/proc/generic.c:173
>> __xlate_proc_name+0x78/0x98 name 'R1/S1'
> proc_mkdir() didn't find 'R1' directory.
>
> In other words, you can't have slashes in irq names.
we already came to the point in the discussion before (link in my last
mail). The problem is no libgpiod user (userspace) is aware of this. So
the next question is where it should be fixed?

Sorry, i took my original message because posting the last message to
linux-fsdevel without context would be pointless.

Regards


