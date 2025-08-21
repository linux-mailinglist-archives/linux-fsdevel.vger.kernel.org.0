Return-Path: <linux-fsdevel+bounces-58584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDDBB2F235
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 10:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B476AA59DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 08:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E7A2EB5B0;
	Thu, 21 Aug 2025 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2pS1jnG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C3F2E88AB;
	Thu, 21 Aug 2025 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764881; cv=none; b=JhAqDQTUIESRr4ySjrNUeWAk11Opb5sOmb2TVU4dIuxL1mNXeyhKqsG349nxQfOJ0oMsK149CunbJRevvc7Kh7WdZp4gNy9h6VsxN2wfGPwEP3kkuTXFNFGb2NQhupz7Q7pQYrrL8UvCYqdNUTS64TRE0fUMotsz+xqMZKas3Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764881; c=relaxed/simple;
	bh=KmPFflUGGHgNKUpzXR9Rv2GkGs+cOyXwfBnp1iZo0jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrwV2Ed49wFP8emhxv7w7gE5SMugqMN3wEPipCJI8fjAYs3i0Imt7H2Zv03n6OihLAiLpg1rl/zB29VJJ145XuCG/EDmiC/8jsup40xE/hmUKyUk2RX//FM6ksEAKHInn4Ncw6WdJpt2387h+c2DYzuEdShz5gZ7VknagNLAeb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2pS1jnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6040C4CEEB;
	Thu, 21 Aug 2025 08:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755764880;
	bh=KmPFflUGGHgNKUpzXR9Rv2GkGs+cOyXwfBnp1iZo0jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2pS1jnGDI+htkKLDZiAuH5UtRY6PffoEozEGAxd+sMIgwzmFnmJ6Ye/CJjMkM+p+
	 kB4/VKWUY3Er5I1ULKrWfFMqmTBDAaMSrMIEkiHcwbUInT7u4o6IjK1ZF47/b1mBnz
	 8CBH9hINM2tHSUjdJKvVS2w4zhlGSkG4U6xXtZD/FMKfwkFa915L4q3VosFSb9q6t5
	 CxD81GyEcZ2eASxbVA1ozGsQZeSlQhY5+ZicuhFDvbtyq0fUGLcy1VJicTLdHC5wyi
	 g5RUDz97h8V2qp6+Hz2Mjir8OeJKPoJUJ5wVhmQmL6KFMRqiaG57ghWIaMrZ42Dc0r
	 rksUmxH+dJ7Lw==
From: Christian Brauner <brauner@kernel.org>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: Christian Brauner <brauner@kernel.org>,
	festevam@denx.de,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix indentation style
Date: Thu, 21 Aug 2025 10:27:50 +0200
Message-ID: <20250821-rangliste-gattung-31eb0838c6a1@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250820133424.1667467-1-zhangguopeng@kylinos.cn>
References: <20250820133424.1667467-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=876; i=brauner@kernel.org; h=from:subject:message-id; bh=KmPFflUGGHgNKUpzXR9Rv2GkGs+cOyXwfBnp1iZo0jU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQsu9ETvu7EJ3u5EofKma+PhKlcYHzrslPnI8/2mMZt0 ifsGxPPdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEYj3DH34f0YQLe/fM9Htw wiW5bvZD0YnlBdYhmzfdmjeHl3ct+xyG/xkZ0hZa2fsj8hNPRia13ym4vJR9hR6je5KSr/mu96c 5eAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 20 Aug 2025 21:34:24 +0800, Guopeng Zhang wrote:
> Replace 8 leading spaces with a tab to follow kernel coding style.
> 
> 

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs: fix indentation style
      https://git.kernel.org/vfs/vfs/c/41a86f62424a

