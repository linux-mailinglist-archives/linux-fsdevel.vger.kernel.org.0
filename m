Return-Path: <linux-fsdevel+bounces-28087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BFC96692B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 20:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340BC285E4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 18:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584551BC9FF;
	Fri, 30 Aug 2024 18:52:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BE51BB69B;
	Fri, 30 Aug 2024 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725043964; cv=none; b=ZrMHWGfYpn2RSJFrgqQdynyOEwhoZ4QT0uAtAaehZTPrDKFVQzNY/DptSeDDXL/WxGSJnqqG876KLDpMF/vcOHHnSn9FZUn+qLynEUXC3tG2ZiDPcNroCQYQWJX2ZZsXH+3baItJy36nK+KQ/RFQuN904+HflRrRdy9tr8gg5n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725043964; c=relaxed/simple;
	bh=kPiLDQ8HQsZ7OY2s7jtUVwKAWbrRXvStaSUX+5VHXqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSw2zZm4rOFiwni7YV532TOmNrd5CZGVXYRrFRBgPg9q4Cx+DBBIK1TYIfHGP/zGlZ7ejGY/04tkMkZPgUOe/HkVElRd1HfbsVXq0mqmXv4K6SSYifPGCk7YaeQHWAJOQzGpYffZp549G0cXZ9YuJknUe3ZdqOxKon1cGtwBIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WwS2H2zdLz9sSN;
	Fri, 30 Aug 2024 20:52:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3f9-XC2A1YeT; Fri, 30 Aug 2024 20:52:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WwS2H1wnjz9sSK;
	Fri, 30 Aug 2024 20:52:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 28C2A8B794;
	Fri, 30 Aug 2024 20:52:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id h0_TT9jQfciA; Fri, 30 Aug 2024 20:52:39 +0200 (CEST)
Received: from [192.168.234.133] (unknown [192.168.234.133])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 428938B764;
	Fri, 30 Aug 2024 20:52:38 +0200 (CEST)
Message-ID: <ef38cd36-3e15-4608-8b72-87cf7621cce6@csgroup.eu>
Date: Fri, 30 Aug 2024 20:52:37 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] powerpc/vdso: Wire up getrandom() vDSO
 implementation on PPC32
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Xi Ruoyao <xry111@xry111.site>
References: <cover.1725031952.git.christophe.leroy@csgroup.eu>
 <e7e4c6d36cf98229850c333f113bcea909564501.1725031952.git.christophe.leroy@csgroup.eu>
 <ZtHwnc4AZuRULkom@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <ZtHwnc4AZuRULkom@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/08/2024 à 18:17, Jason A. Donenfeld a écrit :
> On Fri, Aug 30, 2024 at 05:57:08PM +0200, Christophe Leroy wrote:
>> @@ -14,6 +14,10 @@ ifeq ($(uname_M),x86_64)
>>   TEST_GEN_PROGS += vdso_test_getrandom
>>   TEST_GEN_PROGS += vdso_test_chacha
>>   endif
>> +ifeq ($(ARCH),powerpc)
>> +TEST_GEN_PROGS += vdso_test_getrandom
>> +TEST_GEN_PROGS += vdso_test_chacha
>> +endif
> 
> FYI, as of [1], you should now be able to add powerpc to the filter list
> instead of having to duplicate a new stanza:
> 
> [1] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fcrng%2Frandom.git%2Fcommit%2F%3Fid%3Dbbaae98172ed284fc0d5d39cc0d68f5d06164f06&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C4f51736c027a44cc7df908dcc90f46d6%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638606314665557021%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=UtLdKTuEaZVhsguKa7kX1TBJ%2BvvQtl7DmU9hSBeThWo%3D&reserved=0

I'm a bit sceptic with that commit. IIUC you are changing the meaning of 
$ARCH. How does that fit with the $ARCH we give when we cross-build or 
with the ARCH which is set by the top-level Makefile in 
tools/testing/selftests ?

Also, wouldn't there be a way to use scripts/subarch.include instead of 
opencoding ?

Afterall, would it be a problem to build it even for i386 ? It should 
now be ignored anyway with your new commit f78280b1a3ce ("selftests: 
vDSO: skip getrandom test if architecture is unsupported")

Christophe

