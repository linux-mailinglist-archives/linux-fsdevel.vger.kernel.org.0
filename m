Return-Path: <linux-fsdevel+bounces-7834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BF382B7CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 00:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9A11F262DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 23:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8987959142;
	Thu, 11 Jan 2024 23:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="n374fa5J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="8EJR+e51"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C870524A8;
	Thu, 11 Jan 2024 23:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 41FDE5C0076;
	Thu, 11 Jan 2024 18:01:56 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 11 Jan 2024 18:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1705014116; x=1705100516; bh=oZXd44/iUL
	eucMaGv4BNeFUvP0p+w9PCsZxuaMhOtuw=; b=n374fa5Jz+FUk0jiydMTizDaxY
	J0CC8/Jbq6MivHZ0qO4T3tpcvjmiB4Q1xUj/a9PRtDyjR4OivQLKvtw6fFxVMAoQ
	g4lUD0nhNqZyHIsq8Z2RQWCjk9wVJhz73DCcSUV8r/sUjTIQdBw2n7F/RkyR5B8s
	ENCpiCZCld8UB1VjUJxBRfor17fd5XdYCi1+SxPMbdWGv271AS6kIeqzvZcKa7X+
	wKMKkzfGbbkZqYTQYNxjroAQlJXMnQeZtdkV10G+oBR/dE2KUMHfSxJ3KuJ9Ynit
	kZFHX2FJN24/ZlMHiL61mV+VQycTOlmmo8AHVhMuhMwnKayNh6RmM+dICSLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1705014116; x=1705100516; bh=oZXd44/iULeucMaGv4BNeFUvP0p+
	w9PCsZxuaMhOtuw=; b=8EJR+e51ZxTxDdqmsp+ACMDiaKQVQZgHR7ioChuEDwqH
	lVcAp0w0Knhv4mGwJIFjEC1SOOqJEx0nJ5yTHoqsGX3aWTrkh6/sahg9ixI5S5R8
	an/sxt6yE89GHZtmT7Oaj78AU3L/wAY7Eu4pXDxLDDn8u9lDUsTbZMFRONPD4c96
	X6jPJ65aBVv1yDJ1oTwxeGzxkXcxKPZmhyjTVhthYe8iLJFS+sC+cHvc6okUc25K
	O62sI4dsIfc2qG4gByxS3d04mScLFze3n6fgCoTlGyGwteq7aTGJX2lIhfwI5Md9
	yvJFtkGKq+EDdwiyEb0hYkAbsnRKA7W7yP9/r4GslQ==
X-ME-Sender: <xms:Y3OgZdsrrmddnp0x2ftuxACmpMcdSCuDfG1iJb9-3DHAAmGcOv50rQ>
    <xme:Y3OgZWeKaUDNPOmBPqQfJqnuQSJwyxu3R13mmA4deuOyVf6J-1VF4xzTqA3ujep_i
    2w28o6farPDur3XkIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeigedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Y3OgZQzQnB9weu89BwnifSdJ_5CdXW93usF8KqV508Pk4dsOw53YWQ>
    <xmx:Y3OgZUPJotBC7wRKYObKXjSx4zrVUq2zSIhoXotyyOgdoPpBdSNG1g>
    <xmx:Y3OgZd-nKfYUnsHCZsejz5O2Dxr-yBTZ7B3bsCZgM8249h2GNqjD9Q>
    <xmx:ZHOgZVOc_SV3r1f-YYNS0JO3tAbguG6PBOkuIApIoY8gAkB0mPWd7Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 75097B6008F; Thu, 11 Jan 2024 18:01:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <07d8877b-d933-46f4-8ca4-c10ed602f37e@app.fastmail.com>
In-Reply-To: 
 <CAHk-=wjh6Cypo8WC-McXgSzCaou3UXccxB+7PVeSuGR8AjCphg@mail.gmail.com>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <20231025140205.3586473-6-mszeredi@redhat.com>
 <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net>
 <CAHk-=wjdW-4s6Kpa4izJ2D=yPdCje6Ta=eQxxQG6e2SkP42vnw@mail.gmail.com>
 <2f595f28-7fcd-4196-a0b1-6598781530b9@roeck-us.net>
 <CAHk-=wjh6Cypo8WC-McXgSzCaou3UXccxB+7PVeSuGR8AjCphg@mail.gmail.com>
