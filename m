Return-Path: <linux-fsdevel+bounces-20411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081178D2EC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 09:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA37285D47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 07:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3088E167DBB;
	Wed, 29 May 2024 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGPPCyzs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D60038F96;
	Wed, 29 May 2024 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968755; cv=none; b=NVZtz8ournNeXDhyph7NN3X6cGseCVJcH2q+OGxpubFqOy6GBienJx3mBNzcxXW6x7y1zJq0v6id3D02/JA/IlANESO0f3pF1a6bSo/3IS+F6po527V7WXRSZ2bgvLX5xeGLWxdfV8qYEZhP+rvp/dRx8H6f+pJsfXOYfHAdJlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968755; c=relaxed/simple;
	bh=CwmwE3Bwwqq+qF+BJH7iFpufE32KFVNoA+yw0gGGhOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3m/XAukw/jF6QBHCR9S1Rj7kyz/R9dEguZ/6zdd6Li8pZIxLfA0F3pw2nkot0W4xbU+sgRCtN9Kg95/DF9COQAQ8ZmQA5Q+p9bDZiJjs8OvraUe2Dq/KPAENQj+mJ6jdJdYXbCtsZZa3dQ943sxraMbjkdKR5xyLa7i6vmODXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGPPCyzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBFEC2BD10;
	Wed, 29 May 2024 07:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716968755;
	bh=CwmwE3Bwwqq+qF+BJH7iFpufE32KFVNoA+yw0gGGhOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGPPCyzsiMPXJA2IjrwefTa1HKplRceJ+rgi4CZiwysWm96diugbLLYvqeVS18V9U
	 ywJCLe1ygfdGMol4hxRVFIsTwb/22SoWYIMNM5la3x+0U7q2+cB9Yx9mxLiNkXbwrb
	 Y38neuN1HgeMDnggA4C4JuKoPo1sKF25MxYxYgYPDctunA1ubmuwOtndjE1FKrdQrO
	 Y6nwua5Ro5sB+4DOWUt57Z6lforBWEuh5h4umlMjwupBu94oZ9PipfE8OiwBRjme1P
	 LngWndvL+gsahCnet3AO8ZbHUeT8l1Z4tfrabhUvbkn0BxxkfacoXXxDx4MSBIyNKw
	 CI3J/seL5jHVg==
Date: Wed, 29 May 2024 09:45:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, 
	linux-fsdevel@vger.kernel.org, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] fs: autofs: add MODULE_DESCRIPTION()
Message-ID: <20240529-gesund-heerscharen-d811e424d9d3@brauner>
References: <20240527-md-fs-autofs-v1-1-e06db1951bd1@quicinc.com>
 <20240528-ausnimmt-leise-4feb91054db2@brauner>
 <20240528180346.GG2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240528180346.GG2118490@ZenIV>

On Tue, May 28, 2024 at 07:03:46PM +0100, Al Viro wrote:
> On Tue, May 28, 2024 at 01:39:03PM +0200, Christian Brauner wrote:
> > On Mon, 27 May 2024 12:22:16 -0700, Jeff Johnson wrote:
> > > Fix the 'make W=1' warning:
> > > WARNING: modpost: missing MODULE_DESCRIPTION() in fs/autofs/autofs4.o
> > > 
> > > 
> > 
> > Applied to the v6.10-rc1 branch of the vfs/vfs.git tree.
> > Patches in the v6.10-rc1 branch should appear in linux-next soon.
> > 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> > 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> > 
> > Note that commit hashes shown below are subject to change due to rebase,
> > trailer updates or similar. If in doubt, please check the listed branch.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: v6.10-rc1
> 
> *Ugh*

That was a bug in b4 which seems to have selected the wrong branch. The
is as I said elsewhere #vfs.module.description.

