Return-Path: <linux-fsdevel+bounces-46253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AE5A85EDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 15:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D3E8C1770
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 13:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3ED165F1F;
	Fri, 11 Apr 2025 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5sHMEaA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE113957E;
	Fri, 11 Apr 2025 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377853; cv=none; b=OFb5DQCcihUuShq23HAsLL2uzieH3U8X7VgZMMhKbnuXKkcEdBSOZZhAv7aNTW8c/MOz7eRt0xAW8ynY8kHp4XHl9lccPohFkK73wsHjH9UgNdcPa3X1Hnca8cA/XtUWp708uxe8xzMaywvALJYV+oYXD2gstra9+Yz3Mv5kcUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377853; c=relaxed/simple;
	bh=NVhl8TTovP9OlgHH9p6aeeDp9nCAEbN6fMbgpNg+ELo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ox8B8qX5CeYLS/5ChRAZ70eSL8E+gI5oDxrZWKEX3/oBmak2ut5PISutka0KRli3PW67eBV2a63B1UpBvVYcT23RNyScx3K7vD5nGIcgyWcLpJoGVNf+9klg8BowBV6YOz4qgbj0uncoNXUE3oGAKjk8kkI+LmfQ8F6Fak8q8S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5sHMEaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248C9C4CEE2;
	Fri, 11 Apr 2025 13:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744377853;
	bh=NVhl8TTovP9OlgHH9p6aeeDp9nCAEbN6fMbgpNg+ELo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5sHMEaAzS8YWt5ClST/ZaFQlWaxqoSS+1lvrgg7DPwi19XkaEnsTiBOUxzhvhhvC
	 W+7YTNnSXofwontPAU2hlZSmGnuSeSkBhtdycKg4bW4v3145X+3kiDgrsVZTxixnac
	 ldJ2oRjd00VdKUsDK6WD/bHAslZan4vvK9Hr2Uu4mWQ5PHWcneawWhaBsLZnWVlxko
	 MnXRWypbi8tRSwSdkB444QPN6A5Yx4gUEO+/zJUujp5KtMZfmIyoXljEEdMLgBm1Xp
	 nJx62n+ihxWz2UyOL5eEZ0dERc2q6/eI2zRgSwK4t0lRNT3ceHCwMPnZkk2yuEX+vx
	 ixpuF+fEJsdlQ==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Timothy Day <timday@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	netfs@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] netfs: Update main API document
Date: Fri, 11 Apr 2025 15:24:03 +0200
Message-ID: <20250411-modewelt-fachkenntnis-2ea37a35a620@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <1690127.1744208325@warthog.procyon.org.uk>
References: <1565252.1744124997@warthog.procyon.org.uk> <1690127.1744208325@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=869; i=brauner@kernel.org; h=from:subject:message-id; bh=NVhl8TTovP9OlgHH9p6aeeDp9nCAEbN6fMbgpNg+ELo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/FP/isP1hYMuFpIjkZ29TKo9cU33z8OP/ZPeX802d/ PN19m326ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI4xUM/zPfPsnw7DyZc9J3 lt6qoGMTW7/edNl/ilOcTUW36/F8xbeMDGtFMrbsCGBOfv482jPi4+mlUaqNebNEN14y0fsbnGw pwAYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 09 Apr 2025 15:18:45 +0100, David Howells wrote:
> Bring the netfs documentation up to date.
> 
> 

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

[1/1] netfs: Update main API document
      https://git.kernel.org/vfs/vfs/c/f1745496d3fb

