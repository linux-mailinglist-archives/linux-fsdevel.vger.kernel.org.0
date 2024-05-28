Return-Path: <linux-fsdevel+bounces-20343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 305E18D19D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 13:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619AF1C21790
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 11:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE9016C87B;
	Tue, 28 May 2024 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX8slS2y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C67716C6B1;
	Tue, 28 May 2024 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896369; cv=none; b=R9mJAYQcM804DOxFPc16Oq8r0DUAcG35ouJAFa7kTtvLeB30NZzZzpOC5+b5rF/Orz2Oj4UY4wOrV887m+vBKTtcTNiwGrjbfK8jD2x8QxEnDW9hyt3mcl+9EnKlMBMuCdN0rcjQ5kE+HTVzpr2dQ/AQgBsp18ug6Efykyvo+pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896369; c=relaxed/simple;
	bh=G717kZ3GlAFRjBo95YsZ6259IX83RnHKDLX49SWlhEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEMmT/aK00LcIwoBHqjHRuRCiuFofQBu3ja/eAFVKe/xmZiH18Hf/yjmNVpGKiPA3OZJGDT7SMa/6D5h9siETeJR4+HvVVXiQwK4Al1pEDp1qfCh1LX6vEgTfJNZq2CRbbkxtRHUO+7PoBobki06gKWwFW8n8aRGpqx8yUOwpHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX8slS2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCB4C3277B;
	Tue, 28 May 2024 11:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716896368;
	bh=G717kZ3GlAFRjBo95YsZ6259IX83RnHKDLX49SWlhEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bX8slS2yQ+Bafw2t3X92kwBGNMxFIf2DY52pjJmO5FwwGtA75ATyz1ALnHJ8yBsQs
	 NhQ/a1VbyjARY5ASB+CR+ZLzZ+Mbezp7GLV9iHjUdbvFMaiyrK3lPO6SyEF9kHooZi
	 wdbeKs5H7iqbz9hVAfAtH0/5kIlHw8rkxPjWuOvNCZ+IIieHYBrVn4HZs539jWxNOW
	 wHOuorDMwWHKeuUudqzDQ6eUphJr5rScxh6AK37ZWWb9pSfob4Vzx6Ezt3qbfpomVT
	 bv8eraWASVjfPBRdjs7wHn0serAZHcWP0tIdpHrd4NEqfvjlxkYdOSgHDHoGenLi5m
	 lKUtWZBg24ckg==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	autofs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: autofs: add MODULE_DESCRIPTION()
Date: Tue, 28 May 2024 13:39:03 +0200
Message-ID: <20240528-ausnimmt-leise-4feb91054db2@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527-md-fs-autofs-v1-1-e06db1951bd1@quicinc.com>
References: <20240527-md-fs-autofs-v1-1-e06db1951bd1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=920; i=brauner@kernel.org; h=from:subject:message-id; bh=G717kZ3GlAFRjBo95YsZ6259IX83RnHKDLX49SWlhEU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSFHko40Lq58vmrFW5vjsqJ+TUCZYwc3Xo4vqbtW/mS/ Vp9v01HKQuDGBeDrJgii0O7Sbjccp6KzUaZGjBzWJlAhjBwcQrARBZ5MTLsvmuS9z6+22B+7/ek SsVr0fKTq93jktUez7r0U06l3uIoI8Ova9x7hDomNaxUXiT5421EUeaSptOphw59OmTTEuRzZQ8 fAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 27 May 2024 12:22:16 -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/autofs/autofs4.o
> 
> 

Applied to the v6.10-rc1 branch of the vfs/vfs.git tree.
Patches in the v6.10-rc1 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: v6.10-rc1

[1/1] fs: autofs: add MODULE_DESCRIPTION()
      https://git.kernel.org/vfs/vfs/c/5478ce951be8

