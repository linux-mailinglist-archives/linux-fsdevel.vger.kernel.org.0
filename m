Return-Path: <linux-fsdevel+bounces-25092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A127A948D23
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 12:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4422883D0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 10:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A479C1C0DE8;
	Tue,  6 Aug 2024 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrNJYJa4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB041BE852;
	Tue,  6 Aug 2024 10:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941351; cv=none; b=Fd2Naq+bXswUaTRlGXojDSsdHVAhXR1j0ldZtzuo9/o8XIIQ+OP3ZpWCj/x2H0hn62FfVx1ww04qLWOIrWdXwGAxnYGNzHGVMknn2DFJCNhTOOrCmyuLADAkR6Fy5dEhlyLjwxNRu2F2xgpBmx1s250YBaHfRRF0jEE3IvcLXnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941351; c=relaxed/simple;
	bh=fv839ZtErwa9R2DfjDzoRtgqbssgZDKi01olLjFOF/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLEJhoLyGQ9B6TXUxMLNFrwHD8OYnq1ug56+eGRW2I6QUrFJpgDwR11uNXX/UVFR9wM9kc/6gnT7Ba3wgFMeWVC7aocS+Q9EIsMo782zr3GTfN8iCqhe5pXILV77VU0Fy1DTpa6RqEukV9OiFjk/jVeBRvNyLiam/DJyjGmU70c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrNJYJa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E548C32786;
	Tue,  6 Aug 2024 10:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722941350;
	bh=fv839ZtErwa9R2DfjDzoRtgqbssgZDKi01olLjFOF/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HrNJYJa4AW0Aa6GCeUHi7TtLiVbfg/l3RL7FwRRnPuWjQYM5dqW5qzuzZHGlxigVy
	 1JPRB7sY+2DzTjWQR5ooLz3L2E0T0W0JuazUpKW7vosGmJUAcJeToSWtQFzqkmkauo
	 YUJlVLxeqFUafSFWvnj6ZK7zFx0SCteqQ3FCaI2XNWrvtE058CVPFOpiZq7d7fZLvM
	 LRbHT/+ZJkUJBvQXGZIXYb6ZxgctL8pJaoaVYp37/rNflMkb3UxoRcU5kLGwu+SXvz
	 8/iYzGCFxU4+2LVl7AqNqkpkHhwNjvq7HS6aZFZhF+y9gz3+Xl/+B/cj4WAc5yvcaV
	 JYCAx2a8+Gvjw==
From: Christian Brauner <brauner@kernel.org>
To: Yuesong Li <liyuesong@vivo.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@vivo.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs/namespace.c: Fix typo in comment
Date: Tue,  6 Aug 2024 12:48:56 +0200
Message-ID: <20240806-indikatoren-galaxie-d652d6fd6b2d@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806034710.2807788-1-liyuesong@vivo.com>
References: <20240806034710.2807788-1-liyuesong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=927; i=brauner@kernel.org; h=from:subject:message-id; bh=fv839ZtErwa9R2DfjDzoRtgqbssgZDKi01olLjFOF/o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRt/D9fofkYd6SPZoWQJsvTfykC/2JE3i9hXLrh+J5at hkTf/V96ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgIRywjw6dXoS9FfmpaR1U+ VLdYVVV+NHLyiuVP5XKDrOp23VeJqmRkmLyBPzHaTUf7qI+Yz5239hWyBxWYOpR1eXc5OO3g3b6 YAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 06 Aug 2024 11:47:10 +0800, Yuesong Li wrote:
> replace 'permanetly' with 'permanently' in the comment &
> replace 'propogated' with 'propagated' in the comment
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

[1/1] fs/namespace.c: Fix typo in comment
      https://git.kernel.org/vfs/vfs/c/2d17506818d0

