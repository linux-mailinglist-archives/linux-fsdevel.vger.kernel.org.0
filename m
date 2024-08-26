Return-Path: <linux-fsdevel+bounces-27122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574FE95EC27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008501F21342
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 08:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D7E13C693;
	Mon, 26 Aug 2024 08:37:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF3773478;
	Mon, 26 Aug 2024 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661476; cv=none; b=n3dZAyZnrI5yVYlIDQwBufphlH+vhySQk3Z5/fIcXIrAZNcCtXEiWCxbVJbYMLumD1Z14Cq8K3MHpJzFsTXLTi4O/NmIyyAqetwJ0FcPh39gG6j4+hxYA5APeZLsQc1QLh/0z4061ouMhYqMxn7HD9EhDJrkZzaem9/vZ5cv5oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661476; c=relaxed/simple;
	bh=Hr69Ny0Fx+veT36ohPJ0ZeQmzGQbKmDpmYlnHx6h2l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPxtaeFYbUDBU5DVez22+YDQkJyv3zgYt/ujk4TSAUBJ+1xglotXc8GZcBLxI1UxeyCtgNUNURwHfY20yaRxa8BQde2CE2T30muYVwHYbQCxEPKZfNk4Jo1U0dbo8hj0FtDcDcXnI2SEk+GLu0aP/lzDC/okdxzHaIxxOK1cmoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WskZl5slLz9sRr;
	Mon, 26 Aug 2024 10:37:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qtZt4nGFX6b0; Mon, 26 Aug 2024 10:37:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WskZl4WrZz9sRk;
	Mon, 26 Aug 2024 10:37:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 85D558B773;
	Mon, 26 Aug 2024 10:37:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id g2eIkF1jnL0E; Mon, 26 Aug 2024 10:37:51 +0200 (CEST)
Received: from [192.168.233.85] (PO17705.IDSI0.si.c-s.fr [192.168.233.85])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1399C8B763;
	Mon, 26 Aug 2024 10:37:50 +0200 (CEST)
Message-ID: <7e519ba2-0293-4320-84bf-44f930fc286d@csgroup.eu>
Date: Mon, 26 Aug 2024 10:37:49 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/17] vdso: Clean header inclusion in getrandom
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan
 <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <2a081f1fff5e40f496153f8e0162fc7ec5adab2e.1724309198.git.christophe.leroy@csgroup.eu>
 <Zsw3xMoX2EI5UUs1@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Zsw3xMoX2EI5UUs1@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/08/2024 à 10:07, Jason A. Donenfeld a écrit :
> On Thu, Aug 22, 2024 at 09:13:10AM +0200, Christophe Leroy wrote:
>>   
>> +#define _PAGE_SIZE (1UL << CONFIG_PAGE_SHIFT)
>> +#define _PAGE_MASK (~(_PAGE_SIZE - 1))
> 
> If PAGE_SIZE isn't defined at this point, why not just call it PAGE_SIZE
> instead of _PAGE_SIZE? But if that's the case, why not put the vdso
> definition of PAGE_SIZE into some vdso header included by this file?

It was working ok on powerpc but on x86 I got:

   CC      arch/x86/entry/vdso/vgetrandom.o
In file included from arch/x86/entry/vdso/vgetrandom.c:7:
arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:24: error: 
"PAGE_SIZE" redefined [-Werror]
    24 | #define PAGE_SIZE (1UL << CONFIG_PAGE_SHIFT)
       |
In file included from ./arch/x86/include/asm/page.h:9,
                  from ./arch/x86/include/asm/thread_info.h:12,
                  from ./include/linux/thread_info.h:60,
                  from ./include/linux/smp.h:118,
                  from ./include/linux/alloc_tag.h:14,
                  from ./include/linux/percpu.h:5,
                  from ./arch/x86/include/asm/msr.h:15,
                  from ./arch/x86/include/asm/vdso/gettimeofday.h:19,
                  from ./include/vdso/datapage.h:164,
                  from 
arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:7,
                  from arch/x86/entry/vdso/vgetrandom.c:7:
./arch/x86/include/asm/page_types.h:11: note: this is the location of 
the previous definition
    11 | #define PAGE_SIZE  (_AC(1,UL) << PAGE_SHIFT)
       |
In file included from arch/x86/entry/vdso/vgetrandom.c:7:
arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:25: error: 
"PAGE_MASK" redefined [-Werror]
    25 | #define PAGE_MASK (~(PAGE_SIZE - 1))
       |
In file included from ./arch/x86/include/asm/page.h:9,
                  from ./arch/x86/include/asm/thread_info.h:12,
                  from ./include/linux/thread_info.h:60,
                  from ./include/linux/smp.h:118,
                  from ./include/linux/alloc_tag.h:14,
                  from ./include/linux/percpu.h:5,
                  from ./arch/x86/include/asm/msr.h:15,
                  from ./arch/x86/include/asm/vdso/gettimeofday.h:19,
                  from ./include/vdso/datapage.h:164,
                  from 
arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:7,
                  from arch/x86/entry/vdso/vgetrandom.c:7:
./arch/x86/include/asm/page_types.h:12: note: this is the location of 
the previous definition
    12 | #define PAGE_MASK  (~(PAGE_SIZE-1))
       |
cc1: all warnings being treated as errors


Christophe

