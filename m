Return-Path: <linux-fsdevel+bounces-13446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F508700FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6142283778
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 12:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27963BB4C;
	Mon,  4 Mar 2024 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ATUPb4Ec";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="m4cofuHG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A060B2261A;
	Mon,  4 Mar 2024 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554324; cv=none; b=qHXX5RkvvTjdpy0XguO52HkaCsrN1Sjewf8XuhZVBl2mhGyI+6qdFAxuXkzqaa2hk01D0xNufyVbDeZdoPEz99SIzGj+MJ9uXcMDEQH+0MvGDT+jS70HinTMHM5bjIWm8RGylNmYFfBv8zRzqIu6tGK++3eEtWKEBr4BPVOtLGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554324; c=relaxed/simple;
	bh=nxynEXQnbPzCEps4/vN/tlKZKuT6sbVfyE2Bf43k7Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZbm/f7K/J+D11zgAHxj0pU6tQD2TXoFyNlVoZUwzsUaPUEUBExlcfeLE7Dvvmtod2Jtt2wLWF4IHdG72c9/XutHFKQ17sOVUDfIqDmcBUFsM6u5V14inszhcXY2JCBJiL6KJY6P9Nql72N8/lK4vrR6ZLS09rreVR6k5MRZWUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ATUPb4Ec; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=m4cofuHG; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 38ADBC01C; Mon,  4 Mar 2024 13:11:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709554313; bh=s0/+PZLwbDwwVcX3U624+7+5k1GRK8btyXeIYeNGilQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ATUPb4Ec2PU0u9fevnCdcOK2WasRgWQabRzNw3SNgywoNXy9EL9jKmAFxR9EsTmI2
	 Re4A2uRNt3gitRZK/mhPwSZ8qGzDT0/0c4ZS/GbwVwFEe8pg1dzGHVMceIBURlOvOM
	 QdzTvQMG6L7JAfP/1diC1UG4oJ5NMFHYZkcpsN6ce+VlHA2rsGashGa2AtimUEYSzC
	 lchk/rbR1D3cbZBLdFlHwa7THwgiLpx/NYkKLz8j5+haRThejJfwH13USb5RWRQGaD
	 Pma4ggmLBdSPy2lq3QzS8IwHzd44H2Tg1vgGEtE9AdPJIWDJv+B/8fwrlCuiH2YeyB
	 8YTKkOKsI1hZQ==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id B0F03C009;
	Mon,  4 Mar 2024 13:11:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709554306; bh=s0/+PZLwbDwwVcX3U624+7+5k1GRK8btyXeIYeNGilQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m4cofuHGsCq7kPOOJlTP4Z7gHG/Mf10X5QX9ZZeimha65Jby3bQTFP/rXT53+Os3W
	 YgYbPPjIF0/4V8s/VHkVxn0nTQqiEcqJEdOFL+H7qjHNzJiD6kNyX4jrwKFKX3420e
	 EDbXtftJCWcCRp8Ok9bs9yrK8F3t6y420Gnb7bOL+HOBiOwKdvv7BFG/w09NelNuvQ
	 hsQxlYC+fPhGmdgc/U8V8T2tOGqI5OJPhCn4AcAlxnsKkbPRRBvgKLTjPGWLhTLhbK
	 DxITGSeiH+b4crdq74datPT90S77JJEWBYLRqnbreva6rVfcdnr1lV923CokTDUkMJ
	 NJTUn3tsNwwgQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 05491c99;
	Mon, 4 Mar 2024 12:11:38 +0000 (UTC)
Date: Mon, 4 Mar 2024 21:11:23 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Brauner <brauner@kernel.org>
Cc: xingwei lee <xrivendell7@gmail.com>, linux-kernel@vger.kernel.org,
	samsun1006219@gmail.com, linux-fsdevel@vger.kernel.org,
	syzkaller@googlegroups.com, jack@suse.cz, viro@zeniv.linux.org.uk,
	Eric Van Hensbergen <ericvh@kernel.org>, v9fs@lists.linux.dev
Subject: Re: WARNING in vfs_getxattr_alloc
Message-ID: <ZeW6a1OK-lhCbAf0@codewreck.org>
References: <CABOYnLwY5Y499j=JgWtk9ksRneOzLoH_G9dYZTwXi=UvLbUsSg@mail.gmail.com>
 <20240304-stuhl-appetit-656a443d78a5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240304-stuhl-appetit-656a443d78a5@brauner>

Christian Brauner wrote on Mon, Mar 04, 2024 at 12:50:12PM +0100:
> > kernel: lastest linux 6.7.rc8 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
> > kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=4a65fa9f077ead01
> > with KASAN enabled
> > compiler: gcc (GCC) 12.2.0
> > 
> > TITLE: WARNING in vfs_getxattr_alloc------------[ cut here ]------------
> 
> Very likely a bug in 9p. Report it on that mailing list. It seems that
> p9_client_xattrwalk() returns questionable values for attr_size:
> 748310584784038656
> That's obviously a rather problematic allocation request.

That's whatever the server requested -- in 9p we don't have the data at
allocation time (xattrwalk returns the size, then we "read" it out in a
subsequent request), so we cannot double-check that the size makes sense
based on a payload at this point.

We could obviously add a max (the current max of SSIZE_MAX is "a bit"
too generous), but I honestly have no idea what'd make sense for this
without breaking some weird usecase somewhere (given the content is
"read" we're not limited by the size of a single message; I've seen
someone return large content as synthetic xattrs so it's hard to put an
actual number for me).
If the linux VFS has a max hard-wired somewhere plase tell me and I'll
be glad to change the max.

Otherwise then as far as I'm concerned if a server returns a huge value
they'll get allocation failures and that's about as bad as it'll get; a
malicious server could probably do quite a bit of bad if they put their
mind at it (perhaps a neverending directory listing or some other
metadata trickery), I wouldn't advise anyone to mount a storage they
don't trust.

-- 
Dominique