Date: Fri, 12 Jan 2024 00:01:34 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Guenter Roeck" <linux@roeck-us.net>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
Cc: "Miklos Szeredi" <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
 "Karel Zak" <kzak@redhat.com>, "Ian Kent" <raven@themaw.net>,
 "David Howells" <dhowells@redhat.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <christian@brauner.io>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Matthew House" <mattlloydhouse@gmail.com>,
 "Florian Weimer" <fweimer@redhat.com>
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
Content-Type: text/plain

On Thu, Jan 11, 2024, at 21:14, Linus Torvalds wrote:

> The SH put_user64() needs to be looked at too, but in the meantime,
> maybe something like this fixes the problems with listmount?

I tried changing it to use the generic memcpy() based uaccess
that m68k-nommu and riscv-nommu use, which also avoids the
build failure. I still run into other unrelated build issues
on arch/sh, so I'm not sure if this is a sufficient fix.

     Arnd

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 7500521b2b98..2cc3a541e231 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -73,6 +73,7 @@ config SUPERH
        select PERF_USE_VMALLOC
        select RTC_LIB
        select SPARSE_IRQ
+       select UACCESS_MEMCPY if !MMU
        select TRACE_IRQFLAGS_SUPPORT
        help
          The SuperH is a RISC processor targeted for use in embedded systems
diff --git a/arch/sh/include/asm/uaccess.h b/arch/sh/include/asm/uaccess.h
index a79609eb14be..b42764d55901 100644
--- a/arch/sh/include/asm/uaccess.h
+++ b/arch/sh/include/asm/uaccess.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_SH_UACCESS_H
 #define __ASM_SH_UACCESS_H
 
+#ifdef CONFIG_MMU
 #include <asm/extable.h>
 #include <asm-generic/access_ok.h>
 
@@ -130,4 +131,8 @@ struct mem_access {
 int handle_unaligned_access(insn_size_t instruction, struct pt_regs *regs,
                            struct mem_access *ma, int, unsigned long address);
 
+#else
+#include <asm-generic/uaccess.h>
+#endif
+
 #endif /* __ASM_SH_UACCESS_H */
diff --git a/arch/sh/include/asm/uaccess_32.h b/arch/sh/include/asm/uaccess_32.h
index 5d7ddc092afd..e053f2fd245c 100644
--- a/arch/sh/include/asm/uaccess_32.h
+++ b/arch/sh/include/asm/uaccess_32.h
@@ -35,7 +35,6 @@ do {                                                          \
        }                                                       \
 } while (0)
 
-#ifdef CONFIG_MMU
 #define __get_user_asm(x, addr, err, insn) \
 ({ \
 __asm__ __volatile__( \
@@ -56,16 +55,6 @@ __asm__ __volatile__( \
        ".previous" \
        :"=&r" (err), "=&r" (x) \
        :"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
-#else
-#define __get_user_asm(x, addr, err, insn)             \
-do {                                                   \
-       __asm__ __volatile__ (                          \
-               "mov." insn "   %1, %0\n\t"             \
-               : "=&r" (x)                             \
-               : "m" (__m(addr))                       \
-       );                                              \
-} while (0)
-#endif /* CONFIG_MMU */
 
 extern void __get_user_unknown(void);
 
@@ -140,7 +129,6 @@ do {                                                        \
        }                                               \
 } while (0)
 
-#ifdef CONFIG_MMU
 #define __put_user_asm(x, addr, err, insn)                     \
 do {                                                           \
        __asm__ __volatile__ (                                  \
@@ -164,17 +152,6 @@ do {                                                               \
                : "memory"                                      \
        );                                                      \
 } while (0)
-#else
-#define __put_user_asm(x, addr, err, insn)             \
-do {                                                   \
-       __asm__ __volatile__ (                          \
-               "mov." insn "   %0, %1\n\t"             \
-               : /* no outputs */                      \
-               : "r" (x), "m" (__m(addr))              \
-               : "memory"                              \
-       );                                              \
-} while (0)
-#endif /* CONFIG_MMU */
 
 #if defined(CONFIG_CPU_LITTLE_ENDIAN)
 #define __put_user_u64(val,addr,retval) \

