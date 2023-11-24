Return-Path: <linux-fsdevel+bounces-3650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5237F6D37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 08:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B0FFB21133
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0DB8F65;
	Fri, 24 Nov 2023 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrAMS07s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F0B8F52
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 07:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F619C433C8;
	Fri, 24 Nov 2023 07:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700812346;
	bh=fzuJaQqn78iACdwzYRHNK1kg8mpai1WDIat+UyDxe1s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mrAMS07sfZ8Zv00roMdfyVe5lNoW9UnNlqNVQsOWUxLyMwj1hyloHZx2LZiY1eH1j
	 WWlxHDWPL8Yi3DO/AoNeFk6xvDTfBREk2YoaTnroC0oLU32By1bwwjwe9EYGtYycAL
	 xxLFB28VgnZLfAzxK1OzZy822Ot/tvquEmAQTxzYrVpjlY4vj7BKm0XLiIgGtyn2C+
	 mYIVcRuT0mtgB0SCQseibk5gCp+3+IzqGfGTYP1EqziKfq+8oq2x3Nb+9vSQGUngiw
	 bo1g2GVzCWK/4lGSBGMnNjw9nVAwa/wjfHr4CQQYCd8rmkEIJxqK5fgXzJj3nVSc7O
	 Y0faN64w9VimA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 0/4] mnt_idmapping: decouple from namespaces
Date: Fri, 24 Nov 2023 08:52:15 +0100
Message-ID: <20231124-lachen-anorak-4bd3f6a766e2@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122-vfs-mnt_idmap-v1-0-dae4abdde5bd@kernel.org>
References: <20231122-vfs-mnt_idmap-v1-0-dae4abdde5bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1502; i=brauner@kernel.org; h=from:subject:message-id; bh=fzuJaQqn78iACdwzYRHNK1kg8mpai1WDIat+UyDxe1s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQmhOm566W8339L1/3UYWP3X15lWXfEcm88fjd9xmun6 yZPfrLP7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIlzYjw633VmcONn5lt6su 3Ghtfe58J+9jmdsXWW5W+jaFPn1kmcLIsNF+qcakKTa//sQ/Y9t++030fOG3+/kKLnFe4dZ+6rG 7gQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 22 Nov 2023 13:44:36 +0100, Christian Brauner wrote:
> Hey,
> 
> This is a tiny series to fully decouple idmapped mounts from namespaces.
> We already have a dedicated type and nothing matters from a namespace
> apart from it's permissions. So just get rid of it. Also means we could
> extend this to allow changing of idmapping completely independent of
> namespaces in the future. There's no need to tie them that close
> together.
> 
> [...]

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

[1/4] mnt_idmapping: remove check_fsmapping()
      https://git.kernel.org/vfs/vfs/c/a4fd34a68d61
[2/4] mnt_idmapping: remove nop check
      https://git.kernel.org/vfs/vfs/c/b77a69e35261
[3/4] mnt_idmapping: decouple from namespaces
      https://git.kernel.org/vfs/vfs/c/cc8ac0ea8188
[4/4] fs: reformat idmapped mounts entry
      https://git.kernel.org/vfs/vfs/c/5c7b656ebb3b

