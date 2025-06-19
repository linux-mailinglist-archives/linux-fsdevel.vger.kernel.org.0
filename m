Return-Path: <linux-fsdevel+bounces-52199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC21AE0264
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD5F3B5773
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3239B221F26;
	Thu, 19 Jun 2025 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGHdSlBw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A064221720;
	Thu, 19 Jun 2025 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750327684; cv=none; b=jQb55w1M0/Tz30MRMcFFAryKASOTGamukOvMEP6Ovd3dddura1AUjmm6xUi8gtDAh4df5ux4Ugi2oDIj2X8ViBHVs6g4ifZLl9gesvq+Fp/noD6RM4dK9gddsIWd1oV64hCUkw67gep3PX/H1FfuhUJE/ITpxkZicumBOcEnUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750327684; c=relaxed/simple;
	bh=LjZ3u3NJvBKRYepoq/MXA3KSDEGcTVuRZrVeUc50jCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQNN7eTldV6aAchB2yqDhRtd80lhURPfLcXmrCUxUdPjDJi69vpspjbJjn4mzWBo6pfwzPhMvDTIjfZjjkBSoiG5Al/X7DDhjWQbmuM1FQGsBfZMM8qZEH5NxqVL3uz43lDhiC381wVhH+0cFVFjuV+G37anq6uNuDk8XePqiWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGHdSlBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4E0C4CEEA;
	Thu, 19 Jun 2025 10:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750327684;
	bh=LjZ3u3NJvBKRYepoq/MXA3KSDEGcTVuRZrVeUc50jCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LGHdSlBwrEsHzjTIjds3GdgqbSOvBGRbGWcTyIeGYjn7Zij0Kt0E0fuSkqYOoJh6c
	 tBD2HahLAO6Tk/R1l44ufp801wSqoeS1YBnWvfOt5qENr4lRn/vpHUOCIb6s+S9w9l
	 eN9JMrx/B3uYkW0q8JmMlMjS81d8qeXIRyI9+nrrlPV03ztSGr4pvSi333OVVlwUin
	 nYrMN9OGcjted+8QLn8CJI2Ny7bPBbiQEU59pjN8a5QF34hsXyMSJpZh8DGjXT7nhv
	 wAqiZPRrQrEm63T4s2BPfkCQjCtvKPsuENt9THhO94lZL/kOyMyPZsrI9oJ7kZMcXa
	 FhiHzjhhLYXqw==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Pankaj Raghav <p.raghav@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>,
	kernel@pankajraghav.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2] fs/buffer: remove comment about hard sectorsize
Date: Thu, 19 Jun 2025 12:07:58 +0200
Message-ID: <20250619-irreversibel-kaltfront-033771080900@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250618075821.111459-1-p.raghav@samsung.com>
References: <20250618075821.111459-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=brauner@kernel.org; h=from:subject:message-id; bh=LjZ3u3NJvBKRYepoq/MXA3KSDEGcTVuRZrVeUc50jCI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEP6yL55wt9WxRoqzwYyPThc83Nh69KZ12rl+2OpXBQ 3md7rYfHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJfsnIMHE/545tGxrFJIvl p9YYufmGsCf8/skjdK10Ue+HjrCS2wz/axvqdIW+BBaFLemR3CrxM0ZnWwXLovJL+wVa3SYL/cn hAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 18 Jun 2025 09:58:21 +0200, Pankaj Raghav wrote:
> Commit e1defc4ff0cf ("block: Do away with the notion of hardsect_size")
> changed hardsect_size to logical block size. The comment on top still
> says hardsect_size.
> 
> Remove the comment as the code is pretty clear. While we are at it,
> format the relevant code.
> 
> [...]

Applied to the vfs-6.17.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.misc

[1/1] fs/buffer: remove comment about hard sectorsize
      https://git.kernel.org/vfs/vfs/c/6ae58121126d

