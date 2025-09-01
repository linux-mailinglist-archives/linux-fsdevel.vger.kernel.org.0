Return-Path: <linux-fsdevel+bounces-59780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F305BB3E0BE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 12:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCDD1A8143E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 10:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700483043A6;
	Mon,  1 Sep 2025 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rx2GGagp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6DBEAC7
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724325; cv=none; b=Hf7CbyVMMV27AoYJ5q3dF7PLOhrc3P/uwIVJXXgnY+umlXYQm9c4pA7wGUFJY81yF7aYgjfOfBvPQIdBg0pQOhHch24/DwYIwIJtwIxgt2ehoxErNLkTdzfkmtQ+15sF4LikX82/zWij162aE0OGBwRREQvWgYWx3X2MOLtg3Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724325; c=relaxed/simple;
	bh=OCiva9jpjj7tvfNyKB9sgbbe+Kak3HzcGfbmPPShtC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPYEuFWupRcn/Y4tJd5MdZLU05YkvhW6Zy4ReN51z/GHCbYIACrv9SY6fuwzHJjEQM6COv+hyZVLK+dIfMHWmN5VQs+ZEmnKL5L+Qz0gvhJjOV0Xir4GUabcQbD0e87AVQ1i0PALpdmn7kbm8VR8RFXMKbEWjKKoEcIu0a2+o/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rx2GGagp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8434EC4CEF0;
	Mon,  1 Sep 2025 10:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756724325;
	bh=OCiva9jpjj7tvfNyKB9sgbbe+Kak3HzcGfbmPPShtC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rx2GGagppchqcM7uUy9Wq0JdnpZcs6mn7fYUgxvRznba2KYGKGahcnTI3vDVrnONs
	 LkOF2Ei0DIDgHsTWPEiYZKyrUbDz+YchfhkK0B/98TgsnfT4FolhKvIisrpyj/TvqA
	 wUv1oUEKnHQJRRUTTQ0A4Zil1bbee239goQUxhmxWpUt54YZTXBZgV9IK+BPEtxmCL
	 ECn/n9ggppJ6xzUbGM2ElZsvl2lPHEVJqUt+Zu3ugtSGeDutnplsMbt3S/yM0Em20j
	 y+IrOuikus/KbkDQHKNsuZupYSS65LmzUQGA0pG874iGFNcGv4bqEyw61Mx+jGVAIy
	 PDR7b046Letsw==
Date: Mon, 1 Sep 2025 12:58:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] fuse fixes for 6.17-rc5
Message-ID: <20250901-herab-kriterien-af69dd3deb76@brauner>
References: <CAJfpeguEVMMyw_zCb+hbOuSxdE2Z3Raw=SJsq=Y56Ae6dn2W3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpeguEVMMyw_zCb+hbOuSxdE2Z3Raw=SJsq=Y56Ae6dn2W3g@mail.gmail.com>

On Mon, Sep 01, 2025 at 12:30:09PM +0200, Miklos Szeredi wrote:
> Hi Christian,
> 
> Please pull from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
> tags/fuse-fixes-6.17-rc5

Pulled into vfs.fixes of the vfs/vfs.git tree.

Thank you!
Christian

