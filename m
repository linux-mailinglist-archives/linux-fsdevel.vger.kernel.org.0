Return-Path: <linux-fsdevel+bounces-6835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 771C981D4E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 16:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2EE1F221FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 15:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0080FC1D;
	Sat, 23 Dec 2023 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bii8R9Mq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED943DF5C;
	Sat, 23 Dec 2023 15:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0702C433C7;
	Sat, 23 Dec 2023 15:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703345656;
	bh=TQAtHtfyY5SOEXTBMr548AVub4xXZ+3Y7MAwfzf7KaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bii8R9Mqv6ZnIpA6eiJFaC0xPtd99hbGkytddNbV60T7RBBlvOeHX9kKTsi5AKpPJ
	 mg/u74N4XpGn90BnzoxK2jWeqfBHbkfvLeNgCvWqrQmJ0Gi54eyqkFu2lvafA1kL3o
	 CuwFZPZNJyFBSoszXuMfOIsvzVpgl71qlxHxMn5C6FRhqnv4vavhtlx+/w5EpOHPjT
	 y05popLssBes0f9XsnsWHw7xEJaSm9s+IVnhkeLGbx2ujlxBFr05gGP22YvXuPv5WF
	 OaRfIb/y9wGRWgSDhVhwiyZCeWaNdMhIYiYPQ9kdif8l8hhUYfe+K2sFz0srKhn1Lq
	 KRyukHBxV9PuA==
Date: Sat, 23 Dec 2023 09:34:11 -0600
From: Eric Biggers <ebiggers@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Alfred Piccioni <alpic@google.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Eric Paris <eparis@parisplace.org>,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
Message-ID: <20231223153411.GB901@quark.localdomain>
References: <20230906102557.3432236-1-alpic@google.com>
 <20231219090909.2827497-1-alpic@google.com>
 <CAHC9VhTpc7SD0t-5AJ49+b-FMTx1svDBQcR7j6c1rmREUNW7gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTpc7SD0t-5AJ49+b-FMTx1svDBQcR7j6c1rmREUNW7gg@mail.gmail.com>

On Fri, Dec 22, 2023 at 08:23:26PM -0500, Paul Moore wrote:
> 
> Is it considered valid for a native 64-bit task to use 32-bit
> FS_IO32_XXX flags?

No, that's not valid.

> If not, do we want to remove the FS_IO32_XXX flag
> checks in selinux_file_ioctl()?

I don't see any such flag checks in selinux_file_ioctl().

Is there something else you have in mind?

- Eric

