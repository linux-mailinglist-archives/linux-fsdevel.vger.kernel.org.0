Return-Path: <linux-fsdevel+bounces-36628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 486399E6DDC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 13:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08FFD2839B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 12:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC705201006;
	Fri,  6 Dec 2024 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChjUhhrk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200335464A;
	Fri,  6 Dec 2024 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487236; cv=none; b=dcdIPol00j4NbgZUbU9v4CpLmXk1FLpbQNSnpB/oR8RssNQuSBwN2D1yqwk9fgrOlyD6tpfHuOe7DyLxFvEsIQExQPlKbSQn6cqNklEWej2WPQL1IMzwqUKHa2noIc2F63agdkhqg2tHjrR5Gqjkfrwy8gWIuSdxEDxgVUpN3Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487236; c=relaxed/simple;
	bh=kMmViGs7oy6ldqGNxCmz3QQ9X3SiOzm8caZTM5TDwOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZc0XoFIBY7rtVibFohzCwinrSw4zNOlhi8bNS2NduI6ABYrST244mnNV8JLOaFLB4Sr/a4GYxmgWu27vGsuRLW/Gw4D9lqW+kG5xl+EeBTWtaJzRaNRO3G1zS6n81/C82VMrEObRwPpP6cl9mKcZ6YnhGqNdjq8ZbkTcqC4Rcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChjUhhrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9652C4CED1;
	Fri,  6 Dec 2024 12:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733487235;
	bh=kMmViGs7oy6ldqGNxCmz3QQ9X3SiOzm8caZTM5TDwOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ChjUhhrk2ewM9a314GVcl8ncbqf4P1Pim41cvR32P7Z78xCHYXDs57hH8GNqt3XsK
	 Td2f5N3BGtfQS7yBCKL/jhAp2gimHwqdgTiG+bdsYIpeVQvAtUURvFCq7wk57ijDlx
	 S0WynqC+OExWcGinLLFUREVYi3E+ELWdfpjB9uq4Z07GN2KdjV4e9QaKeZM7j2ZJDF
	 UzCkfmWvHNM3Tv8nKbTLhj5hvXgOcYTw7WiaHJCB80nt2QoYwCb/R5+j3JHsCtasbw
	 Aw3VEY7HJ1FkEkkRT7s368PFZk/eG4pSMMhyWTh3TjPOfKB0UTZc5Trs2mH1WjXzsx
	 FNL85D5VwXaQw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [MEH PATCH] fs: sort out a stale comment about races between fd alloc and dup2
Date: Fri,  6 Dec 2024 13:13:47 +0100
Message-ID: <20241206-inszenieren-anpflanzen-317317fd0e6d@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205154743.1586584-1-mjguzik@gmail.com>
References: <20241205154743.1586584-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1486; i=brauner@kernel.org; h=from:subject:message-id; bh=kMmViGs7oy6ldqGNxCmz3QQ9X3SiOzm8caZTM5TDwOw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQHvartM330elnwhUTe2xuZJOSWCjN5fFZYdKvsgqnnu Sufg3pYO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACai9YLhr3hJlpiz48RDZ859 3lg/+dwB38M7ZktNs+6exajOLvHi4j+G/2m9vRN1El5mcaQc4s3M7HWZJ/Apb+rNBR8LOhy15xW oMQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 05 Dec 2024 16:47:43 +0100, Mateusz Guzik wrote:
> It claims the issue is only relevant for shared descriptor tables which
> is of no concern for POSIX (but then is POSIX of concern to anyone
> today?), which I presume predates standarized threading.
> 
> The comment also mentions the following systems:
> - OpenBSD installing a larval file -- this remains accurate
> - FreeBSD returning EBADF -- not accurate, the system uses the same
>   idea as OpenBSD
> - NetBSD "deadlocks in amusing ways" -- their solution looks
>   Solaris-inspired (not a compliment) and I would not be particularly
>   surprised if it indeed deadlocked, in amusing ways or otherwise
> 
> [...]

Applied to the vfs-6.14.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.misc

[1/1] fs: sort out a stale comment about races between fd alloc and dup2
      https://git.kernel.org/vfs/vfs/c/9c9e176d7546

