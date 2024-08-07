Return-Path: <linux-fsdevel+bounces-25249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6B494A47D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 11:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9AD281761
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 09:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B30E1D1729;
	Wed,  7 Aug 2024 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1N7pxUV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9EA1CB320;
	Wed,  7 Aug 2024 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723023438; cv=none; b=Lz3e4DJv3IQy5YBb5+Q8GzdHF85YPsBjjuntl1wGPLs0V7XaGAjpXmJ1f5QM/aPRiuwBWhTpF6keTG7iJ4Cvi/Tjk+C2aygXdxZlAO012tI/0bthF8OgTXMVHC9VGeaP3lawXpOU4H5Ju8bs7xfDMbLoEqDd11UhAtD6rh56eZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723023438; c=relaxed/simple;
	bh=I8LCSMujmAqfFzBAvwIjUQzwzPViItRpq+du9KQ5tCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqK69ZTCGdgdzmGaexTxjQCi5WHHjqoJE2ajPnXJAEsVWl92cWNJJrriWbCD03FMD88h/a3s06SmFCMdV7vHdsvr3Y3jKzlCnwjllA3RNM/g0nDCwLWm8zMDMl3ho68GcSh1SpFwq796IhLKHNMN69s4Sos/Q/hZrIl6UkidA38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1N7pxUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E53C32782;
	Wed,  7 Aug 2024 09:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723023438;
	bh=I8LCSMujmAqfFzBAvwIjUQzwzPViItRpq+du9KQ5tCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D1N7pxUVqPXaNGF2EokLIgj7AHU+QZZgOq4m4S603vORtNum3if26eA9iKSENKGk5
	 +qTOiLW5K81Nb/Mdnd10jT0k8JK1VwJyBYoRnJMliSIqbtdQgRckM6WkpfA2Mv8YzX
	 DWA4UShvDLsfWsNAh2QvzeCIaXloKN4H/1NFhD+8vn5OKAFsaULAdYTQsxRgB7qLKR
	 nLt30dz39fM2+YtSH8QeeB7F2mdqKcbVBfcZpKPsn1AeYCjIzw2RLJIelb9nkRmXgL
	 Ru7ywulDseXSbIxWzIETgIPqMenJ7aP9lZOGgESt9ozThD/1I/FS97ETlvQheBYD6p
	 M/fXdtsYZFvMg==
From: Christian Brauner <brauner@kernel.org>
To: Xiaxi Shen <shenxiaxi26@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH] Fix spelling and gramatical errors
Date: Wed,  7 Aug 2024 11:37:08 +0200
Message-ID: <20240807-wahlgang-leihwagen-015803fd6257@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807070536.14536-1-shenxiaxi26@gmail.com>
References: <20240807070536.14536-1-shenxiaxi26@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=840; i=brauner@kernel.org; h=from:subject:message-id; bh=I8LCSMujmAqfFzBAvwIjUQzwzPViItRpq+du9KQ5tCE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRtdnAt1RYRnnDAWNbXrOB0uVvchaSYogYLixcGt2bId e7mSDnfUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJG22Qz/w6plvtbcscyrLMoP fy+Zu/rLjkWcZw03bowP2DS1Y8fFBkaGzcs44pO7f2q83qis1przpmz/j355mffrD5efsEqclbq RCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 07 Aug 2024 00:05:36 -0700, Xiaxi Shen wrote:
> Fixed 3 typos in design.rst
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] Fix spelling and gramatical errors
      https://git.kernel.org/vfs/vfs/c/9ba1824cc875

