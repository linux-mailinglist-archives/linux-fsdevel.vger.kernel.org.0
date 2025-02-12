Return-Path: <linux-fsdevel+bounces-41565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B39DA31F58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 07:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BCC168FFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 06:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B32F1FE477;
	Wed, 12 Feb 2025 06:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="WC0SlDMH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BAA1E47CA;
	Wed, 12 Feb 2025 06:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342759; cv=none; b=TdrhE5CuRuDq+H+6/thAUZd3rDZa3IgtAm1SqeEaf2+sLZJiDGgdw6eNtn4DXlOroxOeHPleTQ/3DYBMmzWUlsSzvzpJdzW87vDYQqn8L+Ui9hp1dq7dJ60KXfMaqD4ZC6WR7ODW3hfF/bRdjZRsMMh5XA0xqVrpujP0Yn7oV7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342759; c=relaxed/simple;
	bh=ZQsMnwzTf17KEzJgScmk62+uoLSEHEedJ3pMoj7PFFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7PzXEHKLA03dBzx8Qnbxn8UqT94ybh6228P7SozLzgK8QI9LXY/ABmOn1vI5pVxXfGtbP4B9y4EhvQZw5w8UbBMz7DescZ6owGErAFgdPpoa6+pA2waXJ04Pyjz1JnEsqvU4p8dJqWJ+ZP1oWOHS/lPBEHroL6oVcJVnrJAK/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=WC0SlDMH; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=U9ZsS++Scdzt6/PZ8I0ydrljHMoErWwMzMWIoSKzTg4=; t=1739342757;
	x=1739774757; b=WC0SlDMH3C64LjODizP53N7prNMC1iq4Qe9VROs05tuNMK482GqYmtV/wrdiM
	/zNMlYZAyeMCMFTeg/f/iQ4Bh+kuplyFNLQmbvyMZThzcYyEZlYlXCAYrJNMGGJisgkGzWvetvTnG
	0F/MjtC6CIreHnLP8l3F1oniMrZ4XMMv1EUHs9qMnuc/MyrSypuMcCVdRmMwUqQPqUQIx4CAi4zz+
	vG1I4FD9Cw+/P3bnNCpQbN2ZGNKwOMPMpaaKD6t7rhC8vZT+rmZusTwNPDvIioKQwurrz3j3QvXlG
	/Ka9nvpTjisz42OngfnMVvbhBR2tgdHj4o/1Uq3HEsjW+AKU0Q==;
Received: from [185.238.219.16] (helo=[192.168.44.12]); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1ti6VN-00FNTJ-1A;
	Wed, 12 Feb 2025 07:45:53 +0100
Message-ID: <2c26c5e4-9cf3-4020-b0be-637dc826b4e9@leemhuis.info>
Date: Wed, 12 Feb 2025 07:45:51 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] unicode: kunit: change tests filename and path
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
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <87iku7u211.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1739342757;4d3b9490;
X-HE-SMSGID: 1ti6VN-00FNTJ-1A

On 04.10.24 21:00, Gabriel Krisman Bertazi wrote:
> Pedro Orlando <porlando@lkcamp.dev> writes:
>> From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
>>
>> Change utf8 kunit test filename and path to follow the style
>> convention on Documentation/dev-tools/kunit/style.rst
>>
>> Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
>> Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
>> Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
>> Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
>> Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
>> ---
>>  fs/unicode/Makefile                                | 2 +-
>>  fs/unicode/{ => tests}/.kunitconfig                | 0
>>  fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} | 0
>>  3 files changed, 1 insertion(+), 1 deletion(-)
>>  rename fs/unicode/{ => tests}/.kunitconfig (100%)
>>  rename fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} (100%)
>>
>> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
>> index 37bbcbc628a1..d95be7fb9f6b 100644
>> --- a/fs/unicode/Makefile
>> +++ b/fs/unicode/Makefile
>> @@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
>>  obj-y			+= unicode.o
>>  endif
>>  obj-$(CONFIG_UNICODE)	+= utf8data.o
>> -obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += utf8-selftest.o
>> +obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += tests/utf8_kunit.o
> 
> This breaks compilation for me.
> 
> fs/unicode/tests/utf8_kunit.c:11:10: fatal error: utf8n.h: No such file or directory
>    11 | #include "utf8n.h"
>       |          ^~~~~~~~~

I encountered the same error when building -next using the Fedora
rawhide config today. Given that this patch landed in -next today I
suspect it might be due to this change, but I'm on the road and unable
to verify that right now.

Log:
https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-x86_64/08642966-next-next-all/builder-live.log.gz

Cioa, Thorsten

> After this patch that local header is now in the parent directory.
> 
> I'm building with:
> 
> CONFIG_UNICODE=m
> CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST=m
> 
>>  unicode-y := utf8-norm.o utf8-core.o
>>  
>> diff --git a/fs/unicode/.kunitconfig b/fs/unicode/tests/.kunitconfig
>> similarity index 100%
>> rename from fs/unicode/.kunitconfig
>> rename to fs/unicode/tests/.kunitconfig
>> diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/tests/utf8_kunit.c
>> similarity index 100%
>> rename from fs/unicode/utf8-selftest.c
>> rename to fs/unicode/tests/utf8_kunit.c
> 


