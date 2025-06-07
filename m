Return-Path: <linux-fsdevel+bounces-50917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2857EAD0FE9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 23:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9BCE16C691
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 21:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965C5215F56;
	Sat,  7 Jun 2025 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BHMVYdYU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AF12F3E;
	Sat,  7 Jun 2025 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749331507; cv=none; b=IOc2XrVQYJ80GYBY4jdIIvj6QTKtyjRtUps6nCGaYSUEpLmfCgVyWtYFoTv4L9hrm66zr35a9O1dnOIU+bBM0TqLMCBnN1E/W0YU/OBUPXSG4p9LmwAYZzzgAntIq1k8vl4QfaUaimFwx2cvWa3RdBRhhllh5GjsteQrkNlK3o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749331507; c=relaxed/simple;
	bh=PYoPnw5ejgALW0suoy2NdoxfVJO7YAi9yZCyKK5g6ro=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=POenFUN2jE1e9sweejsEA8YkQWk5V0T9++gUc13fqoMpGk8nW9tvIEtE5flqTGAHiK2nQznNOeghOEAOBpeGT+9KTEb2aW0C/+SrnMDtQx6ru2dnaTdZm4LWLFQSOL3canmTSitwKK/STM1zZvHlAPDhNWCVmnZ/vQIaEc9Gzqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BHMVYdYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263EDC4CEE4;
	Sat,  7 Jun 2025 21:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749331506;
	bh=PYoPnw5ejgALW0suoy2NdoxfVJO7YAi9yZCyKK5g6ro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BHMVYdYU6Set/xLh+GyImSxwTjT0heDDceYtBW6ZUlLMo5yIrtYnPluQxfGf3ZQXM
	 UO8SSCzbB7tN8NuuubXUJ33Vch/bALN0qx2O6ICpqyXp60M6KclptduddUmM8eFtUi
	 FAYUpt7krEOZPk/0/iiK4MOPjBI2rctU2AOuExIY=
Date: Sat, 7 Jun 2025 14:25:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: wangfushuai <wangfushuai@baidu.com>, corbet@lwn.net, david@redhat.com,
 andrii@kernel.org, npache@redhat.com, catalin.marinas@arm.com,
 xu.xin16@zte.com.cn, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: proc: update VmFlags documentation in smaps
Message-Id: <20250607142505.e58fda734ce54167724705a3@linux-foundation.org>
In-Reply-To: <CAKha_so-2Z+4rAKezv1peeWdkOKoMMvuLqq7dhOmbeeAGxHF5Q@mail.gmail.com>
References: <20250607153614.81914-1-wangfushuai@baidu.com>
	<CAKha_so-2Z+4rAKezv1peeWdkOKoMMvuLqq7dhOmbeeAGxHF5Q@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 7 Jun 2025 13:03:30 -0400 Tal Zussman <tz2294@columbia.edu> wrote:

> On Sat, Jun 7, 2025 at 11:36 AM wangfushuai <wangfushuai@baidu.com> wrote:
> > Remove outdated VM_DENYWRITE("dw") reference and add missing
> > VM_LOCKONFAULT("lf") and VM_UFFD_MINOR("ui") flags.
> 
> VM_DROPPABLE ("dp") is also missing, would be nice to add it as well.
> 

Thanks.  How's this?


--- a/Documentation/filesystems/proc.rst~docs-proc-update-vmflags-documentation-in-smaps-fix
+++ a/Documentation/filesystems/proc.rst
@@ -610,6 +610,7 @@ encoded manner. The codes are the follow
     ss    shadow/guarded control stack page
     sl    sealed
     lf    lock on fault pages
+    dp    always lazily freeable mapping
     ==    =======================================
 
 Note that there is no guarantee that every flag and associated mnemonic will
_


