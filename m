Return-Path: <linux-fsdevel+bounces-7002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1A081F89C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 14:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D69F1C22F69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 13:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644B9D51B;
	Thu, 28 Dec 2023 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="olpOk7MJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5777C8F1;
	Thu, 28 Dec 2023 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=j9i0nhxFkx3FmDjtnlisxkWdcJggHgh1gb4z0LASq0o=; b=olpOk7MJ+YWLK2gFanT1fLO1M3
	LclMnY7T7+VFALOAJ14ovJTgNDb/PxK2fPrDkm+/n00qBrFvxfcXeSq+Ysf9UHrejE809yzkidSqy
	JOs3POUWpGqFqFVzc0wFnalj+VAxKnXDtakwlMD9Aj6nOBcUS0bPYB7Rkp30dAjQpgtVcmey4QsaI
	876mzZQh1Rw8PsjbV7jVP8sgR6AJ6swBiSATL6tvG4znLRHDOrkGLU+5cc9g4BTu0/R2X9b+/w+ao
	UJf45o1KzgIdvxU9lZkV5WL0w1xpWz+Kh9VB+ogC/YP+hdU2IYahxauk8AhXmcucyTDefW0qB+rLK
	7rPrOdSg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rIq2o-00GsYr-1U;
	Thu, 28 Dec 2023 13:03:26 +0000
Date: Thu, 28 Dec 2023 05:03:26 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Kees Cook <keescook@chromium.org>, Iurii Zaikin <yzaikin@google.com>,
	Joel Granados <j.granados@samsung.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: remove struct ctl_path
Message-ID: <ZY1yHnBWOh/Y0aOo@bombadil.infradead.org>
References: <20231220-sysctl-paths-v1-1-e123e3e704db@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231220-sysctl-paths-v1-1-e123e3e704db@weissschuh.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Dec 20, 2023 at 10:23:35PM +0100, Thomas Weiﬂschuh wrote:
> All usages of this struct have been removed from the kernel tree.
> 
> The struct is still referenced by scripts/check-sysctl-docs but that
> script is broken anyways as it only supports the register_sysctl_paths()
> API and not the currently used register_sysctl() one.
> 
> Fixes: 0199849acd07 ("sysctl: remove register_sysctl_paths()")
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Patch applied and pushed, thanks!

  Luis

