Return-Path: <linux-fsdevel+bounces-30940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC4598FF49
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 11:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C561C218C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 09:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD8F13D2A9;
	Fri,  4 Oct 2024 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jA3Ze55Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D88E13B7B3;
	Fri,  4 Oct 2024 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032725; cv=none; b=XFp/rLzqUslSGESNcrgjjrB+EbxyPTb1rBmwIqV4r9JDpcKMNmJ8OFl9IXUDmVRvzUFj/6rw9dkMc6wkPGHrt42vWg0D1VcaYUCLd8zTsPXK8JYxbhBf2alNYcwpMoLGsHrFsk/sWvT2S3JgLMxpIlF8LnBOXDcTR8Z4ouIwt2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032725; c=relaxed/simple;
	bh=Wx/PthyK7u37Dlo4XmAudCyVDraW/qj3CqiGEMo8BRM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k90OkaGX0gqagfB/2gGvSODs4dDsn7he2HKZaDKpQu7BKQcahPwQFKVrZeMGJcbDg8NghEz+zF1/7aRJ3UixS4SqyeZIAIw41VcC7ekXl9NFhO/HQBkEe/vXISgQ97C8pJ8GWWLz8bo4PSz4ujVOpPeDSPM2qkfxfq59HLICgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jA3Ze55Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2493C4CEC6;
	Fri,  4 Oct 2024 09:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728032725;
	bh=Wx/PthyK7u37Dlo4XmAudCyVDraW/qj3CqiGEMo8BRM=;
	h=Date:From:To:Cc:Subject:From;
	b=jA3Ze55QwjRAvIupcMpl/TtW8t3o8XdzAqVq1a0VSIF2KTB7IQwxB/lCxRfyOu9Wy
	 HNPBP5P43+KqGXFBErOKL+jHwwV2ymWiGCed+FroP7ruZjMZFRVexTlIL4K0UV2iSL
	 LMYxb0LvPppQ9cS03cxA50wCTyMFCyLls4VDdeEepToF8S8c1VPdrKzdyEKJUduWjI
	 H8ubyGPcdX7qpTeXyn3AV+zva2AFQWwvZDO5XJMu1SIZYkAWgpaUTZ9xVyQqBqEV+I
	 X50q2GhPnKUXuwFKHy3vmCxtZXDJ/ZgbteKpwEEc2PurDU389JS8DvzmC1KS32yed0
	 ESYcaqlRPaY9Q==
Date: Fri, 4 Oct 2024 11:05:18 +0200
From: Carlos Maiolino <cem@kernel.org>
To: linux-xfs@vger.kernel.org
Cc: cem@kerne.org, chandan.babu@oracle.com, chandanbabu@kernel.org, 
	dchinner@redhat.com, djwong@kernel.org, hch@infradead.org, hch@lst.de, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, ubizjak@gmail.com, yanzhen@vivo.com, 
	zhangzekun11@huawei.com
Subject: [ANNOUNCE] xfs-linux: for-next updated to fddb9740e775
Message-ID: <ljjtohz7moxjr6zrwc57gbzcjczuu5eb7anmtgv4waasubioi2@gowemfb2k3pa>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Subject: [ANNOUNCE] xfs-linux: for-next updated to fddb9740e775

Hi folks,

The for-next branch of the xfs-linux repository at:

	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the for-next branch is commit:

fddb9740e775 xfs: Use try_cmpxchg() in xlog_cil_insert_pcp_aggregate()

4 new commits:

Chandan Babu R (1):
      [c2790266d822] MAINTAINERS: add Carlos Maiolino as XFS release manager

Uros Bizjak (1):
      [fddb9740e775] xfs: Use try_cmpxchg() in xlog_cil_insert_pcp_aggregate()

Yan Zhen (1):
      [a52d631f3fe5] xfs: scrub: convert comma to semicolon

Zhang Zekun (1):
      [8a81fe8a3c7e] xfs: Remove empty declartion in header file

Code Diffstat:

 MAINTAINERS                  |  2 +-
 fs/xfs/scrub/ialloc_repair.c |  4 ++--
 fs/xfs/xfs_log.h             |  2 --
 fs/xfs/xfs_log_cil.c         | 11 ++++-------
 4 files changed, 7 insertions(+), 12 deletions(-)

