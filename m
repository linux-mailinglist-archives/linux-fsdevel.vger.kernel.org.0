Return-Path: <linux-fsdevel+bounces-21272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D265900CEF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 22:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20CAB22671
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 20:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13853154449;
	Fri,  7 Jun 2024 20:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BD949qhv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E974F154424;
	Fri,  7 Jun 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792232; cv=none; b=LS67LKFHJxr4GrL8XVpKh+eBmLIVDojOahPuXkivDDa8MDPHQh4YAFp/8rJCqX4b9YKW99Of6ZUR+Y1MmRFqkfCiQzUlicqeMMvpS2Vtk8skmVPHHg5wMjW26rMfNgihKNckspjXd7XQdYmox1s8epF4eYddcsrQHME30gfgx5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792232; c=relaxed/simple;
	bh=IoslD7mjLZes0z/Pdb1R5uPtVtTWZYFBRxVyVXvPpZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAhaRcspjCzAbz6jDxtk4WZDFOjqwHtIlNMt/wsUvyHjEfMpZRfKJ5smagqlyrUI7p+AdRSot5wdGVgvdAuezMrGB2JLRocHgrCbSk+UH3nX1VvCa5vwXVts3xaAj9MLLB7QE3HGYhEJ8HgRoeWX189B537sBdkYm4KeRKUYuJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BD949qhv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o3OMEbaSK5J2umcY3DiUsQ5RuyLJhGrfao7NvY5OexI=; b=BD949qhvHdhkf3RD9ABkr6yeCE
	9mWyT91IrbNLZK58ikXXyeSu98VxgEgfJhnwtj9JTvAxT7dBmdI80JwqW3tTmXwDpkpZdzgEQVdiF
	M3iSuILs79BbQhHptq0wTIaNEXf98CmcOt2n/CNvq7VQId/CvHtrJLxz0JijcZqKDPVsRB0UdCGiK
	goC75zoOf5SN352NOcQlFlVexExo31G1eV8i9KmQoth4eGk/x3A5WzZ5o36dTLO5Bp92MhCG9ZKJE
	4fJis4sut1CoXSL+z01fqyR0ZOo9Sq9yfnWBzRcFcO9v3JP+pZBJJgGOAEjXyUOEEIZKHY19QqOFg
	pwgX+7+Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFgEB-00E1i9-1H;
	Fri, 07 Jun 2024 20:30:23 +0000
Date: Fri, 7 Jun 2024 21:30:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Nathan Chancellor <nathan@kernel.org>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:work.fd 11/19] fs/select.c:860:3: error: cannot jump
 from this goto statement to its label
Message-ID: <20240607203023.GB1629371@ZenIV>
References: <202406071836.yx9rpD7U-lkp@intel.com>
 <20240607152428.GY1629371@ZenIV>
 <20240607202010.GA2270105@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607202010.GA2270105@thelio-3990X>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 07, 2024 at 01:20:10PM -0700, Nathan Chancellor wrote:
> On Fri, Jun 07, 2024 at 04:24:28PM +0100, Al Viro wrote:
> > > >> fs/select.c:860:3: error: cannot jump from this goto statement to its label
> > >      860 |                 goto out;
> > >          |                 ^
> > >    fs/select.c:862:12: note: jump bypasses initialization of variable with __attribute__((cleanup))
> > >      862 |         CLASS(fd, f)(fd);
> > >          |                   ^
> > >    13 warnings and 1 error generated.
> > 
> > Sigh...  That's why declarations in the middle of block really stink.
> > Sadly, the use of CLASS() very much invites that kind of crap.
> > For this series I decided to suppress the gag reflex and see how
> > it goes, but... ouch.
> > 
> > Worse, neither current gcc, nor clang 14 catch that kind of crap ;-/
> 
> Hmmm, I am able to reproduce this with clang 14.0.6 from kernel.org [1]
> with x86_64 allnoconfig:
> 
> $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 allnoconfig fs/select.o
> fs/select.c:860:3: error: cannot jump from this goto statement to its label
>                 goto out;
>                 ^
> fs/select.c:862:12: note: jump bypasses initialization of variable with __attribute__((cleanup))
>         CLASS(fd, f)(fd);
>                   ^
> 1 error generated.
> 
> $ clang --version | head -1
> ClangBuiltLinux clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> 
> It is a bug that GCC does not warn about this as far as I understand it:
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91951

Mea culpa - messed up make arguments ;-/

