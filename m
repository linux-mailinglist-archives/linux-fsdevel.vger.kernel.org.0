Return-Path: <linux-fsdevel+bounces-65101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54806BFBF54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231CB1A067EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 12:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE0A346E6D;
	Wed, 22 Oct 2025 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c+GsN7Ok";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XL9aqYXe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3F3451C7;
	Wed, 22 Oct 2025 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137371; cv=none; b=J+/+Ndn//nBiUGZuGncRhJfPYOhVGh5TrHSe0p7QjaIikIepGJ5xBAjVPRmqJB4M7t6rnaOI9PGwinZQzooc2vm7XMJ4d+zVWdvG21eZtPAM7WC76rkZQSWM2MRKFTi8eUxRd3RSGCq+/3qmK3c8GXKNrJIspbobtRATevR1Adc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137371; c=relaxed/simple;
	bh=V1mfCsRfXgy86CzSvOjy9288devaZUurilfSaMjXsyI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=k6MgLVtnZUMXT78XUOrSwKz+kCHf85k6bj0AzHcQuA0MhWXkeYwKcXyBPmy4TwLyzPCiRm7tzDFHLLa6NRVUlFevuqKsXRhb4NcpFrdHDl/a8KH+/JTWqev2T47yK3pCMmdeOKlPm4On9cC/yW3C73UVtT+zWO1PSC7JuFo+FaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c+GsN7Ok; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XL9aqYXe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022103112.599762593@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Zgu2fA8f5xJPsST4+i4W8NVv6qck0BV/bxjOydsn72k=;
	b=c+GsN7Okc6pVlhYZbNSP7Toqy1JPrPZo2WWCszVxgnGybEpRPIQIW6Oi++aJ7M7EDT5dih
	h5W1u7FWU9oeSXrfkqgLl34z0J+QHvA4b7h1UdTaSb3j4GNm74ot+FAPrjzNyxyUUYuQxA
	H2dbgpZcxCrNjP/+2WXs3ASsUYmpNyG3c1Odt1tWMxPuYJicOmHtcBcVm8vAUKTDG1GHMe
	EJbM5XwdqiAVnbKG7S/5QlckGl934URCN+8uz2S6h2zVGfduEqUnMA2N3jVYqd21H2V2Bs
	0Fd1DPkOp2ObPYIF2FbETMhr1t84W7XZDyHSCvUCrJXKJMafpd0naiVUH09whQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Zgu2fA8f5xJPsST4+i4W8NVv6qck0BV/bxjOydsn72k=;
	b=XL9aqYXe9gwXBer7lMaKuJJPuEejbrtT8VGos4rq/T6Pk40BsJ8Lc68pZAE8duaBoNwxvZ
	zqjZ+XGAseMveoCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org,
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
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 David Laight <david.laight.linux@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [patch V4 12/12] select: Convert to scoped user access
References: <20251022102427.400699796@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:49:16 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Replace the open coded implementation with the scoped user access guard.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
---
V4: Use read guard - Peterz
    Rename once more
V3: Adopt to scope changes
---
 fs/select.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)
---
--- a/fs/select.c
+++ b/fs/select.c
@@ -776,17 +776,13 @@ static inline int get_sigset_argpack(str
 {
 	// the path is hot enough for overhead of copy_from_user() to matter
 	if (from) {
-		if (can_do_masked_user_access())
-			from = masked_user_access_begin(from);
-		else if (!user_read_access_begin(from, sizeof(*from)))
-			return -EFAULT;
-		unsafe_get_user(to->p, &from->p, Efault);
-		unsafe_get_user(to->size, &from->size, Efault);
-		user_read_access_end();
+		scoped_user_read_access(from, Efault) {
+			unsafe_get_user(to->p, &from->p, Efault);
+			unsafe_get_user(to->size, &from->size, Efault);
+		}
 	}
 	return 0;
 Efault:
-	user_read_access_end();
 	return -EFAULT;
 }
 


