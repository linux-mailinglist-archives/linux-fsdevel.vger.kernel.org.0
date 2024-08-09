Return-Path: <linux-fsdevel+bounces-25536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A38CE94D26D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 16:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D96D281BF2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 14:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B401922C9;
	Fri,  9 Aug 2024 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1AAKhGP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC5413FFC
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214796; cv=none; b=Frd3Q8645esFV2OG5RKzEowq/aBTrJjYJUUY8Xhvq2W4fRWVCoKNGTpMm3DcaMhwGpULVFH23ow6P+DwbWvv3dTrB5l/yNdNqWdwgddudKxiUokyB/K+6pMu0z46ZRQ6nxVbSofQ7u4h0rNRGZgBtRf5T5QTT8DIdYNWg6M+li4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214796; c=relaxed/simple;
	bh=T45co3eC2IX9HSD25zbMze1UZIgf1wMsSHxtZM5zjTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNfSfcxZRggCIgxog7jLK7qB40c+0zWmZ7dm/Od4yUVCfkV/u+5TK5VRlT2dCypFY7qlTIrDScS4FENHzVmQs8XnMyoJuojDsvWzUkazLbN8Wby8iC4G8RndmUSakvPhbhz/zFkdake1AZSomYCHVFePWW9T6nD7uIfbI96mw0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1AAKhGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBE1C32782;
	Fri,  9 Aug 2024 14:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723214796;
	bh=T45co3eC2IX9HSD25zbMze1UZIgf1wMsSHxtZM5zjTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1AAKhGP4NtA+Kz39F6PFwWFDf+AniyUKs+bFQY/a/lx12olAtoiS0j2obSzxm2cn
	 0CqJ6ewGDkAVnAskVAYz0WJ2gZj+v/a8Ty+GYSzkLzDFdvEH3NpIW1Pc/Sy2NqGXuH
	 W1J/FhqJf+aTf0Om82bgMYTqMRLKXvBScfzSexr8YwXf87T77ydzIlcjx2YYU8tpN3
	 NXXIdUQZHF0zlkzGaDGlLlNQhoBUEbNQ0uJIAP9ERkz1pweG9nMfWBEo366whS9Ao8
	 H78VwhhgsharyVMCD6khuPFfQ3qquPVYF+refxiOstuj3MHDfMXD5IO6AnR3jhGgsJ
	 XXSDqRFQeMQ4g==
From: Christian Brauner <brauner@kernel.org>
To: Mathias Krause <minipli@grsecurity.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] file: fix typo in take_fd() comment
Date: Fri,  9 Aug 2024 16:46:22 +0200
Message-ID: <20240809-ungefiltert-bauordnung-9d9e825b5a34@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809135035.748109-1-minipli@grsecurity.net>
References: <20240809135035.748109-1-minipli@grsecurity.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=913; i=brauner@kernel.org; h=from:subject:message-id; bh=T45co3eC2IX9HSD25zbMze1UZIgf1wMsSHxtZM5zjTI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRt0z4m0Bjgdjnc/9CKZOOXz/ts0ozVD37pbnz5+ZRQ/ O552Tf2dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEQoSR4Q9zXi3rh8zLcXuM XMofz5m98PiBj1LRmVq7vrIEd87YYMTI0HpFLHD5rZ6sKe/k3ONvt3xiPNVQtJBl3Rn5LzZHRR5 xcAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 09 Aug 2024 15:50:35 +0200, Mathias Krause wrote:
> The explanatory comment above take_fd() contains a typo, fix that to not
> confuse readers.
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

[1/1] file: fix typo in take_fd() comment
      https://git.kernel.org/vfs/vfs/c/5e486881d587

