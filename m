Return-Path: <linux-fsdevel+bounces-12129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AD685B746
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 10:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1213B217BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A584F60881;
	Tue, 20 Feb 2024 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7pcmF76"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109BA604B1;
	Tue, 20 Feb 2024 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421122; cv=none; b=tujjscjLMh1hJ9157ALOoWREjlbZh7Jvxmew1jpu7D6sDOQJNwiKbyQgvNRV/M6bkEJwtq6rktm8YMb7tH6lupYBoe47lfCJHUTaOOljoqvcbQJ7YQfQIicnkZM/weaFqcVpKOgYJJ+cam6QATJDF7Qm6X1BybIkYLWqMzPThGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421122; c=relaxed/simple;
	bh=bnuFd1QRUEyv+W3wv1XgCrLia9XbR75ETipxWj4UVKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYgJiiVVx+UMYEmytitqWKFWMWyAnM/XxMjl5dBV64hQMoEHmqsME60yiOjo0327jFKpqluYlrW0qixhc292/8/2s0ZT6ZDj6KCy/NPfoWwOu+1/rsmDKzKH2AxWfKPnHBFmNPvs2qzj4jfMH1XFVlPatwLUCIjfhZsCWOpMxfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7pcmF76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F9AC43390;
	Tue, 20 Feb 2024 09:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708421121;
	bh=bnuFd1QRUEyv+W3wv1XgCrLia9XbR75ETipxWj4UVKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U7pcmF76j21Fnb9Sum8eSFeQlk5fdn1qhwhW76f4rJ+Wf95NnTyZFDXs+3xPQtEzW
	 v66py3Svs4myMhRgR7YY7zR4hfyhwI0KDL4PipKoOOZWtf2Tz5+GvzLwUF75fqZoCA
	 Ca/30qzJb7R0NjMASLBFMJDbubLy9KSwevZIEprh7Gy3A28Ft39PhEIBBCmTxX1cgr
	 9VEOwpesiJf7XPu4cteYNaTKLK9IoGqqkjUnB1mwavwaKkXx4seQV0w4NFjVy9ZfcY
	 Gd8SSOzPB7uCs2UoSj0Br7Q0Q4hd8DT/ONBdN+NMd2I3Q162eZSdWYnW+42jLx/R4h
	 Ei7NgEdB5RK+w==
From: Christian Brauner <brauner@kernel.org>
To: Li zeming <zeming@nfschina.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: =?utf-8?q?Re=3A_=5BPATCH=5D_libfs=3A_Remove_unnecessary_=E2=80=980?= =?utf-8?q?=E2=80=99_values_from_ret?=
Date: Tue, 20 Feb 2024 10:25:07 +0100
Message-ID: <20240220-locken-penibel-e4cff570c3cc@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220062030.114203-1-zeming@nfschina.com>
References: <20240220062030.114203-1-zeming@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=899; i=brauner@kernel.org; h=from:subject:message-id; bh=bnuFd1QRUEyv+W3wv1XgCrLia9XbR75ETipxWj4UVKw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaReyf8t56jHK3qTMZv1C9uSD055LX/4hadHbb7UksBgf CWQSzero5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKFEQy/mDZre2gm5VxfpJ+r d7fh0GKXifbnLlxqEDpvHWX9dEsqI8P/gBCPGYknF1ZYxuUZsxRsfJclEXD38s/co4p7+y+eil3 CAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 20 Feb 2024 14:20:30 +0800, Li zeming wrote:
> ret is assigned first, so it does not need to initialize the assignment.
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

[1/1] libfs: Remove unnecessary ‘0’ values from ret
      https://git.kernel.org/vfs/vfs/c/297ff2f5a0e4

