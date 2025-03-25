Return-Path: <linux-fsdevel+bounces-45033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA27A7046B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 15:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8F8D7A2725
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E50625B682;
	Tue, 25 Mar 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THjc/2tX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17D6A2D;
	Tue, 25 Mar 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914752; cv=none; b=A5KMpQwLaAmvDnIjCmPpa2Wex43neZsQR/G2PMGj7Ps9rtVM9Samd186+C3hY+sTlClPHdPb09HbXHunMo+PBTFxWzD+EMa9+O6pdiL6lqJnxsB5jp457HwhO9lGQ+qPJH/LzX4TDdudQdkKVs01uOXKWaVI3ZmrySB8B2zn7+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914752; c=relaxed/simple;
	bh=GG0tU6LAS0IFpbXq1LKTAjBG2Gdzv1j6t3kcYYdww/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FH6UhMFgOIS8h3/k/aLAzAh3l/TbqcQEFu2szWm5ZWSUbvOmH9oX+1Zy4NuYtlTz34CF2tXmZy8+yLOuQ2lJ++OhuvVi36LfLIMSBlDC1Bl5gzehX0mbPVRIYxwq+UmeeGm3AUUlHaGUO8aB54MlQv1ukeopUXMYKa5lUfHOLdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THjc/2tX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21EEC4CEE4;
	Tue, 25 Mar 2025 14:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742914750;
	bh=GG0tU6LAS0IFpbXq1LKTAjBG2Gdzv1j6t3kcYYdww/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=THjc/2tXjglNxUVBg49jtkwvKg3Q6v6ExEDsXkormSA4o1E094osQbHG1L50sjLLN
	 l22BzJ8t7UVC2UrJoZLPg9zOiCWClpXJc+1MiZW2o8M2ZUwZ+sdfLn8ODLijRBmLyM
	 nbNwZ8QXS2rYaiLARjuJE1Y9KkqGCZJbzWWWUrchlrPN6rG+xnrURxCbSyHdA9OjgM
	 3zyemc6xcpwYS0I+6VPkrNZorSlFQVszix6P7NhomKeCSqwHPdWwOPAj+yQCsyOPFQ
	 iv05QgxhyTnDgDkHjkXbFrGnS0LQ5+8X4+QaHzpNrtncIZDoFmLPH83iA7RBEVJ+XS
	 V1vlOouXQ4TxQ==
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Amir Goldstein <amir73il@gmail.com>,
	NeilBrown <neil@brown.name>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: (subset) [PATCH 01/10] exportfs: add module description
Date: Tue, 25 Mar 2025 15:58:29 +0100
Message-ID: <20250325-typisch-absicht-8fd692d68fe6@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250324173242.1501003-1-arnd@kernel.org>
References: <20250324173242.1501003-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1092; i=brauner@kernel.org; h=from:subject:message-id; bh=GG0tU6LAS0IFpbXq1LKTAjBG2Gdzv1j6t3kcYYdww/0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/OrLL/f3quYkNWyV8ZiSd/XfmfJrdBb2wCZYP4n29h FU9JD6rdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE8CTDP3VWP6lba9iS9mut ubm85d4jVuMnpgLu2Q86Ij4KJV83DGf4wz3h3Vr5COGVnxsEDFav5Z9Tt9qWmcc7+GbgEq6F33e 85wMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 24 Mar 2025 18:32:26 +0100, Arnd Bergmann wrote:
> Every loadable module should have a description, to avoid a warning such as:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/exportfs/exportfs.o
> 
> 

I've removed mentioning of NFS from the module description because
exportfs is now used for a lot more.

---

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

[01/10] exportfs: add module description
        https://git.kernel.org/vfs/vfs/c/e3206c4aa06f

