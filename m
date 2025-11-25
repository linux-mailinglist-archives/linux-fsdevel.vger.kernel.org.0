Return-Path: <linux-fsdevel+bounces-69742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71321C84290
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 805B44E8681
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 09:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982D5301711;
	Tue, 25 Nov 2025 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsL+/1r8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D382D8390;
	Tue, 25 Nov 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061901; cv=none; b=jA5YcE03ZtulMPkKiEMjSzmov3BDp8V2mZILaDcrvxTgCmzCzTRKEKm+R6w8IMBT6/juKp5X+Qn2LIUXg4xsl41xwQPcOEQ7U7ztiX/VmPvTBm59cO7eIMSm5k81tNdISG8kAnhc6Y1l+KnuvhLyFVlidPTrOZScprdfm4O3pbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061901; c=relaxed/simple;
	bh=Lt7MOuXQCBXf7CcgK3PFOt3m/RHaxkeh7Eam4VFIZGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxCkJRpST3Hp2yb/ggvLHFrV86DJoHMP9zUxF5F9yoCu45aYAbPI4+1HaVpnArC09bxwG97cEGsY3d2CyXaExVGcoGMagY0v8t1J5VtF3vljhEZy3Egs8THN2dv6yNL2KkHVBT0T9Ic4k89LNgPOGsikv0YRptJi5kTdu9aEgi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsL+/1r8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7288EC4CEF1;
	Tue, 25 Nov 2025 09:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764061900;
	bh=Lt7MOuXQCBXf7CcgK3PFOt3m/RHaxkeh7Eam4VFIZGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nsL+/1r8eQN9afWpNCIstV7EVG/y+S7m6XVNqORXF9hrhOAIszmWqpZzLcYL2E/RL
	 gkRHDXMOTCPA7uBSlwXEgmsxtklrjaAPp3c+EvOscVd+FUdHICQy7MgZ+ms9YnMNv0
	 ErAWfRWSPkkdgHMmLS+kiUJyPy17kq2BwVcqpbxtBZaCgJPctmHGq5v8gG8eS7JTMp
	 OVBmRa1dzvvEAC7SLa3OKbEzuAHDYPOuTvhDGGfZtRBqubGdEURMMEANKLq+2Kgi2r
	 qzuU9yX/pp9gO+xi/FUDjfTmQVkIHAwyluTAuroFP8tBcVj8WRxXMKhaOWMl0kdSxD
	 9F6+vscTzWBRw==
From: Christian Brauner <brauner@kernel.org>
To: Askar Safin <safinaskar@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	patches@lists.linux.dev,
	kernel-janitors@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/splice.c: trivial fix: pipes -> pipe's
Date: Tue, 25 Nov 2025 10:11:30 +0100
Message-ID: <20251125-hinunter-laufzeit-b6a3a4c0efab@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120211316.706725-1-safinaskar@gmail.com>
References: <20251120211316.706725-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=848; i=brauner@kernel.org; h=from:subject:message-id; bh=Lt7MOuXQCBXf7CcgK3PFOt3m/RHaxkeh7Eam4VFIZGk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSqFh3/yBJbdmzuqSvfC/c3n4ncGGf5qfWx23zeNbpa5 rLrA5rfd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk7XxGhlm93C0/Nj7xakn8 zmysWve0LfU60wzmS8vE5lmkyPN/fMvwV9Aj5fTm8OBuN+VZvIL+Xe5BHlP3SNU0Mb38+mnO3Ir bHAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 20 Nov 2025 21:13:16 +0000, Askar Safin wrote:
> Trivial fix.
> 
> 

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

[1/1] fs/splice.c: trivial fix: pipes -> pipe's
      https://git.kernel.org/vfs/vfs/c/bef0202fb77b

