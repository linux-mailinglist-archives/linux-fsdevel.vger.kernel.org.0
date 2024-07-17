Return-Path: <linux-fsdevel+bounces-23871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 583369342E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 22:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6167B21DA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 20:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE63518411C;
	Wed, 17 Jul 2024 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tf0zwRKF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBE51CF90;
	Wed, 17 Jul 2024 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246709; cv=none; b=iUnp5LnnP6gwg9AWxqxdfgUFqrAHBCfK3LJjIoToYnuJjaq7GWmu+bbcPO2h8pYAQ1a4StIPun+zzdRfp/cUSQRghhjzgwLgcire69kgDu+JsIiHHTEclH1xhLc98uZASWWUzwT1D1y/EgJGG3jp4GJXuGlzIHGL1Hzmrf+GrHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246709; c=relaxed/simple;
	bh=qAlWD4YMYB3VSt1kCmG7suBOjAE5drOR52luJRx8o0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3vm5bkzf42GydxR0OYMTeLu6MruhNZCBlWFcpB8IeqadG64ok6ao5V/KxSvnw3Wl18EURPOYPvPP/qpxmDvVdfSbNLlyl8mMHVoxJ76p96zM6pX7YGxXwQxek4WDQCTbV2TzZ+ExYBEA/SjhAFueKh+V3Ds51WTNNWiLlA1vTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tf0zwRKF; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1721246705;
	bh=qAlWD4YMYB3VSt1kCmG7suBOjAE5drOR52luJRx8o0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tf0zwRKFvOegZimTgdNNVsN+ynmoW4akgZoAliT1yrHov5VdGh2ncmf0YQk3kwQ3a
	 cQTnYZIE1FXXSbzwFNckGf0Pu01R4OV/eRk9MB9kHNIycfG9kDQgjOriMoSQLB6ZxN
	 TxI21G0boEpb5qXAL+JQLk1Ehznrk+5WSwtjQQNY=
Date: Wed, 17 Jul 2024 22:05:03 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Joel Granados <j.granados@samsung.com>
Cc: Kees Cook <kees@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, Wen Yang <wen.yang@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] sysctl changes for v6.11-rc1
Message-ID: <25decb62-201e-4202-9c3d-24eb2dfb7cce@t-8ch.de>
References: <CGME20240716141703eucas1p2f6ddaf91b7363dd893d37b9aa8987dc6@eucas1p2.samsung.com>
 <20240716141656.pvlrrnxziok2jwxt@joelS2.panther.com>
 <202407161108.48DCFCD7B7@keescook>
 <20240717194620.mx7hbefl2pxd34rv@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240717194620.mx7hbefl2pxd34rv@joelS2.panther.com>

On 2024-07-17 21:46:20+0000, Joel Granados wrote:
> On Tue, Jul 16, 2024 at 11:13:24AM -0700, Kees Cook wrote:
> > On Tue, Jul 16, 2024 at 04:16:56PM +0200, Joel Granados wrote:
> > > * Preparation patches for sysctl constification
> > > 
> > >     Constifying ctl_table structs prevents the modification of proc_handler
> > >     function pointers as they would reside in .rodata. The ctl_table arguments
> > >     in sysctl utility functions are const qualified in preparation for a future
> > >     treewide proc_handler argument constification commit.
> > 
> > And to add some additional context and expectation setting, the mechanical
> > treewide constification pull request is planned to be sent during this
> > merge window once the sysctl and net trees land. Thomas Weißschuh has
> > it at the ready. :)
> 
> Big fan of setting expectations :). thx for the comment.
> Do you (@kees/ @thomas) have any preference on how to send the treewide
> const patch? I have prepared wording for the pull request for when the
> time comes next week, but if any of you prefer to send it through
> another path different than sysctl, please let me know.

Sysctl sounds good to me.

Linus, if you are already interested in the upcoming patch and its
background:

https://lore.kernel.org/lkml/20240619-sysctl-const-handler-v2-1-e36d00707097@weissschuh.net/


Thomas

