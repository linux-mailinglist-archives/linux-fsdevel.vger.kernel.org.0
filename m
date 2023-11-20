Return-Path: <linux-fsdevel+bounces-3216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FD47F17A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 16:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC52BB21922
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 15:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386151DA36;
	Mon, 20 Nov 2023 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4BNIYSA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D631CF9C
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 15:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DC6C433C8;
	Mon, 20 Nov 2023 15:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700494954;
	bh=Ec52klbY35lJdHqfaeV6a8M0GtAsBsRL4qBkgpTYu+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I4BNIYSAr4Dj1MnxT6ZrYHnkn2DLnsVwMFFLu/qOVZTrPwc3qXzt/TImagFU9EIOf
	 2lLAbqYDTSgZBvWb9Ivy7i+Bq3S+qpc+U+dOsRMp1bvEz1WvKEx9r0v7hgMupwbaed
	 tnA3bJtClig9Zf1nYE0n+IQUKvS5STBqMFdzgaTQCMevLMJtASSYT6JqY+EkC5O5PR
	 E5MbusW2MuWZ4rswYEDOVu8lkeZc63FQK0rE6eo3eHi68nrV0QOss7FxN3YIQk78GW
	 w2Cx6hUW7HdiXZbNDG6wDjaF3CaXkledCdGoyOIyLoRnTPMqDSuFEc3OnUwXPTlOd9
	 rMmNTyQWShbIQ==
From: Christian Brauner <brauner@kernel.org>
To: YangXin <yx.0xffff@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: namei: Fix spelling mistake "Retuns" to "Returns"
Date: Mon, 20 Nov 2023 16:42:09 +0100
Message-ID: <20231120-sackgasse-umspielen-4487ee8910b0@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231118132136.3084-1-yx.0xffff@gmail.com>
References: <20231118132136.3084-1-yx.0xffff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; i=brauner@kernel.org; h=from:subject:message-id; bh=Ec52klbY35lJdHqfaeV6a8M0GtAsBsRL4qBkgpTYu+c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRG1wVabJobc/nyRJ0ivrt+1xaqmh259FvhxuXQt0sOc 219Vi2p0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRidYM/5MYTmuumVT67uhF L//LJW9udCg7urx58GfvjgTdws0sxm8YGVas29MpoPpgY7rqpzj9h8fEI7ofZe5aIiSrffXUrhI 9a34A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 18 Nov 2023 21:21:36 +0800, YangXin wrote:
> There are two spelling mistake in comments. Fix it.
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

[1/1] fs: namei: Fix spelling mistake "Retuns" to "Returns"
      https://git.kernel.org/vfs/vfs/c/136aef2de55c

