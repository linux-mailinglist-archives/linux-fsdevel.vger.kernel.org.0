Return-Path: <linux-fsdevel+bounces-42217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE92A3F0B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 10:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCEA8189F262
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 09:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CED20469D;
	Fri, 21 Feb 2025 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN1nl70X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218582046A3
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130782; cv=none; b=GWTKzKDzWWPDPprc/c/iwySdxGfCCUH8eCCZzRxFR21aNAynmSyIWDPfY9CSkGvyYVaTZbBiG4YvGlD4gshzcdGIhECPYG0CvWP7aW0a7XPQWCJmFlq+SdDfKrrSZEWb1+uomESLNQk6gVpuwaPN0N/305M3N8HK6a+VfDhv/dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130782; c=relaxed/simple;
	bh=qM6tZqqR8npGDyIwhP/9MRry5fOlKUbhdVnPrOpRrs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYJmVWSBGqSl7EyVYlcwuuZa3ai9hdbqNiu5/fu2kwunFTX5zxvuIfDEp0gsdSnuQZ7CH3PwYZaA9o5sozRuqCae2uf+v/zn5uWCWMGAZdL4+MuiRyTe4/2TnvcvWOE66Rv1/p7Uh9sXiAe1n/7UR+x56lthtCM+gOgF7K5Son8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN1nl70X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9E6C4CED6;
	Fri, 21 Feb 2025 09:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740130781;
	bh=qM6tZqqR8npGDyIwhP/9MRry5fOlKUbhdVnPrOpRrs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QN1nl70XvKed5p2wlt3BPs77oPkTnuwYnTwK+agE8E0iCh9VFh4H+Omkdpc5oCttr
	 7pEhpFi/kbxY65ZmDoXYbMTaMZt8FNR1a26kYqFIkqYfxuKzyY/89x3kqDBuedJWxD
	 MmoqKTKAq/wdhgiTRVMNISs287jma3285BH1S/8cd8hixQKMdiiDWVtK32ILslsoGA
	 aTWqWy1DrVXZu1BAwhWNehmOKBU1bq2A43SPmfS5ZGBFMvzeIyEBJ/4+9senowNwjU
	 jFKNS+ymaqNAmZri9n68iZC6eZePz9ESFI4M+VRm5XlSiLl17PgerMDpYmL0kZAhcr
	 DpBKYa5IoaOuQ==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysv: Remove the filesystem
Date: Fri, 21 Feb 2025 10:38:31 +0100
Message-ID: <20250221-dienlich-metapher-c2755e73b3f7@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220163940.10155-2-jack@suse.cz>
References: <20250220163940.10155-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234; i=brauner@kernel.org; h=from:subject:message-id; bh=qM6tZqqR8npGDyIwhP/9MRry5fOlKUbhdVnPrOpRrs8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTv8LyuqcTLaVRY6n3AK2vX+wUvy7ivZM5bnvjK2My6q dXhd75SRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ6YxgZLh9TOtJ29pux/MVa 6ZQPYnu44v3b7qr8uLpXiHl62pYXUxn+ylno/puV7250MSHQTUS8wU5GM6XkrfvepQkpu3cctAl gAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 20 Feb 2025 17:39:41 +0100, Jan Kara wrote:
> Since 2002 (change "Replace BKL for chain locking with sysvfs-private
> rwlock") the sysv filesystem was doing IO under a rwlock in its
> get_block() function (yes, a non-sleepable lock hold over a function
> used to read inode metadata for all reads and writes).  Nobody noticed
> until syzbot in 2023 [1]. This shows nobody is using the filesystem.
> Just drop it.
> 
> [...]

It's time to say goodbye! :)

---

Applied to the vfs-6.15.sysv branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.sysv branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.sysv

[1/1] sysv: Remove the filesystem
      https://git.kernel.org/vfs/vfs/c/448fa70158f9

