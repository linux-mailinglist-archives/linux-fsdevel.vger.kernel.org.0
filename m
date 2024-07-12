Return-Path: <linux-fsdevel+bounces-23608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8A892FBE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 15:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953CF282DD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 13:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602C517108E;
	Fri, 12 Jul 2024 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WC4QO9f7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5F716CD12;
	Fri, 12 Jul 2024 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792465; cv=none; b=Pqh0M8NcljrxK9d5oWi6j1wh2CDD9QrPiykAZhdrRUq/F8ssoEBkJcjLMtqalkWkPk05MWyuTo2hHW6KHJG+RNBkf2zWaggI8SPfLWeTLclokisfLppAcklE8VIlSv3ird2oKwjCrrVVXhRQUD5fVk/Pw7o21+n0uzkw3PPULU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792465; c=relaxed/simple;
	bh=ASb4uUl9onGaXi3ZmpTmuC3q3odAXqPBUXnZOxldlL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JavTVf43DMm2moIIlvdlwsN7B6hm7NAJp3NdSX2/WN/Zmbzm0sORvfkynNWaVLBaRl/pTEK2oOnuyGpx7+Z3jRp6IJURJVI5nfvYTf9jdplCuR0GVcKjHn7jBnlrcR2f47amKW7FAUpTln5gOsR/FMyWdfxwYGbCBJ2nm5RbXXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WC4QO9f7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B3FC32782;
	Fri, 12 Jul 2024 13:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720792465;
	bh=ASb4uUl9onGaXi3ZmpTmuC3q3odAXqPBUXnZOxldlL8=;
	h=From:To:Cc:Subject:Date:From;
	b=WC4QO9f7YCt/qaj32jNOn8fPq/WUQ+y4hZkJrJyK0+Xzge32SerQxQnv4ZmWGLKqY
	 mvq+Tvv6sy6FSczrNq4qkrMYRuDfZHfgEW1A3kFhpIBS9aDUGWvlEB16ZHNzff++EM
	 bIEyYg+uUCeOxiIvAURQJxbk6/I/0dpi9gs3j6dRKYOJUb0GvuxDPQxV+bxLz+Ajpa
	 3zOaxm1KwrHr6CJ6isNnYmGnu81FPhkzClZVsNaxNVQ+M6GTgcDx/ncSOy+klq8+DD
	 za/1VHEaewOtca0RPgOG8HkkqNGUWcwpp3kPMKSe5Mloxbp2Ak8EPb2miPwVnba/eB
	 k8TAojnJUcfGA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.11] vfs module descriptions
Date: Fri, 12 Jul 2024 15:54:15 +0200
Message-ID: <20240712-vfs-module-400367af1f9a@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3881; i=brauner@kernel.org; h=from:subject:message-id; bh=ASb4uUl9onGaXi3ZmpTmuC3q3odAXqPBUXnZOxldlL8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRNNO3MvFNnUrBwt7OvZtY7q0CdfKv0U4Jn1+hmf+kO7 D8hHVLSUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJEfSxn+Z3iU3l9yTHTZs8s/ Ui8HrMq6fiR7qbeFQ/FDnf0MpsX7NBgZHrlIuZtm7Ej+PNVxYrP3Ps1QphiePbl/qzU6mCWvnpR iAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains patches to add module descriptions to all modules under fs/
currently lacking them.

/* Testing */
clang: Debian clang version 16.0.6 (26)
gcc: (Debian 13.2.0-24)

All patches are based on v6.10-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
No known conflicts.

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.module.description

for you to fetch changes up to 807221c54db6bc696b65106b4ee76286e435944d:

  openpromfs: add missing MODULE_DESCRIPTION() macro (2024-06-20 09:46:01 +0200)

Please consider pulling these changes from the signed vfs-6.11.module.description tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.11.module.description

