Return-Path: <linux-fsdevel+bounces-45036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62061A70809
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 18:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA26016BA07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 17:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4533261396;
	Tue, 25 Mar 2025 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJ2T5CwZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED3E42A96;
	Tue, 25 Mar 2025 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923327; cv=none; b=tcZ9AU67lUiML0PIWs08rRvUBPZ3RQLx19hfHc4xWa8xe7CCeaiyxx4r4S6gw4Ty2R2+osAZS4n7YlFoLtSEBJv4/au76FQWncr1fMTYSApG4LL79eKse9pOPBMEXhIwOPh0Y0HhxSONWEZlBaexCgZNS512OGMAfN/pQLq8d0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923327; c=relaxed/simple;
	bh=nzFJ6RQkVQu0YREAlMsXBrpOIrhfn/ssZhBuPOFAUjA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HmkwZ9yZDYE36RbSaM9/pRbykTOFeIrqrgFPvBhxbdW7xbQMtYUyb0ac8PvaGua0T0zhe/Ky7GPoi6BbT9NQQgf/bc7DKK1kmS1vJ6KbvnUVNsOWKjEbKWIEf3sdRObK4huB9p0OSdr4YmQvhj0Ozj+3oifWjvrUgAGU/4jablU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJ2T5CwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7E7C4CEE4;
	Tue, 25 Mar 2025 17:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742923326;
	bh=nzFJ6RQkVQu0YREAlMsXBrpOIrhfn/ssZhBuPOFAUjA=;
	h=Date:From:To:Cc:Subject:From;
	b=CJ2T5CwZJoDIGUXxwbh3PxJSjYEiXlXpOzYhc5eq+MwV8L2+/ehPZxV+DYdYAIShA
	 nOKKYpBq0RKKe5MgEbwg3bHmBaznL41pT7pS+iS8WKFd9RIV9I3mmFh4CNU4TcgpEV
	 /pczWanmqwdoZFoDgdta6LnWSCrztYQ3y+2lcLgR3Xs28yfPnbbXeT4fnDYjOCTeJB
	 jMZ3l7eB3gFzOGP42+Aj3qkT/1VraDcX7ZVRUEQ76Ht55lpwgFXBb/nOuWhIIBrLKa
	 FnNN8LMwHgZZY+DF3K1ImE7ohYeSyn0+kBsjMplmEWStMxqzcjGnVnAbvq3cRBHwy5
	 ldcwA2ZF8gJ0w==
Date: Tue, 25 Mar 2025 18:21:36 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Anna Schumaker <anna.schumaker@oracle.com>, 
	Bharadwaj Raju <bharadwaj.raju777@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Joel Granados <joel.granados@kernel.org>, Kaixiong Yu <yukaixiong@huawei.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Kees Cook <kees@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] sysctl changes for v6.15-rc1
Message-ID: <mmb5fqe6a3a7bdoeyeccfn4wafhzgbpsnowjhhj6jtnbdwv24r@73wpky2szbg6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-6.15-rc1

for you to fetch changes up to 29fa7d7934216e0a93102a930ef28e2a6ae852b1:

  selftests/sysctl: fix wording of help messages (2025-02-27 10:02:12 +0100)

----------------------------------------------------------------
Summary

* Move vm_table members out of kernel/sysctl.c

  All vm_table array members have moved to their respective subsystems leading
  to the removal of vm_table from kernel/sysctl.c. This increases modularity by
  placing the ctl_tables closer to where they are actually used and at the same
  time reducing the chances of merge conflicts in kernel/sysctl.c.

* ctl_table range fixes

  Replace the proc_handler function that checks variable ranges in
  coredump_sysctls and vdso_table with the one that actually uses the extra{1,2}
  pointers as min/max values. This tightens the range of the values that users
  can pass into the kernel effectively preventing {under,over}flows.

* Misc fixes

  Correct grammar errors and typos in test messages. Update sysctl files in
  MAINTAINERS. Constified and removed array size in declaration for
  alignment_tbl

* Testing

  - These have all been in linux-next for at least 1 month
  - They have gone through 0-day
  - Ran all these through sysctl selftests in x86_64

----------------------------------------------------------------
Bharadwaj Raju (1):
      selftests/sysctl: fix wording of help messages

Chandra Pratap (1):
      selftests: fix spelling/grammar errors in sysctl/sysctl.sh

Joel Granados (2):
      csky: Remove the size from alignment_tbl declaration
      MAINTAINERS: Update sysctl file list in MAINTAINERS

Kaixiong Yu (16):
      mm: vmstat: move sysctls to mm/vmstat.c
      mm: filemap: move sysctl to mm/filemap.c
      mm: swap: move sysctl to mm/swap.c
      mm: vmscan: move vmscan sysctls to mm/vmscan.c
      mm: util: move sysctls to mm/util.c
      mm: mmap: move sysctl to mm/mmap.c
      security: min_addr: move sysctl to security/min_addr.c
      mm: nommu: move sysctl to mm/nommu.c
      fs: fs-writeback: move sysctl to fs/fs-writeback.c
      fs: drop_caches: move sysctl to fs/drop_caches.c
      sunrpc: simplify rpcauth_cache_shrink_count()
      fs: dcache: move the sysctl to fs/dcache.c
      x86: vdso: move the sysctl to arch/x86/entry/vdso/vdso32-setup.c
      sh: vdso: move the sysctl to arch/sh/kernel/vsyscall/vsyscall.c
      sysctl: remove the vm_table
      sysctl: remove unneeded include

Nicolas Bouchinet (2):
      coredump: Fixes core_pipe_limit sysctl proc_handler
      sysctl: Fix underflow value setting risk in vm_table

 MAINTAINERS                              |   7 +-
 arch/csky/abiv1/alignment.c              |   2 +-
 arch/sh/kernel/vsyscall/vsyscall.c       |  21 +++
 arch/x86/entry/vdso/vdso32-setup.c       |  16 ++-
 fs/coredump.c                            |   4 +-
 fs/dcache.c                              |  21 ++-
 fs/drop_caches.c                         |  23 +++-
 fs/fs-writeback.c                        |  30 +++--
 include/linux/dcache.h                   |   7 +-
 include/linux/mm.h                       |  23 ----
 include/linux/mman.h                     |   2 -
 include/linux/swap.h                     |   9 --
 include/linux/vmstat.h                   |  11 --
 include/linux/writeback.h                |   4 -
 kernel/sysctl.c                          | 221 -------------------------------
 mm/filemap.c                             |  18 ++-
 mm/internal.h                            |  10 ++
 mm/mmap.c                                |  54 ++++++++
 mm/nommu.c                               |  15 ++-
 mm/swap.c                                |  16 ++-
 mm/swap.h                                |   1 +
 mm/util.c                                |  67 ++++++++--
 mm/vmscan.c                              |  23 ++++
 mm/vmstat.c                              |  44 +++++-
 net/sunrpc/auth.c                        |   2 +-
 security/min_addr.c                      |  11 ++
 tools/testing/selftests/sysctl/sysctl.sh |  10 +-
 27 files changed, 350 insertions(+), 322 deletions(-)

Best
-- 

Joel Granados

