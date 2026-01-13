Return-Path: <linux-fsdevel+bounces-73387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FF7D175E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F4A5303EBAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 08:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3405C336ECE;
	Tue, 13 Jan 2026 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxMmrpjC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988BBEEBB;
	Tue, 13 Jan 2026 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293931; cv=none; b=rF3pzhB4iIdPn5qNiTyC2ME4MuWHBW2I1y0U923RyLUIS6QsQZJXceDAFbtZ0tvLa+7bBtD+yMq1fZgcGR5S+UWKUgxnXMgbRRsrOUaaJ0Dl1uFNOeg5KW26f/rUDQpnvosTcVpa/peGQEGux+EbEgJugShP24B78H/Gaa43iAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293931; c=relaxed/simple;
	bh=6sxlwd/nbX4EZ0nsyiBG5EL0XzNqgxa2bnQd92SD4FE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bI8uVV87QzdW99mLRC/hfU0B27yUBBKZIARYTJUSWVlWzdMEqW8RcUUHpqZ4gT9RxsTAPQebKdtsdVV+WuavPuUsWUhUxNsbgUEF6fxiahM2meS/7cTjlVQzw3SKNzKEajGrj7uYOYTx2Ctyvk+r9OV8bLc2RhLWcu8vcLamdV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxMmrpjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB7DC116C6;
	Tue, 13 Jan 2026 08:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768293931;
	bh=6sxlwd/nbX4EZ0nsyiBG5EL0XzNqgxa2bnQd92SD4FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FxMmrpjC+hfKXh11mMDuyOYAhmdyt5813G5Ku4a46lfmknefA9mjBiLlU2W/mG28e
	 dTMvY2EMBHekbmcb67kL4PP224nWh5XhAGiSas9SW8RwAxJ7OCgnYSXc31PGaRlSw0
	 vok8ujJyIdvRNXrzGODam/EpzDNHqN+lyQMdGg25/nJlybU8K2X3UUA4Dv+YEntwsX
	 nWadPWYb4zwrNAhBjDtoGB6HffqQNpitS/I1gsO7A0eSF4PxNWcUcresLHxEYGoin1
	 kv8uwDlpg0NwogYPRAKMlbZGTTmKq+1xYMEFMl4zSG+71fyYEw83hHwUSNZaf0m1Mh
	 JIQOELckEn0/w==
From: Christian Brauner <brauner@kernel.org>
To: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/4] exportfs: Some kernel-doc fixes
Date: Tue, 13 Jan 2026 09:45:17 +0100
Message-ID: <20260113-gestochen-campen-1d3a663928df@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112-tonyk-fs_uuid-v1-0-acc1889de772@igalia.com>
References: <20260112-tonyk-fs_uuid-v1-0-acc1889de772@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=brauner@kernel.org; h=from:subject:message-id; bh=6sxlwd/nbX4EZ0nsyiBG5EL0XzNqgxa2bnQd92SD4FE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmsSl35KxlL4l8yscpp+fjIbVL/9Mldr57bRv2vDnK9 WpW/+wJHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5s4Hhf56wlV7bvUV35fq+ zt1m4Xrqquru+geVDdyPt8vOuW+Y08zwV+TwhVUBE76/1+b5IXdNJPsFd6HBQp0SfqbJK8t04vq d2QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 12 Jan 2026 22:51:23 -0300, André Almeida wrote:
> This short series removes some duplicated documentation and address some
> kernel-doc issues:
> 
> 

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/4] exportfs: Fix kernel-doc output for get_name()
      https://git.kernel.org/vfs/vfs/c/c9ae970f7c11
[2/4] exportfs: Mark struct export_operations functions at kernel-doc
      https://git.kernel.org/vfs/vfs/c/69639fccd6e3
[3/4] exportfs: Complete kernel-doc for struct export_operations
      https://git.kernel.org/vfs/vfs/c/66982f431798
[4/4] docs: exportfs: Use source code struct documentation
      https://git.kernel.org/vfs/vfs/c/4e9076eaa1a9

