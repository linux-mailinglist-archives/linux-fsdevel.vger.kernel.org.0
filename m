Return-Path: <linux-fsdevel+bounces-52514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B8AAE3C0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FD13B69D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 10:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C19239E8A;
	Mon, 23 Jun 2025 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBGATQUz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237B119D884;
	Mon, 23 Jun 2025 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750673884; cv=none; b=XkKAtelMxodidyItT/OzAhCiabze59mpCK4oOE6yFJYF++w25KSu+aSMn1Z+yaMVHE56Ohg3oUwqvbTAvkLU4s7XAFEZy45QZyTrZLOHyYkSAVu2atwe1ks5FBftlet8P1ZO5zI6Negt94WqjCX5r6RILv+Hqb9gJLaJ3le5pvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750673884; c=relaxed/simple;
	bh=zp7IfPN1N0vhOpRg7yl1/Zx30inaox6U6AKMqGEoWQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmaxqzdRLjuLbk+M71BmyY6yMr5PahpnjjoeLo/c6ckibJN+7Cm4mfwurkvIVx7vgWAkMFQajZ5AdXSZ1Jn0q1jdhUNxewSeE4E8Eiy4iLQGrIqhBJ7h9BHzzQTG97G/DSWo8UwoGUOf1ypDfXrHUf3XKkgIIyPcgEW+QLwPKDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBGATQUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CB0C4CEEA;
	Mon, 23 Jun 2025 10:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750673883;
	bh=zp7IfPN1N0vhOpRg7yl1/Zx30inaox6U6AKMqGEoWQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FBGATQUz3iYZ2tb3RWvIcatdkUzD88hOM69gMeSIHaFnZrpK6c6QggZ7NxvMD6lHu
	 SzfSBX32x3ntiFW1ZV6zB+XKfxyj+/cY2mSCuCDgD85uxASObx5IunmeucBDSbPHph
	 u1fh5V3cAPN7FKtCTkYtr2pNW6lVSSQK/A8+NHEPJtJb7kAW5boHXM13YD4b4pTiPp
	 0jx7fK7i2Rl+oT46LP47UeRVr8MN74k7KtHlzlOw2vCcJNOfWrXS0dG36cw6oLiNtt
	 dnPxeI+8Sq439e2XNvSoJLlVUMAApCXBigzngVirpnEF5kazEJX2tpiwexZVtNmESz
	 PgHyIuFIQcM9g==
From: Christian Brauner <brauner@kernel.org>
To: Junxuan Liao <ljx@cs.wisc.edu>
Cc: Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] docs/vfs: update references to i_mutex to i_rwsem
Date: Mon, 23 Jun 2025 12:17:49 +0200
Message-ID: <20250623-wehmut-etappen-939e10d535b9@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <72223729-5471-474a-af3c-f366691fba82@cs.wisc.edu>
References: <72223729-5471-474a-af3c-f366691fba82@cs.wisc.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025; i=brauner@kernel.org; h=from:subject:message-id; bh=zp7IfPN1N0vhOpRg7yl1/Zx30inaox6U6AKMqGEoWQw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREal45d8ZM89fdEzPckxbaCAX9/lRVcKdlv/GqxIucD d9NtaUbOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSu4aRoXGl4h+7gAlS0aKX pgQndBqKPvnVlpGm8cEhpWJFU1x2NMP/zCxZnaUGtha1Oz3ulurI787VuLCGJWXyw5dX8z/fq93 OAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 22 Jun 2025 23:01:32 -0500, Junxuan Liao wrote:
> VFS has switched to i_rwsem for ten years now (9902af79c01a: parallel
> lookups actual switch to rwsem), but the VFS documentation and comments
> still has references to i_mutex.
> 
> 

Applied to the vfs-6.17.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.misc

[1/1] docs/vfs: update references to i_mutex to i_rwsem
      https://git.kernel.org/vfs/vfs/c/2773d282cd56

