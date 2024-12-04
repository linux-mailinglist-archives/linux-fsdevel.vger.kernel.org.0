Return-Path: <linux-fsdevel+bounces-36406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D85559E37DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 11:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99657169705
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 10:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0C51B0F18;
	Wed,  4 Dec 2024 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmoigJ5g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4BE187555;
	Wed,  4 Dec 2024 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309317; cv=none; b=WPs1d600iDYW31OUwyfxSqC1FsJQe4AcSiVLhqLzKNzD0qPhFAIYQt+50S2z0Ct+bqxGShuShmz1Sp6QNKR90B+PizrD6okh5KEMpMPIOjYKsQcnd7qqJyPK7GSmSUDBB1FbMgzWASJfKmbWikDo/jhDF+kBVs6A2XxuyFUq5kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309317; c=relaxed/simple;
	bh=lPT5H7D7YN3MfncgvivZr/u25OyzzMmy1rZ9Kz4FsGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OuJOLvhlIQjZMnqnlGusfPREbBJKLjYo+P7wO2Dz4E8VQ07pdwxq8ba9+Sl3G3WjpR7vQWaf8Zs6cywALNuc5d4NT3GTqpNCN/4BiIa93OyDwomPdg4273k3wJEezUiQD/QMfFCeChDfgJV/HyR8z8a1/Jk5BuyVrYeMtu5xNYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmoigJ5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0F2C4CED1;
	Wed,  4 Dec 2024 10:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733309316;
	bh=lPT5H7D7YN3MfncgvivZr/u25OyzzMmy1rZ9Kz4FsGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cmoigJ5gupatu5Wch9WDLNQZTv9eG6w9qMcUdRQ4YR3qgjmJOItwZ8WE+MW7UiFBW
	 UMA7bHB8mm4VoTXyEFcQYgOC39T4xu2i2pyY94/P5DpRp6w4UCQGyipUGJyHTrw4q5
	 yeH9GzqukU5s71S10e1hmyhusGzLqOSP1isOfrx8IYsTvq+qz8nBKlmRiHpUaLpO6u
	 PjP/ANTQ2Z4IOjQU4QATMv8MMSVNtq8YZyvRptXomNkefaQ43caUql9cJG7h5GrtwZ
	 dtMNBRwsC8Y0fMs6E+9TlasP24b9/B1zDkvbk22AnsD/2wvf7TU5IVKqAZTjEVRkhm
	 QVD4/RrOnK2cg==
From: Christian Brauner <brauner@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: Fix typo in pnode.c
Date: Wed,  4 Dec 2024 11:48:08 +0100
Message-ID: <20241204-silbentrennung-wehrlos-53b670b31caa@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204081218.12141-1-zhujun2@cmss.chinamobile.com>
References: <20241204081218.12141-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=brauner@kernel.org; h=from:subject:message-id; bh=lPT5H7D7YN3MfncgvivZr/u25OyzzMmy1rZ9Kz4FsGw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQHGNdNKtp5OJmD/WCA665iZiv/T1rmJ1bMVzJMrFx+W 6X7co94RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwES27WRkWGs/8Xh1+eUFGd8W bXQ/t1vkssmBosc7Yu4vSlZ8/dZDQ57hn0YER87T2UI6Tae3cb3s3f9tQ+Py8BP8b05GLJFSWG4 XyQgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 04 Dec 2024 00:12:18 -0800, Zhu Jun wrote:
> The word 'accross' is wrong, so fix it.
> 
> 

Applied with additional fixes in that comment.

---

Applied to the vfs-6.14.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.misc

[1/1] fs: Fix typo in pnode.c
      https://git.kernel.org/vfs/vfs/c/4a11d534d9ae

