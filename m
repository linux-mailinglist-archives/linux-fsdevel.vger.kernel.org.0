Return-Path: <linux-fsdevel+bounces-45934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAD8A7F7D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4028917953D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 08:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB10218ABD;
	Tue,  8 Apr 2025 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhknSs6E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1149514AD29;
	Tue,  8 Apr 2025 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744100940; cv=none; b=fvPtS7hy06TFtc/3g7Ls8yUObBYMMnFWmpzURH/L9eBm4//Gx1pS6/5KaMkpsGbgDYh67Zxj2pEF+AW2Xs1xqCcAFwDedVxdsGCiZvOGldrYI4a5sCyvIuelu7S4o02uZO72vc3oZw7DQyrw7J+Ryorc2aNtR8TGZozMn9RSOWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744100940; c=relaxed/simple;
	bh=w7YzOAdB0AOkzbLpklUzeIust3CO7A4mhXh1lMfhEJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqpdHW2ZJ7DZkc8oD691qjewejCakJ3aoa3LuCtJlWL0DpmSmu3gmv3mGz9rnLT7U05Biz3HKXx0q4aV/CPWnjwQ7RGLFMQ0/WIK9Tpp2h2MYyphS+dmd8fkHhb0owDNUjb/VZWfjcAn5cLKdeMjBRzkQ47uf0kE9Ond07AMTHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhknSs6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B00C4CEE5;
	Tue,  8 Apr 2025 08:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744100938;
	bh=w7YzOAdB0AOkzbLpklUzeIust3CO7A4mhXh1lMfhEJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LhknSs6E+fdSdb0lcGkLLfQebPRU0QL2bXUjeVQV2+g7EgA6iQ4bEo1aPTkoXkurF
	 vtEZt95OOFzG+6J/HGHm35zm5CE4Hqy6LDUitDSdGJgUEsFJTTbKQCTbwn8MxBPZxB
	 /orc79RWC/jPp6wLLDEl8Y7dhQUxFHpN6rjRVALv/eEVu51gZLmBVpG1j5/0vluC+k
	 E95TdOhatu57F8dDm9n9F27UeIsymfiE4cdfMFYDT9RJEtFZo0UXecugaBsqNR4kWf
	 hSdSVEchbhwJikPGdR6W5I1y6b9+E9MDZ45IujuJlPqvGgS4jpyQnFwM0F8Hhn9T2J
	 MnXaKXotDAHdQ==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/3] fs: sort out cosmetic differences between stat funcs and add predicts
Date: Tue,  8 Apr 2025 10:28:47 +0200
Message-ID: <20250408-mietwagen-gegeben-378f07e5ea14@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250406235806.1637000-1-mjguzik@gmail.com>
References: <20250406235806.1637000-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020; i=brauner@kernel.org; h=from:subject:message-id; bh=w7YzOAdB0AOkzbLpklUzeIust3CO7A4mhXh1lMfhEJc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR/uefa5p3bJ/SzvvGBy7fe//+jHrIJMh1x/SxmUniK7 VNxVKt6RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ4XjEyfJXh0LBqN643qEpc y7dj9+63d8ofbq7cEndD68bVTW128xkZlr6qX2CrPWXHXfPQ+0+0FLeyful55ZHj/eP/2pI0dhF xbgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 07 Apr 2025 01:58:04 +0200, Mateusz Guzik wrote:
> This is a nop, but I did verify asm improves.
> 
> 

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[1/3] fs: sort out cosmetic differences between stat funcs and add predicts
      https://git.kernel.org/vfs/vfs/c/eaec2cd1670d
[2/3] fs: predict not having to do anything in fdput()
      https://git.kernel.org/vfs/vfs/c/5f3e0b4a1f59

