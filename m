Return-Path: <linux-fsdevel+bounces-76600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHxpJAYdhmmTJwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:55:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 352BF1009B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 17:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA6FD304DC8B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 16:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4503532F770;
	Fri,  6 Feb 2026 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2HaoUVY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7026322B80;
	Fri,  6 Feb 2026 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770396686; cv=none; b=F48rh5ADZAK/o3Q8yECvavVL4t7KmjuNGoQKvf21FUJQeGvSWAeQ63e7CYlc7uVTONch6L3ifY2l9v0Mn4RTBX4jt1o+nH+uS+TTFnA66o6Hly5I9Z9AGl/4rb1yvIRd3UIEhEVwyGOgu3XbGvTQOwhjrWOjTneork/o0ejYP/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770396686; c=relaxed/simple;
	bh=xG/cCU++Sba5ZTuPdfTINpWSIV4q6xp3x/karROvn1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5KpCksdfaPmTn6oW9SSYUv7gnZL6ukWOGtBg2AUrRhn9dRhYzm0RbTafHMguQ9QxWyk/vIAbLBfBlXps0gOfB8ISsKalcp7cDeac1niYdw3JTNSFOCO+mkAX4ExnokY0rJXcGzThqygxqusPWTMLxd5lkSdvV8yNlu5STUIJqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2HaoUVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BEFC2BCB2;
	Fri,  6 Feb 2026 16:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770396686;
	bh=xG/cCU++Sba5ZTuPdfTINpWSIV4q6xp3x/karROvn1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J2HaoUVYOPndsUpBQbOdbnAy7HkYB0Pzd96vS4P6yr1SafFJwVRy8eWFJ+zxVpOzL
	 cb+y8hBpzQ1tZun6FH5bpu0E2x7j1MrlalT5mMbDuHoOuoiP/EeWq/RQwT32zfBP54
	 Esk7G5E6tFe9MTKyTUVd1kPdB44RmXYQiMkFFr6EKxVPbk/FvJuSkFkIbzGhut7bKk
	 m2WKOYnFb7J8Br8C0UuE3eKOC6cOnA+T9rJvtral8aCBi8L+gvY4MKYduwmfxkTSG7
	 plRrV6FipUTI0DIwC045KOT6yapLjXW/v8K1SCiwpAR4p81PaACLXGWNt6fK+1esot
	 oaJwL5o7UajyQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 02/12 for v7.0] vfs initrd
Date: Fri,  6 Feb 2026 17:49:58 +0100
Message-ID: <20260206-vfs-initrd-v70-5b2e335bdce0@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206-vfs-v70-7df0b750d594@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3833; i=brauner@kernel.org; h=from:subject:message-id; bh=xG/cCU++Sba5ZTuPdfTINpWSIV4q6xp3x/karROvn1Y=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS2Se/c9stqjY3QLYUKwfmKNmwOPzaLHPDj90yWrntp8 fcSA69sRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET+fGRk6Ev9Kx7KFVl1MPl1 mKXl+6U+7H97o1X0zqrM3WkXPS17MiPDcoap2Wws4TN233iXtnjhvwCufKErdcYevtf3rX8zU0m UBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76600-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 352BF1009B0
X-Rspamd-Action: no action

Hey Linus,

/* Summary */

Remove classic initrd linuxrc support

  Remove the deprecated linuxrc-based initrd code path and related dead code.
  The linuxrc initrd path was deprecated in 2020 and this series completes its
  removal. If we see real-life regressions we'll revert.

  The core change removes handle_initrd() and init_linuxrc() — the entire flow
  that ran /linuxrc from an initrd, pivoted roots, and handed off to the real
  root filesystem. With that gone, initrd_load() becomes void (no longer
  short-circuits prepare_namespace()), rd_load_image() is simplified to always
  load /initrd.image instead of taking a path, and rd_load_disk() is deleted.
  The /proc/sys/kernel/real-root-dev sysctl and its backing variable are
  removed since they only existed for linuxrc to communicate the real root
  device back to the kernel. The no-op load_ramdisk= and prompt_ramdisk=
  parameters are dropped, and noinitrd and ramdisk_start= gain deprecation
  warnings.

  Initramfs is entirely unaffected. The non-linuxrc initrd path
  (root=/dev/ram0) is preserved but now carries a deprecation warning targeting
  January 2027 removal.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

diff --cc Documentation/admin-guide/kernel-parameters.txt
index aa0031108bc1,f67591615a6a..000000000000
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@@ -3472,13 -3437,6 +3472,11 @@@ Kernel parameter
                        If there are multiple matching configurations changing
                        the same attribute, the last one is used.

 +      liveupdate=     [KNL,EARLY]
 +                      Format: <bool>
 +                      Enable Live Update Orchestrator (LUO).
 +                      Default: off.
 +
-       load_ramdisk=   [RAM] [Deprecated]
-
        lockd.nlm_grace_period=P  [NFS] Assign grace period.
                        Format: <integer>

Merge conflicts with other trees
================================

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc1.initrd

for you to fetch changes up to ef12d0573a7f5e7a495e81d773ae5f3e98230cd4:

  Merge patch series "initrd: remove half of classic initrd support" (2026-01-12 17:22:27 +0100)

----------------------------------------------------------------
vfs-7.0-rc1.initrd

Please consider pulling these changes from the signed vfs-7.0-rc1.initrd tag.

Thanks!
Christian

----------------------------------------------------------------
Askar Safin (3):
      init: remove deprecated "load_ramdisk" and "prompt_ramdisk" command line parameters
      initrd: remove deprecated code path (linuxrc)
      init: remove /proc/sys/kernel/real-root-dev

Christian Brauner (1):
      Merge patch series "initrd: remove half of classic initrd support"

 Documentation/admin-guide/kernel-parameters.txt |  12 ++-
 Documentation/admin-guide/sysctl/kernel.rst     |   6 --
 arch/arm/configs/neponset_defconfig             |   2 +-
 include/linux/initrd.h                          |   2 -
 include/uapi/linux/sysctl.h                     |   1 -
 init/do_mounts.c                                |  11 +--
 init/do_mounts.h                                |  18 +---
 init/do_mounts_initrd.c                         | 107 ++----------------------
 init/do_mounts_rd.c                             |  24 +-----
 9 files changed, 23 insertions(+), 160 deletions(-)

