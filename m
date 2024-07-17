Return-Path: <linux-fsdevel+bounces-23885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 585E99344AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 00:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B1E1F2163C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 22:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B31948CCC;
	Wed, 17 Jul 2024 22:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/nbP4Zw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73CD1DA23;
	Wed, 17 Jul 2024 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721254531; cv=none; b=VWU0YGk0l3Dd06JU/XOF7boURtAl9idJgMBbX2KpAR6xzQNLKU4vFBDtTycpVWzgt3bsREoiVrd9uTvFrzEqHJ5E0h0H8FLcyds5HiGiVYIHbYUGqBbchCHic1cLXE+IByFodLKYvSJcNa5KBbHHMkOzG5VK00ukayo0HuuSHGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721254531; c=relaxed/simple;
	bh=EvXJfJ4LeK7Tz0VGq5kYpcvi1GgCtO7ZiVX5AIHsABY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ak9MljIhrvM1o7QMFov8LvgPtDME3ciNtNLN6+eNDEHBgLHDWJqzVzdAu5itqcmcJtI5lGpIH0vduvts2NMVtNS3kn+tIVIPW7cCAUGBCbd5ImeKPF8Q8l83dDqGWtlzKP31JN1xIe+GioYlcgzNHlrtMFOn+CJvPCcMKNV1T48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/nbP4Zw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392BCC2BD10;
	Wed, 17 Jul 2024 22:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721254531;
	bh=EvXJfJ4LeK7Tz0VGq5kYpcvi1GgCtO7ZiVX5AIHsABY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T/nbP4Zwr7nKg3wiEZJjCz/ppLC141EbXeuQJWJg4GYusCvTVxsfztzAPIopJU6W0
	 k5MAIQp7o3ChLk7d/Wgnu3HLtfcQF65cNNlNUNBvOnLuwqPKbCJfsGoFo6bUcsfHsh
	 xZgLKRz6g7nuWRc9zwClek914b9pKfhkiUUEPNM/eomfRPteSTc4CNfLw/WR6C8dBo
	 fHSCVSi+o6N1GNiPw4jP1mOSBKkBAJTuAumHmRDKVARt2U/K2SfuPuhrly9zxkbsC0
	 iJvmnpbXT/Ng0nujBWlkDiYYp4Q7l6cEd8e5ytdGfN2bt1m2A/hSFdxqrNwVug3yeN
	 VqA/B8FhS4ooQ==
Date: Wed, 17 Jul 2024 15:15:30 -0700
From: Kees Cook <kees@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Wen Yang <wen.yang@linux.dev>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] sysctl changes for v6.11-rc1
Message-ID: <202407171511.E11629EC@keescook>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717194620.mx7hbefl2pxd34rv@joelS2.panther.com>

On Wed, Jul 17, 2024 at 09:46:20PM +0200, Joel Granados wrote:
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
> > merge window once the sysctl and net trees land. Thomas Wei?schuh has
> > it at the ready. :)
> 
> Big fan of setting expectations :). thx for the comment.
> Do you (@kees/ @thomas) have any preference on how to send the treewide
> const patch? I have prepared wording for the pull request for when the
> time comes next week, but if any of you prefer to send it through
> another path different than sysctl, please let me know.

I don't have any preference. I can only speak to historical context for
other treewide changes: Linus has taken a PR, a raw patch, or just run a
script directly in the past, so any should work. I would guess that a
PR created from a script (that is reproduced in the commit log) is the
easiest, as Linus can either just take the PR or choose to run the
script himself.

-- 
Kees Cook

