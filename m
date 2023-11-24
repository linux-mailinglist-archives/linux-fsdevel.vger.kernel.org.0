Return-Path: <linux-fsdevel+bounces-3647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAA07F6D1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 08:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180D91C20CB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F068F4F;
	Fri, 24 Nov 2023 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Den3NYXf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE43A848C
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 07:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E49C433C9;
	Fri, 24 Nov 2023 07:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700812061;
	bh=WJcomARFBAYd+TfZ9HBC3K5cDJS5IrI0S/2OOkakEA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Den3NYXfObpijzztBldEIRVBytZQFcQwsm6JRaEOxNQ0P92Q0i99e352qOqVl1jZI
	 rRk3M02eQoCccD56fWsrLZKrXZ/M4Zji+e8xTT11Aqaeajk7tLjDunysZ97kK32AR1
	 0In9HgJNzf0VhAYRIKXkoCcegfReYMljB3Fh9190cwz5m8ikh/scK2A6rm1qrG+o7j
	 nrM8zMFDw+MHyiFq8ksFmybF8zfNWBGQfhs7rvD3kRgJTWCd1WumjmKQ4r6e2XGZ+i
	 HiztoYywdnAX2fyom3xctL5f65ZeEs15FdM+JE+rG7iitcASDDPdyykltGMfQRtZwn
	 dEw6joVt4UbyQ==
From: Christian Brauner <brauner@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/aio: obey min_nr when doing wakeups
Date: Fri, 24 Nov 2023 08:47:29 +0100
Message-ID: <20231124-verstanden-abhandeln-da0501d1d463@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122234257.179390-1-kent.overstreet@linux.dev>
References: <20231122234257.179390-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163; i=brauner@kernel.org; h=from:subject:message-id; bh=WJcomARFBAYd+TfZ9HBC3K5cDJS5IrI0S/2OOkakEA4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQmhArE/gxM3/Citdbrc+pPzi/bTl9L2jRd7PfiuqqCu EamW7/LOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACai3c3wV4xDa31pe4radXfL 2ML2U4ec3kTrfgiJXLz4kes6n7lsPowM8378NV63uoNZ6KR/yffPIXfUS56zTNtXkbv7+remJP9 qLgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 22 Nov 2023 18:42:53 -0500, Kent Overstreet wrote:
> I've been observing workloads where IPIs due to wakeups in
> aio_complete() are ~15% of total CPU time in the profile. Most of those
> wakeups are unnecessary when completion batching is in use in
> io_getevents().
> 
> This plumbs min_nr through via the wait eventry, so that aio_complete()
> can avoid doing unnecessary wakeups.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs/aio: obey min_nr when doing wakeups
      https://git.kernel.org/vfs/vfs/c/7a2c359a17b5