----------------------------------------------------------------
Jeff Johnson (13):
      fs: minix: add MODULE_DESCRIPTION()
      fs: efs: add MODULE_DESCRIPTION()
      fs: sysv: add MODULE_DESCRIPTION()
      qnx6: add MODULE_DESCRIPTION()
      qnx4: add MODULE_DESCRIPTION()
      fs: hpfs: add MODULE_DESCRIPTION()
      fs: hfs: add MODULE_DESCRIPTION()
      fs: cramfs: add MODULE_DESCRIPTION()
      fs: binfmt: add missing MODULE_DESCRIPTION() macros
      fs: fat: add missing MODULE_DESCRIPTION() macros
      fs: autofs: add MODULE_DESCRIPTION()
      fs: nls: add missing MODULE_DESCRIPTION() macros
      openpromfs: add missing MODULE_DESCRIPTION() macro

 fs/autofs/init.c        | 1 +
 fs/binfmt_misc.c        | 1 +
 fs/binfmt_script.c      | 1 +
 fs/cramfs/inode.c       | 1 +
 fs/efs/inode.c          | 1 +
 fs/fat/fat_test.c       | 1 +
 fs/fat/inode.c          | 1 +
 fs/hfs/super.c          | 1 +
 fs/hpfs/super.c         | 1 +
 fs/minix/inode.c        | 1 +
 fs/nls/mac-celtic.c     | 1 +
 fs/nls/mac-centeuro.c   | 1 +
 fs/nls/mac-croatian.c   | 1 +
 fs/nls/mac-cyrillic.c   | 1 +
 fs/nls/mac-gaelic.c     | 1 +
 fs/nls/mac-greek.c      | 1 +
 fs/nls/mac-iceland.c    | 1 +
 fs/nls/mac-inuit.c      | 1 +
 fs/nls/mac-roman.c      | 1 +
 fs/nls/mac-romanian.c   | 1 +
 fs/nls/mac-turkish.c    | 1 +
 fs/nls/nls_ascii.c      | 1 +
 fs/nls/nls_base.c       | 1 +
 fs/nls/nls_cp1250.c     | 1 +
 fs/nls/nls_cp1251.c     | 1 +
 fs/nls/nls_cp1255.c     | 1 +
 fs/nls/nls_cp437.c      | 1 +
 fs/nls/nls_cp737.c      | 1 +
 fs/nls/nls_cp775.c      | 1 +
 fs/nls/nls_cp850.c      | 1 +
 fs/nls/nls_cp852.c      | 1 +
 fs/nls/nls_cp855.c      | 1 +
 fs/nls/nls_cp857.c      | 1 +
 fs/nls/nls_cp860.c      | 1 +
 fs/nls/nls_cp861.c      | 1 +
 fs/nls/nls_cp862.c      | 1 +
 fs/nls/nls_cp863.c      | 1 +
 fs/nls/nls_cp864.c      | 1 +
 fs/nls/nls_cp865.c      | 1 +
 fs/nls/nls_cp866.c      | 1 +
 fs/nls/nls_cp869.c      | 1 +
 fs/nls/nls_cp874.c      | 1 +
 fs/nls/nls_cp932.c      | 1 +
 fs/nls/nls_cp936.c      | 1 +
 fs/nls/nls_cp949.c      | 1 +
 fs/nls/nls_cp950.c      | 1 +
 fs/nls/nls_euc-jp.c     | 1 +
 fs/nls/nls_iso8859-1.c  | 1 +
 fs/nls/nls_iso8859-13.c | 1 +
 fs/nls/nls_iso8859-14.c | 1 +
 fs/nls/nls_iso8859-15.c | 1 +
 fs/nls/nls_iso8859-2.c  | 1 +
 fs/nls/nls_iso8859-3.c  | 1 +
 fs/nls/nls_iso8859-4.c  | 1 +
 fs/nls/nls_iso8859-5.c  | 1 +
 fs/nls/nls_iso8859-6.c  | 1 +
 fs/nls/nls_iso8859-7.c  | 1 +
 fs/nls/nls_iso8859-9.c  | 1 +
 fs/nls/nls_koi8-r.c     | 1 +
 fs/nls/nls_koi8-ru.c    | 1 +
 fs/nls/nls_koi8-u.c     | 1 +
 fs/nls/nls_ucs2_utils.c | 1 +
 fs/nls/nls_utf8.c       | 1 +
 fs/openpromfs/inode.c   | 1 +
 fs/qnx4/inode.c         | 1 +
 fs/qnx6/inode.c         | 1 +
 fs/sysv/super.c         | 1 +
 67 files changed, 67 insertions(+)

