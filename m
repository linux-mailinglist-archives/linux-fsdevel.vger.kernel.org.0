Return-Path: <linux-fsdevel+bounces-70124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9D8C9172E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 10:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6290A3A7E48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 09:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDB32E7658;
	Fri, 28 Nov 2025 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMQm6s1R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2640C1F9F47
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764322263; cv=none; b=pHQ/5psYJX2YzynnlpdsTe3UZOumHhQt2nPHFu4jH45VVhq+v5crnBrgLL8Esk40RDBsxVBjEYXd/xsEXaDYTGH9ytMzZqGtMFsQc0i4n/S/bR3slB9SrfQG33MzatFIEzmOWlJGnTgUtjrswxfRttGJtKj9q179xj/jPP9lNzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764322263; c=relaxed/simple;
	bh=B8gKZkkoKANk4LqFlXD2SmV1HGuKHebT17zpqq0jU8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3GUyZe5UaNTrVxduRnDqqKNEWRrdTw680u7f2adPBfCt155kbmj67uzuc54sS1d991gUGqkahrao+3WFqdcIZqXWnt2VtCauVyIX+JcG7+T+UDKapnIuW47x7IcrwhTe8cFtcUNiI2HV19qunGJl4/ctDnikhxnB3w0dZi1VTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMQm6s1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D9FC2BCF6;
	Fri, 28 Nov 2025 09:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764322262;
	bh=B8gKZkkoKANk4LqFlXD2SmV1HGuKHebT17zpqq0jU8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hMQm6s1Rf00CVYpvKp6YoYHcXWezNOTf2wPP68czj3sxwRsMRxBMFm2ZpkiWjYD3J
	 naUz3Lp0jT8olEc1P7hh3m8tRe/ROLi7kdZNJq2/LEtTpRyWHFNFYLgezLJH9MaDzf
	 PSc9Q6JJw/yTwenS9HlR27kUsEF1RUMSRAl+LJzKz8gowI8EfNLm3wfOx7MXoj5nM9
	 9KrJqj788lIvjMvqO4QlDiV9hJ4pgSSbyeX3Bg7KwQAGM1xQCITEZP2J/H/UHSjLIF
	 ATAvAEHooapJb7PsEY8xC/J3kt6F6bjDAR1EdKU07tvDMzk5ZLkslI5ixyeQA16wqK
	 bSZKUY4U+HXTw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] filelock: __fcntl_getlease: fix kernel-doc warnings
Date: Fri, 28 Nov 2025 10:30:55 +0100
Message-ID: <20251128-winzer-verwundbar-7f773a910712@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128000826.457120-1-rdunlap@infradead.org>
References: <20251128000826.457120-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1236; i=brauner@kernel.org; h=from:subject:message-id; bh=B8gKZkkoKANk4LqFlXD2SmV1HGuKHebT17zpqq0jU8Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqZl9oM2SetHub5dvXKz8Z/dMIie9R3PlROfHpjeWHp FKbOrIudpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkwneGP1zfK/fkbe9PD0ry ZLumr6x1PO24eWHq0079rbbLvm5hs2X4Hxg1L72vKPbe2eOZ1XtUnPI4p147YB6dGRf+1IAhM5S fGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 27 Nov 2025 16:08:26 -0800, Randy Dunlap wrote:
> Use the correct function name and add description for the @flavor
> parameter to avoid these kernel-doc warnings:
> 
> Warning: fs/locks.c:1706 function parameter 'flavor' not described in
>  '__fcntl_getlease'
> WARNING: fs/locks.c:1706 expecting prototype for fcntl_getlease().
>  Prototype was for __fcntl_getlease() instead
> 
> [...]

Applied to the vfs-6.19.directory.delegations branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.directory.delegations branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.directory.delegations

[1/1] filelock: __fcntl_getlease: fix kernel-doc warnings
      https://git.kernel.org/vfs/vfs/c/01c9c30aae31

