Return-Path: <linux-fsdevel+bounces-52679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32600AE5C0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 07:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF713A2E83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 05:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308FD239581;
	Tue, 24 Jun 2025 05:50:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4185B2CCC1;
	Tue, 24 Jun 2025 05:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750744241; cv=none; b=NKfIfGR+SzSZXlD2Xv0xjvmCK5FuM+zqfnDY/4DowisKTA5tGd1pujKfubjV5f4gTa5+YuFA9TKMGk44HjAcXeFbO0ADM5qgzxRo4ty2xsmMPuUI1zmoW98/HXJnkJ/lYYtq1OZviXxf+SuGFUUcBZVyCo9YpLLKmSgcIph/d2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750744241; c=relaxed/simple;
	bh=3D0KQ5ka29PjRTqDd/N/4uZhjid6uamBrNB6qb6b4VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfiVZDjoYGMxu6HWf0KV90VTdFrNJoZJPhvNKND1cxJxMCBwBU4Ec1J9njlhHm1tG070MDsua1l9yMrD428ax6DOufBsl4VLEWt9rwqkrAG8tPfAHCVuGZ97hXaeeWKaE6OdUSVLT1YrfrgaBvAjYsPrRZuSaXuIuzztJJmp2FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bRD450pqCz9sHR;
	Tue, 24 Jun 2025 07:27:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TQwRk1sPy-Tu; Tue, 24 Jun 2025 07:27:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bRD446pFmz9sFT;
	Tue, 24 Jun 2025 07:27:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DB3938B768;
	Tue, 24 Jun 2025 07:27:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id SZzaiK0op1Va; Tue, 24 Jun 2025 07:27:48 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F03358B767;
	Tue, 24 Jun 2025 07:27:47 +0200 (CEST)
Message-ID: <ff2662ca-3b86-425b-97f8-3883f1018e83@csgroup.eu>
Date: Tue, 24 Jun 2025 07:27:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] powerpc: Implement masked user access
To: David Laight <david.laight.linux@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Andre Almeida <andrealmeid@igalia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
 <20250622172043.3fb0e54c@pumpkin>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250622172043.3fb0e54c@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/06/2025 à 18:20, David Laight a écrit :
> On Sun, 22 Jun 2025 11:52:38 +0200
> Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> 
>> Masked user access avoids the address/size verification by access_ok().
>> Allthough its main purpose is to skip the speculation in the
>> verification of user address and size hence avoid the need of spec
>> mitigation, it also has the advantage to reduce the amount of
>> instructions needed so it also benefits to platforms that don't
>> need speculation mitigation, especially when the size of the copy is
>> not know at build time.
> 
> It also removes a conditional branch that is quite likely to be
> statically predicted 'the wrong way'.

But include/asm-generic/access_ok.h defines access_ok() as:

	#define access_ok(addr, size) likely(__access_ok(addr, size))

So GCC uses the 'unlikely' variant of the branch instruction to force 
the correct prediction, doesn't it ?

> 
>> Unlike x86_64 which masks the address to 'all bits set' when the
>> user address is invalid, here the address is set to an address in
>> the gap. It avoids relying on the zero page to catch offseted
>> accesses. On book3s/32 it makes sure the opening remains on user
>> segment. The overcost is a single instruction in the masking.
> 
> That isn't true (any more).
> Linus changed the check to (approx):
> 	if (uaddr > TASK_SIZE)
> 		uaddr = TASK_SIZE;
> (Implemented with a conditional move)

Ah ok, I overlooked that, I didn't know the cmove instruction, seem 
similar to the isel instruction on powerpc e500.

Christophe


