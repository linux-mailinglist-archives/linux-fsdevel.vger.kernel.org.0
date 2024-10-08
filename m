Return-Path: <linux-fsdevel+bounces-31329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F1F9949E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 14:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D255128345B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 12:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46571DF747;
	Tue,  8 Oct 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rapY8Ysu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041581DF25A;
	Tue,  8 Oct 2024 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390433; cv=none; b=qiWjcIWXClnjlr22I1g2Khd1ZNY+EYSWcIYigs1FarrYZd76V/zyNM66QhJJdA/BadM0Nc3DivR+y7KLLmm+DIm9IXai3W/myKPLRK1Vx8/MfDsIxjGep0blW6TOgxX6QEwvjr8CrRKeu1vCG2SoTh6+gjSSv/AW4SHdK2EpQak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390433; c=relaxed/simple;
	bh=Bex9kWWkf1IYbePz5Dn+VZ9xnqyq7zc+PIKmCL23il4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P+p169Yx2ZynT9Q8N0FhYn+h3iLsFCoqF9ZqHoVqT21ERfg0C4F/AlAHg4LK/zevI5GBjAMuWtZj+NcY+D4KHMFDHmwruAYvoaY7kCgbqsFYOcklD2BVHWMrn/wAQ17xOlUwoyMB7jD2kfQnPCgRbCy3BMG/1YCdnq1WgG2kaKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rapY8Ysu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A0EC4CEC7;
	Tue,  8 Oct 2024 12:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728390432;
	bh=Bex9kWWkf1IYbePz5Dn+VZ9xnqyq7zc+PIKmCL23il4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rapY8YsuiXiFzuUBQL5TU17rlUmLVj37hlrfQRivl7bwl9HHMMPOU0Iwy7WBQAcER
	 oSF/eHzWaovsjjwgTYof0BkZS9uTE4HOYbxpt0/Tg9/Sgpapb6VRukCQOX/jS+Ai2M
	 JNeKBM1VQitYCvPk+w1MFX36u8ZX09huNpny5H5ZSBbtKOdLCr4//1LfNEPdQ7BH0Q
	 UODVymhlRHO+7iT5EAkVe2tBQCtqVxf1Yb5vdY/7Ka54zKuibKdPQ3AHp+dEeFHkiV
	 uy/xf689Z5/Z+PsU8AMie5ZR20sFo9h7cSedLxNBTJIlhTv6HDlJerz85wdue9fAOZ
	 x4Sm3OShYZAVA==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Andrew Kreimer <algonell@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20241008121602.16778-1-algonell@gmail.com>
References: <20241008121602.16778-1-algonell@gmail.com>
Subject: Re: [PATCH] fs/inode: Fix a typo
Message-Id: <172839043123.1673124.6132955349484034928.b4-ty@kernel.org>
Date: Tue, 08 Oct 2024 14:27:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-dedf8

On Tue, 08 Oct 2024 15:16:02 +0300, Andrew Kreimer wrote:
> Fix a typo in comments: wether v-> whether.
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

[1/1] fs/inode: Fix a typo
      https://git.kernel.org/vfs/vfs/c/e1a6efa9de95


