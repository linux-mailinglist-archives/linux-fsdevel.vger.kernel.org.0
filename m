Return-Path: <linux-fsdevel+bounces-69991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3066EC8D8A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 10:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D06BD346A3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 09:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EDC32720F;
	Thu, 27 Nov 2025 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYSjiIK+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C367826F2AD
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235680; cv=none; b=eXo8BTyhxNek/qoziBCnxZ7GaPeDVxs3b13YPfDZ7qd+HYRqH/2icSTPvyKa0lmmmIHQbtqZgBJTTesh8ApkZMk0Il8vZMmls8vgO20aQeYAd+sCBsZB0xLxxFt7+MnyKszOBA857mVdRb+X2JM+cpiYrPfqTd2xc/3CWcSVWM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235680; c=relaxed/simple;
	bh=XIUY6hkHE+X5GOQVLvRGEK6KrKGPW2wqdwJmTf8d1Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djdDvNYXumJaPblPE+3KU6KGXLn9DmQ7gX5WynjOqpSSEhAWYwwPMurHQRbtV2lzxXCEmvjQ+wTCj9KMBp1Olku8MfeuzGvoppnBRszdIHBiTh9fN2anfPngNLrElauVvWUu4PPheE9xaQ7T7u9TWsSyQdu3zHRhAKPBlXaLUr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYSjiIK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A95C4CEF8;
	Thu, 27 Nov 2025 09:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764235680;
	bh=XIUY6hkHE+X5GOQVLvRGEK6KrKGPW2wqdwJmTf8d1Rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hYSjiIK+o3wpi9SAYfCExLsdlwiuQidpkAS/lGc6EIokkvkyaxmSuQXIo6KS9fbzF
	 LcZtSKfXfWFlbP2rhMluoLlK7aQKdSi3CRegnJOGfN4y05S3kZ0Aicu/+hfPLekQU/
	 RUdmorLs3A7QtSqJzgwpmL9PGMwwxGSA2DhFK7zJISqns8qEjkQS0wt41NM4KruAcj
	 722amKQyB67f64K7fWioj2s5Dy4wgdhx52cCXkCVIs5PrG153OlCRkuiEKQbIzAg8o
	 ytMQ9Oy9WKxbhm6cbzBF1jI57Yp3lj6+ewe4i+d2FpUB1rt7GnB+8e9IwLIK4UUVeG
	 ELttvBKKX9H6g==
Date: Thu, 27 Nov 2025 10:27:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, 
	"Saarinen, Jani" <jani.saarinen@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: REGRESSION on linux-next (next-20251125)
Message-ID: <20251127-agenda-befinden-61628473b16b@brauner>
References: <a27eb5f4-c4c9-406c-9b53-93f7888db14a@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a27eb5f4-c4c9-406c-9b53-93f7888db14a@intel.com>

On Thu, Nov 27, 2025 at 11:35:32AM +0530, Borah, Chaitanya Kumar wrote:
> Hello Christian,
> 
> Hope you are doing well. I am Chaitanya from the linux graphics team in
> Intel.
> 
> This mail is regarding a regression we are seeing in our CI runs[1] on
> linux-next repository.
> 
> Since the version next-20251125 [2], we are seeing the following regression
> 
> `````````````````````````````````````````````````````````````````````````````````
> (kms_busy:5818) sw_sync-CRITICAL: Test assertion failure function
> sw_sync_timeline_create_fence, file ../lib/sw_sync.c:117:
> (kms_busy:5818) sw_sync-CRITICAL: Failed assertion:
> sw_sync_fd_is_valid(fence)
> (kms_busy:5818) sw_sync-CRITICAL: Last errno: 2, No such file or directory
> (kms_busy:5818) sw_sync-CRITICAL: Created invalid fence
> (kms_busy:5818) igt_core-INFO: Stack trace:
> (kms_busy:5818) igt_core-INFO:   #0 ../lib/igt_core.c:2075
> __igt_fail_assert()
> (kms_busy:5818) igt_core-INFO:   #1 [sw_sync_timeline_create_fence+0x5f]
> (kms_busy:5818) igt_core-INFO:   #2 ../tests/intel/kms_busy.c:122
> flip_to_fb()
> (kms_busy:5818) igt_core-INFO:   #3 ../tests/intel/kms_busy.c:220
> test_flip()
> (kms_busy:5818) igt_core-INFO:   #4 ../tests/intel/kms_busy.c:459
> __igt_unique____real_main411()
> (kms_busy:5818) igt_core-INFO:   #5 ../tests/intel/kms_busy.c:411 main()
> (kms_busy:5818) igt_core-INFO:   #6 [__libc_init_first+0x8a]
> (kms_busy:5818) igt_core-INFO:   #7 [__libc_start_main+0x8b]
> (kms_busy:5818) igt_core-INFO:   #8 [_start+0x25]
> `````````````````````````````````````````````````````````````````````````````````
> Details log can be found in [3].
> 
> After bisecting the tree, the following patch [4] seems to be the first
> "bad" commit
> 
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> commit 8459303c886151b71e8de08b73e384fd2bb7499c
> Author: Christian Brauner brauner@kernel.org
> Date:   Sun Nov 23 17:33:55 2025 +0100
> 
>     dma: port sw_sync_ioctl_create_fence() to FD_PREPARE()
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> 
> We also verified that if we revert the patch the issue is not seen.
> 
> Could you please check why the patch causes this regression and provide a
> fix if necessary?

Gah, sorry about this:

diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index dc2e79a1b196..8d827b03e84c 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -244,7 +244,8 @@ static long sync_file_ioctl_merge(struct sync_file *sync_file,
        if (copy_to_user((void __user *)arg, &data, sizeof(data)))
                return -EFAULT;

-       return fd_publish(fdf);
+       fd_publish(fdf);
+       return 0;
 }

 static int sync_fill_fence_info(struct dma_fence *fence,

Pushing out the fix now. Can I trigger a new test myself somehow?

