Return-Path: <linux-fsdevel+bounces-35556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFEE9D5D80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 11:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244FC2814AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 10:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39C81D7E4A;
	Fri, 22 Nov 2024 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPFJ0Jai"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552CA189F5A;
	Fri, 22 Nov 2024 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732272649; cv=none; b=NSBq1iC0ALH9Bt3FZnTGWHUNOAGhjj7jXHHpMG68GuPV5h1n7Sghh36O3BCa/dbirBc4W3YU5qS8cQ0tiwiuBGEUpG6Wt9SRqfwrCqwN9d3o76yK9EMFFhMz9McPLnciETZgltcTmz0GZ7jop5YkkWDkukNd5UPTCwauHscsvGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732272649; c=relaxed/simple;
	bh=XJ68kKpaNzVoIdXwNJKFRxflItoows7yxZiLs3I7YGM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tdNJM8NZEJWga2tSSbdteG5t5Os3TXaFp0qxsokHtL9M32fve+qFGx1jGAWD9+9Fkhhco6HpzSYa/DCJ9m/nsmgmW1fMkpdvSKkP2JvxGK9RD0gizFqmZDbh08/5Sb3PRiVBudRpX9PM7dLWzTrXcJLfJvdcRvn3JPJ3GStLOj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPFJ0Jai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDEBC4CECE;
	Fri, 22 Nov 2024 10:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732272648;
	bh=XJ68kKpaNzVoIdXwNJKFRxflItoows7yxZiLs3I7YGM=;
	h=Date:From:To:Cc:Subject:From;
	b=hPFJ0JaiNwiZHJs/yWSFucMTZEg2x4mdfGTztoLAm9iCTV9eznNAG0/fK2+og2wS6
	 DZiSPzMbMJTixpqkEbLkrPkbIIKjZkvQ2NtLMAtrx+6r1X/SLa1YuAO2TDgw3bA75N
	 Lhd6yH01JJtX94aTMCkUt2jkRb0/xOphUN7ubQc7L5ZRrRirub/EsPSBuIo/Av+saC
	 1Z/aSJxGNq8zpkileoG6+K4Nx/cIwBGkTIEV2UY3+5IpCyaZo59NtC+9rxn9tcWpl+
	 KE6sH5sT88GqZo4aqMGFJ0hFeCX6XsGyZlJ529PxOG87ig2TU5ggn80Yt022dlkPBv
	 F3Yb/iiDFiK1A==
Date: Fri, 22 Nov 2024 11:50:42 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas =?utf-8?B?V2Vp77+9c2NodWg=?= <linux@weissschuh.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Markus Elfring <elfring@users.sourceforge.net>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] sysctl changes for v6.13-rc1
Message-ID: <67lhgpay5opmjkgnhm7nnkhfhbzmlgp3bkwxap6nexzfb62mj5@fsr5p2aggmxt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus:

Please pull


The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-6.13-rc1

for you to fetch changes up to 9c738dae9534fbdf77c250132cba04e0822983b3:

  sysctl: Reduce dput(child) calls in proc_sys_fill_cache() (2024-10-31 11:39:55 +0100)

----------------------------------------------------------------
Summary

* sysctl ctl_table constification

  Constifying ctl_table structs prevents the modification of proc_handler
  function pointers. All ctl_table struct arguments are const qualified in the
  sysctl API in such a way that the ctl_table arrays being defined elsewhere
  and passed through sysctl can be constified one-by-one. We kick the
  constification off by qualifying user_table in kernel/ucount.c and expect all
  the ctl_tables to be constified in the coming releases.

* Misc fixes

  Adjust comments in two places to better reflect the code. Remove superfluous
  dput calls. Remove Luis from sysctl maintainership. Replace comments about
  holding a lock with calls to lockdep_assert_held.

* Testing

  All these went through 0-day and they have all been in linux-next for at
  least 1 month (since Oct-24). I also rand these through the sysctl selftest
  for x86_64.

----------------------------------------------------------------
Julia Lawall (1):
      sysctl: Reorganize kerneldoc parameter names

Luis Chamberlain (1):
      MAINTAINERS: remove me from sysctl

Markus Elfring (1):
      sysctl: Reduce dput(child) calls in proc_sys_fill_cache()

Thomas Weiﬂschuh (8):
      bpf: Constify ctl_table argument of filter function
      sysctl: move internal interfaces to const struct ctl_table
      sysctl: allow registration of const struct ctl_table
      sysctl: make internal ctl_tables const
      const_structs.checkpatch: add ctl_table
      sysctl: Convert locking comments to lockdep assertions
      sysctl: update comments to new registration APIs
      ucounts: constify sysctl table user_table

 MAINTAINERS                      |   1 -
 fs/proc/internal.h               |   2 +-
 fs/proc/proc_sysctl.c            | 113 +++++++++++++++++++++------------------
 include/linux/bpf-cgroup.h       |   2 +-
 include/linux/sysctl.h           |  18 +++----
 kernel/bpf/cgroup.c              |   2 +-
 kernel/sysctl.c                  |   1 -
 kernel/ucount.c                  |   2 +-
 scripts/const_structs.checkpatch |   1 +
 9 files changed, 73 insertions(+), 69 deletions(-)

-- 

Joel Granados

