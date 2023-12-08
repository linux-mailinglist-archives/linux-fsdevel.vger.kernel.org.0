Return-Path: <linux-fsdevel+bounces-5323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E116880A586
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 15:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89083B20C2E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 14:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F021B1E534
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2urW31q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212011711
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 13:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB96C433C7;
	Fri,  8 Dec 2023 13:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702041330;
	bh=nD3eF0ibw6Q9BmrjuIl94Jt6xBkToFacmbiWArBMqPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z2urW31qWJwCoqowIYoHijbKCYUPh6RbJfwGiXcigA0o7dDirDH0C1dPfapAI/k4z
	 UZ70/Zpwh/hDmmfAxCXZ7hHJoFi4NbS15GD5/A7tgSFCVORcKvO4YADgPvpsYiRUVq
	 qpbuOGrKLZ4GpjESsXJ3oH4d8nrj+JEVkrpMeuy2LsDmNXadiGEMZzPcyNfiGQnlGD
	 Q14BtHXiN0rAFRT/WJMbZzX7lnjQS87muk1KmelJLZzH8g0ynghDgyGlEigSmh+Ee7
	 iYuh6hzHg4glGiqBv9sOhCmh34Ia+4ulwKcrbts9yCL+6KQLJSL0VzlMJzLZK/Wt/g
	 feyseggBpsfTw==
From: Christian Brauner <brauner@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/hfsplus: wrapper.c: fix kernel-doc warnings
Date: Fri,  8 Dec 2023 14:15:21 +0100
Message-ID: <20231208-lassen-vorenthalten-eef9da43f947@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231206024317.31020-1-rdunlap@infradead.org>
References: <20231206024317.31020-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=brauner@kernel.org; h=from:subject:message-id; bh=nD3eF0ibw6Q9BmrjuIl94Jt6xBkToFacmbiWArBMqPA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQWi714s/tHuo3p1M6Nu6W+xRzUN2wW7znYM+HHZf+9w XLaS4JWd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk8Q/D/0CWM/2fFO+fvujp W6K/i/Nn9NKJC9y45CyOuJ4/KdLDzcrwT/nmKse2O3dyDI2ZSmLnmJkas8hEOajHBKzIf9Fvoir PDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 05 Dec 2023 18:43:17 -0800, Randy Dunlap wrote:
> Fix kernel-doc warnings found when using "W=1".
> 
> wrapper.c:48: warning: No description found for return value of 'hfsplus_submit_bio'
> wrapper.c:49: warning: Function parameter or member 'opf' not described in 'hfsplus_submit_bio'
> wrapper.c:49: warning: Excess function parameter 'op' description in 'hfsplus_submit_bio'
> wrapper.c:49: warning: Excess function parameter 'op_flags' description in 'hfsplus_submit_bio'
> 
> [...]

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

[1/1] fs/hfsplus: wrapper.c: fix kernel-doc warnings
      https://git.kernel.org/vfs/vfs/c/bff713c4a439

