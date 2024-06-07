Return-Path: <linux-fsdevel+bounces-21271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C97E900CCE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 22:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83FB71C212E4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 20:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69C014D704;
	Fri,  7 Jun 2024 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTGovV3V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDE519D89B;
	Fri,  7 Jun 2024 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791613; cv=none; b=nd5Niwv2Wo3uU1D3CK0wpHlzYQHkzTmnE3vFT8tdC9ClucFRtkol6uUtgpVzc2WeROYRWzmlCJXyKgSsEO8QaWGHXN/5dg30JD6IXr1CJqky4RwaY5SkvDkeB+Wd7+wkUk85LpAwHeczMiDpow4yq/EUY0YeEfnCX6D08QgIZbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791613; c=relaxed/simple;
	bh=SAnvbGYMVAGZvJ0KxLz2t6WPUTgFG2qnm7liC5zgPIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mpy+DJ1xQq4CumtQxxqEtvp9/LOOmRP4+x/vQdFo+nvpBsq7kSrW0K92TlktmTd869v0Lhj+W4BbdazngvZG0jbyEv6IFyOs/z5/8idyDhU3WyknrpRFBqE4uh/9lPwsXQCy58KIumzvTcc3iJLlrfwF0ayE+PXS7I47/mGwMBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTGovV3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641D1C2BBFC;
	Fri,  7 Jun 2024 20:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717791612;
	bh=SAnvbGYMVAGZvJ0KxLz2t6WPUTgFG2qnm7liC5zgPIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tTGovV3VS8eee2EGPjnFdZxO/Fx3DXxDa5hWuW8Cg14ZPAxB15zSPAF2pMcXdmujE
	 sqL58cNZDVzrjEpPseFjdYDzvhLoTCnFbdwYUBvXGt9zisz7r1dPDhwrG2pKmNqt1P
	 f1+s/M9+lPX33Xg6rgtzxd/1k8lOmIX/45A3A/V80g/wN4HHADsNyvod+MZwaiRGkI
	 7ObXPHSFFmVSwrAPWsItodFXLCqRPupD6u7UPZ5jP1WAo1jgbOxnBpDqZZ9IjrHj3s
	 LVhVtE+TUprEZ6G/AUSXVst5N0UVcEb6MdVBsj0ZZwQ0OWhumKOoxmtvu1Nyaiq5vH
	 NybM/rRsVGqcw==
Date: Fri, 7 Jun 2024 13:20:10 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:work.fd 11/19] fs/select.c:860:3: error: cannot jump
 from this goto statement to its label
Message-ID: <20240607202010.GA2270105@thelio-3990X>
References: <202406071836.yx9rpD7U-lkp@intel.com>
 <20240607152428.GY1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607152428.GY1629371@ZenIV>

On Fri, Jun 07, 2024 at 04:24:28PM +0100, Al Viro wrote:
> > >> fs/select.c:860:3: error: cannot jump from this goto statement to its label
> >      860 |                 goto out;
> >          |                 ^
> >    fs/select.c:862:12: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >      862 |         CLASS(fd, f)(fd);
> >          |                   ^
> >    13 warnings and 1 error generated.
> 
> Sigh...  That's why declarations in the middle of block really stink.
> Sadly, the use of CLASS() very much invites that kind of crap.
> For this series I decided to suppress the gag reflex and see how
> it goes, but... ouch.
> 
> Worse, neither current gcc, nor clang 14 catch that kind of crap ;-/

Hmmm, I am able to reproduce this with clang 14.0.6 from kernel.org [1]
with x86_64 allnoconfig:

$ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 allnoconfig fs/select.o
fs/select.c:860:3: error: cannot jump from this goto statement to its label
                goto out;
                ^
fs/select.c:862:12: note: jump bypasses initialization of variable with __attribute__((cleanup))
        CLASS(fd, f)(fd);
                  ^
1 error generated.

$ clang --version | head -1
ClangBuiltLinux clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)

It is a bug that GCC does not warn about this as far as I understand it:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91951

[1]: https://mirrors.edge.kernel.org/pub/tools/llvm/

Cheers,
Nathan

