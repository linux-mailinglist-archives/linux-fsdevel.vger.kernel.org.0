Return-Path: <linux-fsdevel+bounces-9981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829AD846DCF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4AF41C21318
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0CF7C084;
	Fri,  2 Feb 2024 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6yCE96+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CA562801
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869348; cv=none; b=fJ7aYeBAc0VxntpRKjv1XStHeAhShwNcfaMnnfQ0P+OTQWLlFr9DJcLd4mKUPJ+8v/TJSimsPNrRhH0N+J2PoYtOLbYXfkCe7ZKqNXcdfSRTa8dgf7tx+lrHOKO/GHZmh/nrvnaccfCj4xBG7JLj6n6HDeaYkW3Qnk7iUhddjZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869348; c=relaxed/simple;
	bh=g7hEd5+foPlxMVvNn92yA1Ab1TMXbDj0d+U4Gcgx7qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZ/DeKIAXv6MieM7hHm/Y3Kdd5YBTOwVQGjvq0BXhb2tNWC+zYU4mIbR/6P+pbDJIIfhpEsUv9yMtZI+rp3z08POOl1WIZEwoXbWKCY8Ive9M+J4lj1rR6mbXoLdlT+0+7ZlQYy0nOz/tQjboDglqar9uZCleVPop5vStNfol1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6yCE96+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6B2C433C7;
	Fri,  2 Feb 2024 10:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706869347;
	bh=g7hEd5+foPlxMVvNn92yA1Ab1TMXbDj0d+U4Gcgx7qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c6yCE96+q+TaSjfMXsLVqhdS6zsyq7hgSGP/BPlAiE4gWMJ/nfeiUqTsP2PdzYyeF
	 j8pCXASdaNyadRFagLZF6vhP6RRz6FI9MZsdEJpNp9SVfOyUi37K5YGYxX2d0kXJ+B
	 sgl9YK8D9fMHL6Wfg14wqXB1T6v16Nni+VFP+JVo2lP025hYU2UZGNLA1AeqF+72Ma
	 ZMPoPTs3DU2PUvKE46Bgu26CNzGPAkjJNq6sRqHU5m+tl0tKXLHDiPaC1NS8p9giAv
	 ZoINI1qGurJ3+vjlMSnuat1wXOXZb8ARSOpbTKefcBhdD1cUibp8Q5v5QZdChtq+BX
	 rH+te1yF9PjGQ==
From: Christian Brauner <brauner@kernel.org>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] __fs_parse: Correct a documentation comment
Date: Fri,  2 Feb 2024 11:22:18 +0100
Message-ID: <20240202-lernziel-zugfahrt-fe2de6f30bf1@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202072042.906-1-chenhx.fnst@fujitsu.com>
References: <20240202072042.906-1-chenhx.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=brauner@kernel.org; h=from:subject:message-id; bh=g7hEd5+foPlxMVvNn92yA1Ab1TMXbDj0d+U4Gcgx7qo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTuORTzl3X2iaMB91RWp/jnfWSd8Y57ZenBWV2fkjIfT 8hLusks3FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR9hCGfypXPr3p2FSw3duu pf2WWHfZ4pl+x70117e2b9i6//Ix/wpGhrsWC++zfbzp8n6rI0/73ALORYnbznEkn2WwPsIkd3t HFj8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 02 Feb 2024 15:20:42 +0800, Chen Hanxiao wrote:
> Commit 7f5d38141e30 ("new primitive: __fs_parse()")
> taking p_log instead of fs_context.
> 
> So, update that comment to refer to p_log instead
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

[1/1] __fs_parse: Correct a documentation comment
      https://git.kernel.org/vfs/vfs/c/0faa7bffa2ff

