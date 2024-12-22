Return-Path: <linux-fsdevel+bounces-38005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF959FA52D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Dec 2024 11:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BC11664BD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Dec 2024 10:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E581898E9;
	Sun, 22 Dec 2024 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCFa/mcK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFA217A5A4
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Dec 2024 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734862225; cv=none; b=B/HweLAeIBIThP/5hJa9yovPjFJK45+a8+dTlY746Dvgk/U1BB0Yvc5IYbCr/YQv30jc64WB9lQ2NMXm5EpLH3NpdirtGIE6p1LMC0FpQaZ81ELk1JBu1Bq6PLwyfDj9/B932b2DxMcYh1JW0z1QnpJvsz6kpwY2a3tMP9pB+9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734862225; c=relaxed/simple;
	bh=G/f99pNtMhkH5XA/HtbFRgFYdEhaS+17mIFVVRc086s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zrj+AXBZYitWdCR/vyo6SxaYkFR32LBO85J81WCeEC0ka+huVRob6Y38zZHsi9Jk07rXzVIvi/70iMwy4udBlqNkLXM0n/zAwJjVf5APwR5/tvu49YqIt8vLeQykP2wTmVD2yojdLYA16bYSqqZvgkrKXz0DYa9EMPccPItkhGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCFa/mcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1173C4CECD;
	Sun, 22 Dec 2024 10:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734862224;
	bh=G/f99pNtMhkH5XA/HtbFRgFYdEhaS+17mIFVVRc086s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VCFa/mcKXhvADw3ybZyRYiUmXxs9DQuoSxOWGDI/XAuzFWMzw/9pNK3aYkyGLCs6/
	 T97H32YIXPBGq2jmf51QP4SRrCY/N396Lck5aXrL0Lpnl/mJRkyrwxiR5axc8WF7+E
	 TxSwqMecRfs4lkNS1fGsjePGQGRwXSeFMBDS+9Q5yuFt6NoPBHI3XBfwznYwPyL/ky
	 lJM94UEPsq8kKD8JiTJ5Wb7FGSzwVj7kklNU/4R8f2riswqfa5ABiInZub97oFSx61
	 apv3rSeUynse5/+/Ar5me9A3Q4IzSpe2IWi9B29EDs1Wqc3+0FanJIklftzalU2svm
	 iIM2QW0aGmMrg==
Date: Sun, 22 Dec 2024 11:10:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: PR aggregation for fuse
Message-ID: <20241222-shoppen-video-87403263f607@brauner>
References: <CAJfpegt1Z3RLGT_hozYp96+rxB8dsmJ_jUU3cUBnfqSGAR3MKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegt1Z3RLGT_hozYp96+rxB8dsmJ_jUU3cUBnfqSGAR3MKA@mail.gmail.com>

On Thu, Dec 19, 2024 at 03:36:39PM +0100, Miklos Szeredi wrote:
> Hi Christian,
> 
> Would you be willing to take fuse PR's and send them with other
> changes to Linus?

Hey Miklos,

Sorry for the delay! Thanks for the trust! And yes, I'm happy to do
this. The format for feature branches I nowadays usually use is:

vfs-<major>.<minor>.<topic>

So for fuse we'd have:

vfs-6.14.fuse

for this cycle and vfs-6.15.fuse for the next one etc pp. This has
worked well so far and it's easy for people to figure out what branch to
monitor for upcoming changes.

Christian

