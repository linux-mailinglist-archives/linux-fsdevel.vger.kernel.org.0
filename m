Return-Path: <linux-fsdevel+bounces-28909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB2C9706D0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 13:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00411F21845
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 11:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDA41531CD;
	Sun,  8 Sep 2024 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="m8kWdmQS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD2F136344;
	Sun,  8 Sep 2024 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725794665; cv=none; b=m4/NWbxVacgEjyPI2+GXLjzWLCF92QDIQz4hNC72vTzaeeXweaqa39fzCyvuJUXU1RaAKwoWIaDQMNDpnOnsXCyt6XWn3RcncJ+K/rjQkoMCrgFxrAuMK8qluVIIFfSyqFRVyqbD0ddlEVBFwkwC0kafBsLQ9sXPwtdQ+CJul0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725794665; c=relaxed/simple;
	bh=2ZvKI1QcAZV3IfkR1NgZhGVf9lxaFygYlmHfLD+LC1E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=lzLuXdQjC02nsndwyjkAyxca0UyPD0vA41gO7nW/9c98OHqgSiDKLZk20+xIvCuxkUdOIvIM1KJcwR4OE6uuHSBlnNkDoOtdvY13IgZsFr7GUcz3GIzRb3fw2AdMU3eyviP5B6Zh8rikBesOT1Y9RG8J1WuTAPLhGQzJPFbZZ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=m8kWdmQS; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725794653; x=1726399453; i=markus.elfring@web.de;
	bh=2ZvKI1QcAZV3IfkR1NgZhGVf9lxaFygYlmHfLD+LC1E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m8kWdmQSJ2P8DalP1xrWXJKQmMNwPMaVGDx2wRwaW/KxRrf/NWXrQASuXQBb+FGb
	 Jsgxifu8MdFpsgXz21hdbE2Fk6kE4VQoC9r3W6Fdd4XIL2UXIYV2tdDi9UptmegZK
	 9Q5bt4/BgVRiBohMfDFnlwKivem9Wdsas5/AHlhCpcK606x/2ZK1ixQIqtV1V/Vhk
	 VusbyjYURuHHD3w0KWIosmg8l7lrqinLey+2lJKskQSd2wZ219zX0UvfaHNO+uXm0
	 eKecMzRsS4nZFLZ+YpyG+ykCHa5haTyVaZ7M5mU4YJJYwaapctDE2Tf0GbYLZGjM1
	 oYOdmQUFwov75mrbaA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrOhx-1sHYRW05qB-00miLD; Sun, 08
 Sep 2024 13:24:13 +0200
Message-ID: <56b30220-c3ef-4bde-9f6a-c35e7f0060b3@web.de>
Date: Sun, 8 Sep 2024 13:24:10 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alexey Dobriyan <adobriyan@gmail.com>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <90af27c1-0b86-47a6-a6c8-61a58b8aa747@p183>
Subject: Re: [PATCH] proc: fold kmalloc() + strcpy() into kmemdup()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <90af27c1-0b86-47a6-a6c8-61a58b8aa747@p183>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Nyd7MhBYzas78M+Cw/a/bUDHgHGLlZv+2JGIrdi2CGrFRIMOHBA
 G/E83zmof/XRtZNB5ugXPlFFMRCzLeZ5bsxpSwVJK4amCWKN/1VuFSgJkEZ/LdIg1hFPxQh
 1esv794csDjuAYZh+z5Kt3T7iNIjz7TYwWFlYK2/T+0Jz2QD/SYlwmAzl9Q95TyowrT4KyK
 UvJqCEt4X7TmkCBj1+TOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8uQo8Kc1WaI=;DqZOnxblbsTYsUUxVMry8+7BLOW
 /ATCnMRf/0ef2mdnMNghag03T5D/45QXZ7zLYiximYrNKrv0qkQuyWzCvfpzrmdeiyTfIq1SB
 OMhzCYvcVAH00t+F+iZVE01sbuncF9lzBT3kZJrthbNbBa7TKxQBU8CTH25V05ubaZXX3lGyn
 QIeBQEi5M3U9Qeju0KZ5gYAC7V3E79voChfHu9dEqT/EG3YUjBz07605YgHz6dCSV0tL6KdmN
 HmtksgleS4ZKz1iCbbyLY5aIUnlUZzgC53QV71MVmWvDan6C2yKvXu09LCprKL48Lb3CQ90Ep
 tTAliFYv69uhJewCfYndHJRCsAq/t4bDe4eGiAgjOYXEgw0Cnb4A+pBeHjAFjkQNwWVPF4QZm
 R8xeEnnjqemmP1eJCnCON2X1r91MAesMsVHkwTPdUtXK5yMcWEC7hb/yqvmQdjxgtHAbsrI0T
 AGn6YN8jzExl+rPh0Q7GA8LqxtFTGVbHJDIcZKl28u0sSl3v3jxf/FuStDoLf+umpppKblyNW
 72KDv9FPAi+hq/xGP6BTWPj58g8Y3wTHGiQLDRbbQxaheG1ha2nppjydztSfVEiheOxG6fFk/
 poelz5P3NsQSsZPi7ZfThUDLKXa1UrP2cq0Z3v6BbP1//4dWPHxA7gauq4d1hBBBaSveCgw3i
 dbbR1FG1YTRMCAqVleCzeZuJB8HbvFJnY5OKne0d6HZQLZA/XVEJH6R6yhYeWNuIpZwotcly7
 Lf+10Oik9Nuq2G2N+Dc9bwIz1qSuLDvL90yPkIGpWHEtn7DzBEwjRie3e2q9ITf9GaYJjZiv8
 civwse9hepDYczJ/S5hkhp6w==

> strcpy() will recalculate string length second time which is
> unnecessary in this case.

Can corresponding imperative wordings be preferred for a better change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.11-rc6#n94

Regards,
Markus

