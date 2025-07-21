Return-Path: <linux-fsdevel+bounces-55553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C34B0BCE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 08:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2246E189B0D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 06:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E003927FB3B;
	Mon, 21 Jul 2025 06:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bDfUUXio";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GqCH6LtS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DB927F187;
	Mon, 21 Jul 2025 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753080167; cv=none; b=QWioLANpvkpcEs4yuHpXIqD/UpkS64uqzHIl0uUZJyd+SAAFE2fXWt5adgpzYUoWV1Gli9VQk/GTKvEyeNj9RTCNMrvUmqgedJ5mSBUHLQ4M20jbYFhngJuLPRMu+oTvkwfaoAFCfj+Cybt9Ln0mOIH++92BdF8Mjle3G4AeZaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753080167; c=relaxed/simple;
	bh=Y87bhy5daZH8/4KCjU0hN1yCQ/40lLvGcZ4NSSiWxvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzg+V14IR86TPkjy3arSv9iaMw7Aacdois8YoOQ5IAOanc22+mbry0MWpF3+3QPs71hfe52GdrIYdER1eDAAoSHHJ1gnQ8c7hNxwQ8UpCtMQtJbq9Nz4531ak6Glnq4HRhxs/rH4e/2HYvmx1l6lngH//GaS8Xb/6frT6oiSw2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bDfUUXio; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GqCH6LtS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 21 Jul 2025 08:42:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753080163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tyczl2pXIS5un450KeY12IY1AEuLzrL/JOTCmCTx0/Y=;
	b=bDfUUXioek9CJPvHOobeJUFRkzBLUB4SxeE7NHC9ODhWlWmij0QEEU8AaC+a4Y8vHB+v/r
	vjqq+jqE5ZJPQU9dvC9XKUfiDg9mOwznhjswrKSpysrWTHy5bRLE8uikKkLAD5Zj0iFTjz
	YXKOIGPO6+m9pAIAi/Nk6QdDKFHyxPdQvI8ZCZgn0G+D8O2rGhRAhX4avhjPm65L3mMfhM
	eLvE5drLzj0rJJtQaAS8tyxQnx5wSj6EFvrjmz8b2CZyh0b1b4xFdszwhisYWCEd4xlKfm
	pCtRWmAXiLHgtnDgqW1LBlID3Jn6KiabOxhgfhscrpLFti4df0DlUCjKu7wZSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753080163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tyczl2pXIS5un450KeY12IY1AEuLzrL/JOTCmCTx0/Y=;
	b=GqCH6LtSDPllEmiW8hSXADeWdGxHElcJ8pEB2JVXeLV0OpRpMGQktzjDkwXz4EWuGmvo5Z
	z33lXSs4UrMWhWAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Willy Tarreau <w@1wt.eu>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Kees Cook <kees@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, workflows@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 06/15] fs,fork,exit: export symbols necessary for
 KUnit UAPI support
Message-ID: <20250721075849-b3cf33b6-2516-4707-bab6-53fe95afbffa@linutronix.de>
References: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de>
 <20250717-kunit-kselftests-v5-6-442b711cde2e@linutronix.de>
 <20250718164412.GD2580412@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250718164412.GD2580412@ZenIV>

On Fri, Jul 18, 2025 at 05:44:12PM +0100, Al Viro wrote:
> On Thu, Jul 17, 2025 at 10:48:08AM +0200, Thomas Weiﬂschuh wrote:
> > The KUnit UAPI infrastructure starts userspace processes.
> > As it should be able to be built as a module, export the necessary symbols.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> No.  This is just plain wrong.  This is way too low-level; teach kernel/umh.c
> to provide what you need, but do *not* add more kernel_execve() callers.

Sounds good.

> And the situation with ramfs needs cleaning up, but "export put_filesystem()"
> is not a solution.

Cleaning up would mean to stop calling put_filesystem(), as it is a no-op
here anyways, right?


This would still leave the exports for replace_fd(), create_pipe_files()
and set_fs_pwd(). Instead of using kernel/umh.c, I can also extend
kernel/usermode_driver.c to provide these in a way that works for me.
But kernel/usermode_driver.c is dead code, unused since commit
98e20e5e13d2 ("bpfilter: remove bpfilter")
Would it be fine to export those symbols? And delete usermode_driver.c,
as carrying around an unused generic framework seems pointless.


Thomas

