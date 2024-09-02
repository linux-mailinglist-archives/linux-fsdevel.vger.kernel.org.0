Return-Path: <linux-fsdevel+bounces-28264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDA89689E2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 16:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF8C1C226A1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F67205E06;
	Mon,  2 Sep 2024 14:27:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610619E977;
	Mon,  2 Sep 2024 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287237; cv=none; b=eMn/cZO9wwlyHYWOhdnAlGdpAqZR5LRL1C74f7S0L236ycljh2wp7PqepjAynNNz77buLsAGRkzaBf9GXZLRHDDZqFlfB9ZIUhYKdkNAbsWVvFPZGnBME5D6PJ77rPVEDO9YauxJSSnQFhyWoWUGAt0q9BYPqTfsmi4wur9kEJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287237; c=relaxed/simple;
	bh=5XAO6So90C7Z77hOfFo5Hiv5bfoYoQmj35QQGHH/8zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FeYONUK3zp5mBPpSVRfvoSXz8n2eM2mPxYuFmhGCz1RktaPNfmmL6NGkQCh+pz4kl6zS6+yYFyP1b0wBf6SNMBdk3hQrYJ3lalzY+0W08owBjClmPL/18Ik7ylYmcs85qk1NRplfgFif8Uq4NG+GJl7DUhZeXJHUYBPnDinmXP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WyB0d6QXrz9sSN;
	Mon,  2 Sep 2024 16:27:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AL8egIazKnXh; Mon,  2 Sep 2024 16:27:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WyB0d5ZcCz9sRy;
	Mon,  2 Sep 2024 16:27:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id ADBF68B770;
	Mon,  2 Sep 2024 16:27:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Y7uy6imdDGV5; Mon,  2 Sep 2024 16:27:13 +0200 (CEST)
Received: from [192.168.234.167] (unknown [192.168.234.167])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C76C28B76E;
	Mon,  2 Sep 2024 16:27:12 +0200 (CEST)
Message-ID: <dac37bce-9616-450c-8c1e-aa24dcbfb882@csgroup.eu>
Date: Mon, 2 Sep 2024 16:27:12 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] powerpc/vdso: Wire up getrandom() vDSO
 implementation on PPC64
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Xi Ruoyao <xry111@xry111.site>
References: <cover.1725278148.git.christophe.leroy@csgroup.eu>
 <27de70dcc356e56754a03a2887a97597f5e840a4.1725278148.git.christophe.leroy@csgroup.eu>
 <ZtWyeuCfzZ66fVsg@zx2c4.com>
 <bdf1a515-b3d0-471d-89ee-989ae0d63202@csgroup.eu>
 <ZtXE-AISB4w9U9Yc@zx2c4.com>
 <c411b0c6-1806-4e4d-8bcf-51f0747fcd19@csgroup.eu>
 <ZtXJfiA1lU55JLMM@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <ZtXJfiA1lU55JLMM@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jason, hi Michael,

Le 02/09/2024 à 16:19, Jason A. Donenfeld a écrit :
> On Mon, Sep 02, 2024 at 04:16:48PM +0200, Christophe Leroy wrote:
>> Can do that, but there will still be a problem with chacha selftests if
>> I don't opt-out the entire function content when it is ppc64. It will
>> build properly but if someone runs it on a ppc64 it will likely crash
>> because only the low 32 bits of registers will be saved.
> 
> What if you don't wire up the selftests _at all_ until the ppc64 commit?
> Then there'll be no risk.
> 
> (And I think I would prefer to see the 32-bit code all in the 32-bit
> commit; that'd make it more straight forward to review too.)

I'd be fine with that but I'd like feedback from Michael on it: Is there 
a risk to only get PPC32 part merged as a first step or will both PPC32 
and PPC64 go together anyway ?

I would prefer not to delay PPC32 because someone doesn't feel confident 
with PPC64.

Christophe

