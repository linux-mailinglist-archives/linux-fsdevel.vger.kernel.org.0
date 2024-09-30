Return-Path: <linux-fsdevel+bounces-30345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3239898A1EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6587D1C20FA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 12:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADD41917CD;
	Mon, 30 Sep 2024 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHMI/Q98"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC04191473;
	Mon, 30 Sep 2024 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698206; cv=none; b=d4FG7C3NpM8HaNH3SuSfNcuoFK9T94st9/1sO0inLOonbbTJ+DdUQHs3KHqliFK3VFnvjjOV2jWOdRJTKv2hLWHJ1Yz386kEw2NESUrExWwr7+lM3uaUNxE8q7xxeSmnkZSslgJ7PylWCqCgE3eG2AdDaeGYxqJy60AwDZJ21aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698206; c=relaxed/simple;
	bh=bCr2jzrz9425tbOMb2k3hNmIpw62+BDOoCUJbWT6eBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9IHAFEkQIEw6SZi0dLjTaJf+PyXZP2zc3Dx/I/B4iHTzAizSZ8SM5XEWYUAkZMxMTsVQoJ2MiGNBs8KaRDAfcIARoNyUdDItdgaZJ657PZQNq3FHJtba2bw7T7hhT7sCuk4b7hHRaQN9xkBQZdzHquRI3LL9kJx2X/RIdnvREM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHMI/Q98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134ACC4CEC7;
	Mon, 30 Sep 2024 12:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727698205;
	bh=bCr2jzrz9425tbOMb2k3hNmIpw62+BDOoCUJbWT6eBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GHMI/Q98ONkPO+WOEfj07iO+SINuE50eXzgTuVUU3mYksjvGTknNxqz9YYy9Wc09j
	 Z7Gja9UOU5B2jTr9QIAKVDeKucdjJlJkYrnKbLPHnCmgZMAjQ+3uewPKCXBZaBJkX2
	 ikLxouw+diNe+FXTrYPVJMH84lE86FKjyxBNSDX3XxgFxiHwYntmtPuHXqLa1qH7fd
	 c4CduoXOa/7FQMmO1ryN6f35eQIBz40lX01cGqSl25KOwcFLZ2IZJg4QSiad5e95u5
	 AM5XaEaTNP/mwGVneYbbxJmeZf8mO3ZOjZdXZibU60F2lNPgksnZ6ZCwM5Wka4jdhf
	 4OS/ugcegS95A==
From: Christian Brauner <brauner@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Christian Brauner <brauner@kernel.org>,
	kernel-janitors@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: (subset) [PATCH 08/35] fs: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 14:09:58 +0200
Message-ID: <20240930-lesebrille-bankgeheimnis-00a2b1def47f@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930112121.95324-9-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr> <20240930112121.95324-9-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=brauner@kernel.org; h=from:subject:message-id; bh=bCr2jzrz9425tbOMb2k3hNmIpw62+BDOoCUJbWT6eBk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT9mip+5cpSNZN/8W9azk/ofMr3uGnpkVleEfZ+QpFbJ 5hPvSl5oqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiCt0M/5R7WZ9vSss6vzab Ra1G5NOkew+TBIzLIwMaPqXcqb6euZDhv3Pvm1W1Da1BGj5fjnMf3PDTv7GfS+JjiaproZ4bb9B kTgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 30 Sep 2024 13:20:54 +0200, Julia Lawall wrote:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> Problems identified using Coccinelle.
> 
> 

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

[08/35] fs: Reorganize kerneldoc parameter names
        https://git.kernel.org/vfs/vfs/c/513f3387a9f3

