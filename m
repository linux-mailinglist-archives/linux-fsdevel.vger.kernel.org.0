Return-Path: <linux-fsdevel+bounces-31283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB1E9942E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 10:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9905F285968
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 08:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC751E2608;
	Tue,  8 Oct 2024 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wu6cZ8zo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BEB1E25FF;
	Tue,  8 Oct 2024 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376821; cv=none; b=RND40FzW9TZ+p1qJIgoxTGHIgijHUPnIMWYKO/vEg8ZVaKdtd7fMq3D2EHj6ipe7NZQaq5FbjK26LE9bgMD6Zn9IUU85SuntQAT50MADGq1/jMhp8Ukv3SVYq+G/5T5GnAyajXCAcnQBzGQQqA+04i14gJ86NkmE8P7ReYoK4ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376821; c=relaxed/simple;
	bh=3cz33KncOICKx7ShZ3NOisnnTTtr0HXZkt/kGfGqYz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYzqfBZqruL2sCrxwANCny3Tl3kcM+X1cBylyyEP2zRlc39ERmr1eHPdTOv+Ai9aQxKerqLPklvixAdkwiaxZCQqqIpepp5eQhjmvBe1liiLql/0YdJmwUo0UfwwPXerZ8QCTAXMBvIO67tSK4jZgGIpUV+OvVZABsGXGfVCly4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wu6cZ8zo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B696C4CEC7;
	Tue,  8 Oct 2024 08:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728376819;
	bh=3cz33KncOICKx7ShZ3NOisnnTTtr0HXZkt/kGfGqYz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wu6cZ8zoEh+73fXcVU7PUMHkpq+0MUC7AEFy64kKiULfleedGGAwVA7RG4Z351kpq
	 mpDqNNdpJZjvhsVqxR4M2L66KSi3M1a3KeALifan4s59S5UgBkvSMaGF6tsiGvUyUK
	 d2B1DFoCHxNA7jsjD0rAT7l1jF88p1VewwRhwWp/lDuS94ZPs40r0TJH/9Q9eMiHx/
	 nPXepKQykq6cX5BHTQtZG2fVd5ov/c1YNMaWPvE4w1zaqB971Y8HbRyJCS9mPBDzof
	 RXOakPW+RcE9HZKqjJdqGyZ+/BAf0vLM7rPmhG/TjADdb1jYdqog1yPX9PJOIDNATW
	 S6ve9sh4ZAFTA==
From: Christian Brauner <brauner@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] netfs: fix documentation build error
Date: Tue,  8 Oct 2024 10:40:09 +0200
Message-ID: <20241008-hosen-kulleraugen-5f9b8affb227@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <874j5nlu86.fsf@trenco.lwn.net>
References: <874j5nlu86.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1256; i=brauner@kernel.org; h=from:subject:message-id; bh=3cz33KncOICKx7ShZ3NOisnnTTtr0HXZkt/kGfGqYz4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSzvH/t7u0wZ4OfoOv7ZUYCUa39qyqiGE5aHJ64zaZ+5 Wv3o6f9OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSW8TI8Milg0eV9S/nA0vd Hb94wtUXJu189pO93NPGUeHApzPLTzEy3H9yXn7tl8kpT/rXLl5VrLR42ffeszcTt4bN56n6d4R jBT8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 07 Oct 2024 11:04:57 -0600, Jonathan Corbet wrote:
> Commit 86b374d061ee ("netfs: Remove fs/netfs/io.c") did what it said on the
> tin, but failed to remove the reference to fs/netfs/io.c from the
> documentation, leading to this docs build error:
> 
>   WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -sphinx-version 7.3.7 ./fs/netfs/io.c' failed with return code 1
> 
> Remove the offending kernel-doc line, making the docs build process a
> little happier.
> 
> [...]

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

[1/1] netfs: fix documentation build error
      https://git.kernel.org/vfs/vfs/c/368196e50194

