Return-Path: <linux-fsdevel+bounces-55558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89971B0BD94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 09:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16AA189D7A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 07:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8221283FF8;
	Mon, 21 Jul 2025 07:20:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9732F2820CB;
	Mon, 21 Jul 2025 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082442; cv=none; b=itVweliJbC0fc+dRp7oyBoPBL6moEMMUQUAcdBOzc5ETKxrvEr5C/WM2ISus8BW+s1DhdvLxSwZVfjxF0lwvj6DWs13nK0pENF2Gswj3xposwFkQVa0eVd67QIxee4qJoAEA2Wn+QYhzEqnuXH98ajqgIkSRS9PI6jTkB8fcgqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082442; c=relaxed/simple;
	bh=UAifdKV4Qk4RK7rDbibFB7hcdEXYewn2l6vnSUlQywI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D78flpKOSa0rqkWQlS5lkclJmCrnMQGLMLfqQLisk8AByMh/WkxHAbbFd6NtAYlxKTN8MrBpQqoP7U0+Hz8QXCEubN2TBEDRfXajAuf9OeeFPiPxFLjpwT4irvy/H3N/j+QJUTiEiEIEXwqUTnL/pHF8aHhk1mg6B8CNDrA7w6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9683668B05; Mon, 21 Jul 2025 09:20:33 +0200 (CEST)
Date: Mon, 21 Jul 2025 09:20:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Kees Cook <kees@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 06/15] fs,fork,exit: export symbols necessary for
 KUnit UAPI support
Message-ID: <20250721072033.GA30175@lst.de>
References: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de> <20250717-kunit-kselftests-v5-6-442b711cde2e@linutronix.de> <20250718164412.GD2580412@ZenIV> <20250721075849-b3cf33b6-2516-4707-bab6-53fe95afbffa@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250721075849-b3cf33b6-2516-4707-bab6-53fe95afbffa@linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 21, 2025 at 08:42:40AM +0200, Thomas Weißschuh wrote:
> This would still leave the exports for replace_fd(), create_pipe_files()
> and set_fs_pwd(). Instead of using kernel/umh.c,

Please look into a way to just run your userspace tests from userspace.

It's not that hard, people have done this novel concept for at least
a few decades if you look into it.

> I can also extend
> kernel/usermode_driver.c to provide these in a way that works for me.
> But kernel/usermode_driver.c is dead code, unused since commit
> 98e20e5e13d2 ("bpfilter: remove bpfilter")
> Would it be fine to export those symbols? And delete usermode_driver.c,
> as carrying around an unused generic framework seems pointless.

Unused code should always go away.  Weirdly enough USERMODE_DRIVER is
selected by BPF_PRELOAD despite that not really using any code from
it, though.


