Return-Path: <linux-fsdevel+bounces-58410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF46B2E79E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 23:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18EDCAA5BE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 21:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5D13314DC;
	Wed, 20 Aug 2025 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XkLLiJ2d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AB52DC32D;
	Wed, 20 Aug 2025 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755725996; cv=none; b=X004UhAk6DF0oCEnR9YPclHMtzL/cegpu8C+bEJ/fDxsJb6JbMCB4XZuDwuiQ7YoR3SV1H+Eee71SbdYua6DnxAlLIAFDZbZ6eIfbQz1tDhInEDTGk8yz02k2nEQne/VGVJMV4EVWllPCfYCwDm+lGSovq5+lWme01CWKJT1nM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755725996; c=relaxed/simple;
	bh=i0jbInS0+2DRpfh54p9PsOb2qESAlY24P6B5UDaXAhY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RvBJBgIDYPefhd0fWkSnPAE2FSm9NnkdO7Ah1mWz9EucuzMmERUB63V6IQOxPUE+RKLfxeWtk4Rrfy4LXu/y15R6KQlX/CO/FRlII9OGicn/9LevgJ4OKoCmM1nDvxY9+D9aAp8quF+RYj+MQTGzPuz0aOHar01CM6Z3h5rSQl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XkLLiJ2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167B6C4CEE7;
	Wed, 20 Aug 2025 21:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755725995;
	bh=i0jbInS0+2DRpfh54p9PsOb2qESAlY24P6B5UDaXAhY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XkLLiJ2dzln8lUa212EB1pPOLnuKRgYTcHSM7dJFeB2yCytytNCkkTlZCcws8yRux
	 jyTRFW67gE1MiJGVEcxW8PUO/Ejz1gS3UE1qrjVvaYJCESGCTdNj9CYjdcdcMqggsC
	 wVv8RXgAiGSlrS/JGxJs5Ol4X1tJ0Rh/FK5WewFg=
Date: Wed, 20 Aug 2025 14:39:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: shuah@kernel.org, surenb@google.com, skhan@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] selftests: proc: mark vsyscall strings maybe-unused
Message-Id: <20250820143954.33d95635e504e94df01930d0@linux-foundation.org>
In-Reply-To: <20250820175610.83014-1-reddybalavignesh9979@gmail.com>
References: <20250820175610.83014-1-reddybalavignesh9979@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 20 Aug 2025 23:26:10 +0530 Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com> wrote:

> The str_vsyscall_* constants in proc-pid-vm.c triggers
> -Wunused-const-variable warnings with gcc-13.32 and clang 18.1.

OT but lol.  My head is spinning at the term "const-variable".  I
understand what they mean, but it's oxymoronic.

> Define and apply __maybe_unused locally to suppress the warnings.
> No functional change
> 
> Fixes compiler warning:
> warning: ‘str_vsyscall_*’ defined but not used[-Wunused-const-variable]
>
> ...
>
> --- a/tools/testing/selftests/proc/proc-pid-vm.c
> +++ b/tools/testing/selftests/proc/proc-pid-vm.c
> @@ -47,6 +47,10 @@
>  #include <sys/resource.h>
>  #include <linux/fs.h>
>  
> +#ifndef __maybe_unused
> +#define __maybe_unused __attribute__((__unused__))
> +#endif

This would be approximately the seventh definition of __maybe_unused
under tools/testing/selftests.  And there's another in
tools/testing/memblock, which, as if admitting that its directory is in
the wrong place, had to go and include ../selftests/kselftest.h.

So it would be pleasing if some kind soul were to define __maybe_unused
in a common place, which looks to be
tools/testing/selftests/kselftest.h.  Then go zap all those private
definitions.

This could be done either before or after your patch.

>  #include "../kselftest.h"

And we have 350 occurrences of "../kselftest.h".  Shouldn't the build
system be providing -Itools/testing/selftests?

Anyway, patch looks OK - I'll add it to mm.git, thanks.

