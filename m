Return-Path: <linux-fsdevel+bounces-30454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B49D98B7E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7AC1C225D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 09:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A4619D082;
	Tue,  1 Oct 2024 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLn2SgHc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FDF19CCFC
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773539; cv=none; b=CtnWg8oSyvdomgMSrWl4Av6wFNUYhkfLLpUhfQeKUn0OzPmno09C/0kGx0VuM61EXIX+5jdlLqnTgaG+tIWJdyb+4pMBMnRVHzKjIocz1cKpy2hSour8j+ZaOzyJo1Ml4B1lGkcOuaPgmnl4ry/1jNqY7YN6aH/7KQkN1ts4C/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773539; c=relaxed/simple;
	bh=g5xAWbYCT3Oh/2Drts4QZWeeVyqqWM2zTlLmMFrLNLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qjeo3uEkX2dzSa+nk0zborpu+mF7UK8MAWPQsyzyjlJ4/J/VQtLSXcDVHVac0Lq5uTpkNEv3iPrFhOGftF6EhE3a++c7XQRIFQiczLurNeAdcsvG/rQc+4V9GP+prZagVOo/5T0b1/0azFHs188pkkFXGOxBAqZ3z8RWiUrfeEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLn2SgHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8E5C4CEC6;
	Tue,  1 Oct 2024 09:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727773538;
	bh=g5xAWbYCT3Oh/2Drts4QZWeeVyqqWM2zTlLmMFrLNLQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ZLn2SgHcTRamkbRJfXbw+8tBGRxcc2MVsRVER4RfZMP79PsL29XtWTS8eYowH1jZh
	 IAn4GPBnsIeUFJ+00zAF4wYmRuylw+sQ6Lx/380v6UEYb7ZKW/W50Q0EaUqSSOF1kz
	 yk9bOOmi2PLFeZHgXa+KOYPlrpB580KT4vM+VEhDBqaZXH3EYX43D2qcQ0cCRISqBG
	 1Iy4jwH0sFiLbtdxQ+vGdIaPN86lRNPA/hBh4A2HJ2c5+wshohQiVdUMbqz+0JaFpf
	 uhJ/Lj2M069D+mt18mi/m89NX7N3yGSskKGT6YNO2YyCBLi2uvBE2xt/poA7ITWR85
	 pU95NAxezHikw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs changes for 6.12-rc2
Date: Tue,  1 Oct 2024 18:05:37 +0900
Message-ID: <20241001090537.81713-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

Very late pull request for zonefs for 6.12 (with travels the last 2 weeks, I
completely forgot to send this in time). Given that this is a single one-liner
patch only, I hope it is OK as a "fix" pull request. If not, I will resend this
for 6.13. My apologies for this.

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.12-rc2

for you to fetch changes up to c4b3c1332f55c48785e6661cebeb7269a92a45fd:

  zonefs: add support for FS_IOC_GETFSSYSFSPATH (2024-08-20 17:46:54 +0900)

----------------------------------------------------------------
zonefs fixes for 6.12-rc2

 - Add support for the FS_IOC_GETFSSYSFSPATH ioctl.

----------------------------------------------------------------
Liao Chen (1):
      zonefs: add support for FS_IOC_GETFSSYSFSPATH

 fs/zonefs/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

