Return-Path: <linux-fsdevel+bounces-57770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB19B24F9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A405A1B9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3802B28937D;
	Wed, 13 Aug 2025 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XpJJyEk9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UylDjWI3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3950327FD7C;
	Wed, 13 Aug 2025 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101182; cv=none; b=c7Qb1Mm2uwFCzG179IeFZGaah3S3lfuFrWAG5kGluNzAbwT9w34NCU8L8HAn108ZoknBxXsw1TxvSG+crDK+sYKjwOq+v7dH8A4rVxt50MOQsBpSTflafB+wHXtKoEihvhxttdWqjdKznD+xu+Z/vv3rrWjSRyAewWIuySvcebQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101182; c=relaxed/simple;
	bh=XWmLOpE3MHZzeoFeGXclW85lVdc4LV+Vvanhn7HkMtc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=iE6s7SkMTCRIegAsVFiuoRllUTQZjpsa4cOWxZP3BlleWvWY+Al8ptr21vgEm5A8AKD0xzBRgOdEmjoftmJTWlpHDsQqQK+u9MANlSyyUvwL4IoMIm70njlzNZeCpwcZrExb42IliR/efxOt/GL69PjQznfL8J0CyIqvKhB6HNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XpJJyEk9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UylDjWI3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250813151939.792908766@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755100630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aj6NiNAQEDq03gk/l0fePjjYEF3cxMDBbL8IKh5eMrs=;
	b=XpJJyEk90Xq/z+6kZeVXLlSkpX66sK5cGMVN7g3NC0Nh6jwg6PxlpVo/jtYQgVeB9Eu4zw
	9OmOV5JPeJE3x6+eVbblbBKPY9JlIZaV/FSjZESPDA+3GoWNkid6rjr3wJsFIXPQ84ghmv
	o/MLGzVYk8Nk5049d7LphGELjiwS1ie5MwZrtVjarNbD5N+N+llPPtxwEkAmo/h2t3BKue
	7IOmVkLaD6kd7IYorJlGlrN1ESReSnap9ZdDCJlOcrzwbxKufpK3EpmtEpw7oGcPJJum4b
	OH7KBG0U/tdrjUI1OJ8QyOkPchyyG5FKp0yxL2ALpwfawIb73U/wbM5hnhUv9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755100630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aj6NiNAQEDq03gk/l0fePjjYEF3cxMDBbL8IKh5eMrs=;
	b=UylDjWI37f33I7FCCy3yiuijP1ZZ5hs1QPphJPxnG+SpxLfNfkUq7YKClph+cSJ+w56UEV
	CGZiTgtYG2nLkxDw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 x86@kernel.org
Subject: [patch 4/4] select: Use user_read_masked_begin()
References: <20250813150610.521355442@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 17:57:09 +0200 (CEST)

Replace the can_do_masked_user_access()	conditional with the generic macro.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/select.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/fs/select.c
+++ b/fs/select.c
@@ -776,9 +776,7 @@ static inline int get_sigset_argpack(str
 {
 	// the path is hot enough for overhead of copy_from_user() to matter
 	if (from) {
-		if (can_do_masked_user_access())
-			from = masked_user_access_begin(from);
-		else if (!user_read_access_begin(from, sizeof(*from)))
+		if (!user_read_masked_begin(from))
 			return -EFAULT;
 		unsafe_get_user(to->p, &from->p, Efault);
 		unsafe_get_user(to->size, &from->size, Efault);


