Return-Path: <linux-fsdevel+bounces-18118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C608B5F1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 18:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880631C218FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 16:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B8E85655;
	Mon, 29 Apr 2024 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pEZsWNN+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E48F1DA23;
	Mon, 29 Apr 2024 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408552; cv=none; b=fLduC/q9VNRWxIOPl89w/Ea98oa+fxm/83T9Fp7DF2jixqXu/je9RNXIkZJ8siVpPSz5orQmScRYnrM0z/P20WKoSfTGrM9RLDMXVkjlPPDJJjNNfsbzGfB01wcLt2XvjkI/YLTcpZDuHHhZJQxPSWTErtArFmrWNFBV8MrLoO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408552; c=relaxed/simple;
	bh=GGjBagnQCW0lryPvoeTSTgt4dXQUdO+O5KSvIq+GuEY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Xqy5fFLVeXz3v77OCM5RMoGlqrwDjeFz2mgW5uBcJqdGp01KHQgXIMlCOLNSQBMseI3UfF5oB5bWmaH9g9pwWFcEnFFDBufMunuieW5ZzcBP/JOX/4Z/s1yZWyA+gRPSB6dZ2yygEpFseMRyRrQ/Nz4oOGKltqX+i5SZHbpzTMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pEZsWNN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91403C4AF14;
	Mon, 29 Apr 2024 16:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1714408551;
	bh=GGjBagnQCW0lryPvoeTSTgt4dXQUdO+O5KSvIq+GuEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pEZsWNN+jofkwx7AqvwnZYcu3Y5URHI9av2fEOe5mrTetGwbuTuC/wjmmulYJX9o5
	 dK0Y9fbyU1a1aZ6rsc5zv67C8ytCOP1BMmo0Ng70n6l64hcTZbrmZ41/e1k81+MP6J
	 CTh4qVrdIis+99pFCJ+S8Htw9utBNT8Fr6JdTPR8=
Date: Mon, 29 Apr 2024 09:35:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <mcgrof@kernel.org>, <j.granados@samsung.com>, <brauner@kernel.org>,
 <david@redhat.com>, <willy@infradead.org>, <oleg@redhat.com>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH -next] proc: Remove unnecessary interrupts.c include
Message-Id: <20240429093549.f2b9c670f383bed627022f31@linux-foundation.org>
In-Reply-To: <20240428094847.42521-1-ruanjinjie@huawei.com>
References: <20240428094847.42521-1-ruanjinjie@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Apr 2024 17:48:47 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> The irqnr.h is included in interrupts.h and the fs.h is included in
> proc_fs.h, they are unnecessary included in interrupts.c, so remove it.
> 
> ...
>
> --- a/fs/proc/interrupts.c
> +++ b/fs/proc/interrupts.c
> @@ -1,8 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/fs.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> -#include <linux/irqnr.h>
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>

Within limits, we prefer that .c files directly include the headers
which they use.  If interrupts.c uses nothing from these headers then
OK.  If, however, interrupts.c does use things which are defined in
these headers then the inclusion of those headers is desired.

