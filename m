Return-Path: <linux-fsdevel+bounces-64443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FB2BE7FE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 720DF5666A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE8F31A7F0;
	Fri, 17 Oct 2025 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q8b6SIEb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="alxqReYg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05C33191AE;
	Fri, 17 Oct 2025 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695752; cv=none; b=MfQP9rgkQ3IRWayZ7w4mTXIHgwSXfRCeeZray/nfPu0FhudMGb+YdfRNHdrJHk5nOs7J4K8fPdOJGfOHGc+ohMFDDXxziidAcMy+3ymLm1Kie5ihbiyJT3qgeEY/GZ7bdsychK2oA9I3UPLTaFb6gCwRZP0pT+3SDhkN5h+UkXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695752; c=relaxed/simple;
	bh=u/yk2503WbcPVzxext/24oA9U+OTQsqD5MrPiHlhlts=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ceQdb9TsdCG5FJI0QLgCU+wkXZty4Lhp4wvogbedFBSoT4w7RfXAoeL71x/UB/o40W3WIk6PWXKAzyn0ycufI5m/IhLUdpon/AHtA0DMTMg3zHSf6E38bJcvGuuFn9Z6vrXzoxHVwu/XDEKKByZDgMGdkDAPHxkW26w4rroDldw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q8b6SIEb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=alxqReYg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251017093030.191135747@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760695747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MKNcUChSn/NfFd+dS8+uLnvvYuPvhQsaUPbuMoERc+Y=;
	b=q8b6SIEbM6xmYbfUOBOsLQQqsGBsDZbUG5zgXIQ1nCaDQjNcfLo4DooMbAJRHmRY4Fj1Ya
	bfkqpb+cVypLrVHUdfnXmaR1oShltmHyFSjTkAUXIahM5M4lekfHj7qv7f5Txd9okhwhtE
	QSicNOQgGEIlyCyWThLox7YfPfmrXdiAWsy/GCpSZ+CcUMu2GQ+FuXIRLGbXrDopMZzGNQ
	NgwZCoDvLA+ZG+oO7bRzY2LokGzd1D/ENoZKQfUHTgnHVehDpCj9htY0cllyEeAwi8HFks
	akPf8peQTo0M2vUHxpi9V9vTza0tx5piQl8G/3irMcCQdGqHiNXmJIt3HnZRwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760695747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MKNcUChSn/NfFd+dS8+uLnvvYuPvhQsaUPbuMoERc+Y=;
	b=alxqReYgkWchksom+y0h0ctnpoZBTdkl4M0BCc8DkilDqD43CyCCDp+n0sn9nGvc5OKybq
	DAWDSxoXrZWqR8Bw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 x86@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: [patch V3 06/12] s390/uaccess: Use unsafe wrappers for ASM GOTO
References: <20251017085938.150569636@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 12:09:06 +0200 (CEST)

ASM GOTO is miscompiled by GCC when it is used inside a auto cleanup scope:

bool foo(u32 __user *p, u32 val)
{
	scoped_guard(pagefault)
		unsafe_put_user(val, p, efault);
	return true;
efault:
	return false;
}

It ends up leaking the pagefault disable counter in the fault path. clang
at least fails the build.

S390 is not affected for unsafe_*_user() as it uses it's own local label
already, but __get/put_kernel_nofault() lack that.

Rename them to arch_*_kernel_nofault() which makes the generic uaccess
header wrap it with a local label that makes both compilers emit correct
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/uaccess.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -468,8 +468,8 @@ do {									\
 
 #endif /* CONFIG_CC_HAS_ASM_GOTO_OUTPUT && CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS */
 
-#define __get_kernel_nofault __mvc_kernel_nofault
-#define __put_kernel_nofault __mvc_kernel_nofault
+#define arch_get_kernel_nofault __mvc_kernel_nofault
+#define arch_put_kernel_nofault __mvc_kernel_nofault
 
 void __cmpxchg_user_key_called_with_bad_pointer(void);
 


