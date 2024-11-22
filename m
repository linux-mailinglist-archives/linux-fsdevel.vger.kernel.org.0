Return-Path: <linux-fsdevel+bounces-35576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C03C9D5F43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 13:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AF5DB27668
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0431DE2B9;
	Fri, 22 Nov 2024 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="CPPgOG8t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0557215531A;
	Fri, 22 Nov 2024 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732279855; cv=none; b=bPkgEcxGkt7B3ud3uThuWZpwb3wtWRJfr3NSeyoikRwBimVidlE06q0fke7OWRc5863UfmGi68M5Lvxnby1aC1xcaJW8bV3tZXh0SBelpaAr0UxZ2831EHyLOCX8T/WY3QQLxRdtFQXe3A5uvNHmDCtNsm9WoVjUS+vSfsjhNSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732279855; c=relaxed/simple;
	bh=TXAXohnqcyJXs65CyDSlQGpIMn6HjE7TPDvTwM5Nxw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLdZLWOQTUmmaeKtyb5GqanX4MmOMnqKqJI3YYjcxn0WF6xJ+V4o+bKByQMV7P0DsUseblRTnimCoUNrBE7fxZOiOw/QnZerXfW7lslzW3z5QKPUK/Be+KklznQScRnVG77AiaAR2paVFVNuCroul3Bckc+cmOZ0JrpP6SXfy7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=CPPgOG8t; arc=none smtp.client-ip=80.12.242.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ET7RtSoidpobeET7Rtd9ew; Fri, 22 Nov 2024 13:50:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1732279845;
	bh=1PJEZdDmuvmngMqdpgv+5cohjiUYGlhnQ9eNLiHK038=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=CPPgOG8t7np+rZ9t/HZw0SZVSNAIzvSjlRCYhr3UOktPH2l9tOVNyWyvfAMkCijCW
	 hvcYyYWsOK388Ue5LWgZCTCCgTSrCitQuO/SqVMgQ4m+V2bk4x3xdPz53sjdIRcHMo
	 Th5CXbAI6oVgBGkIVs4m3nzejrm3yBWa2UP7SvY4V95edeNkDmDYGFuXAFsyup6H1s
	 XtF8xec9dtUY6OCUoi9Tgh4/PowSlTd1Amrrd9miMNqmCOD8gkeBPoeE2TMXbk1Am8
	 afD6Z2M4EGJjZhBsbyMD49chjb/dKHiwdgiZH7l4PE0rmDQ+wl8p02Z36yYOiHjL2o
	 EcgctLlIhV+5g==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 22 Nov 2024 13:50:45 +0100
X-ME-IP: 90.11.132.44
Message-ID: <7815334a-940f-4ce5-86e6-9bd90465bb43@wanadoo.fr>
Date: Fri, 22 Nov 2024 13:50:41 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] idr-test: ida_simple_get/remove are deprecated, so switch
 to ida_alloc/free.
To: zhangheng <zhangheng@kylinos.cn>, willy@infradead.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241122115425.3820230-1-zhangheng@kylinos.cn>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241122115425.3820230-1-zhangheng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 22/11/2024 à 12:54, zhangheng a écrit :
> Signed-off-by: zhangheng <zhangheng@kylinos.cn>
> ---
>   tools/testing/radix-tree/idr-test.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
> index 84b8c3c92c79..7fb04a830a21 100644
> --- a/tools/testing/radix-tree/idr-test.c
> +++ b/tools/testing/radix-tree/idr-test.c
> @@ -505,12 +505,12 @@ void ida_simple_get_remove_test(void)
>   	unsigned long i;
>   
>   	for (i = 0; i < 10000; i++) {
> -		assert(ida_simple_get(&ida, 0, 20000, GFP_KERNEL) == i);
> +		assert(ida_alloc_range(&ida, 0, 19999, GFP_KERNEL) == i);
>   	}
> -	assert(ida_simple_get(&ida, 5, 30, GFP_KERNEL) < 0);
> +	assert(ida_alloc_range(&ida, 5, 29, GFP_KERNEL) < 0);
>   
>   	for (i = 0; i < 10000; i++) {
> -		ida_simple_remove(&ida, i);
> +		ida_free(&ida, i);
>   	}
>   	assert(ida_is_empty(&ida));
>   

Hi,

A more complete fix for this specific file is available at [0].


please also see the serie at [1], resent at [2].
It was delayed because another usage of the API was added, and then 
fixed [3].

After that, drivers/gpio/gpio-mpsse.c also re-introduced another usage.
The fix for this one was apparently never sent. This is now done. [4]

CJ

[0]: 
https://lore.kernel.org/linux-kernel/715cff763aa4b2c174cc649750e14e404db6e65b.1722853349.git.christophe.jaillet@wanadoo.fr/

[1]: 
https://lore.kernel.org/linux-kernel/81f44a41b7ccceb26a802af473f931799445821a.1705683269.git.christophe.jaillet@wanadoo.fr/

[2]: 
https://lore.kernel.org/linux-kernel/cover.1722853349.git.christophe.jaillet@wanadoo.fr/

[3]: 
https://lore.kernel.org/linux-kernel/df8bfbe2a603c596566a4f967e37d10d208bbc3f.1728507153.git.christophe.jaillet@wanadoo.fr/

[4]: 
https://lore.kernel.org/linux-kernel/2ce706d3242b9d3e4b9c20c0a7d9a8afcf8897ec.1729423829.git.christophe.jaillet@wanadoo.fr/

