Return-Path: <linux-fsdevel+bounces-56152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE54B141F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C346818C24F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 18:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8782D27585D;
	Mon, 28 Jul 2025 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SijdzzaZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53E222D9E9;
	Mon, 28 Jul 2025 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753727240; cv=none; b=a11C0uKqQj2qJO5CEhdW9cR1zD/Wvy2OvxfBjMvPMsKSDBmJXHwNp+ISohfAM4SwkKoigtT08uNtbesIKbDEMtiEYzY+x19TLmyEFJDWcPujGzCoUDCdXz7znLqPuTFM5KjHxB+Z4j2DgcS11oDmJPwq1MED7NN4bljK2lJa1gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753727240; c=relaxed/simple;
	bh=1KWvItJXFqD5wJqkCmSDFSqTtAe2bsLBE2QHCIAwAAw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BSTqFSY4k6os+pHVF6/rVY65ORTEVDir5jxhVqUkDWiRtOXkf5Am8f+Sji2+z1NdJVz20j0g5wf98B4f7k22mT3MQxHXnYW3KDZBqjf+0PoyUwYJhEUp05llKkPVdbywOdrxerXRbpBjUCjwbZPX2gwE22+urzJ8NIXV7H33T58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SijdzzaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8F3C4CEE7;
	Mon, 28 Jul 2025 18:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753727238;
	bh=1KWvItJXFqD5wJqkCmSDFSqTtAe2bsLBE2QHCIAwAAw=;
	h=Date:From:To:Cc:Subject:From;
	b=SijdzzaZD/FxmkUkct8cM5nNv8EUrBfusQMDmieOAMDfVguPZFiczkRIsQl7Fe2Ey
	 dg2VkwC9/EmLdtsyTLzugYoFkD6EEeW7E10tlmhiIVrxCMriPTefIYw0vk9/4zaZ5T
	 eofSw216aWzM65+lRUf8SK8CH2WN1Hf29q1cmerEIzVa2R+0xoxgmcisXKH2pdoXiZ
	 ovK3gsBuCN1dgZkjvjVWpPCEhwjyqnaveAiGK0iNtlSpj1Jr/tCUbZK+t+xUFcGAmJ
	 mcTuVrn1rqmog1QCKQNCJy8NjJPEhVgWixmdcaGz1FKfyq+7Qb4XrS9L29FvfUX+qD
	 0ZjMy+gppjKUA==
Date: Wed, 23 Jul 2025 13:34:52 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] sysctl changes for v6.17-rc1
Message-ID: <fyahheosszjhz7aacxuctcxvkiket3vwfhsg35fbk4tzieojpo@s33wyvjykkc4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="25ufpsxy7z3hbnyc"
Content-Disposition: inline


--25ufpsxy7z3hbnyc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus:

Sending the PR early as I'm on PTO next week.

I can make adjustments (if needed) at the end of the merge window as
I'll be back by then.

Best

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl.git sysctl-6.17-rc1

for you to fetch changes up to ffc137c5c195a7c2a0f3bdefd9bafa639ba5a430:

  docs: Downgrade arm64 & riscv from titles to comment (2025-07-23 11:57:05=
 +0200)

----------------------------------------------------------------
Summary

* Move sysctls out of the kern_table array

  This is the final move of ctl_tables into their respective subsystems. On=
ly 5
  (out of the original 50) will remain in kernel/sysctl.c file; these handle
  either sysctl or common arch variables.

  By decentralizing sysctl registrations, subsystem maintainers regain cont=
rol
  over their sysctl interfaces, improving maintainability and reducing the
  likelihood of merge conflicts.

* docs: Remove false positives from check-sysctl-docs

  Stopped falsely identifying sysctls as undocumented or unimplemented in t=
he
  check-sysctl-docs script. This script can now be used to automatically
  identify if documentation is missing.

* Testing

  All these have been in linux-next since rc3, giving them a solid 3 to 4 w=
eeks
  worth of testing. Additionally, sysctl selftests and kunit were also run
  locally on my x86_64

----------------------------------------------------------------
Joel Granados (23):
      module: Move modprobe_path and modules_disabled ctl_tables into the m=
