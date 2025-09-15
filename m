Return-Path: <linux-fsdevel+bounces-61356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B1DB57A27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273F51703D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3617A2FE597;
	Mon, 15 Sep 2025 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXd5bYKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909C5229B36;
	Mon, 15 Sep 2025 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938548; cv=none; b=I3e2+ARh2ieJi7NCXnr31LqL7FMAD45zj2c4i3Hk810aZoyvY9Z3UII7bZFoZsHRgzQIQg1ZztuTBua8i+O9Z47uBABiaLDWmi4lYp6vaSvwtOYLH2tuJLNyPda9GayfwEI7Cxebu7bQUevOZv2ASRF0CNuiPNVvxQ5/wZFK5H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938548; c=relaxed/simple;
	bh=Fvl8RWFVi9bPxKy0/e75BuIvTDftup+LKw8Plg+RNpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Onk2bMndTTmufR2Q7unIQu901gdmMTiQpi5Np2qL3aUKEbM9hxinebJGM1qk0oEdqHHIMzCq7PgdI57rzLoGiC66ntsj6/neteEyAYXd7NdVt4Xyj2cOqUypaVOSr3hR2rt2PtCnLyrlXDSkUc/AEHII9axLZ2RTC+dXRMz93uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXd5bYKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA017C4CEF7;
	Mon, 15 Sep 2025 12:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757938548;
	bh=Fvl8RWFVi9bPxKy0/e75BuIvTDftup+LKw8Plg+RNpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qXd5bYKaSWIEbofgI+9oeBlKjX4gu5fnRp1A2EYe2M8RydcGxImvO9TT7ZWWrhLju
	 5WtHs43GVJp9O2rTjFtFb2rUsfF+ex/hILKW44nPdHjpZGZXgBkmuInxx3p0fQeeVC
	 qzwogR1ha61JrgeHKn+CWVX1GW4FL2RFeuUhleqnRffNlPuTYWWjvzudJ6ck0S3Oj7
	 kHSIqYegYf/llML5eZWCQQGvUF0FMZAGswh6qHgV5gGPx3ZaMhZclNd3PNwulBinhr
	 kCJ+uDgUNCrCXu48d1yRtgShyN+neKnOmpZsOXi+mIxbVpKHDu0Jb55oKvDFFetC4M
	 iuk2Wc3ZZkc/A==
Date: Mon, 15 Sep 2025 14:15:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: expand dump_inode()
Message-ID: <20250915-meilenstein-simulation-7e220d91b339@brauner>
References: <20250909082613.1296550-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250909082613.1296550-1-mjguzik@gmail.com>

On Tue, Sep 09, 2025 at 10:26:13AM +0200, Mateusz Guzik wrote:
> This adds fs name and few fields from struct inode: i_mode, i_opflags,
> i_flags and i_state.
> 
> All values printed raw, no attempt to pretty-print anything.
> 
> Compile tested on for i386 and runtime tested on amd64.
> 
> Sample output:
> [   31.450263] VFS_WARN_ON_INODE("crap") encountered for inode ffff9b10837a3240
>                fs sockfs mode 140777 opflags c flags 0 state 100
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---

Applied to vfs-6.18.misc.

