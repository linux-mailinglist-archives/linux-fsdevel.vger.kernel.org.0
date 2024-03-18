Return-Path: <linux-fsdevel+bounces-14700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E6C87E2E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 06:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0D81F21A55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 05:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E76E20B12;
	Mon, 18 Mar 2024 05:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuzNvGQj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA3E3214;
	Mon, 18 Mar 2024 05:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710738145; cv=none; b=CBLo3jKO8K778GiPn3FyKKT/c/p0B1fdtTgo/kmyLjmiEhqXcTgBHDGzEZufFioZmh2NPNCi4/jh/SaTFaDguW+EYbAiA0L9KYl98oPzvzmdvPZl4Tz1eHj+3bmRTfp2qcJA4JvgKUKse5YVnpzEFigFZurdtTp0CKDNpR4omU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710738145; c=relaxed/simple;
	bh=53Mdn0WrM6/NWQCWpzAjopgkVEbfKnFFZNAXrHj9SoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NteGLMc+7nIfkVCVnjxT6Z+Z26F0Ze6g2xX6LfK2M/9IaX4EKzBi9zNFBU5kTXQ+MVWasmrRlaKm8GE9ejcuw894jCAvwQIbApWDPaVDpDgZT95PKhWmPiNfTY55ja7bK507B5YP8Htg4ajGDqFWgF1bc6Le24/4mw5Uyp+Dazs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuzNvGQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795E8C433F1;
	Mon, 18 Mar 2024 05:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710738145;
	bh=53Mdn0WrM6/NWQCWpzAjopgkVEbfKnFFZNAXrHj9SoA=;
	h=From:To:Cc:Subject:Date:From;
	b=TuzNvGQjl58cBE0Suz/eP8E1rlzrG3gAm6Kek9ZdE/eSU5QfZ9TFVL2dJnDarGh+f
	 gflNMLEYC1+7HUId1siSNFPRcN9sLdxS5gXW0wT+9yafyr31PASxEymIFtRjqtZR9A
	 GdmQy5PHNdMYj1YijGal81YC7e1qw15BI9WEK646kuXZ4pSoZGwE+qEb/VZdBY1RAQ
	 oHl3pUBSPQQweb+RT/qPjS9PYqJDo6NqQJ7XI2PZK899e3Rs8dZv/m84FhVOGq1dSK
	 SOMhsRgcpHlFSCvQmyQL3hiG84brbwgZPbMtpu5BJYppdl7r84OexMrFRIvazuzNt3
	 mYteYVrqXf7tA==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: chandanbabu@kernel.org
Cc: dchinner@redhat.com,djwong@kernel.org,hch@lst.de,linux-fsdevel@vger.kernel.org,linux-xfs@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to 0c6ca06aad84
Date: Mon, 18 Mar 2024 10:30:23 +0530
Message-ID: <87sf0ouo82.fsf@debian-BULLSEYE-live-builder-AMD64>
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

0c6ca06aad84 xfs: quota radix tree allocations need to be NOFS on insert

2 new commits:

Darrick J. Wong (1):
      [215b2bf72a05] xfs: fix dev_t usage in xmbuf tracepoints

Dave Chinner (1):
      [0c6ca06aad84] xfs: quota radix tree allocations need to be NOFS on insert

Code Diffstat:

 fs/xfs/xfs_buf_mem.c |  4 ++--
 fs/xfs/xfs_dquot.c   | 18 +++++++++++++-----
 fs/xfs/xfs_trace.h   |  9 +++++++--
 3 files changed, 22 insertions(+), 9 deletions(-)

