Return-Path: <linux-fsdevel+bounces-50310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3988FACABCB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 11:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48F6A7A54F8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE5720103A;
	Mon,  2 Jun 2025 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsW3D9D2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A5B1E32D5;
	Mon,  2 Jun 2025 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857475; cv=none; b=FbU9LeI05MRK+R2pI+ELp8sog9krw93UUEQ1ZlWueHSB7Xns6C2A5N0H4LrjZBoO86+WZlQQDEunYSatDhUKRMuwfvXVOfNb2gri7Ml9cFRRUE1MwPeggHmw+gzTC5CN0mcAQu7fiZ9VH22JD/esvRGMMULi7QzyjcpOtPiajdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857475; c=relaxed/simple;
	bh=Ku8Z0uwEL+JP5dU+wMkvW77sU9CsV6zZejCoPGfn1Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwV5+Ssdwkc5qRz/OXo38toRlN6bQlbXH29GAhX7Ot7dmLIrvNBgyKNEVBBqjZ+FzvACUEe8RA5sbHHL/Z8pzkvx53CAStVa7LU4AI1ZE0/O4Omac32xj8zFMkymKhcs/MiRnI4Va8s3mWVtqYEByRd/4BKh9h3uF1pvSQuqHUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsW3D9D2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C24BC4CEEB;
	Mon,  2 Jun 2025 09:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748857474;
	bh=Ku8Z0uwEL+JP5dU+wMkvW77sU9CsV6zZejCoPGfn1Dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VsW3D9D23VCaynChA+/KmUA1pZ2iiivTCCc3yQWi8PS2aRTOxab7bWV1VrMpv2lge
	 mIK+abLR+Id9c7sC1pz/T76McXXemoZBqjd6MK9ox7G2MYYJQgvUHibi5zhCRrW6pI
	 6laDODTqXzOG9oXxxSQV4vSrAYAiL+3If7viuQA3yg1VVLeON6E0zoeCWLLT7smvBR
	 7TICpBkO2Ip7RFh2QCTOid87lzngGFpfoTIzLGg/s+rVL9WY3eHX4G2TjCpA6rTtud
	 3ZfjjcSBecH4zUsk5JLy2fEgNDUkiCcBRgl46pl/8rRjTm1fMZW8O/g7uFoaRnavgK
	 YIeEn9+ULjMcA==
From: Christian Brauner <brauner@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] fs/read_write: Fix spelling typo
Date: Mon,  2 Jun 2025 11:44:20 +0200
Message-ID: <20250602-ziffer-anpreisen-6a220b0e9828@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250530173204.3611576-1-andriy.shevchenko@linux.intel.com>
References: <20250530173204.3611576-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=868; i=brauner@kernel.org; h=from:subject:message-id; bh=Ku8Z0uwEL+JP5dU+wMkvW77sU9CsV6zZejCoPGfn1Dc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTYFtVcv++2hYuNYdX296+ja7Ufhu3MO/if5/uvJt7/z W6zbu1r7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI61kM/3Q4ss9I7u8Kum2j vPzsLvP9sikmntner5bO9HDf/aXMLpKR4cFT0dWZP6sXdMavub6vYyunYc2FwpvlF4/sTuHe+kb /Fz8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 30 May 2025 20:32:04 +0300, Andy Shevchenko wrote:
> 'implemenation' --> 'implementation'.
> 
> 

Applied to the vfs-6.17.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.misc

[1/1] fs/read_write: Fix spelling typo
      https://git.kernel.org/vfs/vfs/c/28b65351df00

