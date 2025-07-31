Return-Path: <linux-fsdevel+bounces-56386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A48FB1703D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 13:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D06582DA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 11:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FEA2BF017;
	Thu, 31 Jul 2025 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWUxbqZ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA971F78E6
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753960528; cv=none; b=UcqjGXYroJf2eddpHPSje+OO9yizNNIS58e+prz0AOHynsleI7HhIpc2CYFVremXtMoNALYUuMV6Vx57yHvjGNDmgLdmIyOm6OaUykf3C++LjUBNWG81b3KvJUWJ3n0VGNaHxpCO70qUaXK51CgO0kcLv44beXVKc+3qziELih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753960528; c=relaxed/simple;
	bh=JdIslB8Q3QNOmEjhvMHferaDyf/cNSzeYDKGDGLymHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvgQeBYZBRfj/HVklE0Rp6DWp0E9Q102tmGWP8cI1jFX3rXiQoYa5NO2Nk+Z3/QngO7heWc1iY9J8jpOa2h0r0EZqPAp8pJAadNL/1CK6TcF04o96Du5rEMZQEqH5y3l2t3MorIKQWF+g02AKYxLbfqepeYN1UW1Hs6KK3qirFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWUxbqZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D595C4CEEF;
	Thu, 31 Jul 2025 11:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753960527;
	bh=JdIslB8Q3QNOmEjhvMHferaDyf/cNSzeYDKGDGLymHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pWUxbqZ+9QWyyN0eSr/bcDQwf53CkeBwgCv3q0SWESd7j+YSQr3Uv9qn3aOlzW3GY
	 p+q3h05tCbWYD+iviChU80Snd5GzuldYTM6IyDFYdvfEmlwWsHyeMnb/4XrgsVrKcU
	 izR6zCtxqFQYplEwEzsxprRHugQb3WLWnEwMJRq+EBNAs3tYPaRo4P4qY/OBF+Nm0Q
	 qUc3CiXXiBOmjW653FRvZHgqbDjyYRXIOdoMqukx4MM2fnZgK5DkfuOrPdNOyb7lB7
	 mUdFeWmBuNMTgw4C60aUxevIe5s9yCJB7wIusV0SeJCjkQaHcLZ8PHY3XuPTTdwkC6
	 SN64fLZ62EeUw==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: mark file_remove_privs_flags static
Date: Thu, 31 Jul 2025 13:15:16 +0200
Message-ID: <20250731-kannen-bangen-d379e098d161@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724074854.3316911-1-hch@lst.de>
References: <20250724074854.3316911-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=911; i=brauner@kernel.org; h=from:subject:message-id; bh=JdIslB8Q3QNOmEjhvMHferaDyf/cNSzeYDKGDGLymHI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR0B3gH7XLernnmUusWj+m7L6ozaL/M8ErS3x/9vjv3m P1+v7iijlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImYOTP8YhIuDFv2iDs8+EZU ltfDifPm/ypwTzE7t7i0JM0rwTvLluGf3VrD5sNHnWJ/7Huz2PXZbx8euTJec6m6RHvO4Dd2gi1 sAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 24 Jul 2025 09:48:54 +0200, Christoph Hellwig wrote:
> file_remove_privs_flags is only used inside of inode.c, mark it static.
> 
> 

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] fs: mark file_remove_privs_flags static
      https://git.kernel.org/vfs/vfs/c/0fdf709a849f

