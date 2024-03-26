Return-Path: <linux-fsdevel+bounces-15298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D302888BE9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 11:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE772E4EA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 10:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C26453809;
	Tue, 26 Mar 2024 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPFdDZIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D442D487B5;
	Tue, 26 Mar 2024 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447201; cv=none; b=jirR0mVvAKGEbt8yHziKmSKqUD3DDBLB/cPRYYK0kGVPHVaxzu05PoE5PtxdeeZHhTT9uBNmU5iI7dZgwp16n/7JM6tj1U0wUQQF5H7XmLtJkWahqCWgfLRLTuNwGhoEl8m/H2frx98/Qj02Y/DhX2/G1tCs3/IKwutrv9LALjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447201; c=relaxed/simple;
	bh=HoMtsd6kpZK9lAYbu1zZb5lFix7RDAFzZH7hSCnmvoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UgxFKuxMNlrFN5Ogau6UlW6DJfTpedoMnuMTKYNRrf2FOcSRbfUL1pnqKtzuExoteeOhLfY8nJk7KG912u/7Ba85FfN3KZxQur8mkVG8SHF1MtirowlWnHpZW5OM83pY/3CsOPArBcmO7m9sGeCuZsLKhAqDne6a6+PiBeByX7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPFdDZIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39CCC433F1;
	Tue, 26 Mar 2024 10:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711447201;
	bh=HoMtsd6kpZK9lAYbu1zZb5lFix7RDAFzZH7hSCnmvoY=;
	h=From:To:Cc:Subject:Date:From;
	b=pPFdDZIKeG/SJYijHM2h3NK+ISldVuaXj631WcWpgDI/ymibtBG2kZAlL7ap/L8mn
	 tWhEKbllW8ZBVXUJ24t5sdpcBJpp5LD3T7QfrxAS9crgbqS4C1pGB3StAJPUaw65Jk
	 IZa1jaWRLgpw3yJUiJdg33XsHkydyERrvNziUO+L+XxkvDO4VDxz4oXGHxytNbeDhb
	 7PxDvwVKfl2R21TCfbVMYl283ruLfqNSQKaqDS8NafhrbFRewClbqzTt/uekf2yagR
	 uA2zVH/IIl+dHy9dc+r2FhFR5l2+K3sgLJWwdzGAOb4Vjj/Whx2HuZa69f6Uf9kmxu
	 XdDRtejHF0ecg==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: dchinner@redhat.com,djwong@kernel.org,hch@lst.de,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org,mark.tinguely@oracle.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to f2e812c1522d
Date: Tue, 26 Mar 2024 15:28:01 +0530
Message-ID: <874jcte2jm.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi folks,

The for-next branch of the xfs-linux repository at:

	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the for-next branch is commit:

f2e812c1522d xfs: don't use current->journal_info

2 new commits:

Dave Chinner (2):
      [15922f5dbf51] xfs: allow sunit mount option to repair bad primary sb stripe values
      [f2e812c1522d] xfs: don't use current->journal_info

Code Diffstat:

 fs/xfs/libxfs/xfs_sb.c | 40 +++++++++++++++++++++++++++--------
 fs/xfs/libxfs/xfs_sb.h |  5 +++--
 fs/xfs/scrub/common.c  |  4 +---
 fs/xfs/xfs_aops.c      |  7 ------
 fs/xfs/xfs_icache.c    |  8 ++++---
 fs/xfs/xfs_trans.h     |  9 +-------
 6 files changed, 41 insertions(+), 32 deletions(-)

