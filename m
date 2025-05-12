Return-Path: <linux-fsdevel+bounces-48726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F51AB33B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B4716D6B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 09:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8E226562E;
	Mon, 12 May 2025 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWOGJDs/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA85266569
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042287; cv=none; b=ud1hDFaRh5dhtEBGdbLZoL4gutG9jZnI/jb+dMGdMigoD+fgCXmcQu46eqnqTawkZFpM78rr+I8ZNEV802/bdiIrfrKRLG0GpP8X4Jp/W3QvqmyEU2z2ghOKBl1rDdJPj0Qtp4Gz0wenz/n0uJblSvRiUsJWx5ZoTaW1MJsOuqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042287; c=relaxed/simple;
	bh=LuMCzwAdjJbwLhOs1chJPcMj4fiFEGc4+wR6grFq8ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ki+d9+IuZA1Jl1/gs73sS6kgHjyCsrDZiz6so+1fkNt5JqElQMIbQlkmRLf9aAMb8jSn2HEnA8+RyXaHaZIufWsMf49Co7FvKS21qC2L+9xZ/gokg2zEA3G9p8sUQdAKEzelEMEIVe6wi1awJwEmuhtORFHfExewpm7neeGfGoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWOGJDs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5CAC4CEE7;
	Mon, 12 May 2025 09:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747042286;
	bh=LuMCzwAdjJbwLhOs1chJPcMj4fiFEGc4+wR6grFq8ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VWOGJDs/7981H4T+83qRYNwCEUs9pjexVcs2L1zQIfc/u0ds3kQ+us2RXeC3WtxPJ
	 UZJ995Zb3n11LLjH06xjsaeAP4xnj26EaTGtDbDoLQkyHpGRCJU6bHXDcFY7dIEC5o
	 RNIZ6GZ6/hv6HhtfYeRHs2bpoWa4a24WuVPIHQgwVMGo3eH93//LJFIxpfRxz0CHJc
	 IzjW1JQyJpOV16ogj8KycwiV+9GAAaiFPWoFqVMq349qbFiUWx4kAsoltobK6hnker
	 RMpxFcocrBwEGRBJ4aWYeuJQh5J8WYj2M5hBtg1s3XT2yLoDhNYZXEMdVhP8mqisKo
	 9IGZau4WQi54g==
Date: Mon, 12 May 2025 11:31:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] selftests/fs/mount-notify: build with tools
 include dir
Message-ID: <20250512-peinlich-kondition-635792779f26@brauner>
References: <20250509133240.529330-1-amir73il@gmail.com>
 <20250509133240.529330-6-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250509133240.529330-6-amir73il@gmail.com>

On Fri, May 09, 2025 at 03:32:37PM +0200, Amir Goldstein wrote:
> Copy the fanotify uapi header files to the tools include dir
> and define __kernel_fsid_t to decouple dependency with headers_install
> and then remove the redundant re-definitions of fanotify macros.
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Love it.
Reviewed-by: Christian Brauner <brauner@kernel.org>

