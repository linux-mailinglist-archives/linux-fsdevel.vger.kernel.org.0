Return-Path: <linux-fsdevel+bounces-14396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF6587BBC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 12:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096FE1C21911
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 11:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8D86EB56;
	Thu, 14 Mar 2024 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZBCUgdU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA482A1D1;
	Thu, 14 Mar 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710414832; cv=none; b=R0TMshZEu/yL20p9S243/II5WZ+chESaaAZS12Be2+1lkXsgc++pDjiul29goRCI4fxL6P+F4ujBGbGxVmT7Nc+Ky8LesSjmMfRvP2GvFY885joreNG9ZE8KwCmihU8+LugRDEg8b/gClBdJZymhp+Co6AwVAxmBM0/yQFY1bHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710414832; c=relaxed/simple;
	bh=7J8MT0hUY0ltXFRO4SUuelIo+HzcQQ6ooYOqWsUEuAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cG3UQ5eH6u+V/3+130XUuZUYNaGdkoCcLAprNnIfA+rqbPvWPd07xjtmGF65+ABYDsl2er6n5VJgvG8y3ZbChfzig0TDyXyWXXV19zm5d8DTN+B/1yHCGpej/qeUTKwncRICvCBQNAK2hCeLM0HCzD50U6gaHwZ94pUXHjDvD9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZBCUgdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948E1C433F1;
	Thu, 14 Mar 2024 11:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710414832;
	bh=7J8MT0hUY0ltXFRO4SUuelIo+HzcQQ6ooYOqWsUEuAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZBCUgdUaf6PtpckftrOMGMPPWH4+D+FXW9eggLo0TpRtVhNSHOrEsUmqFdJD+Cov
	 dKdZMYDL5uJyriYLnvvk4luVNIxHC0WOzo7GK+DX7RMTGEYnteB0BNAmf51yUxmq1r
	 K7qMhFMavkavQ4rg0hS/67Yg8uWrOFwbaOy0OSefWlhMo3sKUwhXdYVSBcsXXuxat6
	 OrIqSDYV6EJQLNg4A2OmNr5K8FcPlsl9/P0mXjNrWMvw1ppPrbPllxd95sYcx+zQxH
	 nDhZq7vCbE2RPjr04Yv6KUAXUF/dbmZ+6HPumSJI/wahjLy9juEhTFFfmyM4SEw8DL
	 5cTEYeZQN5W3A==
From: Christian Brauner <brauner@kernel.org>
To: Marc Dionne <marc.dionne@auristor.com>,
	David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] afs: Miscellaneous fixes
Date: Thu, 14 Mar 2024 12:13:43 +0100
Message-ID: <20240314-emblem-aufgreifen-1ea689e63099@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313081505.3060173-1-dhowells@redhat.com>
References: <20240313081505.3060173-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1405; i=brauner@kernel.org; h=from:subject:message-id; bh=7J8MT0hUY0ltXFRO4SUuelIo+HzcQQ6ooYOqWsUEuAw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR+uv1yQkti3maD5ltPuDYffGCaE242ZdYlu5B/nZzrm SIWHbdZ1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRnyIMfyUNRGYFt/NeO3U4 7sWFPdk7/xg8i/K903c57XNO5s699TcZ/unM5qjt+7L6uIeBFO/RUlGp6VJPAgqdzrgK/WyZ/TG oghcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 13 Mar 2024 08:15:01 +0000, David Howells wrote:
> Here are some fixes for afs, if you could look them over?
> 
>  (1) Fix the caching of preferred address of a fileserver.  By doing that, we
>      stick with whatever address we get a response back from first rather then
>      obeying any preferences set.
> 
>  (2) Fix an occasional FetchStatus-after-RemoveDir.  The FetchStatus then
>      fails with VNOVNODE (equivalent to -ENOENT) that confuses parts of the
>      driver that aren't expecting that.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/2] afs: Don't cache preferred address
      https://git.kernel.org/vfs/vfs/c/b719dcc8b02d
[2/2] afs: Fix occasional rmdir-then-VNOVNODE with generic/011
      https://git.kernel.org/vfs/vfs/c/4eed8f8549f4

