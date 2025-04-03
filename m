Return-Path: <linux-fsdevel+bounces-45608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25367A79DD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 10:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452513B3CA4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 08:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81762417D8;
	Thu,  3 Apr 2025 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I80QxvIa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42415224B15;
	Thu,  3 Apr 2025 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668285; cv=none; b=komGna22TLl3bDLYr3SFbQTcNqU2nnDuHH953VCHmPbZAx3lrdMIzJEImWCgeqaJWfQ6gRMFMTRFO3N/7KmUggqeN+hTFcOG5UhvlPsncoujlfG23wGywCrBoMqZFWgm8lA64OrpkVJTVZTRAHvMBmfJHNz4oCumsiwBOf9JiyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668285; c=relaxed/simple;
	bh=olgkHe3pH7vGv45YVn7hY1Dfxlf0jaBm/qXalOafhbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2/b5b1pq7ym4bHZ9WuaeqAWWQdhxhVBmR+wKocKUjP0Kxt9rz5sY6Yd5mT/TKnayieyvjeQzy9N7HMgiiEKu7IbyFL7IXiuLqdjYSAcO0FHMMhGYXNUAXpNYn7sYWvtthSQC2oCNRh5EdLXQ6DvAxnpkDGp1Nv0ao7hHfZEl5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I80QxvIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5486FC4CEE3;
	Thu,  3 Apr 2025 08:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743668285;
	bh=olgkHe3pH7vGv45YVn7hY1Dfxlf0jaBm/qXalOafhbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I80QxvIac33Rvilplhed26sAsqttZonvE0Mi7KH0oO0e14wL5l9+Ke8tRs5EJEVxq
	 Zs4mNftFm6Ug2XhtHigpPbSEplH3CWu5MkAuwzORddnJaYjP/1M6AcWBBjoimF5t5j
	 sZsfy0hihmDP2JzyWBSO2MFMMXQ6lo+J4HKM5zSrTqteU3KxOqeN41RnMAaYuXQkCH
	 Odi96hH1plgn5zO2EPLjjtS0xIGPHZM4SliD7Ox6HSb7wS0NuUyJBo9IW6IodL8gmt
	 IUZEpCIHbyDikOQYnXUXOtBf/p4HcNZoj49pmFe3ar8Y/xDBd2kToP3cGOf+8cDqGz
	 RqwKTc8UENw3A==
From: Christian Brauner <brauner@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] docs: initramfs: update compression and mtime descriptions
Date: Thu,  3 Apr 2025 10:17:52 +0200
Message-ID: <20250403-beibehalten-bauphase-065cb8e290d9@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402033949.852-2-ddiss@suse.de>
References: <20250402033949.852-2-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=brauner@kernel.org; h=from:subject:message-id; bh=olgkHe3pH7vGv45YVn7hY1Dfxlf0jaBm/qXalOafhbI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/czGPiXizvyfwiWb9TseAW3n5cZr3qvoSvkSWb6tks z52T+ZpRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERqZRj+qUhvbFmW3/j9Dmt6 /JffZbGc8U9EDj6NSg5Tr3SZyBnuw8hwc2HHBQv7jMqzdip5TLMi23kD7qk+DVgZs2HV7S+3s/p YAQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 02 Apr 2025 14:39:50 +1100, David Disseldorp wrote:
> Update the document to reflect that initramfs didn't replace initrd
> following kernel 2.5.x.
> The initramfs buffer format now supports many compression types in
> addition to gzip, so include them in the grammar section.
> c_mtime use is dependent on CONFIG_INITRAMFS_PRESERVE_MTIME.
> 
> 
> [...]

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[1/1] docs: initramfs: update compression and mtime descriptions
      https://git.kernel.org/vfs/vfs/c/25b64e0cf660

