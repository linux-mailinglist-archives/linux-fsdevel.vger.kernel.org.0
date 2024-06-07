Return-Path: <linux-fsdevel+bounces-21258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B04C59008AC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22C71C218DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A37C195808;
	Fri,  7 Jun 2024 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iaOxQZiX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705651990D8;
	Fri,  7 Jun 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773874; cv=none; b=G/z/HWJEAEebG9QxL05LLxhO8RXS8qulnYzCh6MBavw0MUFkUWjpUNtSUlIq5sTl3kLqtW8Xkvoc7UR1ZNo4vLdSawdl+1QvTSgrHzVqZ4M6+9bUZvp/8UywcYNGiqupu3AwTYzHaXLVXSXDXaX6S7MJPz36DEYqYuVb566vB7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773874; c=relaxed/simple;
	bh=yyeZl9pVtHr8FeH8bar5LtSsN52Ydm96A9tAAy+H0Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtcQ5A48YVp9RM/o8Q1TsI10IeEpwhtR/u2DqDdAcPU/JUCcfM6jdn7BP9RQ/1/s6JZDtbqiMmlLtCMN5l11kRvWOzxoi/luJvkAD3sjQb06RazGQvS1enfK5C6O0WpeRVvPCei2ioXkD9hYBEZD9tjoqDCsnl77TBNhryp2SLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iaOxQZiX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dwUZQ/RptqcQASbcxu59zQVAZDZ7t8wZh63vKmHL/SA=; b=iaOxQZiX8Ub78tpTCs4PxzvGFe
	WezQGgp58v3/J2iE25RscAqkVA4fZnf0cWJRekMOVC4xbGCmLmyB6dRKOwXM6u1Vw0pLvbGcLaINo
	c15ggG48U+u26ezDuVLn5PtLU2HQpSrNI/aHtzy2yqGyc6HZY9p8DFEbcZF54XybQamSOxOvP4H6k
	6dB87wgflZsUb7ogJ9oAi5QhRFbZVStnmoQd3uRXqiaW2g3KKk5QEQ69XdVO4DTLqmdKgFk5WNvW7
	D3QnZMvpRa6BcefhmSm3wDnCXMTHfmBTwIjsQQ3g5xcGRMDCxcj3MX4xKFS2HTWylNEDTYw4r2CWJ
	ZPD7eknQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFbS8-00D0pb-1Z;
	Fri, 07 Jun 2024 15:24:28 +0000
Date: Fri, 7 Jun 2024 16:24:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:work.fd 11/19] fs/select.c:860:3: error: cannot jump
 from this goto statement to its label
Message-ID: <20240607152428.GY1629371@ZenIV>
References: <202406071836.yx9rpD7U-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406071836.yx9rpD7U-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 07, 2024 at 06:47:54PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.fd
> head:   e0288728ff8a4703675c4c8e2ea8a0122b7675f6
> commit: 3cc074209e634318e4f9fd4a813dae7703d2aa78 [11/19] switch simple users of fdget() to CLASS(fd, ...)
> config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20240607/202406071836.yx9rpD7U-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406071836.yx9rpD7U-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406071836.yx9rpD7U-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
[loads of noise, then]

> >> fs/select.c:860:3: error: cannot jump from this goto statement to its label
>      860 |                 goto out;
>          |                 ^
>    fs/select.c:862:12: note: jump bypasses initialization of variable with __attribute__((cleanup))
>      862 |         CLASS(fd, f)(fd);
>          |                   ^
>    13 warnings and 1 error generated.

Sigh...  That's why declarations in the middle of block really stink.
Sadly, the use of CLASS() very much invites that kind of crap.
For this series I decided to suppress the gag reflex and see how
it goes, but... ouch.

Worse, neither current gcc, nor clang 14 catch that kind of crap ;-/

