Return-Path: <linux-fsdevel+bounces-6528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E0B8193EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 23:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E4F1F2720D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 22:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA053D0B6;
	Tue, 19 Dec 2023 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6zZn2z3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B222240BE2;
	Tue, 19 Dec 2023 22:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1D1C433C8;
	Tue, 19 Dec 2023 22:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703026512;
	bh=MW5t6/exIbCttjI/uoABa/B9xpu348NYEe4YO75s+Hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t6zZn2z3m7PdGkeWMUltfF2jJFqBL6orYuCfJw1xhZ7RA25lwXFH/1pVdS4up5/e8
	 4B1wnBM+QeQRGx3LWxmyq+L99bwdG5m4n/SOH7ysDpRzQWaSIS0RAPVM69MiAAgoOE
	 hlBhWcWmFDk4EwA61LrkLCzGCtnPBZ5/Am0i3qUA/0yFWhahY/K36uAvaydE/RRb46
	 kJxVzRlvDiWn/d78ZH3Gt/D6briDMOg4ITNVxWD6xuI0KfY261MHKf7Fexi0UUJLw9
	 5RcgKa05SvuogZjIhQX7mpGSbzHy+9xVQpOQ0kvKLwUjogXRJCIf+goh1SUfud+x2J
	 H3UzDIDFRZh7Q==
Date: Tue, 19 Dec 2023 15:55:09 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] libfs: Merge encrypted_ci_dentry_ops and
 ci_dentry_ops
Message-ID: <20231219225509.GE38652@quark.localdomain>
References: <20231215211608.6449-1-krisman@suse.de>
 <20231215211608.6449-4-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215211608.6449-4-krisman@suse.de>

On Fri, Dec 15, 2023 at 04:16:03PM -0500, Gabriel Krisman Bertazi wrote:
> +#if defined(CONFIG_FS_ENCRYPTION)
> +	.d_revalidate = fscrypt_d_revalidate,
> +#endif

#ifdef CONFIG_FS_ENCRYPTION, since it's a bool.

- Eric

