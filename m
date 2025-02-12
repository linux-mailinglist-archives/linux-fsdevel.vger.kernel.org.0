Return-Path: <linux-fsdevel+bounces-41598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B543DA327C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 14:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A16687A2E79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00DF20E6F2;
	Wed, 12 Feb 2025 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="J935cCFY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEC527181F;
	Wed, 12 Feb 2025 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368613; cv=none; b=Zs4sJ5/xDsgRVtsEyyiUHsq1yYM6BhLYHEGTb3f5IWPKDCFcOi4LX/zqd4aPB5gZSxA44JQjZ5m0YR+TiFqqJMtc/00sVLlOI3AZKzT4sTYBXyxMqlrdYffffbyWcDWiJskwx0qZTnMgOIR6d7EEm8inDvM7GB7dK9wOWwwlWB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368613; c=relaxed/simple;
	bh=Pr86lMV7Bh1PlfKhE4AqhsQxT1UDf0QAwoCgO0pz3iU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=K81JjsvmMAtDbt5j14uru0fAxluF95P6witdvguemep262nWyIvDubczajsj95P6PpRAvxxdqMSf7T5OTEh99aFxZtR7EoHrI6RkGgJLYmXKLD2irH6T6MD2A/2oUE8fxyh/Ia9pkNeHjPyKy3YVIYhDI56m04368EDx5QrV5vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=J935cCFY; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=GB7xjCPOK/pEAuKbKV8HDXw3kI8kkyuIaj/YAhiAvrA=; t=1739368611;
	x=1739800611; b=J935cCFYATk6mzxJGXndeVwV27gYhsvIRFUF3GW22xc2htMFA+MEnE/0yU09N
	wgHHjOyIdQJaTX5byxMELrR2pbKAeVhM1RyNL14fUgI5V/0ObsotROjv+AAleKEAIaBCoTxrZa4Hi
	pPtQBhoRh+PsmJgY3rXDwBpV3LPmLVLHcWWUqQkYwRbK+7C481ZuWckTo1C29o6nCRfj5vdNgqyKW
	ERhz9Pva9dY5NKmWuTTWUdQEA/NNEFs25PmVEb42XzfmkV7Q1Mb88O/OCPEgmImmVOHCIQwTZkJuy
	dcq6gS2rzERE5i/b4FrwMOkIdcica1uZ6IdpOdq42ZkNGyi0dQ==;
Received: from p200300eb2f41aefa7c229ae9bd244007.dip0.t-ipconnect.de ([2003:eb:2f41:aefa:7c22:9ae9:bd24:4007]); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1tiDEH-00H5PA-1T;
	Wed, 12 Feb 2025 14:56:41 +0100
Message-ID: <204cca29-5c75-4601-b659-9733b3282451@leemhuis.info>
Date: Wed, 12 Feb 2025 14:56:40 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] unicode: kunit: change tests filename and path
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>,
 Pedro Orlando <porlando@lkcamp.dev>, Kees Cook <keescook@chromium.org>,
 Danilo Pereira <dpereira@lkcamp.dev>
Cc: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
References: <20240928235825.96961-1-porlando@lkcamp.dev>
 <20240928235825.96961-3-porlando@lkcamp.dev>
 <87iku7u211.fsf@mailhost.krisman.be>
 <2c26c5e4-9cf3-4020-b0be-637dc826b4e9@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <2c26c5e4-9cf3-4020-b0be-637dc826b4e9@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1739368611;dfac2415;
X-HE-SMSGID: 1tiDEH-00H5PA-1T



On 12.02.25 07:45, Thorsten Leemhuis wrote:
> On 04.10.24 21:00, Gabriel Krisman Bertazi wrote:
>> Pedro Orlando <porlando@lkcamp.dev> writes:
> [...]
>> This breaks compilation for me.
>>
>> fs/unicode/tests/utf8_kunit.c:11:10: fatal error: utf8n.h: No such file or directory
>>    11 | #include "utf8n.h"
>>       |          ^~~~~~~~~
> 
> I encountered the same error when building -next using the Fedora
> rawhide config today. Given that this patch landed in -next today I
> suspect it might be due to this change, but I'm on the road and unable
> to verify that right now.

Did that now and this patch was indeed the culprit, as reverting
be6f498e7391 ("unicode: kunit: change tests filename and path") from
-next fixed the build error for me.

Ciao, Thorsten

> Log:
> https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-x86_64/08642966-next-next-all/builder-live.log.gz
>
>> After this patch that local header is now in the parent directory.
>>
>> I'm building with:
>>
>> CONFIG_UNICODE=m
>> CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST=m
>>
>>>  unicode-y := utf8-norm.o utf8-core.o
>>>  
>>> diff --git a/fs/unicode/.kunitconfig b/fs/unicode/tests/.kunitconfig
>>> similarity index 100%
>>> rename from fs/unicode/.kunitconfig
>>> rename to fs/unicode/tests/.kunitconfig
>>> diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/tests/utf8_kunit.c
>>> similarity index 100%
>>> rename from fs/unicode/utf8-selftest.c
>>> rename to fs/unicode/tests/utf8_kunit.c
>>
> 


