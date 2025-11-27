Return-Path: <linux-fsdevel+bounces-69988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 403BBC8D6CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 10:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A2474E32C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB53F3218B2;
	Thu, 27 Nov 2025 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9tMajOn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C80D19F12A;
	Thu, 27 Nov 2025 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764234031; cv=none; b=oKYiqrsaHvQYfqPtrjbHC4M2LjJLEKvHo9YHcdwOnMGcFfO90gVA/N8Qqe/t0uwz3LcGisDZUMLbxYRSBFr0Jd1zB+ei8TaucSR5NTvfYPcg/DUnOkrjQRgsbYRL4MNK6PV0NjgrrsfdlbxlbED0WVupiDe+WCNXJRWrNQe2cyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764234031; c=relaxed/simple;
	bh=bpSipelR/1YEqlqcLMWKFUqZSg9SEz1NShBJ4JR62oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXifd9S86WG6qsNwYUyJa4RRyJAzYqYqUax3SOEm21jTUIOzlIrSOg/IoGx0Ntsv5ugY3xmCYhl3eHqrkQwrEPdZLQbj7e79GMSQ8uiC18Wpndm64DvnDnafwWU5gjHLlw0aMDozE/P+AtOFup/6MJu1eMZk6nbOm+/l3EbIC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9tMajOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA04C4CEF8;
	Thu, 27 Nov 2025 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764234030;
	bh=bpSipelR/1YEqlqcLMWKFUqZSg9SEz1NShBJ4JR62oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y9tMajOnARIfwiayf33J9setDujAzYjAVd615z7s4Qn/JUiK7vz+uPfz+pR8q2o7j
	 NCQ8REIZo7tBKaks8df7o8lhI/4g9pRxLm+oHwOUu/CSkKhZA4atuiUbf6prUo5U1Q
	 4UUlQ3sgaD9oD76qFeLeYvO1Gipm4JIQsW7XFzbazPizEcN+Rv8EO2bkl/3NE5udKP
	 +TiBjP/TZfdMHKTmmHU/fIlpI6oSH1kIWahHtu9XvnhyOOv5UhFU8hYM3y8RNGopRZ
	 gDMFZMMPBpE8LWwfy6MwAJ7MPX980uWH1lYnyqKbWHAcpoTSGIGSIpXI8xHyWEimD3
	 BCHdcJ5xB9unw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	German Maglione <gmaglione@redhat.com>,
	linux-kernel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: add German Maglione as virtiofs co-maintainer
Date: Thu, 27 Nov 2025 10:00:24 +0100
Message-ID: <20251127-neigung-sofern-3b179c7bcf5f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251126211548.598469-1-stefanha@redhat.com>
References: <20251126211548.598469-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=brauner@kernel.org; h=from:subject:message-id; bh=bpSipelR/1YEqlqcLMWKFUqZSg9SEz1NShBJ4JR62oY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqCGtylYmKH9oWkWDhZHRCzVi5O4P50M8oa9MlejcOK 37aYNPZUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJGLhowMsz/xHdYx+BVv94Rh Z+3OBSUT5vZdLLl/6N2j5evN3l08ZcjwP7DaINZzfuG1lU78Liv/Lv4gUf9xkuRykzcpi357ZUt cYQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 26 Nov 2025 16:15:48 -0500, Stefan Hajnoczi wrote:
> German Maglione is a co-maintainer of the virtiofsd userspace device
> implementation (https://gitlab.com/virtio-fs/virtiofsd) and is currently
> one of the most active virtiofs developers outside the kernel.
> 
> I have not worked on virtiofs except to review kernel patches for a few
> years now and would like German to take over from me gradually. It is
> healthier to have a kernel maintainer who is actively involved. I expect
> to remove myself in a few months.
> 
> [...]

Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.misc

[1/1] MAINTAINERS: add German Maglione as virtiofs co-maintainer
      https://git.kernel.org/vfs/vfs/c/ebf853897910

