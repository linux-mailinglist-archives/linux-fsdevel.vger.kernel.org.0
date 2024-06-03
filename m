Return-Path: <linux-fsdevel+bounces-20829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF2B8D845C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 15:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FFD1F21F00
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F0712DDBC;
	Mon,  3 Jun 2024 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl1GuiBU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F04112DD9D;
	Mon,  3 Jun 2024 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422595; cv=none; b=jLJzQ9N6weFjk1BPrapCEQH6osEQ5TAb+Rs5Gi+2QPDmCQKqaBrMUfcJlsKIDEMl2Q132EqLGG8F5fWCMFOHW7cHvNcgs+zhvVF9LWHnVBI/t9rMkwDFPD7uzjV2URzze49cOcATjFm9Q8QRTrxAAxGqz/yeQvkRGze1V+c0voQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422595; c=relaxed/simple;
	bh=9WeO85belMJdnC/BRkbMnH+4twnrcoxfjxbj+btQL8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4nbajaO6X0Mm96kPodwNXt6JgCoxaV1kZz8oO3+F7cT9mcwDL1U0d4KoYX7rtIBOz/MJtJy16jyYtFSSzqXdXrw9SFP1G42aJ/sgk6ret21od8V2pou71y3abFJ9ujtfx5lGzJ21ShS4yMi+EvweB7SmD7yjOX5Y3ExFuHvaCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cl1GuiBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7C5C2BD10;
	Mon,  3 Jun 2024 13:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717422595;
	bh=9WeO85belMJdnC/BRkbMnH+4twnrcoxfjxbj+btQL8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cl1GuiBUYeoYsK6oNNpAWAmRP82WjWr/SS8isnFeu9n8STX1xzF69r51cw4j3cJOi
	 8pJNBUTIgVH2jdD1GL0OkP0GVyCnSQABaTzVyUwbQEBFARH23UR6Irdv6bydQYJauZ
	 5OrIpffzekMlsMnX3QS8d4eHX7x/NEuLd2rNy/+cCnUvlI1OV9LP78l3WBB43gA5y9
	 aKFGke6hamTDNVrjSDoCzcxkp5QoIy2JJN/ETQVAa6Q8JtB9UWfSwSwqgYwOJCtd1h
	 Gs24NisRB8C7KA0yoI+1VyYBl5a/+xJ2vgX1+vlhptOW0TmL8VpGolDna5lMhzL7Kn
	 bxj2QurH0HzPw==
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] readdir: Add missing quote in macro comment
Date: Mon,  3 Jun 2024 15:49:42 +0200
Message-ID: <20240603-lehrjahr-jagen-01b5fbadb203@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240602004729.229634-2-thorsten.blum@toblux.com>
References: <20240602004729.229634-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=902; i=brauner@kernel.org; h=from:subject:message-id; bh=9WeO85belMJdnC/BRkbMnH+4twnrcoxfjxbj+btQL8U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTFnvzrpnPj43ZBA5ma9dMtG+3svY4rZFlKFE/M0Us7e CnivnxyRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERmZzAyPPnKvq34JZPj+aon 24tn/vlbeD9xa+ruNxkr2NW8WWtMHjH8z7r9teO4/f/Zj/3aVm6RvvGhrT4nj/GsvXlZc6yE6uk LDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 02 Jun 2024 02:47:30 +0200, Thorsten Blum wrote:
> Add a missing double quote in the unsafe_copy_dirent_name() macro
> comment.
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

[1/1] readdir: Add missing quote in macro comment
      https://git.kernel.org/vfs/vfs/c/1f9ccdf69c9f

