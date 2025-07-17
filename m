Return-Path: <linux-fsdevel+bounces-55260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2AAB08E0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 15:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815F7A6360B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 13:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC622E5415;
	Thu, 17 Jul 2025 13:23:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B12DD608;
	Thu, 17 Jul 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758589; cv=none; b=biZHHyQIkO5sJ5HBvUrYTQvpgLGsa6MtQ1qqOqn2/SNHf+tQwxJAA4sdG0rjdqe6Mdw7ml4F8L6zevDsk7y6CuUvc0eo2NwR6lA9FrvfrSLvGCYdFS54qdWME8zuPiQBiAhCtcM7JoI1dfAMuVL/Oq+lXHGN1S9HBx3ML3jQvxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758589; c=relaxed/simple;
	bh=+cfutO6wBMYbBpJgajM2/8yIHa5AgEJSDmWRmoflytw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSILpLKZKBMuxSQvGmJfscfwICat5KPnQHBwqkwYepaNQTbf2HJUVm5iaMMyyy20RN/Ro1Ii86D1WSvqiNq3aN/+gNeMwoKIjVhAswXYGwXgz23s/0B509cIL5oTf8m3m7MWKP78zl4UIN0/9gAKrhfa9VCsmUuMi8K4ksPurHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 57276227A88; Thu, 17 Jul 2025 15:23:00 +0200 (CEST)
Date: Thu, 17 Jul 2025 15:23:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 00/15] kunit: Introduce UAPI testing framework
Message-ID: <20250717132259.GA25835@lst.de>
References: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 17, 2025 at 10:48:02AM +0200, Thomas Weißschuh wrote:
> Currently testing of userspace and in-kernel API use two different
> frameworks.

Which is kinda expected as one has to run in the kernel to test
in-kernel kernel space APIs, and the other tests externally provided
kernel functionality.

> Therefore kunit is much easier to run against different kernel
> configurations and architectures.

Which is is normal.  unit tests are always easier to run than
integration tests.

> This series aims to combine kselftests and kunit, avoiding both their
> limitations. It works by compiling the userspace kselftests as part of
> the regular kernel build, embedding them into the kunit kernel or module
> and executing them from there.

This is really weird.  "Running userspace code is hard, so we package
it in the kernel".  I had my own fair share of problems with kselftests,
mostly because of the lack of structure and automated way to run them,
but adding them to the kernel (or a module) is overshooting the target
by far.

> If the kernel toolchain is not fit to
> produce userspace because of a missing libc, the kernel's own nolibc can
> be used instead.

Is nolibc enough to run all the selftests?  If so we should just do
it unconditionally, but linking to different libraries by availability
seems a bit problematic.

> The structured TAP output from the kselftest is integrated into the
> kunit KTAP output transparently, the kunit parser can parse the combined
> logs together.

Good idea!


