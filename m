Return-Path: <linux-fsdevel+bounces-48719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286EBAB32F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8EE16DE24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 09:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09C625D21F;
	Mon, 12 May 2025 09:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+r9GNDk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E131A25C715;
	Mon, 12 May 2025 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041611; cv=none; b=omhmFMEwEOc4R5qi58zkUCB9icppEiP5bm2JNUyEJU+8bV6/UprVcrgQ587MvTkxoj0YHsKrl09UeT4i/qJfdOH9/VCLeqztkIBgCbzMNk5os36/UGOl2wIx3XFOD+kyVZnsTWmYITKRLKJuC/RHC49UzNEQ+MOQxOtTMf7nO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041611; c=relaxed/simple;
	bh=52aKOno0EL7URiPWvaUs3aD3TypLQPuRkCsQEHt1V7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcVi87hcALFYwlL6L93MYVU8c+StLIQ0umrm3HcRyjGyTcee+2euA4T0NMFy/WJXdQWcuNkWC0aQ/xBblXz9guKwhqKhgdWxD7v2sercc/ZYOMFbr+2mn09spWO28ronPYJ1smPQw7cl7W4pVltKeXCtsFzElSOesUYBa/rz628=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+r9GNDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFCCC4CEEF;
	Mon, 12 May 2025 09:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747041610;
	bh=52aKOno0EL7URiPWvaUs3aD3TypLQPuRkCsQEHt1V7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h+r9GNDk5Npg/xucrTc5NBwbu9B9JgGx1VO8Ml5T6khBC/1OrkYtYp+/A51AmuD5t
	 yVqwo42vij7yFasxXteweV2t8wLJMx3RhIASLq7S4VcWqD0rTtTYhJAPxikqeZOixx
	 FJE+zojJCZdk0Ab/+mF+LUEI9OIPqZ0HmZFGcxX+L4RrNxhfapbpeKaDSn/FK5rzav
	 z9pqqLxCk3XLPfG7LSQILdWo0XAHLt8lVyEIMqVGWJnSnPrjBE2Glm4CGjvq6+zIu3
	 GKsE6fyOLzg1t0t9MrBYTiPlSXRR/kT3izpMTzvceYTZlIVJNu+bRXnH06oRb+LhSH
	 kNsXi9DMyfAug==
From: Christian Brauner <brauner@kernel.org>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] statmount: update STATMOUNT_SUPPORTED macro
Date: Mon, 12 May 2025 11:20:04 +0200
Message-ID: <20250512-beinbruch-hasten-ab36c2eb1b66@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250511224953.GA17849@strace.io>
References: <20250511224953.GA17849@strace.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1003; i=brauner@kernel.org; h=from:subject:message-id; bh=52aKOno0EL7URiPWvaUs3aD3TypLQPuRkCsQEHt1V7I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQo7nXbUazCZVO00Gv6wb180r3SDF9nNjUfm3KsJe957 YM9ysurO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyvoDhf+Sp97s3J5S+vXb4 Tghb68oUrv+r1wo5PPymON/k19Z3WmcZ/qeu5dZ0WJvtekIqJXep57TDGyf+bPQKC5Wfqfteu3y 3AAcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 12 May 2025 01:49:53 +0300, Dmitry V. Levin wrote:
> According to commit 8f6116b5b77b ("statmount: add a new supported_mask
> field"), STATMOUNT_SUPPORTED macro shall be updated whenever a new flag
> is added.
> 
> 

Applied to the vfs-6.16.mount branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.mount branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.mount

[1/1] statmount: update STATMOUNT_SUPPORTED macro
      https://git.kernel.org/vfs/vfs/c/ed3453bed26a

