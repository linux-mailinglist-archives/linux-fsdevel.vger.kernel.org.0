Return-Path: <linux-fsdevel+bounces-41614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DF7A33224
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 23:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93CC188B7A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 22:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FB72045A1;
	Wed, 12 Feb 2025 22:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy6y09J1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C206020408C;
	Wed, 12 Feb 2025 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398196; cv=none; b=Xo+RXJd0Iap+V4xv5jgVbVr+xVUldiQvX8sL697p7DCsVFZpMgaLdmFLI72wmfUlUyCp9vCNhpFhzaeC2T++l5H0ZvDjxfZsR6AcA1xgY+scvveBt2A6jzAcoKbj5dX8Al4jdg9hfcjnx8HiBX2Z6Fy4Zhdxvf6Mt8tMCYDtxhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398196; c=relaxed/simple;
	bh=+AjfEdkaI/sPOZZaiIPwmh7CPh03gJLsar/MeSZ1gKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqeRKBMOn25JuCbjTacVfTQb34vfKHmQSvaQwBW+BAYuZwsRWLw6fu3YOy1TEFaxR4r+1JLvF7AYOVpLv6auQKimTCYYzHBJsytRntQEu2CXgPguEtbbkv3R5QxaghwQT2Hdqo0h+L8vSfipI0y3sBuTsedc26psfr+IMPDbakQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy6y09J1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B56C4CEE4;
	Wed, 12 Feb 2025 22:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739398196;
	bh=+AjfEdkaI/sPOZZaiIPwmh7CPh03gJLsar/MeSZ1gKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gy6y09J1YcIWY5VxqVBxjK7CXJY5kKULyaEfm+15ktHCOJYb7XZxmb+mU8NVKW7KL
	 glOwy8V/qgdogZjKZHYJ/kDFHvdCFe0NnSi1XHfx2YPUICLH69lfmOYbc+hHdQvStq
	 PytaJo/qKPaCjtDlB6W8MCvmv8jcSSm09DX+8hkUqrl0j6fudzcLIs7f+P6IgcVXco
	 yKKFO7h1gD81VQRgARUpSlWE6GWSZvSY1KAFWqUSozWGdWoeyESKdwt/89P4AnF7jK
	 r62c8Xj5ZWMIFCW0FnpOXluNS0NZhkGn+nanAShnqpXMCjBFdyVCMi/2P45RRzO/ZL
	 lZPML8dBf0oQA==
Date: Wed, 12 Feb 2025 14:09:55 -0800
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Thorsten Leemhuis <linux@leemhuis.info>,
	Gabriel Krisman Bertazi <gabriel@krisman.be>,
	Pedro Orlando <porlando@lkcamp.dev>,
	Danilo Pereira <dpereira@lkcamp.dev>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] unicode: kunit: change tests filename and path
Message-ID: <202502121409.864E362899@keescook>
References: <20240928235825.96961-1-porlando@lkcamp.dev>
 <20240928235825.96961-3-porlando@lkcamp.dev>
 <87iku7u211.fsf@mailhost.krisman.be>
 <2c26c5e4-9cf3-4020-b0be-637dc826b4e9@leemhuis.info>
 <CABVgOS=36iRrpb+ND4M2awbZzgCKwudYxx5XNvEBEkgss+C-bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOS=36iRrpb+ND4M2awbZzgCKwudYxx5XNvEBEkgss+C-bw@mail.gmail.com>

On Wed, Feb 12, 2025 at 05:31:59PM +0800, David Gow wrote:
> On Wed, 12 Feb 2025 at 14:45, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> >
> > On 04.10.24 21:00, Gabriel Krisman Bertazi wrote:
> > > Pedro Orlando <porlando@lkcamp.dev> writes:
> > >> From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
> > >>
> > >> Change utf8 kunit test filename and path to follow the style
> > >> convention on Documentation/dev-tools/kunit/style.rst
> > >>
> > >> Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
> > >> Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
> > >> Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
> > >> Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
> > >> Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
> > >> ---
> > >>  fs/unicode/Makefile                                | 2 +-
> > >>  fs/unicode/{ => tests}/.kunitconfig                | 0
> > >>  fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} | 0
> > >>  3 files changed, 1 insertion(+), 1 deletion(-)
> > >>  rename fs/unicode/{ => tests}/.kunitconfig (100%)
> > >>  rename fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} (100%)
> > >>
> > >> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
> > >> index 37bbcbc628a1..d95be7fb9f6b 100644
> > >> --- a/fs/unicode/Makefile
> > >> +++ b/fs/unicode/Makefile
> > >> @@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
> > >>  obj-y                       += unicode.o
> > >>  endif
> > >>  obj-$(CONFIG_UNICODE)       += utf8data.o
> > >> -obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += utf8-selftest.o
> > >> +obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += tests/utf8_kunit.o
> > >
> > > This breaks compilation for me.
> > >
> > > fs/unicode/tests/utf8_kunit.c:11:10: fatal error: utf8n.h: No such file or directory
> > >    11 | #include "utf8n.h"
> > >       |          ^~~~~~~~~
> >
> > I encountered the same error when building -next using the Fedora
> > rawhide config today. Given that this patch landed in -next today I
> > suspect it might be due to this change, but I'm on the road and unable
> > to verify that right now.
> >
> > Log:
> > https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-x86_64/08642966-next-next-all/builder-live.log.gz
> >
> > Cioa, Thorsten
> >
> 
> Hmm... this definitely seems like a problem, but I haven't been able
> to reproduce it here (either under x86_64 or UML, both as a module and
> built-in). The suggested fix of changing the path to "../utf8n.h"
> doesn't seem to have broken it, though.

Thanks for the reports! I've squashed this path correction into my tree
and it should be fix in the next -next. :)

-Kees

-- 
Kees Cook

