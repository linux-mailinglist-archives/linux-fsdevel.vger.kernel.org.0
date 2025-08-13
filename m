Return-Path: <linux-fsdevel+bounces-57750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF196B24EB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9AC05A2294
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D1127FB2D;
	Wed, 13 Aug 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZxyY8U85";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0QWkTTsm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE8D23C8CD;
	Wed, 13 Aug 2025 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100625; cv=none; b=BI60MAOabUBi1ozvqb4tQcv9x+yPcvofx59X18VfLzVstK8EDneC9zOjZMCJRkEh7rqX1PLuyN4GybrQ+8pNqtek4aoq7j7BQZyH28o7g5g2ScH9rUX+UPmxlebFrMP/FHjYpDrmYgiCgO3AtnKAcO9oGHQND+LXuPDX940ObYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100625; c=relaxed/simple;
	bh=/E/v6bMyaa69ZsPQafzcvTcAPfS1MBVhIqeKeUxRey4=;
	h=Message-ID:From:To:Cc:Subject:Date; b=SxzDXSpBo8yxT0xnJdlxJKSkHDvgd4x07u8G/8EmOMerjZuESjrOYtew80519YEnUi+ET6VtPY5OG53Si3S3aIO12M/jVbQCjqiPieSVCUxI8Lml/CxWc4DmFCqOPQkoEWxc8PdG3MdH3dSSEE7Ce0xYJLdAY6GUz/nhTgfKsKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZxyY8U85; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0QWkTTsm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250813150610.521355442@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755100621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=VqLPctWM5jvGR2VH7wa9Q2FMcRStcgpws+9Ngf2X7T4=;
	b=ZxyY8U85JfUWfphrkCBpk7S5iMEf8jnxIV0czyrL7Tig6NzxZBG+lsqWeLrjTbECBv9L0t
	5vU7ZkQMWRXpElbDbfhAdPzBElvdaD9OC5X85mfvBvT+5zy2jcFwyg/4GlYU0OR9BpiNoY
	DJTcLsudNtsPCZzVdEzAnWvb8pGIBGG9rSItZ+iZ8hzPL2QIjSNJRQfuCsG4BMVH7xGtzJ
	YJ6wkye0Crvh++W06c9sxB2uV1UuT4zenDxbeH5QLtHRHpx/cA5HuNAsLzxQNaSh+RNpIQ
	SoNZcTvVTmfzWIQNZjS376psb0SZRzq9sEvd/i5LXlreTEMCyHCwSoPBLkfIeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755100621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=VqLPctWM5jvGR2VH7wa9Q2FMcRStcgpws+9Ngf2X7T4=;
	b=0QWkTTsmMyRDL8XARH1EQjhSwgULjdRJoapHJYGKYBxV9EtfkvxpNRGu10ft4PlRyWPevR
	xYcjyiBeXCW/+PBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 x86@kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: [patch 0/4] uaccess: Provide and use helpers for user masked access
Date: Wed, 13 Aug 2025 17:57:00 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

commit 2865baf54077 ("x86: support user address masking instead of
non-speculative conditional") provided an optimization for
unsafe_get/put_user(), which optimizes the Spectre-V1 mitigation in an
architecture specific way. Currently only x86_64 supports that.

The required code pattern screams for helper functions before it is copied
all over the kernel. So far the exposure is limited to futex, x86 and
fs/select.

Provide a set of helpers for common single size access patterns:

  - get/put_user_masked_uNN() where $NN is the variable size in
    bits, i.e. 8, 16, 32, 64.

  - user_read/write_masked_begin() for scenarios, where several
    unsafe_put/get_user() invocations are required.

Convert the existing users over to this.

The series applies on top of

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent

which has a bug fix pending for the futex implementation of this.

It's also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git uaccess/masked

there is another candidate for conversion: RSEQ. This has not been
converted yet because there are more severe performance issues with this
code, which starts to become prominent in exit path profiling because glibc
started to use it. This will be addressed in a seperate series.

As this creates dependencies, merging it should go through one central tree,
i.e. tip, but that's a debate for later :)

Thanks,

	tglx
---
 arch/x86/include/asm/futex.h |   12 ++----
 fs/select.c                  |    4 --
 include/linux/uaccess.h      |   78 +++++++++++++++++++++++++++++++++++++++++++
 kernel/futex/futex.h         |   37 +-------------------
 4 files changed, 85 insertions(+), 46 deletions(-)




