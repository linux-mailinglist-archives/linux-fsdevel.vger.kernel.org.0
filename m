Return-Path: <linux-fsdevel+bounces-263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A0E7C88F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 17:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1D4282C53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 15:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6561BDD7;
	Fri, 13 Oct 2023 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9veG/gz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6720A19BB2
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 15:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D78BC433C8;
	Fri, 13 Oct 2023 15:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697211768;
	bh=w+6BUQBaNHF+OpG8aeQpowtuQW5/tOg+o3dNZGFwO4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9veG/gzxhXI841Er8TksLbC6ytVCHvKa0V4CnStVZRe1640g2p2fQMEcQbRwKoTc
	 GSnuHoANjV22BgWBAEVCno1OrybmJRiESDnhAhWBzODqU5/WO4iVj6CX1FGmvuq0on
	 J4fgXH28QKBhGxMsi4JkCpTEiYEYuIIrwt1u083M0hvAwblqMAe66BkijUiioxaytd
	 w2Brlyi9bwbqZ6tunb6LPCX4f9lwwNoGwTJi26WGiFGg9S3ShCRIO6Bu+rmRLGUCcE
	 qHE/mxLHUzT9tlHw2M+FRWlk7nSPh7DvSSv0lSUfZs02xXOEP2M/7dsbnVTqrKQgXQ
	 vK1fq4pNvi4Ww==
From: Christian Brauner <brauner@kernel.org>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	kernel@pengutronix.de,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] chardev: Simplify usage of try_module_get()
Date: Fri, 13 Oct 2023 17:42:41 +0200
Message-Id: <20231013-pferde-daher-989c3e826a6f@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013132441.1406200-2-u.kleine-koenig@pengutronix.de>
References: <20231013132441.1406200-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=908; i=brauner@kernel.org; h=from:subject:message-id; bh=w+6BUQBaNHF+OpG8aeQpowtuQW5/tOg+o3dNZGFwO4M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRqpuakr9RZ/2otJ5OkhrN2CXedwaurZqo6jjMnTWUyn2+1 8qVlRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESCuBgZdkZxKso6+AoLvfhZPoW5YH qen5PfqW0My7yji7ftNW9UZ/ifLtVtGPSk8C7PP0YVrdy25Ke8z/z9ohVX8S1cMGtjAD83AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 13 Oct 2023 15:24:42 +0200, Uwe Kleine-König wrote:
> try_module_get(NULL) is true, so there is no need to check owner being
> NULL.
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

[1/1] chardev: Simplify usage of try_module_get()
      https://git.kernel.org/vfs/vfs/c/e8591fda1b0d

