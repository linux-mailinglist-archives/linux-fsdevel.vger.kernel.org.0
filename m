Return-Path: <linux-fsdevel+bounces-46281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0F1A860EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3E11BA16CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C901F7575;
	Fri, 11 Apr 2025 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xowotmhu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32C81F541E;
	Fri, 11 Apr 2025 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382573; cv=none; b=PxfKjBd5xJ1Re4VTjBNmXifrcHsIg8OAS7Y7LFDnQK4ULumhwhInoNWCJfJrGrOgHTOaNWs4DJcxhVivEaSCj05cisFqQVIGlHMScUV1ZEDE3VUEVUIUnV0/ZIaqAx/26vwpFXsKUFlPay83HIu497m9Jh6SsxqyI96kcW2cXP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382573; c=relaxed/simple;
	bh=Qhdgpspww9P+Jj9zNZuY4/YmGo9aMreJ/ftse5s3mSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lq2cvvkKnSZcNvt32K2JJ73+vvLsPTrlRnQTzd9XD8iFAK2uz+ACZSe8+Wz1LL/pmJsC1S0AAkuADrtueOoaHVUrOZ8IzNKETXXLxcHwhWHR7G3DXEoQ7wXFDS4ml2rSnXnZG02T0YJAihS478xOR/gVcGvLjiEx+ot78tMxOb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xowotmhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364CBC4CEE2;
	Fri, 11 Apr 2025 14:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744382572;
	bh=Qhdgpspww9P+Jj9zNZuY4/YmGo9aMreJ/ftse5s3mSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XowotmhuKpsip3wj+Th0CNKqYSix20qVHRUtD9Hz2guHnz8k4FesFmI55Hl87V2/2
	 Sc5CYmvrIFplGJNbZ1SS12hIm+tfd16johDt0WZrLaCcpL1iCpujOdy4C7AADzH70V
	 lSbhESAsdeFP7XlrwowaJ/r2Gz6lHfSdaZqm8OCX8Hin0P78u44ICkSPOXPGcwdhQY
	 YXFLsLwkdg93ZBCLbrCBs7C5pOxCqp+5EFnLxEqKcFFB+5XC+RlUEAhcvi/zhpkgOU
	 3CqmQtQOor1qYM/zoM0/BISDMpq4QVEY+NB4ISWQmCEFiFx/wi59hjp7xT1ndRVZcQ
	 BipBQQ8a8kvmw==
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>,
	overlayfs <linux-unionfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] overlayfs fixes for 6.15-rc2
Date: Fri, 11 Apr 2025 16:42:43 +0200
Message-ID: <20250411-anflug-spediteur-cc399d1fa778@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <CAJfpegt-EE4RROKDXA3g5GxAYXQrWcLAL1TfTPK-=VmPC7U13g@mail.gmail.com>
References: <CAJfpegt-EE4RROKDXA3g5GxAYXQrWcLAL1TfTPK-=VmPC7U13g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=895; i=brauner@kernel.org; h=from:subject:message-id; bh=Qhdgpspww9P+Jj9zNZuY4/YmGo9aMreJ/ftse5s3mSc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/1EpP9suuu8SROVc8fvtEjuLZneuZ/FOP6pedLJwex hORuvh1RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES2ljMy7Ksuq9Z/ft1bbv52 iStvEvinvc/eqTlZ6OXqXgENvczWfkaG7bY25Uekft6yeXBIqP9Y5FmVa9xzDwVoZ6cevL360o6 /3AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 11 Apr 2025 10:28:05 +0200, Miklos Szeredi wrote:
> Please pull the following into your fixes branch:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
> tags/ovl-fixes-6.15-rc2
> 
> - Fix an missing check for no lowerdir if the datadir+ option was used
> 
> - Misc cleanup.
> 
> [...]

Pulled into the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series or pull request allowing us to
drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

https://git.kernel.org/vfs/vfs/c/e2aef868a8c3

