Return-Path: <linux-fsdevel+bounces-43053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF28A4D72C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9101F17598B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DA71FCD03;
	Tue,  4 Mar 2025 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSapsl0W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731DF1FBCBF;
	Tue,  4 Mar 2025 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078504; cv=none; b=D1Qq5goS8uam+nvgoSUycK1mYHzD6jtOaca4x51JYaUNspr10ByF/Y/oAU3bj8YhhoYkL9nFxHJhEjtx/Tq/u7ybDvaKOZTNbtIM3x5oehgRqECfi+Aeb07VKY5vywOVWEqi9Wgmihve+7eAWkKLTo9XFUcf6/GH75MyLIb/zZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078504; c=relaxed/simple;
	bh=I3Z7U0rZDw2GL5WC6oWxd1hjvPK2mzzVTMT3qctHGWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unUWkn3J5WvrfB6fEcIk0XCGmnlLj43TbErlgGqGpbOHnIAPBEfNt2eN1pMwdgV+4U+SaJiAgGVgrNP75U1RZg7eBEvZBrI0UksDgialxAg1sY1QNujl45E8CgoGp/wG7nEQBGUwFuiGz7W2DaeAunR0mXih7+q2Lt9MA3Eg0+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSapsl0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BA0C4CEE5;
	Tue,  4 Mar 2025 08:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741078503;
	bh=I3Z7U0rZDw2GL5WC6oWxd1hjvPK2mzzVTMT3qctHGWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nSapsl0WH6XtmgzbrmtYmeKYIcrX4V1siLMfVgeNZqn9KAR4TV9toVN0AnJxsbMUr
	 li8AQ6myS6kkIRTRSNqhePm3k4YphnJE1w7FhZ/R3UwOc7HxGM8tBAGlN3nTwBHZHQ
	 fzm322MM+ZoP6Zo35O7V4+DkSJrAFUoWXsNa4xZnALCgLFwgYQjauTP77CJ/7DAA/h
	 Y1Sw255zrYLDYtaIBCg2TmxzAz2klhgRAHroOxVlRdOrngm169Fp4W8FWAhCaNKweQ
	 zk/B8mExAkWrT9a2s1a8crS+ny2WL32gb+fom/5jSZgwgg/+Oy3sbMNcUb+kZxI3PM
	 FTEI2j3h8aSCg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 0/8] initramfs: kunit tests and cleanups
Date: Tue,  4 Mar 2025 09:54:37 +0100
Message-ID: <20250304-anfingen-kondor-c7f9cc352472@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250304061020.9815-1-ddiss@suse.de>
References: <20250304061020.9815-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2133; i=brauner@kernel.org; h=from:subject:message-id; bh=I3Z7U0rZDw2GL5WC6oWxd1hjvPK2mzzVTMT3qctHGWw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQf2/9o6qZTh+KKGWKiuMynuop0XTwoczP+Wlm/mb9QW JqXuXNSRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER+tjH8FW7VNJ3ZnSgfN2vh J887S1ofzJvUk7r4/9O38SGdXOuPbmRk2HCmbHrLzk3mVTHfDpb9qV7rNkNBuYPHce1crVLm9Qn sTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 04 Mar 2025 16:57:43 +1100, David Disseldorp wrote:
> This patchset adds basic kunit test coverage for initramfs unpacking
> and cleans up some minor buffer handling issues / inefficiencies.
> 
> Changes since v3:
> - Drop shared unpack buffer changes
>   + rework into initramfs: allocate heap buffers together (patch 5/8)
>   + extra review complexity wasn't worth the tiny boot-time heap saving
> - move hardlink hash leak repro into first initramfs_test patch
> - add note regarding kunit section=.data -> section=.init.text warning
> 
> [...]

Ok, let's see if this breaks any testsuites.

---

Applied to the vfs-6.15.initramfs branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.initramfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.initramfs

[1/8] init: add initramfs_internal.h
      https://git.kernel.org/vfs/vfs/c/5f469c4f7167
[2/8] initramfs_test: kunit tests for initramfs unpacking
      https://git.kernel.org/vfs/vfs/c/b6736cfccb58
[3/8] vsprintf: add simple_strntoul
      https://git.kernel.org/vfs/vfs/c/dfa63602367a
[4/8] initramfs: avoid memcpy for hex header fields
      https://git.kernel.org/vfs/vfs/c/2c4babf8d182
[5/8] initramfs: allocate heap buffers together
      https://git.kernel.org/vfs/vfs/c/b40c5e61f940
[6/8] initramfs: reuse name_len for dir mtime tracking
      https://git.kernel.org/vfs/vfs/c/aeff5090a5ea
[7/8] initramfs: fix hardlink hash leak without TRAILER
      https://git.kernel.org/vfs/vfs/c/15e2de59de08
[8/8] initramfs: avoid static buffer for error message
      https://git.kernel.org/vfs/vfs/c/154c1e422ffe

