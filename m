Return-Path: <linux-fsdevel+bounces-9595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6021843267
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 02:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6522A1F271C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 01:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5978821353;
	Wed, 31 Jan 2024 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDcMV56L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD46210FB;
	Wed, 31 Jan 2024 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662825; cv=none; b=mmJHUBtLJJGhLSUsW5ZKKdrGNofGEeraxrH/cB3s6rJsRvqa7aSL41XHDdP2XWNLCxDGC5hgyg0AwAWK2IBUYoOcHGHDy9R9bylrqJvtaF8ACGZwTlTGx3BP22NEhMsDvwc9gbJdWpWQc/URRiFAVMuXIZIMndkdMDQ7dt09rTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662825; c=relaxed/simple;
	bh=ez1CGgenjsF/Is63/eP+yB/neTNt6mvPpFdWEtgf8HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/IkxALtgDa8cxQmuth0EPniekpeRZwfiPCb/kfxc5FqDUr6BASAiMFPzdGQEPgYPh1sZVdGRJSMDyE7fYAcUdSXhvFNLFi/ZaM/Otzj+AemWYC/kwO1syp+VyAL7PWCle7tOuv8TRPJVJfZ8Cc295Q1GPngWj8EEJymEYbKIfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDcMV56L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01E7C433F1;
	Wed, 31 Jan 2024 01:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706662825;
	bh=ez1CGgenjsF/Is63/eP+yB/neTNt6mvPpFdWEtgf8HA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GDcMV56LD9h33+lHXOcKL7fIZDvxwA7ZR8UVDBC72qFrvjNCeo9nWdHbKO2Wr0P2+
	 VUW2ei7W0/0Dxl6kGIC++iqr+CkZzAAV/7XJJ1C/gdIwemOf09VmwlSnPxcQUJXp9b
	 ZqQqqNTUXB+nZX0L8wEnYvKHazUv8EO+HE4yOuyVHNBt2518/UkROKd7sxmYg5Isx+
	 MMaohYtdfykriCEJ9w/xaeRTQOgApdYVr/3d7YA0ee1f/KYh2kwfhOjEuH4biZ7z82
	 oSPFS+d3Cu0UFh601y1/bH7qAXxtJEj9yfo3dMEjJRg5UThDvtKZVTJtjOQNqSGek4
	 Qdb/3mUUYXDBA==
Date: Tue, 30 Jan 2024 17:00:23 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	amir73il@gmail.com, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 07/12] libfs: Merge encrypted_ci_dentry_ops and
 ci_dentry_ops
Message-ID: <20240131010023.GE2020@sol.localdomain>
References: <20240129204330.32346-1-krisman@suse.de>
 <20240129204330.32346-8-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129204330.32346-8-krisman@suse.de>

On Mon, Jan 29, 2024 at 05:43:25PM -0300, Gabriel Krisman Bertazi wrote:
> In preparation to get case-insensitive dentry operations from
> sb->s_d_op again, use the same structure for case-insensitive
> filesystems with and without fscrypt.
> 
> This means that on a casefolded filesystem without fscrypt, we end up

Again, we shouldn't use the term "case-insensitive filesystem" (or casefolded
filesystem) when we actually mean "case-insensitive capable filesystem", or more
precisely "filesystem that supports case-insensitive directories".  Real
case-insensitive filesystems like FAT are not relevant here.

> Also, since the first fscrypt_d_revalidate will call d_set_always_valid for us

This is outdated.

- Eric

