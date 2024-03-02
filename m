Return-Path: <linux-fsdevel+bounces-13367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDBF86F082
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 14:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1891C20B91
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFE317574;
	Sat,  2 Mar 2024 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyXYz6GF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3584B7EC;
	Sat,  2 Mar 2024 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709385352; cv=none; b=Ktw3zJjvDeKXnJyv1cp/KpR6j+6ejiHt0AnePvbJRL3afpeMf2cdplMi4AhHYi8oIArtaWkW4NpQ+G7JsmzjPKioN1Pemr0YNUXDWbfAhSclQNHZrWG/wa9sb4osOl2Y2XXegQjlOOGUGD3TWLiNcPuRwETYwqS6X1CTp2R2LjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709385352; c=relaxed/simple;
	bh=UTru0EyJUpG0UwOlr1bMyWP7ILSq2jR/3Vr8JNynXew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jP4ZkPGNnzAuf4tf/e1YrmEsc9ZBMJeNrQN23GDV61eAm5Eh/oQZ39LE0r+YcXoMStwFp9i8Hu7D1YHIltwfZXWB46JLJTpTTHQSPqpjmvjB0N+9lIzGXnTOg3oa56z35j8DKp+MEkVc6aJrOGdLaeO3wbluDSWfN+eZzjFFJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyXYz6GF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A951C433C7;
	Sat,  2 Mar 2024 13:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709385351;
	bh=UTru0EyJUpG0UwOlr1bMyWP7ILSq2jR/3Vr8JNynXew=;
	h=From:To:Cc:Subject:Date:From;
	b=CyXYz6GFHqhiu2Ap1WdzIYfbtHXFLYxivO3E5O5BcPb7Yzvuevkjgr8RSWhwo9lF6
	 /m+BDSdHJDstFpzfTcH5wnxDC+No9GqN7+Er0Ph+iKzPu4NZYJWGzphUXu4wE6pmDB
	 IMAMnRiablzWdi7DLnsYxKLeDAYy7gc9sZmItV4ruGQvn/V3ngiBtahX5QIH5UkJb3
	 cg0lnFj7EQ88/aXKycDODZNeDFXvrOO08+ZpjZwySGhyCu0fk48TpcFgDJ8wLAPuB1
	 qJ03sUshExBFJ+V5Gtc/S/68uparD/sCetJQA0+o6XFSt4TPIBg/qltwgTBvU7v60i
	 10h91kfCcy41g==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org
Cc: chandanbabu@kernel.org,dan.j.williams@intel.com,djwong@kernel.org,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,ruansy.fnst@fujitsu.com
Subject: [GIT PULL] xfs: Code changes for 6.8
Date: Sat, 02 Mar 2024 18:27:36 +0530
Message-ID: <87sf184vwb.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Please pull this branch with changes for xfs for 6.8-rc7. The changes are
limited to just one patch where we drop experimental warning message when
mounting an xfs filesystem on an fsdax device. We now consider xfs on fsdax to
be stable.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts.  Please let me know if you encounter any
problems.

The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.8-fixes-4

for you to fetch changes up to 27c86d43bcdb97d00359702713bfff6c006f0d90:

  xfs: drop experimental warning for FSDAX (2024-02-27 09:53:30 +0530)

----------------------------------------------------------------
Changes for 6.8-rc7:

  * Drop experimental warning for FSDAX.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Shiyang Ruan (1):
      xfs: drop experimental warning for FSDAX

 fs/xfs/xfs_super.c | 1 -
 1 file changed, 1 deletion(-)

-- 
Chandan