odule subsys
      locking/rtmutex: Move max_lock_depth into rtmutex.c
      rcu: Move rcu_stall related sysctls into rcu/tree_stall.h
      mm: move randomize_va_space into memory.c
      parisc/power: Move soft-power into power.c
      fork: mv threads-max into kernel/fork.c
      Input: sysrq: mv sysrq into drivers/tty/sysrq.c
      sysctl: Move tainted ctl_table into kernel/panic.c
      sysctl: move cad_pid into kernel/pid.c
      sysctl: Move sysctl_panic_on_stackoverflow to kernel/panic.c
      sysctl: Remove (very) old file changelog
      sysctl: Remove superfluous includes from kernel/sysctl.c
      sysctl: Nixify sysctl.sh
      sysctl: Removed unused variable
      uevent: mv uevent_helper into kobject_uevent.c
      kernel/sys.c: Move overflow{uid,gid} sysctl into kernel/sys.c
      sysctl: rename kern_table -> sysctl_subsys_table
      docs: nixify check-sysctl-docs
      docs: Use skiplist when checking sysctl admin-guide
      docs: Add awk section for ucount sysctl entries
      docs: Remove colon from ctltable title in vm.rst
      docs: Replace spaces with tabs in check-sysctl-docs
      docs: Downgrade arm64 & riscv from titles to comment

 Documentation/admin-guide/sysctl/kernel.rst |  32 ++--
 Documentation/admin-guide/sysctl/vm.rst     |   8 +-
 drivers/parisc/power.c                      |  20 ++-
 drivers/tty/sysrq.c                         |  41 +++++
 include/linux/kmod.h                        |   3 -
 include/linux/module.h                      |   1 -
 include/linux/panic.h                       |   2 -
 include/linux/rtmutex.h                     |   2 +-
 include/linux/sysctl.h                      |   5 -
 kernel/fork.c                               |  20 ++-
 kernel/locking/rtmutex_api.c                |  18 ++
 kernel/module/internal.h                    |   3 +
 kernel/module/main.c                        |  30 +++-
 kernel/panic.c                              |  60 +++++++
 kernel/pid.c                                |  31 ++++
 kernel/rcu/tree_stall.h                     |  33 +++-
 kernel/sys.c                                |  29 +++
 kernel/sysctl.c                             | 270 +-----------------------=
----
 lib/kobject_uevent.c                        |  20 +++
 mm/memory.c                                 |  18 ++
 scripts/check-sysctl-docs                   | 184 ++++++++++---------
 tools/testing/selftests/sysctl/sysctl.sh    |   2 +-
 22 files changed, 445 insertions(+), 387 deletions(-)

--=20

Joel Granados

--25ufpsxy7z3hbnyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmiAyNwACgkQupfNUreW
QU9jqwwAj1PyNuUSHKuxgJVMGgW+0jSvvLSHP+idijtw2baDSFyLXbKvFwQixz+/
+KVncNEixQ0LhUntxSkkTjhtXcRZuiMXDeaKwH1D1NIsQdHQ5QhXAlG0c0gyTnHy
9picmusmvhBR427lmPz3jWiewRR1o+aATFEVeFdAocp7YeqUWDgKzgHK1Lm8LZE1
jqJrXeu/bNCXRPWrpAhrDDq7p1/LDJU8HkIk5BwJwBHcGVWi9BCD4XEJBScB7wQf
QtLVFjqqMfm4DIHojCn1pR6S1xsuScUMvSto2ZrArHG7o+s6vOT1EbArt+M0Yty8
8FQpAZqljkglcIsuTBhPUE91E4KVOYLFzMbIgKRCDBFI0z6oip89yPCQMOmmWmEI
/YlhINGuDq3QURgxu4dxFAKYsRrAu1987cEO6v5YQh3TIozrW1ARpNdC2cnp0abx
KFrr92BXys5G9aiiFbhqcgujPAOx2czXk0tLpQ2fDCqauSFTmBvOgQSSWq6iwuFD
eb/QEoHC
=TgYQ
-----END PGP SIGNATURE-----

--25ufpsxy7z3hbnyc--

